Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262825AbUCOW3x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbUCOW2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:28:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:10153 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262825AbUCOW1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:27:08 -0500
Date: Mon, 15 Mar 2004 14:24:42 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: netdev <netdev@oss.sgi.com>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, davem@redhat.com
Subject: PATCH] networking menus v2
Message-Id: <20040315142442.486bef5b.rddunlap@osdl.org>
In-Reply-To: <20040314163327.53102f46.rddunlap@osdl.org>
References: <20040314163327.53102f46.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

v1 intro:

| BenH mentioned last week that the networking menus need some help.
| They are too twisted or confusing or something.
| 
| I was already looking into this.  Roman suggested s/config/menuconfig/,
| which is helpful.
| 
| This is just a first pass/RFC.  It moves "Networking support" out of
| the "Device Drivers" menu, which seems helpful to me.  However,
| ISTM that it should really just be the "Networking options" here
| and not include Amateur Radio, IrDA, and Bluetooth support.
| I.e., I think that those latter 3 should fall under Device Drivers.
| Does that make sense to anyone else?
| 
| Other comments?

Here is version 2.  It's ready to be merged IMO.  Please apply.

Any other comments/suggestions?

Thanks,
--
~Randy


// linux-2.6.4-bk4

// Networking support/options and Networking drivers have been, uhm,
// messy to navigate for some time now.  They generally have grown in
// an ad hoc manner.  BenH mentioned this last Friday, and I was
// already looking into options to clean it up.  This patch puts some
// kind of order back into the networking menus.

// This is a cleanup of Networking support/options and Networking Drivers.
// It presents a more consistent interface and lists similar driver
// groups closer together.
// It moves Networking options out of the Network device drivers menu
// and into its own menu block.
// It also moves the IBMVETH driver so that it no longer breaks the
// dependency tree, allowing other drivers (nearby in Kconfig file)
// to be presented in a more linear manner.


diffstat:=
 drivers/Kconfig       |    4 ++-
 drivers/net/Kconfig   |   55 ++++++++++++++++++++++++--------------------------
 net/Kconfig           |   21 +++++++------------
 net/ax25/Kconfig      |    7 +-----
 net/bluetooth/Kconfig |    6 -----
 net/irda/Kconfig      |    8 +------
 6 files changed, 43 insertions(+), 58 deletions(-)


diff -Naurp ./drivers/net/Kconfig~net_config ./drivers/net/Kconfig
--- ./drivers/net/Kconfig~net_config	2004-03-15 12:56:22.000000000 -0800
+++ ./drivers/net/Kconfig	2004-03-15 13:48:23.000000000 -0800
@@ -3,7 +3,7 @@
 # Network device configuration
 #
 
-config NETDEVICES
+menuconfig NETDEVICES
 	depends on NET
 	bool "Network device support"
 	---help---
@@ -21,10 +21,6 @@ config NETDEVICES
 
 	  If unsure, say Y.
 
-if NETDEVICES
-	source "drivers/net/arcnet/Kconfig"
-endif
-
 config DUMMY
 	tristate "Dummy net driver support"
 	depends on NETDEVICES
@@ -155,6 +151,10 @@ config NET_SB1000
 
 	  If you don't have this card, of course say N.
 
+if NETDEVICES
+	source "drivers/net/arcnet/Kconfig"
+endif
+
 #
 #	Ethernet
 #
@@ -1178,6 +1178,17 @@ config IBMLANA
 	  boards with this driver should be possible, but has not been tested
 	  up to now due to lack of hardware.
 
+config IBMVETH
+	tristate "IBM LAN Virtual Ethernet support"
+	depends on NETDEVICES && NET_ETHERNET && PPC_PSERIES
+	---help---
+	  This driver supports virtual ethernet adapters on newer IBM iSeries
+	  and pSeries systems.
+
+	  To compile this driver as a module, choose M here and read
+	  <file:Documentation/networking/net-modules.txt>. The module will
+	  be called ibmveth.
+
 config NET_PCI
 	bool "EISA, VLB, PCI and on board controllers"
 	depends on NET_ETHERNET && (ISA || EISA || PCI)
@@ -2103,6 +2114,17 @@ config IXGB_NAPI
 
 endmenu
 
+source "drivers/net/tokenring/Kconfig"
+
+source "drivers/net/wireless/Kconfig"
+
+source "drivers/net/pcmcia/Kconfig"
+
+source "drivers/net/wan/Kconfig"
+
+source "drivers/atm/Kconfig"
+
+source "drivers/s390/net/Kconfig"
 
 config VETH
 	tristate "iSeries Virtual Ethernet driver support"
@@ -2170,17 +2192,6 @@ config HIPPI
 	  under Linux, say Y here (you must also remember to enable the driver
 	  for your HIPPI card below). Most people will say N here.
 
-config IBMVETH
-	tristate "IBM LAN Virtual Ethernet support"
-	depends on NETDEVICES && NET_ETHERNET && PPC_PSERIES
-	---help---
-	  This driver supports virtual ethernet adapters on newer IBM iSeries
-	  and pSeries systems.
-
-	  To compile this driver as a module, choose M here and read
-	  <file:Documentation/networking/net-modules.txt>. The module will
-	  be called ibmveth.
-
 config ROADRUNNER
 	tristate "Essential RoadRunner HIPPI PCI adapter support (EXPERIMENTAL)"
 	depends on HIPPI && PCI
@@ -2438,10 +2449,6 @@ config SLIP_MODE_SLIP6
 	  end of the link as well. It's good enough, for example, to run IP
 	  over the async ports of a Camtec JNT Pad. If unsure, say N.
 
-source "drivers/net/wireless/Kconfig"
-
-source "drivers/net/tokenring/Kconfig"
-
 config NET_FC
 	bool "Fibre Channel driver support"
 	depends on NETDEVICES && SCSI && PCI
@@ -2501,11 +2508,3 @@ config NETCONSOLE
 	---help---
 	If you want to log kernel messages over the network, enable this.
 	See Documentation/networking/netconsole.txt for details.
-
-source "drivers/net/wan/Kconfig"
-
-source "drivers/net/pcmcia/Kconfig"
-
-source "drivers/atm/Kconfig"
-
-source "drivers/s390/net/Kconfig"
diff -Naurp ./drivers/Kconfig~net_config ./drivers/Kconfig
--- ./drivers/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
+++ ./drivers/Kconfig	2004-03-15 12:58:49.000000000 -0800
@@ -1,5 +1,7 @@
 # drivers/Kconfig
 
+source "net/Kconfig"
+
 menu "Device Drivers"
 
 source "drivers/base/Kconfig"
@@ -28,7 +30,7 @@ source "drivers/message/i2o/Kconfig"
 
 source "drivers/macintosh/Kconfig"
 
-source "net/Kconfig"
+source "drivers/net/Kconfig"
 
 source "drivers/isdn/Kconfig"
 
diff -Naurp ./net/bluetooth/Kconfig~net_config ./net/bluetooth/Kconfig
--- ./net/bluetooth/Kconfig~net_config	2004-03-10 18:55:43.000000000 -0800
+++ ./net/bluetooth/Kconfig	2004-03-15 12:59:12.000000000 -0800
@@ -2,10 +2,8 @@
 # Bluetooth subsystem configuration
 #
 
-menu "Bluetooth support"
+menuconfig BT
 	depends on NET
-
-config BT
 	tristate "Bluetooth subsystem support"
 	help
 	  Bluetooth is low-cost, low-power, short-range wireless technology.
@@ -62,5 +60,3 @@ source "net/bluetooth/cmtp/Kconfig"
 
 source "drivers/bluetooth/Kconfig"
 
-endmenu
-
diff -Naurp ./net/irda/Kconfig~net_config ./net/irda/Kconfig
--- ./net/irda/Kconfig~net_config	2004-03-10 18:55:27.000000000 -0800
+++ ./net/irda/Kconfig	2004-03-15 12:59:12.000000000 -0800
@@ -2,11 +2,9 @@
 # IrDA protocol configuration
 #
 
-menu "IrDA (infrared) support"
+menuconfig IRDA
 	depends on NET
-
-config IRDA
-	tristate "IrDA subsystem support"
+	tristate "IrDA (infrared) subsystem support"
 	---help---
 	  Say Y here if you want to build support for the IrDA (TM) protocols.
 	  The Infrared Data Associations (tm) specifies standards for wireless
@@ -95,5 +93,3 @@ config IRDA_DEBUG
 
 source "drivers/net/irda/Kconfig"
 
-endmenu
-
diff -Naurp ./net/ax25/Kconfig~net_config ./net/ax25/Kconfig
--- ./net/ax25/Kconfig~net_config	2004-03-10 18:55:44.000000000 -0800
+++ ./net/ax25/Kconfig	2004-03-15 12:58:49.000000000 -0800
@@ -6,9 +6,8 @@
 #		Joerg Reuter DL1BKE <jreuter@yaina.de>
 # 19980129	Moved to net/ax25/Config.in, sourcing device drivers.
 
-menu "Amateur Radio support"
-
-config HAMRADIO
+menuconfig HAMRADIO
+	depends on NET
 	bool "Amateur Radio support"
 	help
 	  If you want to connect your Linux box to an amateur radio, answer Y
@@ -109,5 +108,3 @@ source "drivers/net/hamradio/Kconfig"
 
 endmenu
 
-endmenu
-
diff -Naurp ./net/Kconfig~net_config ./net/Kconfig
--- ./net/Kconfig~net_config	2004-03-15 12:56:23.000000000 -0800
+++ ./net/Kconfig	2004-03-15 13:38:59.000000000 -0800
@@ -2,9 +2,7 @@
 # Network configuration
 #
 
-menu "Networking support"
-
-config NET
+menuconfig NET
 	bool "Networking support"
 	---help---
 	  Unless you really know what you are doing, you should say Y here.
@@ -648,16 +646,6 @@ config NET_PKTGEN
 
 endmenu
 
-endmenu
-
-source "drivers/net/Kconfig"
-
-source "net/ax25/Kconfig"
-
-source "net/irda/Kconfig"
-
-source "net/bluetooth/Kconfig"
-
 config NETPOLL
 	def_bool NETCONSOLE
 
@@ -675,3 +663,10 @@ config NET_POLL_CONTROLLER
 	def_bool NETPOLL
 
 endmenu
+
+source "net/ax25/Kconfig"
+
+source "net/irda/Kconfig"
+
+source "net/bluetooth/Kconfig"
+
