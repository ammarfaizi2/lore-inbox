Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965242AbWJYX7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965242AbWJYX7V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 19:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbWJYX7V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 19:59:21 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:37816 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S965237AbWJYX7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 19:59:18 -0400
Date: Wed, 25 Oct 2006 16:59:57 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: David Brownell <david-b@pacbell.net>
Cc: toralf.foerster@gmx.de, netdev@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, link@miggy.org, greg@kroah.com,
       akpm@osdl.org, zippel@linux-m68k.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net
Subject: [PATCH 1/2] !CONFIG_NET_ETHERNET unsets CONFIG_PHYLIB, but 
 CONFIG_USB_USBNET also needs CONFIG_PHYLIB
Message-Id: <20061025165957.4c390137.randy.dunlap@oracle.com>
In-Reply-To: <20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.64.0610231618510.3962@g5.osdl.org>
	<20061025201341.GH21200@miggy.org>
	<20061025151737.1bf4898c.randy.dunlap@oracle.com>
	<20061025222709.A13681C5E0B@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
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

On Wed, 25 Oct 2006 15:27:09 -0700 David Brownell wrote:

> The other parts are right, this isn't.
> 
> Instead, "usbnet.c" should #ifdef the relevant ethtool hooks
> according to CONFIG_MII ... since it's completely legit to
> use usbnet with peripherals that don't need MII.

Ugh.  OK.  How's this?  (2 patches)

(oh, OP mentioned CONFIG_PHYLIB but it's actually CONFIG_MII AFAIK)

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
