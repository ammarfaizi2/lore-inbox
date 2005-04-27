Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261723AbVD0G4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbVD0G4S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVD0G4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:56:18 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:49023 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261723AbVD0Gzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:55:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 1/6] Toshiba driver cleanup
Date: Wed, 27 Apr 2005 01:50:06 -0500
User-Agent: KMail/1.8
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504270149.13450.dtor_core@ameritech.net>
In-Reply-To: <200504270149.13450.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504270150.06196.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toshiba legacy driver cleanup:
 - use module_init/module_exit for initialization instead of using
   #ifdef MODULE and calling tosh_init manually from drivers/char/misc.c
 - do not explicitly initialize static variables
 - some whitespace and formatting cleanups

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 misc.c    |    4 ----
 toshiba.c |   60 ++++++++++++++++++++++++------------------------------------
 2 files changed, 24 insertions(+), 40 deletions(-)

Index: dtor/drivers/char/toshiba.c
===================================================================
--- dtor.orig/drivers/char/toshiba.c
+++ dtor/drivers/char/toshiba.c
@@ -73,16 +73,20 @@
 
 #define TOSH_MINOR_DEV 181
 
-static int tosh_id = 0x0000;
-static int tosh_bios = 0x0000;
-static int tosh_date = 0x0000;
-static int tosh_sci = 0x0000;
-static int tosh_fan = 0;
-
-static int tosh_fn = 0;
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
+MODULE_DESCRIPTION("Toshiba laptop SMM driver");
+MODULE_SUPPORTED_DEVICE("toshiba");
 
-module_param(tosh_fn, int, 0);
+static int tosh_fn;
+module_param(fn, int, 0);
+MODULE_PARM_DESC(tosh_fn, "User specified Fn key detection port");
 
+static int tosh_id;
+static int tosh_bios;
+static int tosh_date;
+static int tosh_sci;
+static int tosh_fan;
 
 static int tosh_ioctl(struct inode *, struct file *, unsigned int,
 	unsigned long);
@@ -359,7 +363,7 @@ static int tosh_get_machine_id(void)
 	unsigned long address;
 
 	id = (0x100*(int) isa_readb(0xffffe))+((int) isa_readb(0xffffa));
-	
+
 	/* do we have a SCTTable machine identication number on our hands */
 
 	if (id==0xfc2f) {
@@ -424,7 +428,7 @@ static int tosh_probe(void)
 	}
 
 	/* call the Toshiba SCI support check routine */
-	
+
 	regs.eax = 0xf0f0;
 	regs.ebx = 0x0000;
 	regs.ecx = 0x0000;
@@ -440,7 +444,7 @@ static int tosh_probe(void)
 	/* if we get this far then we are running on a Toshiba (probably)! */
 
 	tosh_sci = regs.edx & 0xffff;
-	
+
 	/* next get the machine ID of the current laptop */
 
 	tosh_id = tosh_get_machine_id();
@@ -475,16 +479,15 @@ static int tosh_probe(void)
 	return 0;
 }
 
-int __init tosh_init(void)
+static int __init toshiba_init(void)
 {
 	int retval;
 	/* are we running on a Toshiba laptop */
 
-	if (tosh_probe()!=0)
-		return -EIO;
+	if (tosh_probe())
+		return -ENODEV;
 
-	printk(KERN_INFO "Toshiba System Managment Mode driver v"
-		TOSH_VERSION"\n");
+	printk(KERN_INFO "Toshiba System Managment Mode driver v" TOSH_VERSION "\n");
 
 	/* set the port to use for Fn status if not specified as a parameter */
 	if (tosh_fn==0x00)
@@ -492,12 +495,12 @@ int __init tosh_init(void)
 
 	/* register the device file */
 	retval = misc_register(&tosh_device);
-	if(retval < 0)
+	if (retval < 0)
 		return retval;
 
 #ifdef CONFIG_PROC_FS
 	/* register the proc entry */
-	if(create_proc_info_entry("toshiba", 0, NULL, tosh_get_info) == NULL){
+	if (create_proc_info_entry("toshiba", 0, NULL, tosh_get_info) == NULL) {
 		misc_deregister(&tosh_device);
 		return -ENOMEM;
 	}
@@ -506,27 +509,12 @@ int __init tosh_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-int init_module(void)
-{
-	return tosh_init();
-}
-
-void cleanup_module(void)
+static void __exit toshiba_exit(void)
 {
-	/* remove the proc entry */
-
 	remove_proc_entry("toshiba", NULL);
-
-	/* unregister the device file */
-
 	misc_deregister(&tosh_device);
 }
-#endif
 
-MODULE_LICENSE("GPL");
-MODULE_PARM_DESC(tosh_fn, "User specified Fn key detection port");
-MODULE_AUTHOR("Jonathan Buzzard <jonathan@buzzard.org.uk>");
-MODULE_DESCRIPTION("Toshiba laptop SMM driver");
-MODULE_SUPPORTED_DEVICE("toshiba");
+module_init(toshiba_init);
+module_exit(toshiba_exit);
 
Index: dtor/drivers/char/misc.c
===================================================================
--- dtor.orig/drivers/char/misc.c
+++ dtor/drivers/char/misc.c
@@ -66,7 +66,6 @@ static unsigned char misc_minors[DYNAMIC
 extern int rtc_DP8570A_init(void);
 extern int rtc_MK48T08_init(void);
 extern int pmu_device_init(void);
-extern int tosh_init(void);
 extern int i8k_init(void);
 
 #ifdef CONFIG_PROC_FS
@@ -314,9 +313,6 @@ static int __init misc_init(void)
 #ifdef CONFIG_PMAC_PBOOK
 	pmu_device_init();
 #endif
-#ifdef CONFIG_TOSHIBA
-	tosh_init();
-#endif
 #ifdef CONFIG_I8K
 	i8k_init();
 #endif
