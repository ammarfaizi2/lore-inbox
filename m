Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751011AbWFFTkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751011AbWFFTkk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 15:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751018AbWFFTkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 15:40:40 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:58829
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1750982AbWFFTkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 15:40:39 -0400
Subject: [PATCH] fix missing hdlc symbols for synclink drivers
From: Paul Fulghum <paulkf@microgate.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org,
       zippel@linux-m68k.org
In-Reply-To: <20060605184407.230bcf73.rdunlap@xenotime.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	 <20060605230248.GE3963@redhat.com>
	 <20060605184407.230bcf73.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 14:40:13 -0500
Message-Id: <1149622813.11929.3.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy:

This patch of yours is the only way I've found to
fix the random config build errors and maintain
the necessary flexibility of configuration for the
synclink drivers. I added the synclink_cs config to
the end of your patch.

--

From: Randy Dunlap <rdunlap@xenotime.net>

Fix many missing hdlc_generic symbols when CONFIG_HDLC=m.
When Selecting HDLC, also Select WAN.
Fix Makefile to build for HDLC=y or HDLC=m.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Paul Fulghum <paulkf@microgate.com>


--- linux-2.6.17-rc5-mm3/drivers/net/wan/Makefile	2006-06-06 14:03:59.000000000 -0500
+++ b/drivers/net/wan/Makefile	2006-06-06 14:08:53.000000000 -0500
@@ -9,14 +9,18 @@ cyclomx-y                       := cycx_
 cyclomx-$(CONFIG_CYCLOMX_X25)	+= cycx_x25.o
 cyclomx-objs			:= $(cyclomx-y)  
 
-hdlc-y				:= hdlc_generic.o
+hdlc-$(CONFIG_HDLC)		:= hdlc_generic.o
 hdlc-$(CONFIG_HDLC_RAW)		+= hdlc_raw.o
 hdlc-$(CONFIG_HDLC_RAW_ETH)	+= hdlc_raw_eth.o
 hdlc-$(CONFIG_HDLC_CISCO)	+= hdlc_cisco.o
 hdlc-$(CONFIG_HDLC_FR)		+= hdlc_fr.o
 hdlc-$(CONFIG_HDLC_PPP)		+= hdlc_ppp.o
 hdlc-$(CONFIG_HDLC_X25)		+= hdlc_x25.o
-hdlc-objs			:= $(hdlc-y)
+ifeq ($(CONFIG_HDLC),y)
+  hdlc-objs			:= $(hdlc-y)
+else
+  hdlc-objs			:= $(hdlc-m)
+endif
 
 pc300-y				:= pc300_drv.o
 pc300-$(CONFIG_PC300_MLPPP)	+= pc300_tty.o
--- linux-2.6.17-rc5-mm3/drivers/char/Kconfig	2006-06-06 14:03:58.000000000 -0500
+++ b/drivers/char/Kconfig	2006-06-06 14:08:53.000000000 -0500
@@ -197,6 +197,7 @@ config ISI
 config SYNCLINK
 	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
+	select WAN if SYNCLINK_HDLC
 	select HDLC if SYNCLINK_HDLC
 	help
 	  Driver for SyncLink ISA and PCI synchronous serial adapters.
@@ -214,6 +215,7 @@ config SYNCLINK_HDLC
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINKMP_HDLC
 	select HDLC if SYNCLINKMP_HDLC
 	help
 	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
@@ -231,6 +233,7 @@ config SYNCLINKMP_HDLC
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
+	select WAN if SYNCLINK_GT_HDLC
 	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
--- linux-2.6.17-rc5-mm3/drivers/char/pcmcia/Kconfig	2006-06-06 14:03:58.000000000 -0500
+++ b/drivers/char/pcmcia/Kconfig	2006-06-06 14:09:25.000000000 -0500
@@ -8,6 +8,7 @@ menu "PCMCIA character devices"
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
+	select WAN if SYNCLINK_CS_HDLC
 	select HDLC if SYNCLINK_CS_HDLC
 	help
 	  Driver for SyncLink PC Card synchronous serial adapter.


