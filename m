Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272061AbTG2UBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272126AbTG2UBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:01:40 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:4588 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S272061AbTG2T7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 15:59:48 -0400
Date: Tue, 29 Jul 2003 21:59:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 patch] let broken drivers depend on BROKEN{,ON_SMP}
Message-ID: <20030729195932.GR28767@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below against 2.6.0-test2 does the following:
- let all drivers that don't compile depend on an undefined 
  CONFIG_BROKEN
- let all drivers that don't compile on SMP (due to cli/sti usage)
  depend on a CONFIG_BROKEN_ON_SMP that is only defined if !CONFIG_SMP

Notes:
- I might have missed a few drivers, I found the drivers below by trying
  to compile as many drivers as possible statically on i386
- I added in two drivers an #include <linux/interrupt.h> for the dummy
  cli/sti #define's on !SMP to allow the compilation on UP
- as an example I converted the CONFIG_BLK_DEV_IDETAPE entry from a
  dep_tristate comment to a full Kconfig entry with a dependency on 
  CONFIG_BROKEN (help text stolen from 2.4)
- I do prefer BROKEN, Alan prefers OBSOLETE
  a s/BROKEN/OBSOLETE/g is acceptable for me

I'm not sure whether now or later in the 2.6.0-test phase is the right 
time to apply this patch.

diffstat output:

 drivers/atm/Kconfig               |    4 ++--
 drivers/cdrom/Kconfig             |    8 ++++----
 drivers/char/Kconfig              |   31 ++++++++++++++++---------------
 drivers/char/epca.c               |    1 +
 drivers/char/generic_serial.c     |    1 +
 drivers/i2c/Kconfig               |    2 +-
 drivers/ide/Kconfig               |   26 +++++++++++++++++++++++++-
 drivers/isdn/Kconfig              |    2 +-
 drivers/isdn/hardware/avm/Kconfig |   12 ++++++------
 drivers/isdn/hisax/Kconfig        |    2 ++
 drivers/isdn/i4l/Kconfig          |    1 +
 drivers/media/video/Kconfig       |    4 ++--
 drivers/mtd/devices/Kconfig       |    2 +-
 drivers/net/Kconfig               |   16 ++++++++--------
 drivers/net/hamradio/Kconfig      |    6 +++---
 drivers/net/irda/Kconfig          |    2 +-
 drivers/net/tulip/Kconfig         |    2 +-
 drivers/net/wan/Kconfig           |    8 ++++----
 drivers/scsi/Kconfig              |   20 ++++++++++----------
 drivers/video/Kconfig             |    6 +++---
 fs/partitions/Kconfig             |    1 +
 init/Kconfig                      |    4 ++++
 sound/oss/Kconfig                 |    2 +-
 23 files changed, 99 insertions(+), 64 deletions(-)


cu
Adrian

--- linux-2.6.0-test2-full/drivers/net/tulip/Kconfig.old	2003-07-29 10:09:53.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/net/tulip/Kconfig	2003-07-29 10:10:34.000000000 +0200
@@ -131,7 +131,7 @@
 
 config PCMCIA_XIRTULIP
 	tristate "Xircom Tulip-like CardBus support (old driver)"
-	depends on NET_TULIP && CARDBUS
+	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP
 	---help---
 	  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
 	  It should work with most DEC 21*4*-based chips/ethercards, as well
--- linux-2.6.0-test2-full/drivers/net/irda/Kconfig.old	2003-07-29 09:39:46.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/net/irda/Kconfig	2003-07-29 09:40:19.000000000 +0200
@@ -270,7 +270,7 @@
 
 config TOSHIBA_OLD
 	tristate "Toshiba Type-O IR Port (old driver)"
-	depends on IRDA
+	depends on IRDA && BROKEN_ON_SMP
 	help
 	  Say Y here if you want to build support for the Toshiba Type-O IR
 	  chipset.  This chipset is used by the Toshiba Libretto 100CT, and
--- linux-2.6.0-test2-full/drivers/net/wan/Kconfig.old	2003-07-28 22:23:19.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/net/wan/Kconfig	2003-07-29 10:11:46.000000000 +0200
@@ -63,7 +63,7 @@
 # Not updated to 2.6.
 config COMX
 	tristate "MultiGate (COMX) synchronous serial boards support"
-	depends on WAN && (ISA || PCI) && OBSOLETE
+	depends on WAN && (ISA || PCI) && BROKEN
 	---help---
 	  Say Y if you want to use any board from the MultiGate (COMX) family.
 	  These boards are synchronous serial adapters for the PC,
@@ -443,7 +443,7 @@
 
 config SDLA
 	tristate "SDLA (Sangoma S502/S508) support"
-	depends on DLCI && ISA
+	depends on DLCI && ISA && BROKEN_ON_SMP
 	help
 	  Say Y here if you need a driver for the Sangoma S502A, S502E, and
 	  S508 Frame Relay Access Devices. These are multi-protocol cards, but
@@ -476,7 +476,7 @@
 
 config VENDOR_SANGOMA
 	tristate "Sangoma WANPIPE(tm) multiprotocol cards"
-	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA)
+	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA) && BROKEN
 	---help---
 	  WANPIPE from Sangoma Technologies Inc. (<http://www.sangoma.com/>)
 	  is a family of intelligent multiprotocol WAN adapters with data
@@ -625,7 +625,7 @@
 
 config X25_ASY
 	tristate "X.25 async driver (EXPERIMENTAL)"
-	depends on WAN && LAPB && X25
+	depends on WAN && LAPB && X25 && BROKEN_ON_SMP
 	---help---
 	  This is a driver for sending and receiving X.25 frames over regular
 	  asynchronous serial lines such as telephone lines equipped with
--- linux-2.6.0-test2-full/drivers/net/hamradio/Kconfig.old	2003-07-29 09:27:25.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/net/hamradio/Kconfig	2003-07-29 09:39:25.000000000 +0200
@@ -1,6 +1,6 @@
 config MKISS
 	tristate "Serial port KISS driver"
-	depends on AX25
+	depends on AX25 && BROKEN_ON_SMP
 	---help---
 	  KISS is a protocol used for the exchange of data between a computer
 	  and a Terminal Node Controller (a small embedded system commonly
@@ -19,7 +19,7 @@
 
 config 6PACK
 	tristate "Serial port 6PACK driver"
-	depends on AX25
+	depends on AX25 && BROKEN_ON_SMP
 	---help---
 	  6pack is a transmission protocol for the data exchange between your
 	  PC and your TNC (the Terminal Node Controller acts as a kind of
@@ -49,7 +49,7 @@
 
 config DMASCC
 	tristate "High-speed (DMA) SCC driver for AX.25"
-	depends on ISA && AX25
+	depends on ISA && AX25 && BROKEN_ON_SMP
 	---help---
 	  This is a driver for high-speed SCC boards, i.e. those supporting
 	  DMA on one port. You usually use those boards to connect your
--- linux-2.6.0-test2-full/drivers/net/Kconfig.old	2003-07-28 22:23:19.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/net/Kconfig	2003-07-29 10:31:28.000000000 +0200
@@ -400,7 +400,7 @@
 
 config MVME16x_NET
 	tristate "MVME16x Ethernet support"
-	depends on NETDEVICES && MVME16x
+	depends on NETDEVICES && MVME16x && BROKEN_ON_SMP
 	help
 	  This is the driver for the Ethernet interface on the Motorola
 	  MVME162, 166, 167, 172 and 177 boards.  Say Y here to include the
@@ -409,7 +409,7 @@
 
 config BVME6000_NET
 	tristate "BVME6000 Ethernet support"
-	depends on NETDEVICES && BVME6000
+	depends on NETDEVICES && BVME6000 && BROKEN_ON_SMP
 	help
 	  This is the driver for the Ethernet interface on BVME4000 and
 	  BVME6000 VME boards.  Say Y here to include the driver for this chip
@@ -704,7 +704,7 @@
 
 config ELMC_II
 	tristate "3c527 \"EtherLink/MC 32\" support (EXPERIMENTAL)"
-	depends on NET_VENDOR_3COM && MCA && EXPERIMENTAL
+	depends on NET_VENDOR_3COM && MCA && EXPERIMENTAL && BROKEN_ON_SMP
 	help
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -882,7 +882,7 @@
 
 config NI5010
 	tristate "NI5010 support (EXPERIMENTAL)"
-	depends on NET_VENDOR_RACAL && ISA && EXPERIMENTAL
+	depends on NET_VENDOR_RACAL && ISA && EXPERIMENTAL && BROKEN_ON_SMP
 	---help---
 	  If you have a network (Ethernet) card of this type, say Y and read
 	  the Ethernet-HOWTO, available from
@@ -1221,7 +1221,7 @@
 
 config SKMC
 	tristate "SKnet MCA support"
-	depends on NET_ETHERNET && MCA
+	depends on NET_ETHERNET && MCA && BROKEN
 	---help---
 	  These are Micro Channel Ethernet adapters. You need to say Y to "MCA
 	  support" in order to use this driver.  Supported cards are the SKnet
@@ -1350,7 +1350,7 @@
 
 config APRICOT
 	tristate "Apricot Xen-II on board Ethernet"
-	depends on NET_PCI && ISA
+	depends on NET_PCI && ISA && BROKEN_ON_SMP
 	help
 	  If you have a network (Ethernet) controller of this type, say Y and
 	  read the Ethernet-HOWTO, available from
@@ -2144,7 +2144,7 @@
 
 config DEFXX
 	tristate "Digital DEFEA and DEFPA adapter support"
-	depends on FDDI && (PCI || EISA)
+	depends on FDDI && (PCI || EISA) && BROKEN
 	help
 	  This is support for the DIGITAL series of EISA (DEFEA) and PCI
 	  (DEFPA) controllers which can connect you to a local FDDI network.
@@ -2487,7 +2487,7 @@
 
 config IPHASE5526
 	tristate "Interphase 5526 Tachyon chipset based adapter support"
-	depends on NET_FC && SCSI && PCI
+	depends on NET_FC && SCSI && PCI && BROKEN
 	help
 	  Say Y here if you have a Fibre Channel adaptor of this kind.
 
--- linux-2.6.0-test2-full/drivers/i2c/Kconfig.old	2003-07-29 00:58:38.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/i2c/Kconfig	2003-07-29 00:59:05.000000000 +0200
@@ -152,7 +152,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF
+	depends on I2C_ALGOPCF && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
--- linux-2.6.0-test2-full/drivers/video/Kconfig.old	2003-07-28 22:23:20.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/video/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -40,7 +40,7 @@
 
 config FB_CIRRUS
 	tristate "Cirrus Logic support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && (AMIGA || PCI) && BROKEN
 	---help---
 	  This enables support for Cirrus Logic GD542x/543x based boards on
 	  Amiga: SD64, Piccolo, Picasso II/II+, Picasso IV, or EGS Spectrum.
@@ -55,7 +55,7 @@
 
 config FB_PM2
 	tristate "Permedia2 support"
-	depends on FB && (AMIGA || PCI)
+	depends on FB && (AMIGA || PCI) && BROKEN
 	help
 	  This is the frame buffer device driver for the Permedia2 AGP frame
 	  buffer card from ASK, aka `Graphic Blaster Exxtreme'.  There is a
@@ -802,7 +802,7 @@
 
 config FB_PM3
 	tristate "Permedia3 support"
-	depends on FB && PCI
+	depends on FB && PCI && BROKEN
 	help
 	  This is the frame buffer device driver for the 3DLabs Permedia3
 	  chipset, used in Formac ProFormance III, 3DLabs Oxygen VX1 &
--- linux-2.6.0-test2-full/drivers/isdn/hardware/avm/Kconfig.old	2003-07-29 01:57:44.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/isdn/hardware/avm/Kconfig	2003-07-29 01:58:59.000000000 +0200
@@ -12,13 +12,13 @@
 
 config ISDN_DRV_AVMB1_B1ISA
 	tristate "AVM B1 ISA support"
-	depends on CAPI_AVM && ISDN_CAPI && ISA
+	depends on CAPI_AVM && ISDN_CAPI && ISA && BROKEN_ON_SMP
 	help
 	  Enable support for the ISA version of the AVM B1 card.
 
 config ISDN_DRV_AVMB1_B1PCI
 	tristate "AVM B1 PCI support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI
+	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
 	help
 	  Enable support for the PCI version of the AVM B1 card.
 
@@ -30,14 +30,14 @@
 
 config ISDN_DRV_AVMB1_T1ISA
 	tristate "AVM T1/T1-B ISA support"
-	depends on CAPI_AVM && ISDN_CAPI && ISA
+	depends on CAPI_AVM && ISDN_CAPI && ISA && BROKEN_ON_SMP
 	help
 	  Enable support for the AVM T1 T1B card.
 	  Note: This is a PRI card and handle 30 B-channels.
 
 config ISDN_DRV_AVMB1_B1PCMCIA
 	tristate "AVM B1/M1/M2 PCMCIA support"
-	depends on CAPI_AVM && ISDN_CAPI
+	depends on CAPI_AVM && ISDN_CAPI && BROKEN_ON_SMP
 	help
 	  Enable support for the PCMCIA version of the AVM B1 card.
 
@@ -50,14 +50,14 @@
 
 config ISDN_DRV_AVMB1_T1PCI
 	tristate "AVM T1/T1-B PCI support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI
+	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
 	help
 	  Enable support for the AVM T1 T1B card.
 	  Note: This is a PRI card and handle 30 B-channels.
 
 config ISDN_DRV_AVMB1_C4
 	tristate "AVM C4/C2 support"
-	depends on CAPI_AVM && ISDN_CAPI && PCI
+	depends on CAPI_AVM && ISDN_CAPI && PCI && BROKEN_ON_SMP
 	help
 	  Enable support for the AVM C4/C2 PCI cards.
 	  These cards handle 4/2 BRI ISDN lines (8/4 channels).
--- linux-2.6.0-test2-full/drivers/isdn/i4l/Kconfig.old	2003-07-28 22:23:20.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/isdn/i4l/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -106,6 +106,7 @@
 
 config ISDN_DIVERSION
 	tristate "Support isdn diversion services"
+	depends on BROKEN
 	help
 	  This option allows you to use some supplementary diversion
 	  services in conjunction with the HiSax driver on an EURO/DSS1
--- linux-2.6.0-test2-full/drivers/isdn/hisax/Kconfig.old	2003-07-28 22:23:20.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/isdn/hisax/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -165,6 +165,7 @@
 
 config HISAX_DIEHLDIVA
 	bool "Eicon.Diehl Diva cards"
+	depends on !ISAPNP || BROKEN
 	help
 	  This enables HiSax support for the Eicon.Diehl Diva none PRO
 	  versions passive ISDN cards.
@@ -207,6 +208,7 @@
 
 config HISAX_SEDLBAUER
 	bool "Sedlbauer cards"
+	depends on !ISAPNP || BROKEN
 	help
 	  This enables HiSax support for the Sedlbauer passive ISDN cards.
 
--- linux-2.6.0-test2-full/drivers/isdn/Kconfig.old	2003-07-29 01:50:25.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/isdn/Kconfig	2003-07-29 01:50:48.000000000 +0200
@@ -22,7 +22,7 @@
 
 
 menu "Old ISDN4Linux"
-	depends on NET && ISDN_BOOL
+	depends on NET && ISDN_BOOL && BROKEN_ON_SMP
 
 config ISDN
 	tristate "Old ISDN4Linux (obsolete)"
--- linux-2.6.0-test2-full/drivers/media/video/Kconfig.old	2003-07-28 22:23:20.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/media/video/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -161,7 +161,7 @@
 
 config VIDEO_ZORAN
 	tristate "Zoran ZR36057/36060 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Say Y here to include support for video cards based on the Zoran
 	  ZR36057/36060 encoder/decoder chip (including the Iomega Buz and the
@@ -190,7 +190,7 @@
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Support for ZR36120/ZR36125 based frame grabber/overlay boards.
 	  This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,
--- linux-2.6.0-test2-full/drivers/char/epca.c.old	2003-07-28 22:23:20.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/char/epca.c	2003-07-28 22:25:21.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/tty_flip.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
--- linux-2.6.0-test2-full/drivers/char/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/char/Kconfig	2003-07-29 00:50:26.000000000 +0200
@@ -78,7 +78,7 @@
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
@@ -111,7 +111,7 @@
 
 config CYCLADES
 	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for a card that gives you many serial ports. You
 	  would need something like this to connect more than two modems to
@@ -143,7 +143,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need
@@ -162,7 +162,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
@@ -175,7 +175,7 @@
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA
+	depends on SERIAL_NONSTANDARD && ISA && BROKEN
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read
@@ -188,7 +188,7 @@
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
 
@@ -199,7 +199,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
@@ -260,7 +260,7 @@
 
 config RISCOM8
 	tristate "SDL RISCom/8 card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN
 	help
 	  This is a driver for the SDL Communications RISCom/8 multiport card,
 	  which gives you many serial ports. You would need something like
@@ -273,7 +273,7 @@
 
 config SPECIALIX
 	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN
 	help
 	  This is a driver for the Specialix IO8+ multiport card (both the
 	  ISA and the PCI version) which gives you many serial ports. You
@@ -297,7 +297,7 @@
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.
@@ -308,7 +308,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
@@ -337,7 +337,7 @@
 
 config STALLION
 	tristate "Stallion EasyIO or EC8/32 support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
 	  card, then this is for you; say Y.  Make sure to read
@@ -350,7 +350,7 @@
 
 config ISTALLION
 	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
 	  serial multiport card, say Y here. Make sure to read
@@ -363,7 +363,7 @@
 
 config SERIAL_TX3912
 	bool "TMPTX3912/PR31700 serial port support"
-	depends on SERIAL_NONSTANDARD && MIPS
+	depends on SERIAL_NONSTANDARD && MIPS && BROKEN_ON_SMP
 	help
 	  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -423,7 +423,7 @@
 
 config A2232
 	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ZORRO
+	depends on EXPERIMENTAL && ZORRO && BROKEN_ON_SMP
 	---help---
 	  This option supports the 2232 7-port serial card shipped with the
 	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
@@ -907,6 +907,7 @@
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
+	depends on BROKEN_ON_SMP
 	---help---
 	  If you have a tape drive that is connected to your floppy
 	  controller, say Y here.
--- linux-2.6.0-test2-full/drivers/char/generic_serial.c.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/char/generic_serial.c	2003-07-28 22:25:21.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/serial.h>
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
+#include <linux/interrupt.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
--- linux-2.6.0-test2-full/drivers/scsi/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/scsi/Kconfig	2003-07-29 10:57:31.000000000 +0200
@@ -355,7 +355,7 @@
 # All the I2O code and drivers do not seem to be 64bit safe.
 config SCSI_DPT_I2O
 	tristate "Adaptec I2O RAID support "
-	depends on !X86_64 && SCSI
+	depends on !X86_64 && SCSI && BROKEN
 	help
 	  This driver supports all of Adaptec's I2O based RAID controllers as 
 	  well as the DPT SmartRaid V cards.  This is an Adaptec maintained
@@ -398,7 +398,7 @@
 # does not use pci dma and seems to be onboard only for old machines
 config SCSI_AM53C974
 	tristate "AM53/79C974 PCI SCSI support"
-	depends on X86 && PCI && SCSI
+	depends on X86 && PCI && SCSI && BROKEN
 	---help---
 	  This is support for the AM53/79C974 SCSI host adapters.  Please read
 	  <file:Documentation/scsi/AM53C974.txt> for details.  Also, the
@@ -455,7 +455,7 @@
 
 config SCSI_CPQFCTS
 	tristate "Compaq Fibre Channel 64-bit/66Mhz HBA support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  Say Y here to compile in support for the Compaq StorageWorks Fibre
 	  Channel 64-bit/66Mhz Host Bus Adapter.
@@ -626,7 +626,7 @@
 
 config SCSI_GENERIC_NCR5380_MMIO
 	tristate "Generic NCR5380/53c400 SCSI MMIO support"
-	depends on ISA && SCSI
+	depends on ISA && SCSI && (BROKEN || !SCSI_GENERIC_NCR5380)
 	---help---
 	  This is a driver for the old NCR 53c80 series of SCSI controllers
 	  on boards using memory mapped I/O. 
@@ -742,7 +742,7 @@
 
 config SCSI_INITIO
 	tristate "Initio 9100U(W) support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  This is support for the Initio 91XXU(W) SCSI host adapter.  Please
 	  read the SCSI-HOWTO, available from
@@ -1161,7 +1161,7 @@
 
 config SCSI_MCA_53C9X
 	tristate "NCR MCA 53C9x SCSI support"
-	depends on MCA && SCSI
+	depends on MCA && SCSI && BROKEN_ON_SMP
 	help
 	  Some MicroChannel machines, notably the NCR 35xx line, use a SCSI
 	  controller based on the NCR 53C94.  This driver will allow use of
@@ -1189,7 +1189,7 @@
 
 config SCSI_PCI2000
 	tristate "PCI2000 support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  This is support for the PCI2000I EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1202,7 +1202,7 @@
 
 config SCSI_PCI2220I
 	tristate "PCI2220i support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	help
 	  This is support for the PCI2220i EIDE interface card which acts as a
 	  SCSI host adapter.  Please read the SCSI-HOWTO, available from
@@ -1314,7 +1314,7 @@
 
 config SCSI_SEAGATE
 	tristate "Seagate ST-02 and Future Domain TMC-8xx SCSI support"
-	depends on X86 && ISA && SCSI
+	depends on X86 && ISA && SCSI && BROKEN
 	---help---
 	  These are 8-bit SCSI controllers; the ST-01 is also supported by
 	  this driver.  It is explained in section 3.9 of the SCSI-HOWTO,
@@ -1381,7 +1381,7 @@
 
 config SCSI_DC390T
 	tristate "Tekram DC390(T) and Am53/79C974 SCSI support"
-	depends on PCI && SCSI
+	depends on PCI && SCSI && BROKEN
 	---help---
 	  This driver supports PCI SCSI host adapters based on the Am53C974A
 	  chip, e.g. Tekram DC390(T), DawiControl 2974 and some onboard
--- linux-2.6.0-test2-full/drivers/mtd/devices/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/mtd/devices/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -102,7 +102,7 @@
 
 config MTD_BLKMTD
 	tristate "MTD emulation using block device"
-	depends on MTD
+	depends on MTD && BROKEN
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
--- linux-2.6.0-test2-full/drivers/ide/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/ide/Kconfig	2003-07-28 22:25:21.000000000 +0200
@@ -213,7 +213,31 @@
 	  say M here and read <file:Documentation/modules.txt>.  The module
 	  will be called ide-cd.
 
-#dep_tristate '  Include IDE/ATAPI TAPE support' CONFIG_BLK_DEV_IDETAPE $CONFIG_BLK_DEV_IDE
+config BLK_DEV_IDETAPE
+	tristate "Include IDE/ATAPI TAPE support"
+	depends on BLK_DEV_IDE && BROKEN
+	help
+	  If you have an IDE tape drive using the ATAPI protocol, say Y.
+	  ATAPI is a newer protocol used by IDE tape and CD-ROM drives,
+	  similar to the SCSI protocol.  If you have an SCSI tape drive
+	  however, you can say N here.
+
+	  You should also say Y if you have an OnStream DI-30 tape drive; this
+	  will not work with the SCSI protocol, until there is support for the
+	  SC-30 and SC-50 versions.
+
+	  If you say Y here, the tape drive will be identified at boot time
+	  along with other IDE devices, as "hdb" or "hdc", or something
+	  similar, and will be mapped to a character device such as "ht0"
+	  (check the boot messages with dmesg).  Be sure to consult the
+	  <file:drivers/ide/ide-tape.c> and <file:Documentation/ide.txt> files
+	  for usage information.
+
+	  If you want to compile the driver as a module ( = code which can be
+	  inserted in and removed from the running kernel whenever you want),
+	  say M here and read <file:Documentation/modules.txt>.  The module
+	  will be called ide-tape.o.
+
 config BLK_DEV_IDEFLOPPY
 	tristate "Include IDE/ATAPI FLOPPY support"
 	depends on BLK_DEV_IDE
--- linux-2.6.0-test2-full/drivers/atm/Kconfig.old	2003-07-29 00:07:40.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/atm/Kconfig	2003-07-29 00:08:56.000000000 +0200
@@ -145,7 +145,7 @@
 
 config ATM_ZATM
 	tristate "ZeitNet ZN1221/ZN1225"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_SMP
 	help
 	  Driver for the ZeitNet ZN1221 (MMF) and ZN1225 (UTP-5) 155 Mbps ATM
 	  adapters.
@@ -253,7 +253,7 @@
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_SMP
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
--- linux-2.6.0-test2-full/drivers/cdrom/Kconfig.old	2003-07-29 00:22:00.000000000 +0200
+++ linux-2.6.0-test2-full/drivers/cdrom/Kconfig	2003-07-29 00:28:11.000000000 +0200
@@ -74,7 +74,7 @@
 
 config SBPCD
 	tristate "Matsushita/Panasonic/Creative, Longshine, TEAC CDROM support"
-	depends on CD_NO_IDESCSI
+	depends on CD_NO_IDESCSI && BROKEN_ON_SMP
 	---help---
 	  This driver supports most of the drives which use the Panasonic or
 	  Sound Blaster interface.  Please read the file
@@ -199,7 +199,7 @@
 
 config CM206
 	tristate "Philips/LMS CM206 CDROM support"
-	depends on CD_NO_IDESCSI
+	depends on CD_NO_IDESCSI && BROKEN_ON_SMP
 	---help---
 	  If you have a Philips/LMS CD-ROM drive cm206 in combination with a
 	  cm260 host adapter card, say Y here. Please also read the file
@@ -245,7 +245,7 @@
 
 config CDU31A
 	tristate "Sony CDU31A/CDU33A CDROM support"
-	depends on CD_NO_IDESCSI
+	depends on CD_NO_IDESCSI && BROKEN_ON_SMP
 	---help---
 	  These CD-ROM drives have a spring-pop-out caddyless drawer, and a
 	  rectangular green LED centered beneath it.  NOTE: these CD-ROM
@@ -267,7 +267,7 @@
 
 config CDU535
 	tristate "Sony CDU535 CDROM support"
-	depends on CD_NO_IDESCSI
+	depends on CD_NO_IDESCSI && BROKEN_ON_SMP
 	---help---
 	  This is the driver for the older Sony CDU-535 and CDU-531 CD-ROM
 	  drives. Please read the file <file:Documentation/cdrom/sonycd535>.
--- linux-2.6.0-test2-full/fs/partitions/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/fs/partitions/Kconfig	2003-07-28 22:25:22.000000000 +0200
@@ -29,6 +29,7 @@
 
 config ACORN_PARTITION_EESOX
 	bool "EESOX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	depends on BROKEN
 	default y if !PARTITION_ADVANCED && ARCH_ACORN
 
 config ACORN_PARTITION_ICS
--- linux-2.6.0-test2-full/sound/oss/Kconfig.old	2003-07-28 22:23:21.000000000 +0200
+++ linux-2.6.0-test2-full/sound/oss/Kconfig	2003-07-28 22:25:22.000000000 +0200
@@ -912,7 +912,7 @@
 
 config SOUND_AWE32_SYNTH
 	tristate "AWE32 synth"
-	depends on SOUND_OSS
+	depends on SOUND_OSS && (!ISAPNP || BROKEN)
 	help
 	  Say Y here if you have a Sound Blaster SB32, AWE32-PnP, SB AWE64 or
 	  similar sound card. See <file:Documentation/sound/oss/README.awe>,
--- linux-2.6.0-test2-full/init/Kconfig.old	2003-07-28 22:23:22.000000000 +0200
+++ linux-2.6.0-test2-full/init/Kconfig	2003-07-29 10:14:28.000000000 +0200
@@ -34,6 +34,10 @@
 
 endmenu
 
+config BROKEN_ON_SMP
+	bool
+	depends on BROKEN || !SMP
+	default y
 
 menu "General setup"
 
