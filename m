Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265341AbTIDRxC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 13:53:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265359AbTIDRxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 13:53:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:20679 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265341AbTIDRwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 13:52:10 -0400
Date: Thu, 4 Sep 2003 10:51:54 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ikconfig - cleanups
Message-Id: <20030904105154.7fb8a628.shemminger@osdl.org>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup ikconfig
	- use single_open for built_with file.
	- get rid of unneeded globals
	- use copy_to_user instead of char at a time
	- only need the read routine, proc defaults to correct behaviour
	  for the rest.

Tested against 2.6.0-test4

diff -Nru a/kernel/configs.c b/kernel/configs.c
--- a/kernel/configs.c	Thu Sep  4 10:35:39 2003
+++ b/kernel/configs.c	Thu Sep  4 10:35:39 2003
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/init.h>
 #include <linux/compile.h>
 #include <linux/version.h>
@@ -41,75 +42,59 @@
 /**************************************************/
 /* globals and useful constants                   */
 
-static char *IKCONFIG_NAME = "ikconfig";
-static char *IKCONFIG_VERSION = "0.5";
+static const char IKCONFIG_NAME[] = "ikconfig";
+static const char IKCONFIG_VERSION[] = "0.6";
 
-static int ikconfig_current_size = 0;
-static struct proc_dir_entry *ikconfig_dir, *current_config, *built_with;
-
-static int
-ikconfig_permission_current(struct inode *inode, int op, struct nameidata *nd)
-{
-	/* anyone can read the device, no one can write to it */
-	return (op == MAY_READ) ? 0 : -EACCES;
-}
+static int ikconfig_size;
+static struct proc_dir_entry *ikconfig_dir;
 
 static ssize_t
-ikconfig_output_current(struct file *file, char *buf,
-			 size_t len, loff_t * offset)
-{
-	int i, limit;
-	int cnt;
-
-	limit = (ikconfig_current_size > len) ? len : ikconfig_current_size;
-	for (i = file->f_pos, cnt = 0;
-	     i < ikconfig_current_size && cnt < limit; i++, cnt++) {
-		if (put_user(ikconfig_config[i], buf + cnt))
-			return -EFAULT;
-	}
-	file->f_pos = i;
-	return cnt;
-}
-
-static int
-ikconfig_open_current(struct inode *inode, struct file *file)
+ikconfig_read(struct file *file, char __user *buf, 
+		   size_t len, loff_t *offset)
 {
-	if (file->f_mode & FMODE_READ) {
-		inode->i_size = ikconfig_current_size;
-		file->f_pos = 0;
-	}
-	return 0;
-}
+	loff_t pos = *offset;
+	ssize_t count;
+	
+	if (pos >= ikconfig_size)
+		return 0;
+
+	count = min(len, (size_t)(ikconfig_size - pos));
+	if(copy_to_user(buf, ikconfig_config + pos, count))
+		return -EFAULT;
 
-static int
-ikconfig_close_current(struct inode *inode, struct file *file)
-{
-	return 0;
+	*offset += count;
+	return count;
 }
 
-static struct file_operations ikconfig_file_ops = {
-	.read = ikconfig_output_current,
-	.open = ikconfig_open_current,
-	.release = ikconfig_close_current,
-};
-
-static struct inode_operations ikconfig_inode_ops = {
-	.permission = ikconfig_permission_current,
+static struct file_operations config_fops = {
+	.owner = THIS_MODULE,
+	.read  = ikconfig_read,
 };
 
 /***************************************************/
-/* proc_read_built_with: let people read the info  */
+/* built_with_show: let people read the info  */
 /* we have on the tools used to build this kernel  */
 
-static int
-proc_read_built_with(char *page, char **start,
-		     off_t off, int count, int *eof, void *data)
+static int builtwith_show(struct seq_file *seq, void *v)
+{
+	seq_printf(seq, 
+		   "Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
+		   ikconfig_built_with, LINUX_COMPILER, UTS_RELEASE);
+	return 0;
+}
+
+static int built_with_open(struct inode *inode, struct file *file)
 {
-	*eof = 1;
-	return sprintf(page,
-			"Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
-			ikconfig_built_with, LINUX_COMPILER, UTS_RELEASE);
+	return single_open(file, builtwith_show, PDE(inode)->data);
 }
+	
+static struct file_operations builtwith_fops = {
+	.owner = THIS_MODULE,
+	.open  = built_with_open,
+	.read  = seq_read,
+	.llseek = seq_lseek,
+	.release = single_release,
+};	
 
 /***************************************************/
 /* ikconfig_init: start up everything we need to */
@@ -117,41 +102,33 @@
 int __init
 ikconfig_init(void)
 {
-	int result = 0;
+	struct proc_dir_entry *entry;
 
 	printk(KERN_INFO "ikconfig %s with /proc/ikconfig\n",
 	       IKCONFIG_VERSION);
 
 	/* create the ikconfig directory */
 	ikconfig_dir = proc_mkdir(IKCONFIG_NAME, NULL);
-	if (ikconfig_dir == NULL) {
-		result = -ENOMEM;
+	if (ikconfig_dir == NULL) 
 		goto leave;
-	}
 	ikconfig_dir->owner = THIS_MODULE;
 
 	/* create the current config file */
-	current_config = create_proc_entry("config", S_IFREG | S_IRUGO,
-					   ikconfig_dir);
-	if (current_config == NULL) {
-		result = -ENOMEM;
+	entry = create_proc_entry("config", S_IFREG | S_IRUGO, ikconfig_dir);
+	if (!entry)
 		goto leave2;
-	}
-	current_config->proc_iops = &ikconfig_inode_ops;
-	current_config->proc_fops = &ikconfig_file_ops;
-	current_config->owner = THIS_MODULE;
-	ikconfig_current_size = strlen(ikconfig_config);
-	current_config->size = ikconfig_current_size;
+
+	entry->proc_fops = &config_fops;
+	entry->size = ikconfig_size = strlen(ikconfig_config);
 
 	/* create the "built with" file */
-	built_with = create_proc_read_entry("built_with", 0444, ikconfig_dir,
-					    proc_read_built_with, NULL);
-	if (built_with == NULL) {
-		result = -ENOMEM;
+	entry = create_proc_entry("built_with", S_IFREG | S_IRUGO,
+				  ikconfig_dir);
+	if (!entry)
 		goto leave3;
-	}
-	built_with->owner = THIS_MODULE;
-	goto leave;
+	entry->proc_fops = &builtwith_fops;
+
+	return 0;
 
 leave3:
 	/* remove the file from proc */
@@ -162,7 +139,7 @@
 	remove_proc_entry(IKCONFIG_NAME, NULL);
 
 leave:
-	return result;
+	return -ENOMEM;
 }
 
 /***************************************************/
