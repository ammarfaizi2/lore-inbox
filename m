Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263701AbTCUSPB>; Fri, 21 Mar 2003 13:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263697AbTCUSNk>; Fri, 21 Mar 2003 13:13:40 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:43651
	"EHLO hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263693AbTCUSNJ>; Fri, 21 Mar 2003 13:13:09 -0500
Date: Fri, 21 Mar 2003 19:28:24 GMT
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-Id: <200303211928.h2LJSOkl025789@hraefn.swansea.linux.org.uk>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: PATCH: clean up ht6560 legacy ide driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/legacy/ht6560b.c linux-2.5.65-ac2/drivers/ide/legacy/ht6560b.c
--- linux-2.5.65/drivers/ide/legacy/ht6560b.c	2003-03-03 19:20:09.000000000 +0000
+++ linux-2.5.65-ac2/drivers/ide/legacy/ht6560b.c	2003-03-20 18:23:19.000000000 +0000
@@ -312,42 +312,7 @@
 #endif
 }
 
-void __init probe_ht6560b (void)
-{
-	int t;
-	
-	request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name);
-	ide_hwifs[0].chipset = ide_ht6560b;
-	ide_hwifs[1].chipset = ide_ht6560b;
-	ide_hwifs[0].selectproc = &ht6560b_selectproc;
-	ide_hwifs[1].selectproc = &ht6560b_selectproc;
-	ide_hwifs[0].tuneproc = &tune_ht6560b;
-	ide_hwifs[1].tuneproc = &tune_ht6560b;
-	ide_hwifs[0].serialized = 1;  /* is this needed? */
-	ide_hwifs[1].serialized = 1;  /* is this needed? */
-	ide_hwifs[0].mate = &ide_hwifs[1];
-	ide_hwifs[1].mate = &ide_hwifs[0];
-	ide_hwifs[1].channel = 1;
-			
-	/*
-	 * Setting default configurations for drives
-	 */
-	t = (HT_CONFIG_DEFAULT << 8);
-	t |= HT_TIMING_DEFAULT;
-	ide_hwifs[0].drives[0].drive_data = t;
-	ide_hwifs[0].drives[1].drive_data = t;
-	t |= (HT_SECONDARY_IF << 8);
-	ide_hwifs[1].drives[0].drive_data = t;
-	ide_hwifs[1].drives[1].drive_data = t;
-
-#ifndef HWIF_PROBE_CLASSIC_METHOD
-	probe_hwif_init(&ide_hwifs[0]);
-	probe_hwif_init(&ide_hwifs[1]);
-#endif /* HWIF_PROBE_CLASSIC_METHOD */
-
-}
-
-void __init ht6560b_release (void)
+void ht6560b_release (void)
 {
 	if (ide_hwifs[0].chipset != ide_ht6560b &&
 	    ide_hwifs[1].chipset != ide_ht6560b)
@@ -371,60 +336,80 @@
 	release_region(HT_CONFIG_PORT, 1);
 }
 
-#ifndef MODULE
-/*
- * init_ht6560b:
- *
- * called by ide.c when parsing command line
- */
-
-void __init init_ht6560b (void)
+int __init ht6560b_mod_init(void)
 {
-	if (check_region(HT_CONFIG_PORT,1)) {
+	int t;
+
+	if (!request_region(HT_CONFIG_PORT, 1, ide_hwifs[0].name)) {
 		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
 			__FUNCTION__);
-		return;
+		return -ENODEV;
 	}
+
 	if (!try_to_init_ht6560b()) {
-                printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
-		return;
+		printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
+		goto release_region;
 	}
-	probe_ht6560b();
-}
 
-#else
+	ide_hwifs[0].chipset = ide_ht6560b;
+	ide_hwifs[1].chipset = ide_ht6560b;
+	ide_hwifs[0].selectproc = &ht6560b_selectproc;
+	ide_hwifs[1].selectproc = &ht6560b_selectproc;
+	ide_hwifs[0].tuneproc = &tune_ht6560b;
+	ide_hwifs[1].tuneproc = &tune_ht6560b;
+	ide_hwifs[0].serialized = 1;  /* is this needed? */
+	ide_hwifs[1].serialized = 1;  /* is this needed? */
+	ide_hwifs[0].mate = &ide_hwifs[1];
+	ide_hwifs[1].mate = &ide_hwifs[0];
+	ide_hwifs[1].channel = 1;
 
-MODULE_AUTHOR("See Local File");
-MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
-MODULE_LICENSE("GPL");
+	/*
+	 * Setting default configurations for drives
+	 */
+	t = (HT_CONFIG_DEFAULT << 8);
+	t |= HT_TIMING_DEFAULT;
+	ide_hwifs[0].drives[0].drive_data = t;
+	ide_hwifs[0].drives[1].drive_data = t;
+	t |= (HT_SECONDARY_IF << 8);
+	ide_hwifs[1].drives[0].drive_data = t;
+	ide_hwifs[1].drives[1].drive_data = t;
 
-int __init ht6560b_mod_init(void)
-{
-	if (check_region(HT_CONFIG_PORT,1)) {
-		printk(KERN_NOTICE "%s: HT_CONFIG_PORT not found\n",
-			__FUNCTION__);
-		return -ENODEV;
-	}
+	probe_hwif_init(&ide_hwifs[0]);
+	probe_hwif_init(&ide_hwifs[1]);
 
-	if (!try_to_init_ht6560b()) {
-		printk(KERN_NOTICE "%s: HBA not found\n", __FUNCTION__);
+#ifdef MODULE
+	if (ide_hwifs[0].chipset != ide_ht6560b &&
+	    ide_hwifs[1].chipset != ide_ht6560b) {
+		ht6560b_release();
 		return -ENODEV;
 	}
+#endif
 
-	probe_ht6560b();
-        if (ide_hwifs[0].chipset != ide_ht6560b &&
-            ide_hwifs[1].chipset != ide_ht6560b) {
-                ht6560b_release();
-                return -ENODEV;
-        }
-        return 0;
+	return 0;
+
+release_region:
+	release_region(HT_CONFIG_PORT, 1);
+	return -ENODEV;
 }
-module_init(ht6560b_mod_init);
 
+MODULE_AUTHOR("See Local File");
+MODULE_DESCRIPTION("HT-6560B EIDE-controller support");
+MODULE_LICENSE("GPL");
+
+#ifdef MODULE
 void __init ht6560b_mod_exit(void)
 {
         ht6560b_release();
 }
+
+module_init(ht6560b_mod_init);
 module_exit(ht6560b_mod_exit);
+#else
+/*
+ * called by ide.c when parsing command line
+ */
+void __init init_ht6560b (void)
+{
+	ht6560b_mod_init();	/* ignore return value */
+}
 #endif
-
