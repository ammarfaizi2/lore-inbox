Return-Path: <linux-kernel-owner+w=401wt.eu-S932067AbXAKVTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067AbXAKVTQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 16:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbXAKVTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 16:19:15 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:14176 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbXAKVTP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 16:19:15 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UUsViblSXllPudxIqbquZCLVPlbIoVq2LO4PauQquDfNqYLTGS9IHO5JIcBllY6yvH9a9VxyyNIuu8jQ4ixyKsJWuVmOS0epixwTOjuJhLlueLHwh3iXbBWhihZPYduMZ8l7fOypmQ14LZG1Q9E9oZvz1oUq2HXkTNIyOkriA1k=
Date: Fri, 12 Jan 2007 00:19:12 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] seq_file conversion: APM on i386
Message-ID: <20070111211911.GA13817@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byte-to-byte identical /proc/apm here.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/i386/kernel/apm.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

--- a/arch/i386/kernel/apm.c
+++ b/arch/i386/kernel/apm.c
@@ -211,6 +211,7 @@ #include <linux/fcntl.h>
 #include <linux/slab.h>
 #include <linux/stat.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/apm_bios.h>
 #include <linux/init.h>
@@ -1636,9 +1637,8 @@ static int do_open(struct inode * inode,
 	return 0;
 }
 
-static int apm_get_info(char *buf, char **start, off_t fpos, int length)
+static int proc_apm_show(struct seq_file *m, void *v)
 {
-	char *		p;
 	unsigned short	bx;
 	unsigned short	cx;
 	unsigned short	dx;
@@ -1650,8 +1650,6 @@ static int apm_get_info(char *buf, char 
 	int             time_units     = -1;
 	char            *units         = "?";
 
-	p = buf;
-
 	if ((num_online_cpus() == 1) &&
 	    !(error = apm_get_power_status(&bx, &cx, &dx))) {
 		ac_line_status = (bx >> 8) & 0xff;
@@ -1705,7 +1703,7 @@ static int apm_get_info(char *buf, char 
 	      -1: Unknown
 	   8) min = minutes; sec = seconds */
 
-	p += sprintf(p, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+	seq_printf(m, "%s %d.%d 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version,
 		     (apm_info.bios.version >> 8) & 0xff,
 		     apm_info.bios.version & 0xff,
@@ -1716,10 +1714,22 @@ static int apm_get_info(char *buf, char 
 		     percentage,
 		     time_units,
 		     units);
+	return 0;
+}
 
-	return p - buf;
+static int proc_apm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_apm_show, NULL);
 }
 
+static const struct file_operations apm_file_ops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_apm_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int apm(void *unused)
 {
 	unsigned short	bx;
@@ -2341,9 +2351,9 @@ #endif
 	set_base(gdt[APM_DS >> 3],
 		 __va((unsigned long)apm_info.bios.dseg << 4));
 
-	apm_proc = create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	apm_proc = create_proc_entry("apm", 0, NULL);
 	if (apm_proc)
-		apm_proc->owner = THIS_MODULE;
+		apm_proc->proc_fops = &apm_file_ops;
 
 	kapmd_task = kthread_create(apm, NULL, "kapmd");
 	if (IS_ERR(kapmd_task)) {

