Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263131AbTFGLq3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTFGLpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:45:47 -0400
Received: from dp.samba.org ([66.70.73.150]:27113 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263131AbTFGLov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:44:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16097.53391.364090.367854@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 21:46:23 +1000
To: torvalds@transmeta.com
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fix check warnings in drivers/macintosh
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch removes the warnings that the `check' program came up with
in drivers/macintosh.  This involves adding __user in various places
and fixing some non-ANSI function definitions for functions that take
no arguments.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/drivers/macintosh/adb.c pmac-2.5/drivers/macintosh/adb.c
--- linux-2.5/drivers/macintosh/adb.c	2003-05-08 16:27:25.000000000 +1000
+++ pmac-2.5/drivers/macintosh/adb.c	2003-06-07 17:45:03.000000000 +1000
@@ -749,7 +749,7 @@
 	return 0;
 }
 
-static ssize_t adb_read(struct file *file, char *buf,
+static ssize_t adb_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	int ret;
@@ -810,7 +810,7 @@
 	return ret;
 }
 
-static ssize_t adb_write(struct file *file, const char *buf,
+static ssize_t adb_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	int ret/*, i*/;
diff -urN linux-2.5/drivers/macintosh/apm_emu.c pmac-2.5/drivers/macintosh/apm_emu.c
--- linux-2.5/drivers/macintosh/apm_emu.c	2003-05-23 14:58:26.000000000 +1000
+++ pmac-2.5/drivers/macintosh/apm_emu.c	2003-06-07 14:38:16.000000000 +1000
@@ -180,7 +180,7 @@
 	return 0;
 }
 
-static ssize_t do_read(struct file *fp, char *buf, size_t count, loff_t *ppos)
+static ssize_t do_read(struct file *fp, char __user *buf, size_t count, loff_t *ppos)
 {
 	struct apm_user *	as;
 	size_t			i;
diff -urN linux-2.5/drivers/macintosh/macserial.c pmac-2.5/drivers/macintosh/macserial.c
--- linux-2.5/drivers/macintosh/macserial.c	2003-06-07 08:57:42.000000000 +1000
+++ pmac-2.5/drivers/macintosh/macserial.c	2003-06-07 14:35:34.000000000 +1000
@@ -1496,7 +1496,7 @@
 			if (c <= 0)
 				break;
 
-			c -= copy_from_user(tmp_buf, buf, c);
+			c -= copy_from_user(tmp_buf, (void __user *) buf, c);
 			if (!c) {
 				if (!ret)
 					ret = -EFAULT;
@@ -1694,7 +1694,7 @@
  */
 
 static int get_serial_info(struct mac_serial * info,
-			   struct serial_struct * retinfo)
+			   struct serial_struct __user * retinfo)
 {
 	struct serial_struct tmp;
   
@@ -1716,7 +1716,7 @@
 }
 
 static int set_serial_info(struct mac_serial * info,
-			   struct serial_struct * new_info)
+			   struct serial_struct __user * new_info)
 {
 	struct serial_struct new_serial;
 	struct mac_serial old_info;
@@ -1876,15 +1876,15 @@
 			return set_modem_info(info, cmd, (unsigned int *) arg);
 		case TIOCGSERIAL:
 			return get_serial_info(info,
-					       (struct serial_struct *) arg);
+					(struct serial_struct __user *) arg);
 		case TIOCSSERIAL:
 			return set_serial_info(info,
-					       (struct serial_struct *) arg);
+					(struct serial_struct __user *) arg);
 		case TIOCSERGETLSR: /* Get line status register */
 			return get_lsr_info(info, (unsigned int *) arg);
 
 		case TIOCSERGSTRUCT:
-			if (copy_to_user((struct mac_serial *) arg,
+			if (copy_to_user((struct mac_serial __user *) arg,
 					 info, sizeof(struct mac_serial)))
 				return -EFAULT;
 			return 0;
@@ -2432,7 +2432,7 @@
 
 /* Ask the PROM how many Z8530s we have and initialize their zs_channels */
 static void
-probe_sccs()
+probe_sccs(void)
 {
 	struct device_node *dev, *ch;
 	struct mac_serial **pp;
diff -urN linux-2.5/drivers/macintosh/nvram.c pmac-2.5/drivers/macintosh/nvram.c
--- linux-2.5/drivers/macintosh/nvram.c	2002-12-06 13:56:46.000000000 +1100
+++ pmac-2.5/drivers/macintosh/nvram.c	2003-06-07 17:46:01.000000000 +1000
@@ -39,11 +39,11 @@
 	return file->f_pos;
 }
 
-static ssize_t read_nvram(struct file *file, char *buf,
+static ssize_t read_nvram(struct file *file, char __user *buf,
 			  size_t count, loff_t *ppos)
 {
 	unsigned int i;
-	char *p = buf;
+	char __user *p = buf;
 
 	if (verify_area(VERIFY_WRITE, buf, count))
 		return -EFAULT;
@@ -56,11 +56,11 @@
 	return p - buf;
 }
 
-static ssize_t write_nvram(struct file *file, const char *buf,
+static ssize_t write_nvram(struct file *file, const char __user *buf,
 			   size_t count, loff_t *ppos)
 {
 	unsigned int i;
-	const char *p = buf;
+	const char __user *p = buf;
 	char c;
 
 	if (verify_area(VERIFY_READ, buf, count))
@@ -83,12 +83,12 @@
 		case PMAC_NVRAM_GET_OFFSET:
 		{
 			int part, offset;
-			if (copy_from_user(&part,(void*)arg,sizeof(part))!=0)
+			if (copy_from_user(&part, (void __user*)arg, sizeof(part)) != 0)
 				return -EFAULT;
 			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
 				return -EINVAL;
 			offset = pmac_get_partition(part);
-			if (copy_to_user((void*)arg,&offset,sizeof(offset))!=0)
+			if (copy_to_user((void __user*)arg, &offset, sizeof(offset)) != 0)
 				return -EFAULT;
 			break;
 		}
diff -urN linux-2.5/drivers/macintosh/via-cuda.c pmac-2.5/drivers/macintosh/via-cuda.c
--- linux-2.5/drivers/macintosh/via-cuda.c	2003-04-28 08:28:50.000000000 +1000
+++ pmac-2.5/drivers/macintosh/via-cuda.c	2003-06-07 14:38:00.000000000 +1000
@@ -213,7 +213,7 @@
 
 #ifdef CONFIG_ADB
 static int
-cuda_probe()
+cuda_probe(void)
 {
 #ifdef CONFIG_PPC
     if (sys_ctrler != SYS_CTRLER_CUDA)
@@ -258,7 +258,7 @@
     } while (0)
 
 static int
-cuda_init_via()
+cuda_init_via(void)
 {
     out_8(&via[DIRB], (in_8(&via[DIRB]) | TACK | TIP) & ~TREQ);	/* TACK & TIP out */
     out_8(&via[B], in_8(&via[B]) | TACK | TIP);			/* negate them */
@@ -407,7 +407,7 @@
 }
 
 static void
-cuda_start()
+cuda_start(void)
 {
     struct adb_request *req;
 
@@ -427,7 +427,7 @@
 }
 
 void
-cuda_poll()
+cuda_poll(void)
 {
     unsigned long flags;
 
diff -urN linux-2.5/drivers/macintosh/via-pmu.c pmac-2.5/drivers/macintosh/via-pmu.c
--- linux-2.5/drivers/macintosh/via-pmu.c	2003-06-05 22:27:37.000000000 +1000
+++ pmac-2.5/drivers/macintosh/via-pmu.c	2003-06-07 17:46:48.000000000 +1000
@@ -195,7 +195,7 @@
 #endif /* CONFIG_PMAC_PBOOK */
 static int proc_read_options(char *page, char **start, off_t off,
 			int count, int *eof, void *data);
-static int proc_write_options(struct file *file, const char *buffer,
+static int proc_write_options(struct file *file, const char __user *buffer,
 			unsigned long count, void *data);
 
 #ifdef CONFIG_ADB
@@ -290,7 +290,7 @@
 #endif /* CONFIG_PMAC_BACKLIGHT */
 
 int __openfirmware
-find_via_pmu()
+find_via_pmu(void)
 {
 	if (via != 0)
 		return 1;
@@ -371,7 +371,7 @@
 
 #ifdef CONFIG_ADB
 static int __openfirmware
-pmu_probe()
+pmu_probe(void)
 {
 	return vias == NULL? -ENODEV: 0;
 }
@@ -510,7 +510,7 @@
 device_initcall(via_pmu_dev_init);
 
 static int __openfirmware
-init_pmu()
+init_pmu(void)
 {
 	int timeout;
 	struct adb_request req;
@@ -815,7 +815,7 @@
 }
 			
 static int __pmac
-proc_write_options(struct file *file, const char *buffer,
+proc_write_options(struct file *file, const char __user *buffer,
 			unsigned long count, void *data)
 {
 	char tmp[33];
@@ -1112,7 +1112,7 @@
 }
 
 static void __pmac
-pmu_start()
+pmu_start(void)
 {
 	struct adb_request *req;
 
@@ -1136,7 +1136,7 @@
 }
 
 void __openfirmware
-pmu_poll()
+pmu_poll(void)
 {
 	if (!via)
 		return;
@@ -2402,7 +2402,7 @@
 }
 
 static ssize_t  __pmac
-pmu_read(struct file *file, char *buf,
+pmu_read(struct file *file, char __user *buf,
 			size_t count, loff_t *ppos)
 {
 	struct pmu_private *pp = file->private_data;
@@ -2455,7 +2455,7 @@
 }
 
 static ssize_t __pmac
-pmu_write(struct file *file, const char *buf,
+pmu_write(struct file *file, const char __user *buf,
 			 size_t count, loff_t *ppos)
 {
 	return 0;
