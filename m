Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262237AbTIMXer (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 19:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262249AbTIMXer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 19:34:47 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:46979
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262237AbTIMXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 19:34:44 -0400
Date: Sat, 13 Sep 2003 19:34:37 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [PATCH][2.6] remove extraneous information from ikconfig
Message-ID: <Pine.LNX.4.53.0309131910070.3274@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/version provides the same information as /proc/config_build_info, 
ergo i propose the following patch for your consideration.

Thanks.

 kernel/configs.c  |   46 ++--------------------------------------------
 scripts/mkconfigs |   12 ------------
 2 files changed, 2 insertions(+), 56 deletions(-)

Index: linux-2.6.0-test5-mm1/scripts/mkconfigs
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5-mm1/scripts/mkconfigs,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 mkconfigs
--- linux-2.6.0-test5-mm1/scripts/mkconfigs	13 Sep 2003 21:33:58 -0000	1.1.1.1
+++ linux-2.6.0-test5-mm1/scripts/mkconfigs	13 Sep 2003 23:16:12 -0000
@@ -25,12 +25,6 @@
 #	- Retain lines that begin with "# CONFIG_"
 #	- lines that use double-quotes must \\-escape-quote them
 
-
-kernel_version()
-{
-	KERNVER="`grep VERSION $1 | head -1 | cut -f3 -d' '`.`grep PATCHLEVEL $1 | head -1 | cut -f3 -d' '`.`grep SUBLEVEL $1 | head -1 | cut -f3 -d' '``grep EXTRAVERSION $1 | head -1 | cut -f3 -d' '`"
-}
-
 if [ $# -lt 2 ]
 then
 	echo "Usage: `basename $0` <configuration_file> <Makefile>"
@@ -66,12 +60,6 @@ echo \
  *
  */"
 
-echo "#ifdef CONFIG_IKCONFIG_PROC"
-echo "static char const ikconfig_build_info[] ="
-echo "    \"`uname -s` `uname -r` `uname -v` `uname -m`\";"
-echo "#endif"
-echo
-kernel_version $makefile
 echo "static char const ikconfig_config[] __attribute__((unused)) = "
 echo "\"CONFIG_BEGIN=n\\n\\"
 echo "`cat $config | sed 's/\"/\\\\\"/g' | grep "^#\? \?CONFIG_" | awk '{ print $0 "\\\\n\\\\" }' `"
Index: linux-2.6.0-test5-mm1/kernel/configs.c
===================================================================
RCS file: /build/cvsroot/linux-2.6.0-test5-mm1/kernel/configs.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 configs.c
--- linux-2.6.0-test5-mm1/kernel/configs.c	13 Sep 2003 21:33:54 -0000	1.1.1.1
+++ linux-2.6.0-test5-mm1/kernel/configs.c	13 Sep 2003 23:08:46 -0000
@@ -47,7 +47,7 @@
 /**************************************************/
 /* globals and useful constants                   */
 
-static const char IKCONFIG_VERSION[] = "0.6";
+static const char IKCONFIG_VERSION[] __initdata = "0.7";
 
 static ssize_t
 ikconfig_read_current(struct file *file, char __user *buf,
@@ -72,32 +72,6 @@ static struct file_operations ikconfig_f
 	.read = ikconfig_read_current,
 };
 
-
-/***************************************************/
-/* build_info_show: let people read the info       */
-/* we have on the tools used to build this kernel  */
-
-static int build_info_show(struct seq_file *seq, void *v)
-{
-	seq_printf(seq,
-		   "Kernel:    %s\nCompiler:  %s\nVersion_in_Makefile: %s\n",
-		   ikconfig_build_info, LINUX_COMPILER, UTS_RELEASE);
-	return 0;
-}
-
-static int build_info_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, build_info_show, PDE(inode)->data);
-}
-
-static struct file_operations build_info_file_ops = {
-	.owner = THIS_MODULE,
-	.open  = build_info_open,
-	.read  = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
-
 /***************************************************/
 /* ikconfig_init: start up everything we need to */
 
@@ -112,26 +86,12 @@ static int __init ikconfig_init(void)
 	entry = create_proc_entry("config.gz", S_IFREG | S_IRUGO,
 				  &proc_root);
 	if (!entry)
-		goto leave;
+		return -ENOMEM;
 
 	entry->proc_fops = &ikconfig_file_ops;
 	entry->size = kernel_config_data_size;
 
-	/* create the "build_info" file */
-	entry = create_proc_entry("config_build_info",
-				  S_IFREG | S_IRUGO, &proc_root);
-	if (!entry)
-		goto leave_gz;
-	entry->proc_fops = &build_info_file_ops;
-
 	return 0;
-
-leave_gz:
-	/* remove the file from proc */
-	remove_proc_entry("config.gz", &proc_root);
-
-leave:
-	return -ENOMEM;
 }
 
 /***************************************************/
@@ -139,9 +99,7 @@ leave:
 
 static void __exit ikconfig_cleanup(void)
 {
-	/* remove the files */
 	remove_proc_entry("config.gz", &proc_root);
-	remove_proc_entry("config_build_info", &proc_root);
 }
 
 module_init(ikconfig_init);
