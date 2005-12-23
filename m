Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbVLWATU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbVLWATU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 19:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVLWATJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 19:19:09 -0500
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:36525 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751233AbVLWASy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 19:18:54 -0500
From: David Brownell <david-b@pacbell.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.14-rc6-git 6/6] SPI parport adapter to AVR Butterfly
Date: Thu, 22 Dec 2005 15:41:06 -0800
User-Agent: KMail/1.7.1
Cc: spi-devel-general@lists.sourceforge.net
References: <200511102355.11505.david-b@pacbell.net> 
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200512221541.06956.david-b@pacbell.net>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SmzqD8abksr9LmK"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_SmzqD8abksr9LmK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch ties together a lot of things; it lets folk with PCs use SPI
to talk to an inexpensive(*) microcontroller evaluation/development board
through a simple parport cable.  In particular, it shows one way to hook
up the parts so Linux will bitbang SPI messages to/from devices.

Linux already has a full userspace cross-development environment (avr-gcc,
avrdude, etc) that can use the same adapter to update firmware.  What this
driver adds is the ability for Linux kernel code to use such links to talk
to AVR firmware, or to the dataflash chip on that board.

(*) $20 at DigiKey, or from avrfreaks.net (with their T-Shirt).

--Boundary-00=_SmzqD8abksr9LmK
Content-Type: text/x-diff;
  charset="us-ascii";
  name="butterfly.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="butterfly.patch"

This adds a bitbanging parport based adaptor cable for AVR Butterfly, giving
SPI links to its DataFlash chip and (eventually) firmware running in the card.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

--- tmp.orig/drivers/spi/Kconfig	2005-12-22 14:54:03.000000000 -0800
+++ tmp/drivers/spi/Kconfig	2005-12-22 14:54:10.000000000 -0800
@@ -80,6 +80,16 @@ config SPI_BITBANG
 	  need it.  You only need to select this explicitly to support driver
 	  modules that aren't part of this kernel tree.
 
+config SPI_BUTTERFLY
+	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
+	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
+	select SPI_BITBANG
+	help
+	  This uses a custom parallel port cable to connect to an AVR
+	  Butterfly <http://www.atmel.com/products/avr/butterfly>, an
+	  inexpensive battery powered microcontroller evaluation board.
+	  This same cable can be used to flash new firmware.
+
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
--- tmp.orig/drivers/spi/Makefile	2005-12-22 14:54:03.000000000 -0800
+++ tmp/drivers/spi/Makefile	2005-12-22 14:54:10.000000000 -0800
@@ -12,6 +12,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
+obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/drivers/spi/spi_butterfly.c	2005-12-22 14:54:10.000000000 -0800
@@ -0,0 +1,421 @@
+/*
+ * spi_butterfly.c - parport-to-butterfly adapter
+ *
+ * Copyright (C) 2005 David Brownell
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/parport.h>
+
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/spi/flash.h>
+
+#include <linux/mtd/partitions.h>
+
+
+/*
+ * This uses SPI to talk with an "AVR Butterfly", which is a $US20 card
+ * with a battery powered AVR microcontroller and lots of goodies.  You
+ * can use GCC to develop firmware for this.
+ *
+ * See Documentation/spi/butterfly for information about how to build
+ * and use this custom parallel port cable.
+ */
+
+#undef	HAVE_USI	/* nyet */
+
+
+/* DATA output bits (pins 2..9 == D0..D7) */
+#define	butterfly_nreset (1 << 1)		/* pin 3 */
+
+#define	spi_sck_bit	(1 << 0)		/* pin 2 */
+#define	spi_mosi_bit	(1 << 7)		/* pin 9 */
+
+#define	usi_sck_bit	(1 << 3)		/* pin 5 */
+#define	usi_mosi_bit	(1 << 4)		/* pin 6 */
+
+#define	vcc_bits	((1 << 6) | (1 << 5))	/* pins 7, 8 */
+
+/* STATUS input bits */
+#define	spi_miso_bit	PARPORT_STATUS_BUSY	/* pin 11 */
+
+#define	usi_miso_bit	PARPORT_STATUS_PAPEROUT	/* pin 12 */
+
+/* CONTROL output bits */
+#define	spi_cs_bit	PARPORT_CONTROL_SELECT	/* pin 17 */
+/* USI uses no chipselect */
+
+
+
+static inline struct butterfly *spidev_to_pp(struct spi_device *spi)
+{
+	return spi->controller_data;
+}
+
+static inline int is_usidev(struct spi_device *spi)
+{
+#ifdef	HAVE_USI
+	return spi->chip_select != 1;
+#else
+	return 0;
+#endif
+}
+
+
+struct butterfly {
+	/* REVISIT ... for now, this must be first */
+	struct spi_bitbang	bitbang;
+
+	struct parport		*port;
+	struct pardevice	*pd;
+
+	u8			lastbyte;
+
+	struct spi_device	*dataflash;
+	struct spi_device	*butterfly;
+	struct spi_board_info	info[2];
+
+};
+
+/*----------------------------------------------------------------------*/
+
+/*
+ * these routines may be slower than necessary because they're hiding
+ * the fact that there are two different SPI busses on this cable: one
+ * to the DataFlash chip (or AVR SPI controller), the other to the
+ * AVR USI controller.
+ */
+
+static inline void
+setsck(struct spi_device *spi, int is_on)
+{
+	struct butterfly	*pp = spidev_to_pp(spi);
+	u8			bit, byte = pp->lastbyte;
+
+	if (is_usidev(spi))
+		bit = usi_sck_bit;
+	else
+		bit = spi_sck_bit;
+
+	if (is_on)
+		byte |= bit;
+	else
+		byte &= ~bit;
+	parport_write_data(pp->port, byte);
+	pp->lastbyte = byte;
+}
+
+static inline void
+setmosi(struct spi_device *spi, int is_on)
+{
+	struct butterfly	*pp = spidev_to_pp(spi);
+	u8			bit, byte = pp->lastbyte;
+
+	if (is_usidev(spi))
+		bit = usi_mosi_bit;
+	else
+		bit = spi_mosi_bit;
+
+	if (is_on)
+		byte |= bit;
+	else
+		byte &= ~bit;
+	parport_write_data(pp->port, byte);
+	pp->lastbyte = byte;
+}
+
+static inline int getmiso(struct spi_device *spi)
+{
+	struct butterfly	*pp = spidev_to_pp(spi);
+	int			value;
+	u8			bit;
+
+	if (is_usidev(spi))
+		bit = usi_miso_bit;
+	else
+		bit = spi_miso_bit;
+
+	/* only STATUS_BUSY is NOT negated */
+	value = !(parport_read_status(pp->port) & bit);
+	return (bit == PARPORT_STATUS_BUSY) ? value : !value;
+}
+
+static void butterfly_chipselect(struct spi_device *spi, int value)
+{
+	struct butterfly	*pp = spidev_to_pp(spi);
+
+	/* set default clock polarity */
+	if (value != BITBANG_CS_INACTIVE)
+		setsck(spi, spi->mode & SPI_CPOL);
+
+	/* no chipselect on this USI link config */
+	if (is_usidev(spi))
+		return;
+
+	/* here, value == "activate or not";
+	 * most PARPORT_CONTROL_* bits are negated, so we must
+	 * morph it to value == "bit value to write in control register"
+	 */
+	if (spi_cs_bit == PARPORT_CONTROL_INIT)
+		value = !value;
+		
+	parport_frob_control(pp->port, spi_cs_bit, value ? spi_cs_bit : 0);
+}
+
+
+/* we only needed to implement one mode here, and choose SPI_MODE_0 */
+
+#define	spidelay(X)	do{}while(0)
+//#define	spidelay	ndelay
+
+#define	EXPAND_BITBANG_TXRX
+#include <linux/spi/spi_bitbang.h>
+
+static u32
+butterfly_txrx_word_mode0(struct spi_device *spi,
+		unsigned nsecs,
+		u32 word, u8 bits)
+{
+	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
+}
+
+/*----------------------------------------------------------------------*/
+
+/* override default partitioning with cmdlinepart */
+static struct mtd_partition partitions[] = { {
+	/* JFFS2 wants partitions of 4*N blocks for this device,
+	 * so sectors 0 and 1 can't be partitions by themselves.
+	 */
+
+	/* sector 0 = 8 pages * 264 bytes/page (1 block)
+	 * sector 1 = 248 pages * 264 bytes/page
+	 */
+	.name		= "bookkeeping",	// 66 KB
+	.offset		= 0,
+	.size		= (8 + 248) * 264,
+//	.mask_flags	= MTD_WRITEABLE,
+}, {
+	/* sector 2 = 256 pages * 264 bytes/page
+	 * sectors 3-5 = 512 pages * 264 bytes/page
+	 */
+	.name		= "filesystem",		// 462 KB
+	.offset		= MTDPART_OFS_APPEND,
+	.size		= MTDPART_SIZ_FULL,
+} };
+
+static struct flash_platform_data flash = {
+	.name		= "butterflash",
+	.parts		= partitions,
+	.nr_parts	= ARRAY_SIZE(partitions),
+};
+
+
+/* REVISIT remove this ugly global and its "only one" limitation */
+static struct butterfly *butterfly;
+
+static void butterfly_attach(struct parport *p)
+{
+	struct pardevice	*pd;
+	int			status;
+	struct butterfly	*pp;
+	struct spi_master	*master;
+	struct platform_device	*pdev;
+
+	if (butterfly)
+		return;
+
+	/* REVISIT:  this just _assumes_ a butterfly is there ... no probe,
+	 * and no way to be selective about what it binds to.
+	 */
+
+	/* FIXME where should master->cdev.dev come from?
+	 * e.g. /sys/bus/pnp0/00:0b, some PCI thing, etc
+	 * setting up a platform device like this is an ugly kluge...
+	 */
+	pdev = platform_device_register_simple("butterfly", -1, NULL, 0);
+
+	master = spi_alloc_master(&pdev->dev, sizeof *pp);
+	if (!master) {
+		status = -ENOMEM;
+		goto done;
+	}
+	pp = spi_master_get_devdata(master);
+
+	/*
+	 * SPI and bitbang hookup
+	 *
+	 * use default setup(), cleanup(), and transfer() methods; and
+	 * only bother implementing mode 0.  Start it later.
+	 */
+	master->bus_num = 42;
+	master->num_chipselect = 2;
+
+	pp->bitbang.master = spi_master_get(master);
+	pp->bitbang.chipselect = butterfly_chipselect;
+	pp->bitbang.txrx_word[SPI_MODE_0] = butterfly_txrx_word_mode0;
+
+	/*
+	 * parport hookup
+	 */
+	pp->port = p;
+	pd = parport_register_device(p, "spi_butterfly",
+			NULL, NULL, NULL,
+			0 /* FLAGS */, pp);
+	if (!pd) {
+		status = -ENOMEM;
+		goto clean0;
+	}
+	pp->pd = pd;
+
+	status = parport_claim(pd);
+	if (status < 0) 
+		goto clean1;
+
+	/*
+	 * Butterfly reset, powerup, run firmware
+	 */
+	pr_debug("%s: powerup/reset Butterfly\n", p->name);
+
+	/* nCS for dataflash (this bit is inverted on output) */
+	parport_frob_control(pp->port, spi_cs_bit, 0);
+
+	/* stabilize power with chip in reset (nRESET), and
+	 * both spi_sck_bit and usi_sck_bit clear (CPOL=0)
+	 */
+	pp->lastbyte |= vcc_bits;
+	parport_write_data(pp->port, pp->lastbyte);
+	msleep(5);
+
+	/* take it out of reset; assume long reset delay */
+	pp->lastbyte |= butterfly_nreset;
+	parport_write_data(pp->port, pp->lastbyte);
+	msleep(100);
+
+
+	/*
+	 * Start SPI ... for now, hide that we're two physical busses.
+	 */
+	status = spi_bitbang_start(&pp->bitbang);
+	if (status < 0)
+		goto clean2;
+
+	/* Bus 1 lets us talk to at45db041b (firmware disables AVR SPI), AVR
+	 * (firmware resets at45, acts as spi slave) or neither (we ignore
+	 * both, AVR uses AT45).  We expect firmware for the first option.
+	 */
+	pp->info[0].max_speed_hz = 15 * 1000 * 1000;
+	strcpy(pp->info[0].modalias, "mtd_dataflash");
+	pp->info[0].platform_data = &flash;
+	pp->info[0].chip_select = 1;
+	pp->info[0].controller_data = pp;
+	pp->dataflash = spi_new_device(pp->bitbang.master, &pp->info[0]);
+	if (pp->dataflash)
+		pr_debug("%s: dataflash at %s\n", p->name,
+				pp->dataflash->dev.bus_id);
+
+#ifdef	HAVE_USI
+	/* Bus 2 is only for talking to the AVR, and it can work no
+	 * matter who masters bus 1; needs appropriate AVR firmware.
+	 */
+	pp->info[1].max_speed_hz = 10 /* ?? */ * 1000 * 1000;
+	strcpy(pp->info[1].modalias, "butterfly");
+	// pp->info[1].platform_data = ... TBD ... ;
+	pp->info[1].chip_select = 2,
+	pp->info[1].controller_data = pp;
+	pp->butterfly = spi_new_device(pp->bitbang.master, &pp->info[1]);
+	if (pp->butterfly)
+		pr_debug("%s: butterfly at %s\n", p->name,
+				pp->butterfly->dev.bus_id);
+
+	/* FIXME setup ACK for the IRQ line ...  */
+#endif
+
+	// dev_info(_what?_, ...)
+	pr_info("%s: AVR Butterfly\n", p->name);
+	butterfly = pp;
+	return;
+
+clean2:
+	/* turn off VCC */
+	parport_write_data(pp->port, 0);
+
+	parport_release(pp->pd);
+clean1:
+	parport_unregister_device(pd);
+clean0:
+	(void) spi_master_put(pp->bitbang.master);
+done:
+	platform_device_unregister(pdev);
+	pr_debug("%s: butterfly probe, fail %d\n", p->name, status);
+}
+
+static void butterfly_detach(struct parport *p)
+{
+	struct butterfly	*pp;
+	struct platform_device	*pdev;
+	int			status;
+
+	/* FIXME this global is ugly ... but, how to quickly get from
+	 * the parport to the "struct butterfly" associated with it?
+	 * "old school" driver-internal device lists?
+	 */
+	if (!butterfly || butterfly->port != p)
+		return;
+	pp = butterfly;
+	butterfly = NULL;
+
+	/* stop() unregisters child devices too */
+	pdev = to_platform_device(pp->bitbang.master->cdev.dev);
+	status = spi_bitbang_stop(&pp->bitbang);
+
+	/* turn off VCC */
+	parport_write_data(pp->port, 0);
+	msleep(10);
+
+	parport_release(pp->pd);
+	parport_unregister_device(pp->pd);
+
+	(void) spi_master_put(pp->bitbang.master);
+
+	platform_device_unregister(pdev);
+}
+
+static struct parport_driver butterfly_driver = {
+	.name =		"spi_butterfly",
+	.attach =	butterfly_attach,
+	.detach =	butterfly_detach,
+};
+
+
+static int __init butterfly_init(void)
+{
+	return parport_register_driver(&butterfly_driver);
+}
+device_initcall(butterfly_init);
+
+static void __exit butterfly_exit(void)
+{
+	parport_unregister_driver(&butterfly_driver);
+}
+module_exit(butterfly_exit);
+
+MODULE_DESCRIPTION("Parport Adapter driver for AVR Butterfly");
+MODULE_LICENSE("GPL");
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ tmp/Documentation/spi/butterfly	2005-12-22 14:54:10.000000000 -0800
@@ -0,0 +1,57 @@
+spi_butterfly - parport-to-butterfly adapter driver
+===================================================
+
+This is a hardware and software project that includes building and using
+a parallel port adapter cable, together with an "AVR Butterfly" to run
+firmware for user interfacing and/or sensors.  A Butterfly is a $US20
+battery powered card with an AVR microcontroller and lots of goodies:
+sensors, LCD, flash, toggle stick, and more.  You can use AVR-GCC to
+develop firmware for this, and flash it using this adapter cable.
+
+You can make this adapter from an old printer cable and solder things
+directly to the Butterfly.  Or (if you have the parts and skills) you
+can come up with something fancier, providing ciruit protection to the
+Butterfly and the printer port, or with a better power supply than two
+signal pins from the printer port.
+
+
+The first cable connections will hook Linux up to one SPI bus, with the
+AVR and a DataFlash chip; and to the AVR reset line.  This is all you
+need to reflash the firmware, and the pins are the standard Atmel "ISP"
+connector pins (used also on non-Butterfly AVR boards).
+
+	Signal	  Butterfly	  Parport (DB-25)
+	------	  ---------	  ---------------
+	SCK	= J403.PB1/SCK	= pin 2/D0
+	RESET	= J403.nRST	= pin 3/D1
+	VCC	= J403.VCC_EXT	= pin 8/D6
+	MOSI	= J403.PB2/MOSI	= pin 9/D7
+	MISO	= J403.PB3/MISO	= pin 11/S7,nBUSY
+	GND	= J403.GND	= pin 23/GND
+
+Then to let Linux master that bus to talk to the DataFlash chip, you must
+(a) flash new firmware that disables SPI (set PRR.2, and disable pullups
+by clearing PORTB.[0-3]); (b) configure the mtd_dataflash driver; and
+(c) cable in the chipselect.
+
+	Signal	  Butterfly	  Parport (DB-25)
+	------	  ---------	  ---------------
+	VCC	= J400.VCC_EXT	= pin 7/D5
+	SELECT	= J400.PB0/nSS	= pin 17/C3,nSELECT
+	GND	= J400.GND	= pin 24/GND
+
+The "USI" controller, using J405, can be used for a second SPI bus.  That
+would let you talk to the AVR over SPI, running firmware that makes it act
+as an SPI slave, while letting either Linux or the AVR use the DataFlash.
+There are plenty of spare parport pins to wire this one up, such as:
+
+	Signal	  Butterfly	  Parport (DB-25)
+	------	  ---------	  ---------------
+	SCK	= J403.PE4/USCK	= pin 5/D3
+	MOSI	= J403.PE5/DI	= pin 6/D4
+	MISO	= J403.PE6/DO	= pin 12/S5,nPAPEROUT
+	GND	= J403.GND	= pin 22/GND
+
+	IRQ	= J402.PF4	= pin 10/S6,ACK
+	GND	= J402.GND(P2)	= pin 25/GND
+

--Boundary-00=_SmzqD8abksr9LmK--
