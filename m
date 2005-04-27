Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVD0HDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVD0HDV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0HDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:03:21 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:52095 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261733AbVD0Gzl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:41 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 4/6] I8K: convert to seqfile
Date: Wed, 27 Apr 2005 01:53:30 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504270153.30586.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I8K: Change proc code to use seq_file.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 i8k.c |   64 ++++++++++++++++++++++------------------------------------------
 1 files changed, 22 insertions(+), 42 deletions(-)

Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -20,13 +20,14 @@
 #include <linux/types.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/dmi.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
 #include <linux/i8k.h>
 
-#define I8K_VERSION		"1.13 14/05/2002"
+#define I8K_VERSION		"1.14 21/02/2005"
 
 #define I8K_SMM_FN_STATUS	0x0025
 #define I8K_SMM_POWER_STATUS	0x0069
@@ -74,13 +75,16 @@ static int power_status;
 module_param(power_status, bool, 0600);
 MODULE_PARM_DESC(power_status, "Report power status in /proc/i8k");
 
-static ssize_t i8k_read(struct file *, char __user *, size_t, loff_t *);
+static int i8k_open_fs(struct inode *inode, struct file *file);
 static int i8k_ioctl(struct inode *, struct file *, unsigned int,
 		     unsigned long);
 
 static struct file_operations i8k_fops = {
-	.read = i8k_read,
-	.ioctl = i8k_ioctl,
+	.open		= i8k_open_fs,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.ioctl		= i8k_ioctl,
 };
 
 typedef struct {
@@ -400,9 +404,9 @@ static int i8k_ioctl(struct inode *ip, s
 /*
  * Print the information for /proc/i8k.
  */
-static int i8k_get_info(char *buffer, char **start, off_t fpos, int length)
+static int i8k_proc_show(struct seq_file *seq, void *offset)
 {
-	int n, fn_key, cpu_temp, ac_power;
+	int fn_key, cpu_temp, ac_power;
 	int left_fan, right_fan, left_speed, right_speed;
 
 	cpu_temp	= i8k_get_cpu_temp();			/* 11100 µs */
@@ -431,42 +435,18 @@ static int i8k_get_info(char *buffer, ch
 	 * 9)  AC power
 	 * 10) Fn Key status
 	 */
-	n = sprintf(buffer, "%s %s %s %d %d %d %d %d %d %d\n",
-		    I8K_PROC_FMT,
-		    bios_version,
-		    dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
-		    cpu_temp,
-		    left_fan, right_fan, left_speed, right_speed,
-		    ac_power, fn_key);
-
-	return n;
+	return seq_printf(seq, "%s %s %s %d %d %d %d %d %d %d\n",
+			  I8K_PROC_FMT,
+			  bios_version,
+			  dmi_get_system_info(DMI_PRODUCT_SERIAL) ? : "N/A",
+			  cpu_temp,
+			  left_fan, right_fan, left_speed, right_speed,
+			  ac_power, fn_key);
 }
 
-static ssize_t i8k_read(struct file *f, char __user * buffer, size_t len,
-			loff_t * fpos)
+static int i8k_open_fs(struct inode *inode, struct file *file)
 {
-	int n;
-	char info[128];
-
-	n = i8k_get_info(info, NULL, 0, 128);
-	if (n <= 0) {
-		return n;
-	}
-
-	if (*fpos >= n) {
-		return 0;
-	}
-
-	if ((*fpos + len) >= n) {
-		len = n - *fpos;
-	}
-
-	if (copy_to_user(buffer, info, len) != 0) {
-		return -EFAULT;
-	}
-
-	*fpos += len;
-	return len;
+	return single_open(file, i8k_proc_show, NULL);
 }
 
 static struct dmi_system_id __initdata i8k_dmi_table[] = {
@@ -560,10 +540,10 @@ int __init i8k_init(void)
 		return -ENODEV;
 
 	/* Register the proc entry */
-	proc_i8k = create_proc_info_entry("i8k", 0, NULL, i8k_get_info);
-	if (!proc_i8k) {
+	proc_i8k = create_proc_entry("i8k", 0, NULL);
+	if (!proc_i8k)
 		return -ENOENT;
-	}
+
 	proc_i8k->proc_fops = &i8k_fops;
 	proc_i8k->owner = THIS_MODULE;
 
