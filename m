Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWANV15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWANV15 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 16:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWANV1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 16:27:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:8084 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751307AbWANV1C convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 16:27:02 -0500
Cc: david-b@pacbell.net
Subject: [PATCH] spi: misc fixes
In-Reply-To: <11371995933258@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 13 Jan 2006 16:46:33 -0800
Message-Id: <11371995933018@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] spi: misc fixes

This collects some small SPI patches that seem to be missing from the MM tree:

  - spi_butterfly kbuild hooks got dropped somehow; this restores them
  - quick fix for a (theoretical?) m25p80_write() oops noted by Andrew
  - quick fix for a potential config-specific oops for mtd_dataflash()
  - minor doc tweaks

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 7111763d391b0c5a949a4f2575aa88cd585f0ff6
tree 376eef5003b71c6445c02bbe87950b2e365e0758
parent 8275c642ccdce09a2146d0a9eb022e3698ee927e
author David Brownell <david-b@pacbell.net> Sun, 08 Jan 2006 13:34:29 -0800
committer Greg Kroah-Hartman <gregkh@suse.de> Fri, 13 Jan 2006 16:29:56 -0800

 Documentation/spi/spi-summary       |   13 +++++++++++++
 drivers/mtd/devices/m25p80.c        |    4 +++-
 drivers/mtd/devices/mtd_dataflash.c |    2 +-
 drivers/spi/Kconfig                 |   10 ++++++++++
 drivers/spi/Makefile                |    1 +
 5 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 761debf..a5ffba3 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -115,6 +115,9 @@ shows up in sysfs in several locations:
    /sys/devices/.../CTLR/spiB.C ... spi_device for on bus "B",
 	chipselect C, accessed through CTLR.
 
+   /sys/devices/.../CTLR/spiB.C/modalias ... identifies the driver
+	that should be used with this device (for hotplug/coldplug)
+
    /sys/bus/spi/devices/spiB.C ... symlink to the physical
    	spiB-C device
 
@@ -247,6 +250,12 @@ driver is registered:
 
 Like with other static board-specific setup, you won't unregister those.
 
+The widely used "card" style computers bundle memory, cpu, and little else
+onto a card that's maybe just thirty square centimeters.  On such systems,
+your arch/.../mach-.../board-*.c file would primarily provide information
+about the devices on the mainboard into which such a card is plugged.  That
+certainly includes SPI devices hooked up through the card connectors!
+
 
 NON-STATIC CONFIGURATIONS
 
@@ -258,6 +267,10 @@ up the spi bus master, and will likely n
 board info based on the board that was hotplugged.  Of course, you'd later
 call at least spi_unregister_device() when that board is removed.
 
+When Linux includes support for MMC/SD/SDIO/DataFlash cards through SPI, those
+configurations will also be dynamic.  Fortunately, those devices all support
+basic device identification probes, so that support should hotplug normally.
+
 
 How do I write an "SPI Protocol Driver"?
 ----------------------------------------
diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 45108ed..d5f2408 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -378,7 +378,9 @@ static int m25p80_write(struct mtd_info 
 
 			spi_sync(flash->spi, &m);
 
-			*retlen += m.actual_length - sizeof(flash->command);
+			if (retlen)
+				*retlen += m.actual_length
+					- sizeof(flash->command);
 	        }
  	}
 
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 99d3a03..155737e 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -508,7 +508,7 @@ add_dataflash(struct spi_device *spi, ch
 			priv->partitioned = 1;
 			return add_mtd_partitions(device, parts, nr_parts);
 		}
-	} else if (pdata->nr_parts)
+	} else if (pdata && pdata->nr_parts)
 		dev_warn(&spi->dev, "ignoring %d default partitions on %s\n",
 				pdata->nr_parts, device->name);
 
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 9b21c5d..7a75fae 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -65,6 +65,16 @@ config SPI_BITBANG
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
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 5da6a4d..c2c87e8 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
+obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 # 	... add above this line ...
 
 # SPI protocol drivers (device/link on bus)

