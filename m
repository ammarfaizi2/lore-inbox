Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbWBFUcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbWBFUcm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWBFUcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:32:35 -0500
Received: from mail.kroah.org ([69.55.234.183]:27837 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964793AbWBFU3g convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:29:36 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] SPI: spi_butterfly, restore lost deltas
In-Reply-To: <11392577573268@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 6 Feb 2006 12:29:17 -0800
Message-Id: <1139257757388@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] SPI: spi_butterfly, restore lost deltas

This resolves some minor version skew glitches that accumulated for the AVR
Butterfly adapter driver, which caused among other things the existence of
a duplicate Kconfig entry.  Most of it boils down to comment updates, but in
one case it removes some now-superfluous code that would be better if not
copied into other controller-level drivers.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

---
commit 9c1da3cb46316e40bac766ce45556dc4fd8df3ca
tree d2ab578f2601383f39d316dfca0f00d12da21dba
parent 022f7b07bf2b384ece7fbd7edb90e54cd78db252
author David Brownell <david-b@pacbell.net> Sat, 21 Jan 2006 13:21:43 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 06 Feb 2006 12:17:17 -0800

 Documentation/spi/butterfly |   23 +++++++++++++++++------
 drivers/spi/Kconfig         |   10 ----------
 drivers/spi/spi_butterfly.c |   36 +++++++++++++++++-------------------
 3 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/Documentation/spi/butterfly b/Documentation/spi/butterfly
index a2e8c8d..9927af7 100644
--- a/Documentation/spi/butterfly
+++ b/Documentation/spi/butterfly
@@ -12,13 +12,20 @@ You can make this adapter from an old pr
 directly to the Butterfly.  Or (if you have the parts and skills) you
 can come up with something fancier, providing ciruit protection to the
 Butterfly and the printer port, or with a better power supply than two
-signal pins from the printer port.
+signal pins from the printer port.  Or for that matter, you can use
+similar cables to talk to many AVR boards, even a breadboard.
+
+This is more powerful than "ISP programming" cables since it lets kernel
+SPI protocol drivers interact with the AVR, and could even let the AVR
+issue interrupts to them.  Later, your protocol driver should work
+easily with a "real SPI controller", instead of this bitbanger.
 
 
 The first cable connections will hook Linux up to one SPI bus, with the
 AVR and a DataFlash chip; and to the AVR reset line.  This is all you
 need to reflash the firmware, and the pins are the standard Atmel "ISP"
-connector pins (used also on non-Butterfly AVR boards).
+connector pins (used also on non-Butterfly AVR boards).  On the parport
+side this is like "sp12" programming cables.
 
 	Signal	  Butterfly	  Parport (DB-25)
 	------	  ---------	  ---------------
@@ -40,10 +47,14 @@ by clearing PORTB.[0-3]); (b) configure 
 	SELECT	= J400.PB0/nSS	= pin 17/C3,nSELECT
 	GND	= J400.GND	= pin 24/GND
 
-The "USI" controller, using J405, can be used for a second SPI bus.  That
-would let you talk to the AVR over SPI, running firmware that makes it act
-as an SPI slave, while letting either Linux or the AVR use the DataFlash.
-There are plenty of spare parport pins to wire this one up, such as:
+Or you could flash firmware making the AVR into an SPI slave (keeping the
+DataFlash in reset) and tweak the spi_butterfly driver to make it bind to
+the driver for your custom SPI-based protocol.
+
+The "USI" controller, using J405, can also be used for a second SPI bus.
+That would let you talk to the AVR using custom SPI-with-USI firmware,
+while letting either Linux or the AVR use the DataFlash.  There are plenty
+of spare parport pins to wire this one up, such as:
 
 	Signal	  Butterfly	  Parport (DB-25)
 	------	  ---------	  ---------------
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index b77dbd6..7a75fae 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -75,16 +75,6 @@ config SPI_BUTTERFLY
 	  inexpensive battery powered microcontroller evaluation board.
 	  This same cable can be used to flash new firmware.
 
-config SPI_BUTTERFLY
-	tristate "Parallel port adapter for AVR Butterfly (DEVELOPMENT)"
-	depends on SPI_MASTER && PARPORT && EXPERIMENTAL
-	select SPI_BITBANG
-	help
-	  This uses a custom parallel port cable to connect to an AVR
-	  Butterfly <http://www.atmel.com/products/avr/butterfly>, an
-	  inexpensive battery powered microcontroller evaluation board.
-	  This same cable can be used to flash new firmware.
-
 #
 # Add new SPI master controllers in alphabetical order above this line
 #
diff --git a/drivers/spi/spi_butterfly.c b/drivers/spi/spi_butterfly.c
index 79a3c59..ff9e5fa 100644
--- a/drivers/spi/spi_butterfly.c
+++ b/drivers/spi/spi_butterfly.c
@@ -163,21 +163,20 @@ static void butterfly_chipselect(struct 
 	struct butterfly	*pp = spidev_to_pp(spi);
 
 	/* set default clock polarity */
-	if (value)
+	if (value != BITBANG_CS_INACTIVE)
 		setsck(spi, spi->mode & SPI_CPOL);
 
 	/* no chipselect on this USI link config */
 	if (is_usidev(spi))
 		return;
 
-	/* here, value == "activate or not" */
-
-	/* most PARPORT_CONTROL_* bits are negated */
+	/* here, value == "activate or not";
+	 * most PARPORT_CONTROL_* bits are negated, so we must
+	 * morph it to value == "bit value to write in control register"
+	 */
 	if (spi_cs_bit == PARPORT_CONTROL_INIT)
 		value = !value;
 
-	/* here, value == "bit value to write in control register"  */
-
 	parport_frob_control(pp->port, spi_cs_bit, value ? spi_cs_bit : 0);
 }
 
@@ -202,7 +201,9 @@ butterfly_txrx_word_mode0(struct spi_dev
 
 /* override default partitioning with cmdlinepart */
 static struct mtd_partition partitions[] = { {
-	/* JFFS2 wants partitions of 4*N blocks for this device ... */
+	/* JFFS2 wants partitions of 4*N blocks for this device,
+	 * so sectors 0 and 1 can't be partitions by themselves.
+	 */
 
 	/* sector 0 = 8 pages * 264 bytes/page (1 block)
 	 * sector 1 = 248 pages * 264 bytes/page
@@ -316,8 +317,9 @@ static void butterfly_attach(struct parp
 	if (status < 0)
 		goto clean2;
 
-	/* Bus 1 lets us talk to at45db041b (firmware disables AVR)
-	 * or AVR (firmware resets at45, acts as spi slave)
+	/* Bus 1 lets us talk to at45db041b (firmware disables AVR SPI), AVR
+	 * (firmware resets at45, acts as spi slave) or neither (we ignore
+	 * both, AVR uses AT45).  Here we expect firmware for the first option.
 	 */
 	pp->info[0].max_speed_hz = 15 * 1000 * 1000;
 	strcpy(pp->info[0].modalias, "mtd_dataflash");
@@ -330,7 +332,9 @@ static void butterfly_attach(struct parp
 				pp->dataflash->dev.bus_id);
 
 #ifdef	HAVE_USI
-	/* even more custom AVR firmware */
+	/* Bus 2 is only for talking to the AVR, and it can work no
+	 * matter who masters bus 1; needs appropriate AVR firmware.
+	 */
 	pp->info[1].max_speed_hz = 10 /* ?? */ * 1000 * 1000;
 	strcpy(pp->info[1].modalias, "butterfly");
 	// pp->info[1].platform_data = ... TBD ... ;
@@ -378,13 +382,8 @@ static void butterfly_detach(struct parp
 	pp = butterfly;
 	butterfly = NULL;
 
-#ifdef	HAVE_USI
-	spi_unregister_device(pp->butterfly);
-	pp->butterfly = NULL;
-#endif
-	spi_unregister_device(pp->dataflash);
-	pp->dataflash = NULL;
-
+	/* stop() unregisters child devices too */
+	pdev = to_platform_device(pp->bitbang.master->cdev.dev);
 	status = spi_bitbang_stop(&pp->bitbang);
 
 	/* turn off VCC */
@@ -394,8 +393,6 @@ static void butterfly_detach(struct parp
 	parport_release(pp->pd);
 	parport_unregister_device(pp->pd);
 
-	pdev = to_platform_device(pp->bitbang.master->cdev.dev);
-
 	(void) spi_master_put(pp->bitbang.master);
 
 	platform_device_unregister(pdev);
@@ -420,4 +417,5 @@ static void __exit butterfly_exit(void)
 }
 module_exit(butterfly_exit);
 
+MODULE_DESCRIPTION("Parport Adapter driver for AVR Butterfly");
 MODULE_LICENSE("GPL");

