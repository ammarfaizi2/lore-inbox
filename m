Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269518AbUIZMXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269518AbUIZMXb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 08:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269520AbUIZMXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 08:23:31 -0400
Received: from verein.lst.de ([213.95.11.210]:42892 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269518AbUIZMXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 08:23:23 -0400
Date: Sun, 26 Sep 2004 14:23:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] redue ifdef clutter in arch/ppc64/kernel/idle.c
Message-ID: <20040926122321.GA2265@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- 1.26/arch/ppc64/kernel/idle.c	2004-09-22 11:56:16 +02:00
+++ edited/arch/ppc64/kernel/idle.c	2004-09-25 17:20:32 +02:00
@@ -334,20 +334,24 @@
 }
 __initcall(register_powersave_nap_sysctl);
 #endif
+	
+/*
+ * Move that junk to each platform specific file, eventually define
+ * a pSeries_idle for shared processor stuff
+ */
 
-int idle_setup(void)
-{
-	/*
-	 * Move that junk to each platform specific file, eventually define
-	 * a pSeries_idle for shared processor stuff
-	 */
 #ifdef CONFIG_PPC_ISERIES
+static void iseries_idle_setup(void)
+{
 	idle_loop = iSeries_idle;
-	return 1;
+}
 #else
-	idle_loop = default_idle;
+# define iseries_idle_setup()	do { } while (0)
 #endif
+
 #ifdef CONFIG_PPC_PSERIES
+static void pseries_idle_setup(void)
+{
 	if (systemcfg->platform & PLATFORM_PSERIES) {
 		if (cur_cpu_spec->firmware_features & FW_FEATURE_SPLPAR) {
 			if (get_paca()->lppaca.xSharedProc) {
@@ -362,13 +366,30 @@
 			idle_loop = default_idle;
 		}
 	}
-#endif /* CONFIG_PPC_PSERIES */
+}
+#else
+# define pseries_idle_setup()	do { } while (0)
+#endif
+
 #ifdef CONFIG_PPC_PMAC
+static void pmac_idle_setup(void)
+{
 	if (systemcfg->platform == PLATFORM_POWERMAC) {
 		printk(KERN_INFO "Using native/NAP idle loop\n");
 		idle_loop = native_idle;
 	}
-#endif /* CONFIG_PPC_PMAC */
+}
+#else
+# define pmac_idle_setup()	do { } while (0)
+#endif
+
+int idle_setup(void)
+{
+	idle_loop = default_idle;
+
+	iseries_idle_setup();
+	pseries_idle_setup();
+	pmac_idle_setup();
 
 	return 1;
 }
