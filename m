Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267476AbSLFBDt>; Thu, 5 Dec 2002 20:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267482AbSLFBDt>; Thu, 5 Dec 2002 20:03:49 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:35280 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S267476AbSLFBDr>; Thu, 5 Dec 2002 20:03:47 -0500
Date: Fri, 6 Dec 2002 02:11:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Jochen Friedrich <jochen@scram.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.or
Subject: [patch] fix compile warning and initialization of static tmsisa
Message-ID: <20021206011121.GY2544@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jochen,

as already discussed some months ago the patch below contains the 
follosing fixes for the static compile of tmsisa:
- fixes a "`portlist' defined but not used" compile time warning by
  moving portlist below an #ifdef MODULE
- call tms_isa_probe in Space.c for intialization

The patch compiles against 2.5.50 and applies against 2.4.20.

Please comment on whether it's correct or not and if it's correct 
please apply.

TIA
Adrian


--- l/drivers/net/Space.c.old	Mon Dec 17 00:44:29 2001
+++ l/drivers/net/Space.c	Mon Dec 17 00:49:00 2001
@@ -540,6 +540,7 @@
 #ifdef CONFIG_TR
 /* Token-ring device probe */
 extern int ibmtr_probe(struct net_device *);
+extern int tms_isa_probe(struct net_device *dev);
 extern int smctr_probe(struct net_device *);

 static int
@@ -548,6 +549,9 @@
     if (1
 #ifdef CONFIG_IBMTR
 	&& ibmtr_probe(dev)
+#endif
+#ifdef CONFIG_TMSISA
+	&& tms_isa_probe(dev)
 #endif
 #ifdef CONFIG_SMCTR
 	&& smctr_probe(dev)


--- l/drivers/net/tokenring/tmsisa.c.old	2002-12-06 01:51:02.000000000 +0100
+++ l/drivers/net/tokenring/tmsisa.c	2002-12-06 01:54:58.000000000 +0100
@@ -39,12 +39,6 @@
 
 #define TMS_ISA_IO_EXTENT 32
 
-/* A zero-terminated list of I/O addresses to be probed. */
-static unsigned int portlist[] __initdata = {
-	0x0A20, 0x1A20, 0x0B20, 0x1B20, 0x0980, 0x1980, 0x0900, 0x1900,// SK
-	0
-};
-
 /* A zero-terminated list of IRQs to be probed. 
  * Used again after initial probe for sktr_chipset_init, called from sktr_open.
  */
@@ -367,6 +361,12 @@
 
 #define ISATR_MAX_ADAPTERS 3
 
+/* A zero-terminated list of I/O addresses to be probed. */
+static unsigned int portlist[] __initdata = {
+  0x0A20, 0x1A20, 0x0B20, 0x1B20, 0x0980, 0x1980, 0x0900, 0x1900,// SK
+        0
+};
+
 static int io[ISATR_MAX_ADAPTERS];
 static int irq[ISATR_MAX_ADAPTERS];
 static int dma[ISATR_MAX_ADAPTERS];
