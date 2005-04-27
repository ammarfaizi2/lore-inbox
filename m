Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVD0HG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVD0HG0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVD0HFh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:05:37 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:53119 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261743AbVD0Gzm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:42 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 5/6] I8K: initialization code cleanup; formatting
Date: Wed, 27 Apr 2005 01:54:40 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504270154.40651.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I8K: use module_{init|exit} instead of old style #ifdef MODULE
     code, some formatting changes.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 i8k.c  |  149 ++++++++++++++++++++---------------------------------------------
 misc.c |    4 -
 2 files changed, 47 insertions(+), 106 deletions(-)

Index: dtor/drivers/char/misc.c
===================================================================
--- dtor.orig/drivers/char/misc.c
+++ dtor/drivers/char/misc.c
@@ -66,7 +66,6 @@ static unsigned char misc_minors[DYNAMIC
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
 extern int pmu_device_init(void);
-extern int i8k_init(void);
 
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -313,9 +312,6 @@ static int __init misc_init(void)
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_device_init();
 #endif
-#ifdef CONFIG_I8K
-	i8k_init();
-#endif
 	if (register_chrdev(MISC_MAJOR,"misc",&misc_fops)) {
 		printk("unable to get major %d for misc devices\n",
 		       MISC_MAJOR);
Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -87,14 +87,14 @@ static struct file_operations i8k_fops =
 	.ioctl		= i8k_ioctl,
 };
 
-typedef struct {
+struct smm_regs {
 	unsigned int eax;
 	unsigned int ebx __attribute__ ((packed));
 	unsigned int ecx __attribute__ ((packed));
 	unsigned int edx __attribute__ ((packed));
 	unsigned int esi __attribute__ ((packed));
 	unsigned int edi __attribute__ ((packed));
-} SMMRegisters;
+};
 
 static inline char *i8k_get_dmi_data(int field)
 {
@@ -104,7 +104,7 @@ static inline char *i8k_get_dmi_data(int
 /*
  * Call the System Management Mode BIOS. Code provided by Jonathan Buzzard.
  */
-static int i8k_smm(SMMRegisters * regs)
+static int i8k_smm(struct smm_regs *regs)
 {
 	int rc;
 	int eax = regs->eax;
@@ -134,9 +134,8 @@ static int i8k_smm(SMMRegisters * regs)
 	    :    "a"(regs)
 	    :    "%ebx", "%ecx", "%edx", "%esi", "%edi", "memory");
 
-	if ((rc != 0) || ((regs->eax & 0xffff) == 0xffff) || (regs->eax == eax)) {
+	if (rc != 0 || (regs->eax & 0xffff) == 0xffff || regs->eax == eax)
 		return -EINVAL;
-	}
 
 	return 0;
 }
@@ -147,15 +146,9 @@ static int i8k_smm(SMMRegisters * regs)
  */
 static int i8k_get_bios_version(void)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-	int rc;
-
-	regs.eax = I8K_SMM_BIOS_VERSION;
-	if ((rc = i8k_smm(&regs)) < 0) {
-		return rc;
-	}
+	struct smm_regs regs = { .eax = I8K_SMM_BIOS_VERSION, };
 
-	return regs.eax;
+	return i8k_smm(&regs) ? : regs.eax;
 }
 
 /*
@@ -163,13 +156,11 @@ static int i8k_get_bios_version(void)
  */
 static int i8k_get_fn_status(void)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	struct smm_regs regs = { .eax = I8K_SMM_FN_STATUS, };
 	int rc;
 
-	regs.eax = I8K_SMM_FN_STATUS;
-	if ((rc = i8k_smm(&regs)) < 0) {
+	if ((rc = i8k_smm(&regs)) < 0)
 		return rc;
-	}
 
 	switch ((regs.eax >> I8K_FN_SHIFT) & I8K_FN_MASK) {
 	case I8K_FN_UP:
@@ -188,20 +179,13 @@ static int i8k_get_fn_status(void)
  */
 static int i8k_get_power_status(void)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	struct smm_regs regs = { .eax = I8K_SMM_POWER_STATUS, };
 	int rc;
 
-	regs.eax = I8K_SMM_POWER_STATUS;
-	if ((rc = i8k_smm(&regs)) < 0) {
+	if ((rc = i8k_smm(&regs)) < 0)
 		return rc;
-	}
 
-	switch (regs.eax & 0xff) {
-	case I8K_POWER_AC:
-		return I8K_AC;
-	default:
-		return I8K_BATTERY;
-	}
+	return (regs.eax & 0xff) == I8K_POWER_AC ? I8K_AC : I8K_BATTERY;
 }
 
 /*
@@ -209,16 +193,10 @@ static int i8k_get_power_status(void)
  */
 static int i8k_get_fan_status(int fan)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-	int rc;
+	struct smm_regs regs = { .eax = I8K_SMM_GET_FAN, };
 
-	regs.eax = I8K_SMM_GET_FAN;
 	regs.ebx = fan & 0xff;
-	if ((rc = i8k_smm(&regs)) < 0) {
-		return rc;
-	}
-
-	return (regs.eax & 0xff);
+	return i8k_smm(&regs) ? : regs.eax & 0xff;
 }
 
 /*
@@ -226,16 +204,10 @@ static int i8k_get_fan_status(int fan)
  */
 static int i8k_get_fan_speed(int fan)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-	int rc;
+	struct smm_regs regs = { .eax = I8K_SMM_GET_SPEED, };
 
-	regs.eax = I8K_SMM_GET_SPEED;
 	regs.ebx = fan & 0xff;
-	if ((rc = i8k_smm(&regs)) < 0) {
-		return rc;
-	}
-
-	return (regs.eax & 0xffff) * I8K_FAN_MULT;
+	return i8k_smm(&regs) ? : (regs.eax & 0xffff) * I8K_FAN_MULT;
 }
 
 /*
@@ -243,18 +215,12 @@ static int i8k_get_fan_speed(int fan)
  */
 static int i8k_set_fan(int fan, int speed)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
-	int rc;
+	struct smm_regs regs = { .eax = I8K_SMM_SET_FAN, };
 
 	speed = (speed < 0) ? 0 : ((speed > I8K_FAN_MAX) ? I8K_FAN_MAX : speed);
-
-	regs.eax = I8K_SMM_SET_FAN;
 	regs.ebx = (fan & 0xff) | (speed << 8);
-	if ((rc = i8k_smm(&regs)) < 0) {
-		return rc;
-	}
 
-	return (i8k_get_fan_status(fan));
+	return i8k_smm(&regs) ? : i8k_get_fan_status(fan);
 }
 
 /*
@@ -262,18 +228,17 @@ static int i8k_set_fan(int fan, int spee
  */
 static int i8k_get_cpu_temp(void)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, };
 	int rc;
 	int temp;
 
 #ifdef I8K_TEMPERATURE_BUG
-	static int prev = 0;
+	static int prev;
 #endif
 
-	regs.eax = I8K_SMM_GET_TEMP;
-	if ((rc = i8k_smm(&regs)) < 0) {
+	if ((rc = i8k_smm(&regs)) < 0)
 		return rc;
-	}
+
 	temp = regs.eax & 0xff;
 
 #ifdef I8K_TEMPERATURE_BUG
@@ -297,19 +262,13 @@ static int i8k_get_cpu_temp(void)
 
 static int i8k_get_dell_signature(void)
 {
-	SMMRegisters regs = { 0, 0, 0, 0, 0, 0 };
+	struct smm_regs regs = { .eax = I8K_SMM_GET_DELL_SIG, };
 	int rc;
 
-	regs.eax = I8K_SMM_GET_DELL_SIG;
-	if ((rc = i8k_smm(&regs)) < 0) {
+	if ((rc = i8k_smm(&regs)) < 0)
 		return rc;
-	}
 
-	if ((regs.eax == 1145651527) && (regs.edx == 1145392204)) {
-		return 0;
-	} else {
-		return -1;
-	}
+	return regs.eax == 1145651527 && regs.edx == 1145392204 ? 0 : -1;
 }
 
 static int i8k_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
@@ -346,29 +305,29 @@ static int i8k_ioctl(struct inode *ip, s
 		break;
 
 	case I8K_GET_SPEED:
-		if (copy_from_user(&val, argp, sizeof(int))) {
+		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;
-		}
+
 		val = i8k_get_fan_speed(val);
 		break;
 
 	case I8K_GET_FAN:
-		if (copy_from_user(&val, argp, sizeof(int))) {
+		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;
-		}
+
 		val = i8k_get_fan_status(val);
 		break;
 
 	case I8K_SET_FAN:
-		if (restricted && !capable(CAP_SYS_ADMIN)) {
+		if (restricted && !capable(CAP_SYS_ADMIN))
 			return -EPERM;
-		}
-		if (copy_from_user(&val, argp, sizeof(int))) {
+
+		if (copy_from_user(&val, argp, sizeof(int)))
 			return -EFAULT;
-		}
-		if (copy_from_user(&speed, argp + 1, sizeof(int))) {
+
+		if (copy_from_user(&speed, argp + 1, sizeof(int)))
 			return -EFAULT;
-		}
+
 		val = i8k_set_fan(val, speed);
 		break;
 
@@ -376,25 +335,24 @@ static int i8k_ioctl(struct inode *ip, s
 		return -EINVAL;
 	}
 
-	if (val < 0) {
+	if (val < 0)
 		return val;
-	}
 
 	switch (cmd) {
 	case I8K_BIOS_VERSION:
-		if (copy_to_user(argp, &val, 4)) {
+		if (copy_to_user(argp, &val, 4))
 			return -EFAULT;
-		}
+
 		break;
 	case I8K_MACHINE_ID:
-		if (copy_to_user(argp, buff, 16)) {
+		if (copy_to_user(argp, buff, 16))
 			return -EFAULT;
-		}
+
 		break;
 	default:
-		if (copy_to_user(argp, &val, sizeof(int))) {
+		if (copy_to_user(argp, &val, sizeof(int)))
 			return -EFAULT;
-		}
+
 		break;
 	}
 
@@ -415,11 +373,10 @@ static int i8k_proc_show(struct seq_file
 	left_speed	= i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
 	right_speed	= i8k_get_fan_speed(I8K_FAN_RIGHT);	/*   580 탎 */
 	fn_key		= i8k_get_fn_status();			/*   750 탎 */
-	if (power_status) {
+	if (power_status)
 		ac_power = i8k_get_power_status();		/* 14700 탎 */
-	} else {
+	else
 		ac_power = -1;
-	}
 
 	/*
 	 * Info:
@@ -528,10 +485,7 @@ static int __init i8k_probe(void)
 	return 0;
 }
 
-#ifdef MODULE
-static
-#endif
-int __init i8k_init(void)
+static int __init i8k_init(void)
 {
 	struct proc_dir_entry *proc_i8k;
 
@@ -554,19 +508,10 @@ int __init i8k_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void)
+static void __exit i8k_exit(void)
 {
-	return i8k_init();
-}
-
-void cleanup_module(void)
-{
-	/* Remove the proc entry */
 	remove_proc_entry("i8k", NULL);
-
-	printk(KERN_INFO "i8k: module unloaded\n");
 }
-#endif
 
-/* end of file */
+module_init(i8k_init);
+module_exit(i8k_exit);
