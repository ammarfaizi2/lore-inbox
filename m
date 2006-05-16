Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932184AbWEPVnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932184AbWEPVnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 17:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWEPVnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 17:43:14 -0400
Received: from mail.kroah.org ([69.55.234.183]:31406 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932180AbWEPVkm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 17:40:42 -0400
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 08/10] SPI: busnum == 0 needs to work
Reply-To: Greg KH <greg@kroah.com>
Date: Tue, 16 May 2006 14:38:36 -0700
Message-Id: <11478155181107-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.3.2
In-Reply-To: <11478155182487-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

We need to be able to have a "SPI bus 0" matching chip numbering; but
that number was wrongly used to flag dynamic allocation of a bus number.

This patch resolves that issue; now negative numbers trigger dynamic alloc.

It also updates the how-to-write-a-controller-driver overview to mention
this stuff.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---

 Documentation/spi/spi-summary |   34 +++++++++++++++++++++++++++++++++-
 drivers/spi/spi.c             |    4 ++--
 include/linux/spi/spi.h       |    6 +++---
 3 files changed, 38 insertions(+), 6 deletions(-)

a020ed7521a9737bcf3e34eb880867c60c3c68d0
diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index a5ffba3..068732d 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -414,7 +414,33 @@ to get the driver-private data allocated
 The driver will initialize the fields of that spi_master, including the
 bus number (maybe the same as the platform device ID) and three methods
 used to interact with the SPI core and SPI protocol drivers.  It will
-also initialize its own internal state.
+also initialize its own internal state.  (See below about bus numbering
+and those methods.)
+
+After you initialize the spi_master, then use spi_register_master() to
+publish it to the rest of the system.  At that time, device nodes for
+the controller and any predeclared spi devices will be made available,
+and the driver model core will take care of binding them to drivers.
+
+If you need to remove your SPI controller driver, spi_unregister_master()
+will reverse the effect of spi_register_master().
+
+
+BUS NUMBERING
+
+Bus numbering is important, since that's how Linux identifies a given
+SPI bus (shared SCK, MOSI, MISO).  Valid bus numbers start at zero.  On
+SOC systems, the bus numbers should match the numbers defined by the chip
+manufacturer.  For example, hardware controller SPI2 would be bus number 2,
+and spi_board_info for devices connected to it would use that number.
+
+If you don't have such hardware-assigned bus number, and for some reason
+you can't just assign them, then provide a negative bus number.  That will
+then be replaced by a dynamically assigned number. You'd then need to treat
+this as a non-static configuration (see above).
+
+
+SPI MASTER METHODS
 
     master->setup(struct spi_device *spi)
 	This sets up the device clock rate, SPI mode, and word sizes.
@@ -431,6 +457,9 @@ also initialize its own internal state.
 	state it dynamically associates with that device.  If you do that,
 	be sure to provide the cleanup() method to free that state.
 
+
+SPI MESSAGE QUEUE
+
 The bulk of the driver will be managing the I/O queue fed by transfer().
 
 That queue could be purely conceptual.  For example, a driver used only
@@ -440,6 +469,9 @@ But the queue will probably be very real
 often DMA (especially if the root filesystem is in SPI flash), and
 execution contexts like IRQ handlers, tasklets, or workqueues (such
 as keventd).  Your driver can be as fancy, or as simple, as you need.
+Such a transfer() method would normally just add the message to a
+queue, and then start some asynchronous transfer engine (unless it's
+already running).
 
 
 THANKS TO
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 1168ef0..7a3f733 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -395,7 +395,7 @@ EXPORT_SYMBOL_GPL(spi_alloc_master);
 int __init_or_module
 spi_register_master(struct spi_master *master)
 {
-	static atomic_t		dyn_bus_id = ATOMIC_INIT(0);
+	static atomic_t		dyn_bus_id = ATOMIC_INIT((1<<16) - 1);
 	struct device		*dev = master->cdev.dev;
 	int			status = -ENODEV;
 	int			dynamic = 0;
@@ -404,7 +404,7 @@ spi_register_master(struct spi_master *m
 		return -ENODEV;
 
 	/* convention:  dynamically assigned bus IDs count down from the max */
-	if (master->bus_num == 0) {
+	if (master->bus_num < 0) {
 		master->bus_num = atomic_dec_return(&dyn_bus_id);
 		dynamic = 1;
 	}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 77add90..e928c0d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -172,13 +172,13 @@ static inline void spi_unregister_driver
 struct spi_master {
 	struct class_device	cdev;
 
-	/* other than zero (== assign one dynamically), bus_num is fully
+	/* other than negative (== assign one dynamically), bus_num is fully
 	 * board-specific.  usually that simplifies to being SOC-specific.
-	 * example:  one SOC has three SPI controllers, numbered 1..3,
+	 * example:  one SOC has three SPI controllers, numbered 0..2,
 	 * and one board's schematics might show it using SPI-2.  software
 	 * would normally use bus_num=2 for that controller.
 	 */
-	u16			bus_num;
+	s16			bus_num;
 
 	/* chipselects will be integral to many controllers; some others
 	 * might use board-specific GPIOs.
-- 
1.3.2

