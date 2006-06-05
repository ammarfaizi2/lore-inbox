Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1751142AbWFEO37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWFEO37 (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 10:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWFEO36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 10:29:58 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40373 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751142AbWFEO35 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 10:29:57 -0400
Date: Mon, 5 Jun 2006 16:29:12 +0200
From: Pavel Machek <pavel@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>, Jirka Lenost Benc <jbenc@suse.cz>,
        kernel list <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
        pe1rxq@amsat.org
Subject: Re: move zd1201 where it belongs
Message-ID: <20060605142912.GF2132@elf.ucw.cz>
References: <20060605103952.GA1670@elf.ucw.cz> <1149506120.3111.52.camel@laptopd505.fenrus.org> <20060605113332.GB2132@elf.ucw.cz> <20060605141322.GB23350@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060605141322.GB23350@tuxdriver.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > > zd1201 is wifi adapter, yet it is hiding in drivers/usb/net where
> > > > noone can find it. This moves Kconfig/Makefile to right place; you
> > > > still need to manually move .c and .h files.
> 
> > > do you think it should at least depend in some form or another on
> > > CONFIG_USB ?
> > 
> > Right, added USB && to depends directive.
> 
> Did you mean to only copy Jiri and LKML?

Yes, because this should go in as a git patch (so it is move, not
create new file), and I was hoping for Jiri to generate proper
git-patch :-).

> It seems like you should have sent at least sent this to
> netdev@vger.kernel.org, if not also to me, Jeroen Vreeken and/or
> possibly Greg K-H (USB subsystem).
> 
> Will you be posting a new version, with the CONFIG_USB change?

Here it is, still

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index e0874cb..1eccdb3 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -503,6 +503,23 @@ config PRISM54
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called prism54.ko.
 
+config USB_ZD1201
+	tristate "USB ZD1201 based Wireless device support"
+	depends on USB && NET_RADIO
+	select FW_LOADER
+	---help---
+	  Say Y if you want to use wireless LAN adapters based on the ZyDAS
+	  ZD1201 chip.
+
+	  This driver makes the adapter appear as a normal Ethernet interface,
+	  typically on wlan0.
+	  
+	  The zd1201 device requires external firmware to be loaded.
+	  This can be found at http://linux-lc100020.sourceforge.net/
+	  
+	  To compile this driver as a module, choose M here: the
+	  module will be called zd1201.
+
 source "drivers/net/wireless/hostap/Kconfig"
 source "drivers/net/wireless/bcm43xx/Kconfig"
 
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index c867798..512603d 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -40,3 +40,5 @@ obj-$(CONFIG_BCM43XX)		+= bcm43xx/
 # 16-bit wireless PCMCIA client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+= ray_cs.o
 obj-$(CONFIG_PCMCIA_WL3501)	+= wl3501_cs.o
+
+obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
diff --git a/drivers/usb/net/Kconfig b/drivers/usb/net/Kconfig
index efd6ca7..0540596 100644
--- a/drivers/usb/net/Kconfig
+++ b/drivers/usb/net/Kconfig
@@ -301,21 +301,4 @@ config USB_NET_ZAURUS
 	  some cases CDC MDLM) protocol, not "g_ether".
 
 
-config USB_ZD1201
-	tristate "USB ZD1201 based Wireless device support"
-	depends on NET_RADIO
-	select FW_LOADER
-	---help---
-	  Say Y if you want to use wireless LAN adapters based on the ZyDAS
-	  ZD1201 chip.
-
-	  This driver makes the adapter appear as a normal Ethernet interface,
-	  typically on wlan0.
-	  
-	  The zd1201 device requires external firmware to be loaded.
-	  This can be found at http://linux-lc100020.sourceforge.net/
-	  
-	  To compile this driver as a module, choose M here: the
-	  module will be called zd1201.
-
 endmenu
diff --git a/drivers/usb/net/Makefile b/drivers/usb/net/Makefile
index a21e6ea..160f19d 100644
--- a/drivers/usb/net/Makefile
+++ b/drivers/usb/net/Makefile
@@ -15,7 +15,6 @@ obj-$(CONFIG_USB_NET_RNDIS_HOST)	+= rndi
 obj-$(CONFIG_USB_NET_CDC_SUBSET)	+= cdc_subset.o
 obj-$(CONFIG_USB_NET_ZAURUS)	+= zaurus.o
 obj-$(CONFIG_USB_USBNET)	+= usbnet.o
-obj-$(CONFIG_USB_ZD1201)	+= zd1201.o
 
 ifeq ($(CONFIG_USB_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
