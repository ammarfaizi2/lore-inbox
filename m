Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268168AbUIBKmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268168AbUIBKmm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 06:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268132AbUIBKml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 06:42:41 -0400
Received: from ozlabs.org ([203.10.76.45]:51343 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268185AbUIBKlm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 06:41:42 -0400
Date: Thu, 2 Sep 2004 20:40:18 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org, olof@austin.ibm.com
Subject: [PATCH] [ppc64] Setup fw_features before init_early calls on pSeries
Message-ID: <20040902104018.GY26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Olof Johansson <olof@austin.ibm.com>

To be able to use the cur_cpu_spec->firmware_features values
in early setup, the function initializing them has to be moved
up to before the early init calls.

Signed-off-by: Olof Johansson <olof@austin.ibm.com>
Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/chrp_setup.c~fw-feature-early-init arch/ppc64/kernel/chrp_setup.c
--- linux-2.5/arch/ppc64/kernel/chrp_setup.c~fw-feature-early-init	2004-09-01 21:53:59.009978040 -0500
+++ linux-2.5-olof/arch/ppc64/kernel/chrp_setup.c	2004-09-01 21:53:59.016976976 -0500
@@ -229,10 +229,6 @@ void __init
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
-	struct device_node * dn;
-	char * hypertas;
-	unsigned int len;
-
 	ppc_md.setup_arch     = chrp_setup_arch;
 	ppc_md.get_cpuinfo    = chrp_get_cpuinfo;
 	if (naca->interrupt_controller == IC_OPEN_PIC) {
@@ -261,10 +257,18 @@ chrp_init(unsigned long r3, unsigned lon
 
 	ppc_md.progress       = chrp_progress;
 
-        /* Build up the firmware_features bitmask field
-         * using contents of device-tree/ibm,hypertas-functions.
-         * Ultimately this functionality may be moved into prom.c prom_init().
-         */
+}
+
+/* Build up the firmware_features bitmask field
+ * using contents of device-tree/ibm,hypertas-functions.
+ * Ultimately this functionality may be moved into prom.c prom_init().
+ */
+void __init fw_feature_init(void)
+{
+	struct device_node * dn;
+	char * hypertas;
+	unsigned int len;
+
 	cur_cpu_spec->firmware_features = 0;
 	dn = of_find_node_by_path("/rtas");
 	if (dn == NULL) {
diff -puN arch/ppc64/kernel/setup.c~fw-feature-early-init arch/ppc64/kernel/setup.c
--- linux-2.5/arch/ppc64/kernel/setup.c~fw-feature-early-init	2004-09-01 21:53:59.011977736 -0500
+++ linux-2.5-olof/arch/ppc64/kernel/setup.c	2004-09-01 21:54:19.513923016 -0500
@@ -67,6 +67,7 @@ extern void  pmac_init(unsigned long r3,
 		       unsigned long r6,
 		       unsigned long r7);
 
+extern void fw_feature_init(void);
 extern void iSeries_init( void );
 extern void iSeries_init_early( void );
 extern void pSeries_init_early( void );
@@ -279,11 +280,13 @@ void setup_system(unsigned long r3, unsi
 
 #ifdef CONFIG_PPC_PSERIES
 	case PLATFORM_PSERIES:
+		fw_feature_init();
 		pSeries_init_early();
 		parse_bootinfo();
 		break;
 
 	case PLATFORM_PSERIES_LPAR:
+		fw_feature_init();
 		pSeriesLP_init_early();
 		parse_bootinfo();
 		break;

_

