Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVD0HGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVD0HGZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 03:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbVD0HGT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 03:06:19 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:54143 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261745AbVD0Gzn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 6/6] I8K: add new BIOS signatures
Date: Wed, 27 Apr 2005 01:55:28 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504270155.28318.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I8K: add BIOS signatures of a newer Dell laptops, also there can be
     more than one temperature sensor reported by BIOS. Lifted from
     driver 1.25 on Massimo Dal Zotto's site.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 i8k.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

Index: dtor/drivers/char/i8k.c
===================================================================
--- dtor.orig/drivers/char/i8k.c
+++ dtor/drivers/char/i8k.c
@@ -35,7 +35,8 @@
 #define I8K_SMM_GET_FAN		0x00a3
 #define I8K_SMM_GET_SPEED	0x02a3
 #define I8K_SMM_GET_TEMP	0x10a3
-#define I8K_SMM_GET_DELL_SIG	0xffa3
+#define I8K_SMM_GET_DELL_SIG1	0xfea3
+#define I8K_SMM_GET_DELL_SIG2	0xffa3
 #define I8K_SMM_BIOS_VERSION	0x00a6
 
 #define I8K_FAN_MULT		30
@@ -226,7 +227,7 @@ static int i8k_set_fan(int fan, int spee
 /*
  * Read the cpu temperature.
  */
-static int i8k_get_cpu_temp(void)
+static int i8k_get_temp(int sensor)
 {
 	struct smm_regs regs = { .eax = I8K_SMM_GET_TEMP, };
 	int rc;
@@ -235,7 +236,7 @@ static int i8k_get_cpu_temp(void)
 #ifdef I8K_TEMPERATURE_BUG
 	static int prev;
 #endif
-
+	regs.ebx = sensor & 0xff;
 	if ((rc = i8k_smm(&regs)) < 0)
 		return rc;
 
@@ -260,9 +261,9 @@ static int i8k_get_cpu_temp(void)
 	return temp;
 }
 
-static int i8k_get_dell_signature(void)
+static int i8k_get_dell_signature(int req_fn)
 {
-	struct smm_regs regs = { .eax = I8K_SMM_GET_DELL_SIG, };
+	struct smm_regs regs = { .eax = req_fn, };
 	int rc;
 
 	if ((rc = i8k_smm(&regs)) < 0)
@@ -301,7 +302,7 @@ static int i8k_ioctl(struct inode *ip, s
 		break;
 
 	case I8K_GET_TEMP:
-		val = i8k_get_cpu_temp();
+		val = i8k_get_temp(0);
 		break;
 
 	case I8K_GET_SPEED:
@@ -367,7 +368,7 @@ static int i8k_proc_show(struct seq_file
 	int fn_key, cpu_temp, ac_power;
 	int left_fan, right_fan, left_speed, right_speed;
 
-	cpu_temp	= i8k_get_cpu_temp();			/* 11100 탎 */
+	cpu_temp	= i8k_get_temp(0);			/* 11100 탎 */
 	left_fan	= i8k_get_fan_status(I8K_FAN_LEFT);	/*   580 탎 */
 	right_fan	= i8k_get_fan_status(I8K_FAN_RIGHT);	/*   580 탎 */
 	left_speed	= i8k_get_fan_speed(I8K_FAN_LEFT);	/*   580 탎 */
@@ -421,6 +422,20 @@ static struct dmi_system_id __initdata i
 			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
 		},
 	},
+	{
+		.ident = "Dell Inspiron 2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron"),
+		},
+	},
+	{
+		.ident = "Dell Latitude 2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
 	{ }
 };
 
@@ -451,7 +466,8 @@ static int __init i8k_probe(void)
 	/*
 	 * Get SMM Dell signature
 	 */
-	if (i8k_get_dell_signature() != 0) {
+	if (i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG1) &&
+	    i8k_get_dell_signature(I8K_SMM_GET_DELL_SIG2)) {
 		printk(KERN_ERR "i8k: unable to get SMM Dell signature\n");
 		if (!force)
 			return -ENODEV;
