Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVJXQ77@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVJXQ77 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVJXQ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:59:59 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:6887 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751169AbVJXQ76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:59:58 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] rocketport: make it work when statically linked into kernel
Date: Mon, 24 Oct 2005 10:59:54 -0600
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, Wolfgang Denk <wd@denx.de>,
       support@comtrol.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510241059.54259.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The driver had incorrectly wrapped module_init(rp_init) in #ifdef MODULE,
so it worked only when compiled as a module.

Tested by Wolfgang Denk with this device:

    00:0e.0 Communication controller: Comtrol Corporation RocketPort 8 port w/RJ11 connectors (rev 04)
        Control: I/O+ Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=slow >TAbort- <TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 11
        Region 0: I/O ports at 7000 [size=64]

I also added the Comtrol support email address to MAINTAINERS.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

Index: denk/drivers/char/rocket.c
===================================================================
--- denk.orig/drivers/char/rocket.c	2005-10-24 10:49:03.000000000 -0600
+++ denk/drivers/char/rocket.c	2005-10-24 10:49:04.000000000 -0600
@@ -256,7 +256,6 @@
 static int sReadAiopID(ByteIO_t io);
 static int sReadAiopNumChan(WordIO_t io);
 
-#ifdef MODULE
 MODULE_AUTHOR("Theodore Ts'o");
 MODULE_DESCRIPTION("Comtrol RocketPort driver");
 module_param(board1, ulong, 0);
@@ -288,17 +287,14 @@
 module_param_array(pc104_4, ulong, NULL, 0);
 MODULE_PARM_DESC(pc104_4, "set interface types for ISA(PC104) board #4 (e.g. pc104_4=232,232,485,485,...");
 
-int rp_init(void);
+static int rp_init(void);
 static void rp_cleanup_module(void);
 
 module_init(rp_init);
 module_exit(rp_cleanup_module);
 
-#endif
 
-#ifdef MODULE_LICENSE
 MODULE_LICENSE("Dual BSD/GPL");
-#endif
 
 /*************************************************************************/
 /*                     Module code starts here                           */
@@ -2378,7 +2374,7 @@
 /*
  * The module "startup" routine; it's run when the module is loaded.
  */
-int __init rp_init(void)
+static int __init rp_init(void)
 {
 	int retval, pci_boards_found, isa_boards_found, i;
 
@@ -2502,7 +2498,6 @@
 	return 0;
 }
 
-#ifdef MODULE
 
 static void rp_cleanup_module(void)
 {
@@ -2530,7 +2525,6 @@
 	if (controller)
 		release_region(controller, 4);
 }
-#endif
 
 /***************************************************************************
 Function: sInitController
Index: denk/MAINTAINERS
===================================================================
--- denk.orig/MAINTAINERS	2005-10-24 10:49:03.000000000 -0600
+++ denk/MAINTAINERS	2005-10-24 10:49:04.000000000 -0600
@@ -2041,6 +2041,7 @@
 
 ROCKETPORT DRIVER
 P:	Comtrol Corp.
+M:	support@comtrol.com
 W:	http://www.comtrol.com
 S:	Maintained
 
