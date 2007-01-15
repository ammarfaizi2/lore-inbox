Return-Path: <linux-kernel-owner+w=401wt.eu-S1751482AbXAOU7z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482AbXAOU7z (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 15:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXAOU7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 15:59:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:1994 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbXAOU7y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 15:59:54 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=XUr4pMRpaApuX9ZEnVKOssRIaxwaOPdt1Ca2uom9OQKtyHR2Z6I3rODJ/aLzzAO5R568BXiRwQb2Z6Bk7Nvp6bQ896fZ3TTrwR32eTIR3w7mvxY8KrNJHsRoe10+8v8KsPKIPuxpvSYez88ujLBR5VK1aZbmeemHeJpmZEalYy4=
Date: Mon, 15 Jan 2007 23:59:35 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, rmk@arm.linux.org.uk
Subject: [PATCH] seq_file conversion: APM on arm
Message-ID: <20070115205935.GA5010@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-tested.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/arm/kernel/apm.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- a/arch/arm/kernel/apm.c
+++ b/arch/arm/kernel/apm.c
@@ -14,6 +14,7 @@ #include <linux/module.h>
 #include <linux/poll.h>
 #include <linux/slab.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/miscdevice.h>
 #include <linux/apm_bios.h>
 #include <linux/capability.h>
@@ -501,11 +502,10 @@ #ifdef CONFIG_PROC_FS
  *	-1: Unknown
  *   8) min = minutes; sec = seconds
  */
-static int apm_get_info(char *buf, char **start, off_t fpos, int length)
+static int proc_apm_show(struct seq_file *m, void *v)
 {
 	struct apm_power_info info;
 	char *units;
-	int ret;
 
 	info.ac_line_status = 0xff;
 	info.battery_status = 0xff;
@@ -523,14 +523,26 @@ static int apm_get_info(char *buf, char 
 	case 1: 	units = "sec";	break;
 	}
 
-	ret = sprintf(buf, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
+	seq_printf(m, "%s 1.2 0x%02x 0x%02x 0x%02x 0x%02x %d%% %d %s\n",
 		     driver_version, APM_32_BIT_SUPPORT,
 		     info.ac_line_status, info.battery_status,
 		     info.battery_flag, info.battery_life,
 		     info.time, units);
+	return 0;
+}
 
- 	return ret;
+static int proc_apm_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, proc_apm_show, NULL);
 }
+
+static const struct file_operations proc_apm_fops = {
+	.owner		= THIS_MODULE,
+	.open		= proc_apm_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
 #endif
 
 static int kapmd(void *arg)
@@ -602,7 +614,13 @@ static int __init apm_init(void)
 	wake_up_process(kapmd_tsk);
 
 #ifdef CONFIG_PROC_FS
-	create_proc_info_entry("apm", 0, NULL, apm_get_info);
+	{
+		struct proc_dir_entry *pde;
+
+		pde = create_proc_entry("apm", 0, NULL);
+		if (pde)
+			pde->proc_fops = &proc_apm_fops;
+	}
 #endif
 
 	ret = misc_register(&apm_device);

