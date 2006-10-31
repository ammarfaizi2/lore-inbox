Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423696AbWJaRRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423696AbWJaRRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 12:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423691AbWJaRRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 12:17:18 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:59339 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1423687AbWJaRRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 12:17:17 -0500
Date: Tue, 31 Oct 2006 09:11:55 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Athanasius <link@miggy.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, toralf.foerster@gmx.de,
       netdev@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       greg@kroah.com, akpm@osdl.org, zippel@linux-m68k.org,
       dbrownell@users.sourceforge.net
Subject: Re: CONFIG_USB_USBNET and mii_* (was Re: Linux 2.6.19-rc4)
Message-Id: <20061031091155.d0242262.randy.dunlap@oracle.com>
In-Reply-To: <20061031170209.GN21200@miggy.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
	<20061031170209.GN21200@miggy.org>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2006 17:02:09 +0000 Athanasius wrote:

> On Mon, Oct 30, 2006 at 08:27:17PM -0800, Linus Torvalds wrote:
> > Before I forget, I'd like to thank Adrian Bunk for his regressions 
> > listings, and ask people who are involved with those (both on the blamer 
> > and blamee sides) to follow them, and keep making sure that we get them 
> > resolved - if only by reminding people about the issues, and testing that 
> > things that are claimed to be resolved really are.
> 
>   In that light, although it's not being counted as a regression, my
> report about CONFIG_USB_USBNET stuff starting to make use of mii_* stuff
> in 19-rc3, without making SURE it's available is still outstanding,
> unfixed, in 19-rc4 (checked just now by untarring a fresh 2.6.18 copy,
> applying the rc4 patch, copying in the known-broken .config from rc3,
> make oldconfig, then my usual make bzImage && make modules).
>   I've pootled around 'make menuconfig' as well, 'N' and then re-Y/M'ing
> USBNET things and it has no effect on the PHYLIB stuff.

It's actually CONFIG_MII, not PHYLIB.

Probably David B. needs to resend patch 2/2.
They seem to have been lost in the noise^W recent travel.

Patch 1/2 is below.


>   I know patches were flying around in the discussion, have none of them
> been shaken down sufficiently for inclusion or has the final patch
> simply not been pushed to/seen by Linus yet?
> 
>   'Ironically' I don't actually _use_ the usbnet stuff, I'd only enabled
> it in case my gf pestered me to test her bluetooth dongle for some
> reason.  Thus I'm only likely to keep tabs on this if I specifically
> think to, it won't show up in my normal usage patterns.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

pegasus and mcs7830 drivers use MII interfaces and should
select MII in the same way that drivers/net/ drivers do.

However, the MII config symbol should not be in the 10/100 Ethernet
menu, so that other drivers can use (enable) it or so that users
can enable it without needing to enable 10/100 Ethernet.

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
---
 drivers/net/Kconfig     |   15 +++++++--------
 drivers/usb/net/Kconfig |    2 ++
 2 files changed, 9 insertions(+), 8 deletions(-)

--- linux-2619-rc3-pv.orig/drivers/usb/net/Kconfig
+++ linux-2619-rc3-pv/drivers/usb/net/Kconfig
@@ -84,6 +84,7 @@ config USB_PEGASUS
 config USB_RTL8150
 	tristate "USB RTL8150 based ethernet device support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	select MII
 	help
 	  Say Y here if you have RTL8150 based usb-ethernet adapter.
 	  Send me <petkan@users.sourceforge.net> any comments you may have.
@@ -210,6 +211,7 @@ config USB_NET_PLUSB
 config USB_NET_MCS7830
 	tristate "MosChip MCS7830 based Ethernet adapters"
 	depends on USB_USBNET
+	select MII
 	help
 	  Choose this option if you're using a 10/100 Ethernet USB2
 	  adapter based on the MosChip 7830 controller. This includes
--- linux-2619-rc3-pv.orig/drivers/net/Kconfig
+++ linux-2619-rc3-pv/drivers/net/Kconfig
@@ -145,6 +145,13 @@ config NET_SB1000
 
 source "drivers/net/arcnet/Kconfig"
 
+config MII
+	tristate "Generic Media Independent Interface device support"
+	help
+	  Most ethernet controllers have MII transceiver either as an external
+	  or internal device.  It is safe to say Y or M here even if your
+	  ethernet card lacks MII.
+
 source "drivers/net/phy/Kconfig"
 
 #
@@ -180,14 +187,6 @@ config NET_ETHERNET
 	  kernel: saying N will just cause the configurator to skip all
 	  the questions about Ethernet network cards. If unsure, say N.
 
-config MII
-	tristate "Generic Media Independent Interface device support"
-	depends on NET_ETHERNET
-	help
-	  Most ethernet controllers have MII transceiver either as an external
-	  or internal device.  It is safe to say Y or M here even if your
-	  ethernet card lack MII.
-
 source "drivers/net/arm/Kconfig"
 
 config MACE

