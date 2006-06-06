Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751215AbWFFCRE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWFFCRE (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:17:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFFCRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:17:04 -0400
Received: from xenotime.net ([66.160.160.81]:32984 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751215AbWFFCRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:17:03 -0400
Date: Mon, 5 Jun 2006 19:19:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: paulkf@microgate.com
Cc: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
Message-Id: <20060605191951.1ee122d3.rdunlap@xenotime.net>
In-Reply-To: <20060605190355.c1be6d75.rdunlap@xenotime.net>
References: <20060603232004.68c4e1e3.akpm@osdl.org>
	<20060605230248.GE3963@redhat.com>
	<20060605184407.230bcf73.rdunlap@xenotime.net>
	<4484E06B.9020609@microgate.com>
	<20060605190355.c1be6d75.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jun 2006 19:03:55 -0700 Randy.Dunlap wrote:

> On Mon, 05 Jun 2006 20:54:51 -0500 Paul Fulghum wrote:
> 
> > Randy.Dunlap wrote:
> > > Those Kconfig + Makefiles are quite ugly to me.  I would rather see
> > > SYNCLINK depend on HDLC rather than using some tricks to SELECT HDLC.
> > > And then it selects HDLC (and HDLC depends on WAN), but (in my case)
> > > WAN was not enabled, and doing "SELECT HDLC" did not enable WAN.
> > > 
> > > Adding SELECT WAN and changing the hdlc (wan) Makefile to use
> > > obj-m or obj-y (it was ONLY obj-y for hdlc) fixes^W makes it build
> > > with no missing symbols.  However, I'll also see about a fix
> > > that uses "depends on HDLC" instead of "selects HDLC".
> > 
> > Generic HDLC support in the synclink drivers is optional.
> > Should the generic HDLC code be enabled even if it is not used?
> > 
> > Some of our customers would scream if we started forcing
> > them to compile and load unused code.
> 
> OK, I'll try to allow for that.
> 
> > > Fix many missing hdlc_generic symbols when CONFIG_HDLC=m.
> > > When Selecting HDLC, also Select WAN.
> > > Fix Makefile to build for HDLC=y or HDLC=m.
> > > 
> > > +	select WAN if SYNCLINK_HDLC
> > 
> > If this is the accepted approach, then synclink_cs should be added also.
> > (drivers/char/pcmcia)
> 
> It's not the desired approach AFAIK, but it may be the only
> reasonable one.  I'm still testing alternatives, but you are welcome
> to take over and fix it.  :)
> 
> > What about select WAN if HDLC instead?
> > Or does kbuild not propogate the reverse dependency?
> > (SYNCLINK_HDLC selects HDLC, HDLC selects WAN)
> 
> OK.

Hi Paul,
Here's another version of the patch for you to consider.
---

From: Randy Dunlap <rdunlap@xenotime.net>

Fix missing symbol references to hdlc_generic functions.
Switch SYNCLINK drivers from using SELECT to using DEPENDS for HDLC.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 drivers/char/Kconfig        |    9 +++------
 drivers/char/pcmcia/Kconfig |    3 +--
 drivers/net/wan/Makefile    |    8 ++++++--
 3 files changed, 10 insertions(+), 10 deletions(-)

--- linux-2617-rc5mm3.orig/drivers/char/Kconfig
+++ linux-2617-rc5mm3/drivers/char/Kconfig
@@ -197,7 +197,6 @@ config ISI
 config SYNCLINK
 	tristate "SyncLink PCI/ISA support"
 	depends on SERIAL_NONSTANDARD && PCI && ISA_DMA_API
-	select HDLC if SYNCLINK_HDLC
 	help
 	  Driver for SyncLink ISA and PCI synchronous serial adapters.
 	  These adapters are no longer in production and have
@@ -205,7 +204,7 @@ config SYNCLINK
 
 config SYNCLINK_HDLC
 	bool "Generic HDLC support for SyncLink driver"
-	depends on SYNCLINK
+	depends on SYNCLINK && HDLC
 	help
 	  Enable generic HDLC support for the SyncLink PCI/ISA driver.
 	  Generic HDLC implements multiple higher layer networking
@@ -214,7 +213,6 @@ config SYNCLINK_HDLC
 config SYNCLINKMP
 	tristate "SyncLink Multiport support"
 	depends on SERIAL_NONSTANDARD && PCI
-	select HDLC if SYNCLINKMP_HDLC
 	help
 	  Driver for SyncLink Multiport (2 or 4 ports) PCI synchronous serial adapter.
 	  These adapters are no longer in production and have
@@ -222,7 +220,7 @@ config SYNCLINKMP
 
 config SYNCLINKMP_HDLC
 	bool "Generic HDLC support for SyncLink Multiport"
-	depends on SYNCLINKMP
+	depends on SYNCLINKMP && HDLC
 	help
 	  Enable generic HDLC support for the SyncLink Multiport driver.
 	  Generic HDLC implements multiple higher layer networking
@@ -231,7 +229,6 @@ config SYNCLINKMP_HDLC
 config SYNCLINK_GT
 	tristate "SyncLink GT/AC support"
 	depends on SERIAL_NONSTANDARD && PCI
-	select HDLC if SYNCLINK_GT_HDLC
 	help
 	  Support for SyncLink GT and SyncLink AC families of
 	  synchronous and asynchronous serial adapters
@@ -239,7 +236,7 @@ config SYNCLINK_GT
 
 config SYNCLINK_GT_HDLC
 	bool "Generic HDLC support for SyncLink GT/AC"
-	depends on SYNCLINK_GT
+	depends on SYNCLINK_GT && HDLC
 	help
 	  Enable generic HDLC support for the SyncLink GT/AC driver.
 	  Generic HDLC implements multiple higher layer networking
--- linux-2617-rc5mm3.orig/drivers/char/pcmcia/Kconfig
+++ linux-2617-rc5mm3/drivers/char/pcmcia/Kconfig
@@ -8,13 +8,12 @@ menu "PCMCIA character devices"
 config SYNCLINK_CS
 	tristate "SyncLink PC Card support"
 	depends on PCMCIA
-	select HDLC if SYNCLINK_CS_HDLC
 	help
 	  Driver for SyncLink PC Card synchronous serial adapter.
 
 config SYNCLINK_CS_HDLC
 	bool "Generic HDLC support for SyncLink Multiport"
-	depends on SYNCLINK_CS
+	depends on SYNCLINK_CS && HDLC
 	help
 	  Enable generic HDLC support for the SyncLink PC Card driver.
 	  Generic HDLC implements multiple higher layer networking
--- linux-2617-rc5mm3.orig/drivers/net/wan/Makefile
+++ linux-2617-rc5mm3/drivers/net/wan/Makefile
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
