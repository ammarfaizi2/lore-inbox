Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTIBPsY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 11:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTIBPpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 11:45:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21961 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263916AbTIBPii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 11:38:38 -0400
Date: Tue, 2 Sep 2003 17:38:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] more BROKEN{,ON_SMP}
Message-ID: <20030902153819.GK23729@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

the patch below against 2.6.0-test4 does the following:

- let more drivers that don't compile depend on BROKEN
- MTD_BLKMTD is fixed, remove the dependency on BROKEN
- let all drivers that don't compile on SMP (due to cli/sti usage)
  depend on a BROKEN_ON_SMP that is only defined if !SMP || BROKEN
- #include interrupt.h for dummy cli/sti/... in two files to fix the
  UP compilation of these files

I marked only drivers that are broken for a long time and where I don't 
know about existing fixes with BROKEN or BROKEN_ON_SMP.


diffstat output:

 drivers/atm/Kconfig               |    2 +-
 drivers/cdrom/Kconfig             |    8 ++++----
 drivers/char/Kconfig              |   31 ++++++++++++++++---------------
 drivers/char/epca.c               |    1 +
 drivers/char/generic_serial.c     |    1 +
 drivers/i2c/Kconfig               |    2 +-
 drivers/isdn/Kconfig              |    2 +-
 drivers/isdn/hardware/avm/Kconfig |   12 ++++++------
 drivers/isdn/i4l/Kconfig          |    1 +
 drivers/media/video/Kconfig       |    2 +-
 drivers/mtd/devices/Kconfig       |    2 +-
 drivers/net/Kconfig               |    8 ++++----
 drivers/net/hamradio/Kconfig      |    6 +++---
 drivers/net/irda/Kconfig          |    2 +-
 drivers/net/tulip/Kconfig         |    2 +-
 drivers/net/wan/Kconfig           |    8 ++++----
 drivers/scsi/Kconfig              |   16 ++++++++--------
 drivers/video/Kconfig             |    6 +++---
 init/Kconfig                      |    5 +++++
 19 files changed, 63 insertions(+), 54 deletions(-)


Please apply
Adrian


--- linux-2.6.0-test4-not-full/drivers/media/video/Kconfig.old	2003-08-24 10:26:27.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/media/video/Kconfig	2003-08-24 10:26:51.000000000 +0200
@@ -201,7 +201,7 @@
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Support for ZR36120/ZR36125 based frame grabber/overlay boards.
 	  This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,
--- linux-2.6.0-test4-not-full/drivers/net/tulip/Kconfig.old	2003-08-25 14:53:47.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/tulip/Kconfig	2003-08-25 14:54:02.000000000 +0200
@@ -129,7 +129,7 @@
 
 config PCMCIA_XIRTULIP
 	tristate "Xircom Tulip-like CardBus support (old driver)"
-	depends on NET_TULIP && CARDBUS
+	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP
 	---help---
 	  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
 	  It should work with most DEC 21*4*-based chips/ethercards, as well
--- linux-2.6.0-test4-not-full/drivers/net/irda/Kconfig.old	2003-08-25 14:52:55.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/irda/Kconfig	2003-08-25 14:53:24.000000000 +0200
@@ -256,7 +256,7 @@
 
 config TOSHIBA_OLD
 	tristate "Toshiba Type-O IR Port (old driver)"
-	depends on IRDA
+	depends on IRDA && BROKEN_ON_SMP
 	help
 	  Say Y here if you want to build support for the Toshiba Type-O IR
 	  chipset.  This chipset is used by the Toshiba Libretto 100CT, and
--- linux-2.6.0-test4-not-full/drivers/net/hamradio/Kconfig.old	2003-08-25 14:51:39.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/hamradio/Kconfig	2003-08-25 14:52:13.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/net/Kconfig.old	2003-08-24 11:06:46.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/Kconfig	2003-08-26 20:56:08.000000000 +0200
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
@@ -2670,7 +2670,7 @@
 
 config IPHASE5526
 	tristate "Interphase 5526 Tachyon chipset based adapter support"
-	depends on NET_FC && SCSI && PCI
+	depends on NET_FC && SCSI && PCI && BROKEN
 	help
 	  Say Y here if you have a Fibre Channel adaptor of this kind.
 
--- linux-2.6.0-test4-not-full/drivers/i2c/Kconfig.old	2003-08-26 20:58:13.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/i2c/Kconfig	2003-08-26 20:58:28.000000000 +0200
@@ -150,7 +150,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF
+	depends on I2C_ALGOPCF && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
--- linux-2.6.0-test4-not-full/drivers/video/Kconfig.old	2003-08-24 14:51:48.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/video/Kconfig	2003-08-24 15:05:48.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/isdn/hardware/avm/Kconfig.old	2003-08-25 16:14:34.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/hardware/avm/Kconfig	2003-08-25 16:15:22.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/isdn/i4l/Kconfig.old	2003-08-24 09:59:16.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/i4l/Kconfig	2003-08-24 09:59:46.000000000 +0200
@@ -106,6 +106,7 @@
 
 config ISDN_DIVERSION
 	tristate "Support isdn diversion services"
+	depends on BROKEN
 	help
 	  This option allows you to use some supplementary diversion
 	  services in conjunction with the HiSax driver on an EURO/DSS1
--- linux-2.6.0-test4-not-full/drivers/isdn/Kconfig.old	2003-08-25 14:49:14.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/Kconfig	2003-08-25 14:49:31.000000000 +0200
@@ -22,7 +22,7 @@
 
 
 menu "Old ISDN4Linux"
-	depends on NET && ISDN_BOOL
+	depends on NET && ISDN_BOOL && BROKEN_ON_SMP
 
 config ISDN
 	tristate "Old ISDN4Linux (obsolete)"
--- linux-2.6.0-test4-not-full/drivers/char/Kconfig.old	2003-08-25 15:16:32.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/Kconfig	2003-08-25 15:51:41.000000000 +0200
@@ -80,7 +80,7 @@
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
@@ -113,7 +113,7 @@
 
 config CYCLADES
 	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for a card that gives you many serial ports. You
 	  would need something like this to connect more than two modems to
@@ -145,7 +145,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need
@@ -164,7 +164,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN_ON_SMP
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
@@ -177,7 +177,7 @@
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA
+	depends on SERIAL_NONSTANDARD && ISA && BROKEN_ON_SMP
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read
@@ -190,7 +190,7 @@
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
 
@@ -201,7 +201,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
@@ -262,7 +262,7 @@
 
 config RISCOM8
 	tristate "SDL RISCom/8 card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the SDL Communications RISCom/8 multiport card,
 	  which gives you many serial ports. You would need something like
@@ -275,7 +275,7 @@
 
 config SPECIALIX
 	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the Specialix IO8+ multiport card (both the
 	  ISA and the PCI version) which gives you many serial ports. You
@@ -299,7 +299,7 @@
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.
@@ -310,7 +310,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
@@ -339,7 +339,7 @@
 
 config STALLION
 	tristate "Stallion EasyIO or EC8/32 support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN_ON_SMP
 	help
 	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
 	  card, then this is for you; say Y.  Make sure to read
@@ -352,7 +352,7 @@
 
 config ISTALLION
 	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
 	  serial multiport card, say Y here. Make sure to read
@@ -365,7 +365,7 @@
 
 config SERIAL_TX3912
 	bool "TMPTX3912/PR31700 serial port support"
-	depends on SERIAL_NONSTANDARD && MIPS
+	depends on SERIAL_NONSTANDARD && MIPS && BROKEN_ON_SMP
 	help
 	  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -425,7 +425,7 @@
 
 config A2232
 	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ZORRO
+	depends on EXPERIMENTAL && ZORRO && BROKEN_ON_SMP
 	---help---
 	  This option supports the 2232 7-port serial card shipped with the
 	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
@@ -909,6 +909,7 @@
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
+	depends on BROKEN_ON_SMP
 	---help---
 	  If you have a tape drive that is connected to your floppy
 	  controller, say Y here.
--- linux-2.6.0-test4-not-full/drivers/scsi/Kconfig.old	2003-08-24 11:11:38.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/scsi/Kconfig	2003-08-26 20:57:18.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/mtd/devices/Kconfig.old	2003-08-24 12:43:08.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/mtd/devices/Kconfig	2003-08-24 12:43:25.000000000 +0200
@@ -102,7 +102,7 @@
 
 config MTD_BLKMTD
 	tristate "MTD emulation using block device"
-	depends on MTD && BROKEN
+	depends on MTD
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
--- linux-2.6.0-test4-not-full/drivers/atm/Kconfig.old	2003-08-25 15:03:40.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/atm/Kconfig	2003-08-25 15:04:02.000000000 +0200
@@ -241,7 +241,7 @@
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_SMP
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
--- linux-2.6.0-test4-not-full/drivers/cdrom/Kconfig.old	2003-08-25 15:11:35.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/cdrom/Kconfig	2003-08-25 15:13:29.000000000 +0200
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
--- linux-2.6.0-test4-not-full/init/Kconfig.old	2003-08-25 14:49:54.000000000 +0200
+++ linux-2.6.0-test4-not-full/init/Kconfig	2003-08-25 14:50:22.000000000 +0200
@@ -43,6 +43,11 @@
 
 	  If unsure, say N.
 
+config BROKEN_ON_SMP
+	bool
+	depends on BROKEN || !SMP
+	default y
+
 endmenu
 
 
--- linux-2.6.0-test4-not-full/drivers/char/epca.c.old	2003-09-01 01:01:25.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/epca.c	2003-09-01 01:01:49.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/tty_flip.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
--- linux-2.6.0-test4-not-full/drivers/char/generic_serial.c.old	2003-09-01 01:09:06.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/generic_serial.c	2003-09-01 01:09:23.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/serial.h>
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
+#include <linux/interrupt.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
--- linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig.old	2003-09-02 17:24:42.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig	2003-09-02 17:24:53.000000000 +0200
@@ -35,7 +35,7 @@
 # The COSA/SRP driver has not been tested as non-modular yet.
 config COSA
 	tristate "COSA/SRP sync serial boards support"
-	depends on WAN && ISA && m
+	depends on WAN && ISA && m && BROKEN
 	---help---
 	  This is a driver for COSA and SRP synchronous serial boards. These
 	  boards allow to connect synchronous serial devices (for example
@@ -63,7 +63,7 @@
 # Not updated to 2.6.
 config COMX
 	tristate "MultiGate (COMX) synchronous serial boards support"
-	depends on WAN && (ISA || PCI) && OBSOLETE
+	depends on WAN && (ISA || PCI) && BROKEN
 	---help---
 	  Say Y if you want to use any board from the MultiGate (COMX) family.
 	  These boards are synchronous serial adapters for the PC,
@@ -465,7 +465,7 @@
 
 config SDLA
 	tristate "SDLA (Sangoma S502/S508) support"
-	depends on DLCI && ISA
+	depends on DLCI && ISA && BROKEN_ON_SMP
 	help
 	  Say Y here if you need a driver for the Sangoma S502A, S502E, and
 	  S508 Frame Relay Access Devices. These are multi-protocol cards, but
@@ -498,7 +498,7 @@
 
 config VENDOR_SANGOMA
 	tristate "Sangoma WANPIPE(tm) multiprotocol cards"
-	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA)
+	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA) && BROKEN
 	---help---
 	  WANPIPE from Sangoma Technologies Inc. (<http://www.sangoma.com/>)
 	  is a family of intelligent multiprotocol WAN adapters with data
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
Hi Linus,

the patch below against 2.6.0-test4 does the following:

- let more drivers that don't compile depend on BROKEN
- MTD_BLKMTD is fixed, remove the dependency on BROKEN
- let all drivers that don't compile on SMP (due to cli/sti usage)
  depend on a BROKEN_ON_SMP that is only defined if !SMP || BROKEN
- #include interrupt.h for dummy cli/sti/... in two files to fix the
  UP compilation of these files

I marked only drivers that are broken for a long time and where I don't 
know about existing fixes with BROKEN or BROKEN_ON_SMP.


diffstat output:

 drivers/atm/Kconfig               |    2 +-
 drivers/cdrom/Kconfig             |    8 ++++----
 drivers/char/Kconfig              |   31 ++++++++++++++++---------------
 drivers/char/epca.c               |    1 +
 drivers/char/generic_serial.c     |    1 +
 drivers/i2c/Kconfig               |    2 +-
 drivers/isdn/Kconfig              |    2 +-
 drivers/isdn/hardware/avm/Kconfig |   12 ++++++------
 drivers/isdn/i4l/Kconfig          |    1 +
 drivers/media/video/Kconfig       |    2 +-
 drivers/mtd/devices/Kconfig       |    2 +-
 drivers/net/Kconfig               |    8 ++++----
 drivers/net/hamradio/Kconfig      |    6 +++---
 drivers/net/irda/Kconfig          |    2 +-
 drivers/net/tulip/Kconfig         |    2 +-
 drivers/net/wan/Kconfig           |    8 ++++----
 drivers/scsi/Kconfig              |   16 ++++++++--------
 drivers/video/Kconfig             |    6 +++---
 init/Kconfig                      |    5 +++++
 19 files changed, 63 insertions(+), 54 deletions(-)


Please apply
Adrian


--- linux-2.6.0-test4-not-full/drivers/media/video/Kconfig.old	2003-08-24 10:26:27.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/media/video/Kconfig	2003-08-24 10:26:51.000000000 +0200
@@ -201,7 +201,7 @@
 
 config VIDEO_ZR36120
 	tristate "Zoran ZR36120/36125 Video For Linux"
-	depends on VIDEO_DEV && PCI && I2C
+	depends on VIDEO_DEV && PCI && I2C && BROKEN
 	help
 	  Support for ZR36120/ZR36125 based frame grabber/overlay boards.
 	  This includes the Victor II, WaveWatcher, Video Wonder, Maxi-TV,
--- linux-2.6.0-test4-not-full/drivers/net/tulip/Kconfig.old	2003-08-25 14:53:47.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/tulip/Kconfig	2003-08-25 14:54:02.000000000 +0200
@@ -129,7 +129,7 @@
 
 config PCMCIA_XIRTULIP
 	tristate "Xircom Tulip-like CardBus support (old driver)"
-	depends on NET_TULIP && CARDBUS
+	depends on NET_TULIP && CARDBUS && BROKEN_ON_SMP
 	---help---
 	  This driver is for the Digital "Tulip" Ethernet CardBus adapters.
 	  It should work with most DEC 21*4*-based chips/ethercards, as well
--- linux-2.6.0-test4-not-full/drivers/net/irda/Kconfig.old	2003-08-25 14:52:55.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/irda/Kconfig	2003-08-25 14:53:24.000000000 +0200
@@ -256,7 +256,7 @@
 
 config TOSHIBA_OLD
 	tristate "Toshiba Type-O IR Port (old driver)"
-	depends on IRDA
+	depends on IRDA && BROKEN_ON_SMP
 	help
 	  Say Y here if you want to build support for the Toshiba Type-O IR
 	  chipset.  This chipset is used by the Toshiba Libretto 100CT, and
--- linux-2.6.0-test4-not-full/drivers/net/hamradio/Kconfig.old	2003-08-25 14:51:39.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/hamradio/Kconfig	2003-08-25 14:52:13.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/net/Kconfig.old	2003-08-24 11:06:46.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/Kconfig	2003-08-26 20:56:08.000000000 +0200
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
@@ -2670,7 +2670,7 @@
 
 config IPHASE5526
 	tristate "Interphase 5526 Tachyon chipset based adapter support"
-	depends on NET_FC && SCSI && PCI
+	depends on NET_FC && SCSI && PCI && BROKEN
 	help
 	  Say Y here if you have a Fibre Channel adaptor of this kind.
 
--- linux-2.6.0-test4-not-full/drivers/i2c/Kconfig.old	2003-08-26 20:58:13.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/i2c/Kconfig	2003-08-26 20:58:28.000000000 +0200
@@ -150,7 +150,7 @@
 
 config I2C_ELEKTOR
 	tristate "Elektor ISA card"
-	depends on I2C_ALGOPCF
+	depends on I2C_ALGOPCF && BROKEN_ON_SMP
 	help
 	  This supports the PCF8584 ISA bus I2C adapter.  Say Y if you own
 	  such an adapter.
--- linux-2.6.0-test4-not-full/drivers/video/Kconfig.old	2003-08-24 14:51:48.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/video/Kconfig	2003-08-24 15:05:48.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/isdn/hardware/avm/Kconfig.old	2003-08-25 16:14:34.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/hardware/avm/Kconfig	2003-08-25 16:15:22.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/isdn/i4l/Kconfig.old	2003-08-24 09:59:16.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/i4l/Kconfig	2003-08-24 09:59:46.000000000 +0200
@@ -106,6 +106,7 @@
 
 config ISDN_DIVERSION
 	tristate "Support isdn diversion services"
+	depends on BROKEN
 	help
 	  This option allows you to use some supplementary diversion
 	  services in conjunction with the HiSax driver on an EURO/DSS1
--- linux-2.6.0-test4-not-full/drivers/isdn/Kconfig.old	2003-08-25 14:49:14.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/isdn/Kconfig	2003-08-25 14:49:31.000000000 +0200
@@ -22,7 +22,7 @@
 
 
 menu "Old ISDN4Linux"
-	depends on NET && ISDN_BOOL
+	depends on NET && ISDN_BOOL && BROKEN_ON_SMP
 
 config ISDN
 	tristate "Old ISDN4Linux (obsolete)"
--- linux-2.6.0-test4-not-full/drivers/char/Kconfig.old	2003-08-25 15:16:32.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/Kconfig	2003-08-25 15:51:41.000000000 +0200
@@ -80,7 +80,7 @@
 
 config COMPUTONE
 	tristate "Computone IntelliPort Plus serial support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This driver supports the entire family of Intelliport II/Plus
 	  controllers with the exception of the MicroChannel controllers and
@@ -113,7 +113,7 @@
 
 config CYCLADES
 	tristate "Cyclades async mux support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for a card that gives you many serial ports. You
 	  would need something like this to connect more than two modems to
@@ -145,7 +145,7 @@
 
 config DIGIEPCA
 	tristate "Digiboard Intelligent Async Support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	---help---
 	  This is a driver for Digi International's Xx, Xeve, and Xem series
 	  of cards which provide multiple serial ports. You would need
@@ -164,7 +164,7 @@
 
 config DIGI
 	tristate "Digiboard PC/Xx Support"
-	depends on SERIAL_NONSTANDARD && DIGIEPCA=n
+	depends on SERIAL_NONSTANDARD && DIGIEPCA=n && BROKEN_ON_SMP
 	help
 	  This is a driver for the Digiboard PC/Xe, PC/Xi, and PC/Xeve cards
 	  that give you many serial ports. You would need something like this
@@ -177,7 +177,7 @@
 
 config ESPSERIAL
 	tristate "Hayes ESP serial port support"
-	depends on SERIAL_NONSTANDARD && ISA
+	depends on SERIAL_NONSTANDARD && ISA && BROKEN_ON_SMP
 	help
 	  This is a driver which supports Hayes ESP serial ports.  Both single
 	  port cards and multiport cards are supported.  Make sure to read
@@ -190,7 +190,7 @@
 
 config MOXA_INTELLIO
 	tristate "Moxa Intellio support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa Intellio multiport serial card.
 
@@ -201,7 +201,7 @@
 
 config MOXA_SMARTIO
 	tristate "Moxa SmartIO support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  Say Y here if you have a Moxa SmartIO multiport serial card.
 
@@ -262,7 +262,7 @@
 
 config RISCOM8
 	tristate "SDL RISCom/8 card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the SDL Communications RISCom/8 multiport card,
 	  which gives you many serial ports. You would need something like
@@ -275,7 +275,7 @@
 
 config SPECIALIX
 	tristate "Specialix IO8+ card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the Specialix IO8+ multiport card (both the
 	  ISA and the PCI version) which gives you many serial ports. You
@@ -299,7 +299,7 @@
 
 config SX
 	tristate "Specialix SX (and SI) card support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the SX and SI multiport serial cards.
 	  Please read the file <file:Documentation/sx.txt> for details.
@@ -310,7 +310,7 @@
 
 config RIO
 	tristate "Specialix RIO system support"
-	depends on SERIAL_NONSTANDARD
+	depends on SERIAL_NONSTANDARD && BROKEN_ON_SMP
 	help
 	  This is a driver for the Specialix RIO, a smart serial card which
 	  drives an outboard box that can support up to 128 ports.  Product
@@ -339,7 +339,7 @@
 
 config STALLION
 	tristate "Stallion EasyIO or EC8/32 support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN_ON_SMP
 	help
 	  If you have an EasyIO or EasyConnection 8/32 multiport Stallion
 	  card, then this is for you; say Y.  Make sure to read
@@ -352,7 +352,7 @@
 
 config ISTALLION
 	tristate "Stallion EC8/64, ONboard, Brumby support"
-	depends on STALDRV
+	depends on STALDRV && BROKEN
 	help
 	  If you have an EasyConnection 8/64, ONboard, Brumby or Stallion
 	  serial multiport card, say Y here. Make sure to read
@@ -365,7 +365,7 @@
 
 config SERIAL_TX3912
 	bool "TMPTX3912/PR31700 serial port support"
-	depends on SERIAL_NONSTANDARD && MIPS
+	depends on SERIAL_NONSTANDARD && MIPS && BROKEN_ON_SMP
 	help
 	  The TX3912 is a Toshiba RISC processor based o the MIPS 3900 core;
 	  see <http://www.toshiba.com/taec/components/Generic/risc/tx3912.htm>.
@@ -425,7 +425,7 @@
 
 config A2232
 	tristate "Commodore A2232 serial support (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && ZORRO
+	depends on EXPERIMENTAL && ZORRO && BROKEN_ON_SMP
 	---help---
 	  This option supports the 2232 7-port serial card shipped with the
 	  Amiga 2000 and other Zorro-bus machines, dating from 1989.  At
@@ -909,6 +909,7 @@
 
 config FTAPE
 	tristate "Ftape (QIC-80/Travan) support"
+	depends on BROKEN_ON_SMP
 	---help---
 	  If you have a tape drive that is connected to your floppy
 	  controller, say Y here.
--- linux-2.6.0-test4-not-full/drivers/scsi/Kconfig.old	2003-08-24 11:11:38.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/scsi/Kconfig	2003-08-26 20:57:18.000000000 +0200
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
--- linux-2.6.0-test4-not-full/drivers/mtd/devices/Kconfig.old	2003-08-24 12:43:08.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/mtd/devices/Kconfig	2003-08-24 12:43:25.000000000 +0200
@@ -102,7 +102,7 @@
 
 config MTD_BLKMTD
 	tristate "MTD emulation using block device"
-	depends on MTD && BROKEN
+	depends on MTD
 	help
 	  This driver allows a block device to appear as an MTD. It would
 	  generally be used in the following cases:
--- linux-2.6.0-test4-not-full/drivers/atm/Kconfig.old	2003-08-25 15:03:40.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/atm/Kconfig	2003-08-25 15:04:02.000000000 +0200
@@ -241,7 +241,7 @@
 
 config ATM_AMBASSADOR
 	tristate "Madge Ambassador (Collage PCI 155 Server)"
-	depends on PCI && ATM
+	depends on PCI && ATM && BROKEN_ON_SMP
 	help
 	  This is a driver for ATMizer based ATM card produced by Madge
 	  Networks Ltd. Say Y (or M to compile as a module named ambassador)
--- linux-2.6.0-test4-not-full/drivers/cdrom/Kconfig.old	2003-08-25 15:11:35.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/cdrom/Kconfig	2003-08-25 15:13:29.000000000 +0200
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
--- linux-2.6.0-test4-not-full/init/Kconfig.old	2003-08-25 14:49:54.000000000 +0200
+++ linux-2.6.0-test4-not-full/init/Kconfig	2003-08-25 14:50:22.000000000 +0200
@@ -43,6 +43,11 @@
 
 	  If unsure, say N.
 
+config BROKEN_ON_SMP
+	bool
+	depends on BROKEN || !SMP
+	default y
+
 endmenu
 
 
--- linux-2.6.0-test4-not-full/drivers/char/epca.c.old	2003-09-01 01:01:25.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/epca.c	2003-09-01 01:01:49.000000000 +0200
@@ -40,6 +40,7 @@
 #include <linux/tty_flip.h>
 #include <linux/slab.h>
 #include <linux/ioport.h>
+#include <linux/interrupt.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 
--- linux-2.6.0-test4-not-full/drivers/char/generic_serial.c.old	2003-09-01 01:09:06.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/char/generic_serial.c	2003-09-01 01:09:23.000000000 +0200
@@ -25,6 +25,7 @@
 #include <linux/serial.h>
 #include <linux/mm.h>
 #include <linux/generic_serial.h>
+#include <linux/interrupt.h>
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
 
--- linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig.old	2003-09-02 17:24:42.000000000 +0200
+++ linux-2.6.0-test4-not-full/drivers/net/wan/Kconfig	2003-09-02 17:24:53.000000000 +0200
@@ -35,7 +35,7 @@
 # The COSA/SRP driver has not been tested as non-modular yet.
 config COSA
 	tristate "COSA/SRP sync serial boards support"
-	depends on WAN && ISA && m
+	depends on WAN && ISA && m && BROKEN
 	---help---
 	  This is a driver for COSA and SRP synchronous serial boards. These
 	  boards allow to connect synchronous serial devices (for example
@@ -63,7 +63,7 @@
 # Not updated to 2.6.
 config COMX
 	tristate "MultiGate (COMX) synchronous serial boards support"
-	depends on WAN && (ISA || PCI) && OBSOLETE
+	depends on WAN && (ISA || PCI) && BROKEN
 	---help---
 	  Say Y if you want to use any board from the MultiGate (COMX) family.
 	  These boards are synchronous serial adapters for the PC,
@@ -465,7 +465,7 @@
 
 config SDLA
 	tristate "SDLA (Sangoma S502/S508) support"
-	depends on DLCI && ISA
+	depends on DLCI && ISA && BROKEN_ON_SMP
 	help
 	  Say Y here if you need a driver for the Sangoma S502A, S502E, and
 	  S508 Frame Relay Access Devices. These are multi-protocol cards, but
@@ -498,7 +498,7 @@
 
 config VENDOR_SANGOMA
 	tristate "Sangoma WANPIPE(tm) multiprotocol cards"
-	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA)
+	depends on WAN_ROUTER_DRIVERS && WAN_ROUTER && (PCI || ISA) && BROKEN
 	---help---
 	  WANPIPE from Sangoma Technologies Inc. (<http://www.sangoma.com/>)
 	  is a family of intelligent multiprotocol WAN adapters with data
