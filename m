Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965154AbVJ1Gbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965154AbVJ1Gbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 02:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965155AbVJ1Gbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 02:31:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:51434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965154AbVJ1Gba convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 02:31:30 -0400
Cc: rmk+kernel@arm.linux.org.uk
Subject: [PATCH] DRIVER MODEL: Get rid of the obsolete tri-level suspend/resume callbacks
In-Reply-To: <11304810272893@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 27 Oct 2005 23:30:27 -0700
Message-Id: <113048102730@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] DRIVER MODEL: Get rid of the obsolete tri-level suspend/resume callbacks

In PM v1, all devices were called at SUSPEND_DISABLE level.  Then
all devices were called at SUSPEND_SAVE_STATE level, and finally
SUSPEND_POWER_DOWN level.  However, with PM v2, to maintain
compatibility for platform devices, I arranged for the PM v2
suspend/resume callbacks to call the old PM v1 suspend/resume
callbacks three times with each level in order so that existing
drivers continued to work.

Since this is obsolete infrastructure which is no longer necessary,
we can remove it.  Here's an (untested) patch to do exactly that.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit afe631e665d991c18e3e636b1c2455a891758760
tree a5ee0e95290b40a8b35b1a33de7e9da5fb7df534
parent c4438d593e764474d701af6deebbb7df567be40f
author Russell King <rmk+kernel@arm.linux.org.uk> Thu, 27 Oct 2005 22:48:09 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Thu, 27 Oct 2005 22:48:09 -0700

 Documentation/driver-model/driver.txt |   60 +--------------------------------
 arch/arm/common/locomo.c              |   10 +-----
 arch/arm/common/sa1111.c              |   11 +-----
 arch/arm/common/scoop.c               |   24 ++++++-------
 arch/arm/mach-pxa/corgi_ssp.c         |   24 ++++++-------
 arch/arm/mach-sa1100/neponset.c       |   28 ++++++---------
 drivers/base/platform.c               |   20 +++--------
 drivers/char/s3c2410-rtc.c            |   20 +++++------
 drivers/char/sonypi.c                 |   14 +++-----
 drivers/char/watchdog/s3c2410_wdt.c   |   34 ++++++++-----------
 drivers/hwmon/hdaps.c                 |    6 +--
 drivers/i2c/busses/i2c-s3c2410.c      |    8 ++--
 drivers/i2c/i2c-core.c                |    4 +-
 drivers/ieee1394/nodemgr.c            |    4 +-
 drivers/input/keyboard/corgikbd.c     |   22 ++++++------
 drivers/input/keyboard/spitzkbd.c     |   44 ++++++++++++------------
 drivers/input/serio/i8042.c           |   13 ++-----
 drivers/input/touchscreen/corgi_ts.c  |   38 ++++++++++-----------
 drivers/media/video/msp3400.c         |    8 ++--
 drivers/media/video/tda9887.c         |    4 +-
 drivers/media/video/tuner-core.c      |    4 +-
 drivers/mfd/mcp-sa11x0.c              |   20 +++++------
 drivers/mmc/pxamci.c                  |    8 ++--
 drivers/mmc/wbsd.c                    |    4 +-
 drivers/mtd/maps/sa1100-flash.c       |    8 ++--
 drivers/net/dm9000.c                  |    8 ++--
 drivers/net/irda/sa1100_ir.c          |    8 ++--
 drivers/net/irda/smsc-ircc2.c         |   12 +++----
 drivers/net/phy/mdio_bus.c            |   20 +++--------
 drivers/net/smc91x.c                  |    8 ++--
 drivers/pci/pcie/portdrv_core.c       |    4 +-
 drivers/pcmcia/au1000_generic.c       |   21 +-----------
 drivers/pcmcia/hd64465_ss.c           |   20 +----------
 drivers/pcmcia/i82365.c               |   20 +----------
 drivers/pcmcia/m32r_cfc.c             |   21 +-----------
 drivers/pcmcia/m32r_pcc.c             |   21 +-----------
 drivers/pcmcia/omap_cf.c              |   18 +---------
 drivers/pcmcia/pxa2xx_base.c          |   26 ++++----------
 drivers/pcmcia/sa1100_generic.c       |   20 +----------
 drivers/pcmcia/tcic.c                 |   20 +----------
 drivers/pcmcia/vrc4171_card.c         |   24 +------------
 drivers/serial/8250.c                 |   10 +-----
 drivers/serial/imx.c                  |    8 ++--
 drivers/serial/mpc52xx_uart.c         |    8 ++--
 drivers/serial/pxa.c                  |    8 ++--
 drivers/serial/s3c2410.c              |    9 ++---
 drivers/serial/sa1100.c               |    8 ++--
 drivers/serial/vr41xx_siu.c           |   10 +-----
 drivers/usb/gadget/dummy_hcd.c        |   22 ++----------
 drivers/usb/gadget/omap_udc.c         |    9 +----
 drivers/usb/gadget/pxa2xx_udc.c       |   17 ++++-----
 drivers/usb/host/isp116x-hcd.c        |   14 ++------
 drivers/usb/host/ohci-omap.c          |   10 +-----
 drivers/usb/host/ohci-pxa27x.c        |    4 +-
 drivers/usb/host/sl811-hcd.c          |   10 +-----
 drivers/video/backlight/corgi_bl.c    |   10 ++----
 drivers/video/imxfb.c                 |   10 ++----
 drivers/video/pxafb.c                 |   10 ++----
 drivers/video/s1d13xxxfb.c            |    7 +---
 drivers/video/s3c2410fb.c             |   29 +++++++---------
 drivers/video/sa1100fb.c              |   10 ++----
 drivers/video/w100fb.c                |   48 +++++++++++++-------------
 include/linux/device.h                |   17 +--------
 sound/arm/pxa2xx-ac97.c               |    8 ++--
 sound/core/init.c                     |   14 ++------
 sound/pci/ac97/ac97_bus.c             |    6 ++-
 66 files changed, 330 insertions(+), 697 deletions(-)

diff --git a/Documentation/driver-model/driver.txt b/Documentation/driver-model/driver.txt
index fabaca1..7c26bfa 100644
--- a/Documentation/driver-model/driver.txt
+++ b/Documentation/driver-model/driver.txt
@@ -196,67 +196,11 @@ it into a supported low-power state.
 
 	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
 
-suspend is called to put the device in a low power state. There are
-several stages to successfully suspending a device, which is denoted in
-the @level parameter. Breaking the suspend transition into several
-stages affords the platform flexibility in performing device power
-management based on the requirements of the system and the
-user-defined policy.
-
-SUSPEND_NOTIFY notifies the device that a suspend transition is about
-to happen. This happens on system power state transitions to verify
-that all devices can successfully suspend.
-
-A driver may choose to fail on this call, which should cause the
-entire suspend transition to fail. A driver should fail only if it
-knows that the device will not be able to be resumed properly when the
-system wakes up again. It could also fail if it somehow determines it
-is in the middle of an operation too important to stop.
-
-SUSPEND_DISABLE tells the device to stop I/O transactions. When it
-stops transactions, or what it should do with unfinished transactions
-is a policy of the driver. After this call, the driver should not
-accept any other I/O requests.
-
-SUSPEND_SAVE_STATE tells the device to save the context of the
-hardware. This includes any bus-specific hardware state and
-device-specific hardware state. A pointer to this saved state can be
-stored in the device's saved_state field.
-
-SUSPEND_POWER_DOWN tells the driver to place the device in the low
-power state requested. 
-
-Whether suspend is called with a given level is a policy of the
-platform. Some levels may be omitted; drivers must not assume the
-reception of any level. However, all levels must be called in the
-order above; i.e. notification will always come before disabling;
-disabling the device will come before suspending the device.
-
-All calls are made with interrupts enabled, except for the
-SUSPEND_POWER_DOWN level.
+suspend is called to put the device in a low power state.
 
 	int	(*resume)	(struct device * dev, u32 level);
 
-Resume is used to bring a device back from a low power state. Like the
-suspend transition, it happens in several stages. 
-
-RESUME_POWER_ON tells the driver to set the power state to the state
-before the suspend call (The device could have already been in a low
-power state before the suspend call to put in a lower power state). 
-
-RESUME_RESTORE_STATE tells the driver to restore the state saved by
-the SUSPEND_SAVE_STATE suspend call. 
-
-RESUME_ENABLE tells the driver to start accepting I/O transactions
-again. Depending on driver policy, the device may already have pending
-I/O requests. 
-
-RESUME_POWER_ON is called with interrupts disabled. The other resume
-levels are called with interrupts enabled. 
-
-As with the various suspend stages, the driver must not assume that
-any other resume calls have been or will be made. Each call should be
-self-contained and not dependent on any external state.
+Resume is used to bring a device back from a low power state.
 
 
 Attributes
diff --git a/arch/arm/common/locomo.c b/arch/arm/common/locomo.c
index e8053d1..5cdb412 100644
--- a/arch/arm/common/locomo.c
+++ b/arch/arm/common/locomo.c
@@ -550,15 +550,12 @@ struct locomo_save_data {
 	u16	LCM_SPIMD;
 };
 
-static int locomo_suspend(struct device *dev, pm_message_t state, u32 level)
+static int locomo_suspend(struct device *dev, pm_message_t state)
 {
 	struct locomo *lchip = dev_get_drvdata(dev);
 	struct locomo_save_data *save;
 	unsigned long flags;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	save = kmalloc(sizeof(struct locomo_save_data), GFP_KERNEL);
 	if (!save)
 		return -ENOMEM;
@@ -597,16 +594,13 @@ static int locomo_suspend(struct device 
 	return 0;
 }
 
-static int locomo_resume(struct device *dev, u32 level)
+static int locomo_resume(struct device *dev)
 {
 	struct locomo *lchip = dev_get_drvdata(dev);
 	struct locomo_save_data *save;
 	unsigned long r;
 	unsigned long flags;
 	
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	save = (struct locomo_save_data *) dev->power.saved_state;
 	if (!save)
 		return 0;
diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index 1a47fbf..21e2a51 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -801,7 +801,7 @@ struct sa1111_save_data {
 
 #ifdef CONFIG_PM
 
-static int sa1111_suspend(struct device *dev, pm_message_t state, u32 level)
+static int sa1111_suspend(struct device *dev, pm_message_t state)
 {
 	struct sa1111 *sachip = dev_get_drvdata(dev);
 	struct sa1111_save_data *save;
@@ -809,9 +809,6 @@ static int sa1111_suspend(struct device 
 	unsigned int val;
 	void __iomem *base;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	save = kmalloc(sizeof(struct sa1111_save_data), GFP_KERNEL);
 	if (!save)
 		return -ENOMEM;
@@ -856,23 +853,19 @@ static int sa1111_suspend(struct device 
 /*
  *	sa1111_resume - Restore the SA1111 device state.
  *	@dev: device to restore
- *	@level: resume level
  *
  *	Restore the general state of the SA1111; clock control and
  *	interrupt controller.  Other parts of the SA1111 must be
  *	restored by their respective drivers, and must be called
  *	via LDM after this function.
  */
-static int sa1111_resume(struct device *dev, u32 level)
+static int sa1111_resume(struct device *dev)
 {
 	struct sa1111 *sachip = dev_get_drvdata(dev);
 	struct sa1111_save_data *save;
 	unsigned long flags, id;
 	void __iomem *base;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	save = (struct sa1111_save_data *)dev->power.saved_state;
 	if (!save)
 		return 0;
diff --git a/arch/arm/common/scoop.c b/arch/arm/common/scoop.c
index 9e5245c..e8356b7 100644
--- a/arch/arm/common/scoop.c
+++ b/arch/arm/common/scoop.c
@@ -102,26 +102,24 @@ static void check_scoop_reg(struct scoop
 }
 
 #ifdef CONFIG_PM
-static int scoop_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int scoop_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		struct scoop_dev *sdev = dev_get_drvdata(dev);
+	struct scoop_dev *sdev = dev_get_drvdata(dev);
+
+	check_scoop_reg(sdev);
+	sdev->scoop_gpwr = SCOOP_REG(sdev->base, SCOOP_GPWR);
+	SCOOP_REG(sdev->base, SCOOP_GPWR) = (sdev->scoop_gpwr & ~sdev->suspend_clr) | sdev->suspend_set;
 
-		check_scoop_reg(sdev);
-  		sdev->scoop_gpwr = SCOOP_REG(sdev->base, SCOOP_GPWR);
-		SCOOP_REG(sdev->base, SCOOP_GPWR) = (sdev->scoop_gpwr & ~sdev->suspend_clr) | sdev->suspend_set;
-	}
 	return 0;
 }
 
-static int scoop_resume(struct device *dev, uint32_t level)
+static int scoop_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		struct scoop_dev *sdev = dev_get_drvdata(dev);
+	struct scoop_dev *sdev = dev_get_drvdata(dev);
+
+	check_scoop_reg(sdev);
+	SCOOP_REG(sdev->base,SCOOP_GPWR) = sdev->scoop_gpwr;
 
-		check_scoop_reg(sdev);
-		SCOOP_REG(sdev->base,SCOOP_GPWR) = sdev->scoop_gpwr;
-	}
 	return 0;
 }
 #else
diff --git a/arch/arm/mach-pxa/corgi_ssp.c b/arch/arm/mach-pxa/corgi_ssp.c
index 0ef4282..136c269 100644
--- a/arch/arm/mach-pxa/corgi_ssp.c
+++ b/arch/arm/mach-pxa/corgi_ssp.c
@@ -222,24 +222,22 @@ static int corgi_ssp_remove(struct devic
 	return 0;
 }
 
-static int corgi_ssp_suspend(struct device *dev, pm_message_t state, u32 level)
+static int corgi_ssp_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		ssp_flush(&corgi_ssp_dev);
-		ssp_save_state(&corgi_ssp_dev,&corgi_ssp_state);
-	}
+	ssp_flush(&corgi_ssp_dev);
+	ssp_save_state(&corgi_ssp_dev,&corgi_ssp_state);
+
 	return 0;
 }
 
-static int corgi_ssp_resume(struct device *dev, u32 level)
+static int corgi_ssp_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
-		GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
-		GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846); /* High - Disable ADS7846*/
-		ssp_restore_state(&corgi_ssp_dev,&corgi_ssp_state);
-		ssp_enable(&corgi_ssp_dev);
-	}
+	GPSR(ssp_machinfo->cs_lcdcon) = GPIO_bit(ssp_machinfo->cs_lcdcon);  /* High - Disable LCD Control/Timing Gen */
+	GPSR(ssp_machinfo->cs_max1111) = GPIO_bit(ssp_machinfo->cs_max1111); /* High - Disable MAX1111*/
+	GPSR(ssp_machinfo->cs_ads7846) = GPIO_bit(ssp_machinfo->cs_ads7846); /* High - Disable ADS7846*/
+	ssp_restore_state(&corgi_ssp_dev,&corgi_ssp_state);
+	ssp_enable(&corgi_ssp_dev);
+
 	return 0;
 }
 
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index fc06164..7609d69 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -178,33 +178,27 @@ static int neponset_probe(struct device 
 /*
  * LDM power management.
  */
-static int neponset_suspend(struct device *dev, pm_message_t state, u32 level)
+static int neponset_suspend(struct device *dev, pm_message_t state)
 {
 	/*
 	 * Save state.
 	 */
-	if (level == SUSPEND_SAVE_STATE ||
-	    level == SUSPEND_DISABLE ||
-	    level == SUSPEND_POWER_DOWN) {
-		if (!dev->power.saved_state)
-			dev->power.saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
-		if (!dev->power.saved_state)
-			return -ENOMEM;
+	if (!dev->power.saved_state)
+		dev->power.saved_state = kmalloc(sizeof(unsigned int), GFP_KERNEL);
+	if (!dev->power.saved_state)
+		return -ENOMEM;
 
-		*(unsigned int *)dev->power.saved_state = NCR_0;
-	}
+	*(unsigned int *)dev->power.saved_state = NCR_0;
 
 	return 0;
 }
 
-static int neponset_resume(struct device *dev, u32 level)
+static int neponset_resume(struct device *dev)
 {
-	if (level == RESUME_RESTORE_STATE || level == RESUME_ENABLE) {
-		if (dev->power.saved_state) {
-			NCR_0 = *(unsigned int *)dev->power.saved_state;
-			kfree(dev->power.saved_state);
-			dev->power.saved_state = NULL;
-		}
+	if (dev->power.saved_state) {
+		NCR_0 = *(unsigned int *)dev->power.saved_state;
+		kfree(dev->power.saved_state);
+		dev->power.saved_state = NULL;
 	}
 
 	return 0;
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index a1a56ff..75ce871 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -281,13 +281,9 @@ static int platform_suspend(struct devic
 {
 	int ret = 0;
 
-	if (dev->driver && dev->driver->suspend) {
-		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
-		if (ret == 0)
-			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
-		if (ret == 0)
-			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
-	}
+	if (dev->driver && dev->driver->suspend)
+		ret = dev->driver->suspend(dev, state);
+
 	return ret;
 }
 
@@ -295,13 +291,9 @@ static int platform_resume(struct device
 {
 	int ret = 0;
 
-	if (dev->driver && dev->driver->resume) {
-		ret = dev->driver->resume(dev, RESUME_POWER_ON);
-		if (ret == 0)
-			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
-		if (ret == 0)
-			ret = dev->driver->resume(dev, RESUME_ENABLE);
-	}
+	if (dev->driver && dev->driver->resume)
+		ret = dev->driver->resume(dev);
+
 	return ret;
 }
 
diff --git a/drivers/char/s3c2410-rtc.c b/drivers/char/s3c2410-rtc.c
index e1a90d9..887b8b2 100644
--- a/drivers/char/s3c2410-rtc.c
+++ b/drivers/char/s3c2410-rtc.c
@@ -519,30 +519,28 @@ static struct timespec s3c2410_rtc_delta
 
 static int ticnt_save;
 
-static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state, u32 level)
+static int s3c2410_rtc_suspend(struct device *dev, pm_message_t state)
 {
 	struct rtc_time tm;
 	struct timespec time;
 
 	time.tv_nsec = 0;
 
-	if (level == SUSPEND_POWER_DOWN) {
-		/* save TICNT for anyone using periodic interrupts */
+	/* save TICNT for anyone using periodic interrupts */
 
-		ticnt_save = readb(S3C2410_TICNT);
+	ticnt_save = readb(S3C2410_TICNT);
 
-		/* calculate time delta for suspend */
+	/* calculate time delta for suspend */
 
-		s3c2410_rtc_gettime(&tm);
-		rtc_tm_to_time(&tm, &time.tv_sec);
-		save_time_delta(&s3c2410_rtc_delta, &time);
-		s3c2410_rtc_enable(dev, 0);
-	}
+	s3c2410_rtc_gettime(&tm);
+	rtc_tm_to_time(&tm, &time.tv_sec);
+	save_time_delta(&s3c2410_rtc_delta, &time);
+	s3c2410_rtc_enable(dev, 0);
 
 	return 0;
 }
 
-static int s3c2410_rtc_resume(struct device *dev, u32 level)
+static int s3c2410_rtc_resume(struct device *dev)
 {
 	struct rtc_time tm;
 	struct timespec time;
diff --git a/drivers/char/sonypi.c b/drivers/char/sonypi.c
index a487368..f86c155 100644
--- a/drivers/char/sonypi.c
+++ b/drivers/char/sonypi.c
@@ -1167,19 +1167,17 @@ static int sonypi_disable(void)
 #ifdef CONFIG_PM
 static int old_camera_power;
 
-static int sonypi_suspend(struct device *dev, pm_message_t state, u32 level)
+static int sonypi_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_DISABLE) {
-		old_camera_power = sonypi_device.camera_power;
-		sonypi_disable();
-	}
+	old_camera_power = sonypi_device.camera_power;
+	sonypi_disable();
+
 	return 0;
 }
 
-static int sonypi_resume(struct device *dev, u32 level)
+static int sonypi_resume(struct device *dev)
 {
-	if (level == RESUME_ENABLE)
-		sonypi_enable(old_camera_power);
+	sonypi_enable(old_camera_power);
 	return 0;
 }
 #endif
diff --git a/drivers/char/watchdog/s3c2410_wdt.c b/drivers/char/watchdog/s3c2410_wdt.c
index 3625b26..b732020 100644
--- a/drivers/char/watchdog/s3c2410_wdt.c
+++ b/drivers/char/watchdog/s3c2410_wdt.c
@@ -464,32 +464,28 @@ static void s3c2410wdt_shutdown(struct d
 static unsigned long wtcon_save;
 static unsigned long wtdat_save;
 
-static int s3c2410wdt_suspend(struct device *dev, pm_message_t state, u32 level)
+static int s3c2410wdt_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		/* Save watchdog state, and turn it off. */
-		wtcon_save = readl(wdt_base + S3C2410_WTCON);
-		wtdat_save = readl(wdt_base + S3C2410_WTDAT);
-
-		/* Note that WTCNT doesn't need to be saved. */
-		s3c2410wdt_stop();
-	}
+	/* Save watchdog state, and turn it off. */
+	wtcon_save = readl(wdt_base + S3C2410_WTCON);
+	wtdat_save = readl(wdt_base + S3C2410_WTDAT);
+
+	/* Note that WTCNT doesn't need to be saved. */
+	s3c2410wdt_stop();
 
 	return 0;
 }
 
-static int s3c2410wdt_resume(struct device *dev, u32 level)
+static int s3c2410wdt_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		/* Restore watchdog state. */
+	/* Restore watchdog state. */
+
+	writel(wtdat_save, wdt_base + S3C2410_WTDAT);
+	writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
+	writel(wtcon_save, wdt_base + S3C2410_WTCON);
 
-		writel(wtdat_save, wdt_base + S3C2410_WTDAT);
-		writel(wtdat_save, wdt_base + S3C2410_WTCNT); /* Reset count */
-		writel(wtcon_save, wdt_base + S3C2410_WTCON);
-
-		printk(KERN_INFO PFX "watchdog %sabled\n",
-		       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
-	}
+	printk(KERN_INFO PFX "watchdog %sabled\n",
+	       (wtcon_save & S3C2410_WTCON_ENABLE) ? "en" : "dis");
 
 	return 0;
 }
diff --git a/drivers/hwmon/hdaps.c b/drivers/hwmon/hdaps.c
index 7f01076..0015da5 100644
--- a/drivers/hwmon/hdaps.c
+++ b/drivers/hwmon/hdaps.c
@@ -296,11 +296,9 @@ static int hdaps_probe(struct device *de
 	return 0;
 }
 
-static int hdaps_resume(struct device *dev, u32 level)
+static int hdaps_resume(struct device *dev)
 {
-	if (level == RESUME_ENABLE)
-		return hdaps_device_init();
-	return 0;
+	return hdaps_device_init();
 }
 
 static struct device_driver hdaps_driver = {
diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
index 73a092f..69fa282 100644
--- a/drivers/i2c/busses/i2c-s3c2410.c
+++ b/drivers/i2c/busses/i2c-s3c2410.c
@@ -879,14 +879,12 @@ static int s3c24xx_i2c_remove(struct dev
 }
 
 #ifdef CONFIG_PM
-static int s3c24xx_i2c_resume(struct device *dev, u32 level)
+static int s3c24xx_i2c_resume(struct device *dev)
 {
 	struct s3c24xx_i2c *i2c = dev_get_drvdata(dev);
-	
-	if (i2c != NULL && level == RESUME_ENABLE) {
-		dev_dbg(dev, "resume: level %d\n", level);
+
+	if (i2c != NULL)
 		s3c24xx_i2c_init(i2c);
-	}
 
 	return 0;
 }
diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
index dda472e..45aa0e5 100644
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -48,7 +48,7 @@ static int i2c_bus_suspend(struct device
 	int rc = 0;
 
 	if (dev->driver && dev->driver->suspend)
-		rc = dev->driver->suspend(dev,state,0);
+		rc = dev->driver->suspend(dev, state);
 	return rc;
 }
 
@@ -57,7 +57,7 @@ static int i2c_bus_resume(struct device 
 	int rc = 0;
 	
 	if (dev->driver && dev->driver->resume)
-		rc = dev->driver->resume(dev,0);
+		rc = dev->driver->resume(dev);
 	return rc;
 }
 
diff --git a/drivers/ieee1394/nodemgr.c b/drivers/ieee1394/nodemgr.c
index 347ece6..7fff5a1 100644
--- a/drivers/ieee1394/nodemgr.c
+++ b/drivers/ieee1394/nodemgr.c
@@ -1292,7 +1292,7 @@ static void nodemgr_suspend_ne(struct no
 
 		if (ud->device.driver &&
 		    (!ud->device.driver->suspend ||
-		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND, 0)))
+		      ud->device.driver->suspend(&ud->device, PMSG_SUSPEND)))
 			device_release_driver(&ud->device);
 	}
 	up_write(&ne->device.bus->subsys.rwsem);
@@ -1315,7 +1315,7 @@ static void nodemgr_resume_ne(struct nod
 			continue;
 
 		if (ud->device.driver && ud->device.driver->resume)
-			ud->device.driver->resume(&ud->device, 0);
+			ud->device.driver->resume(&ud->device);
 	}
 	up_read(&ne->device.bus->subsys.rwsem);
 
diff --git a/drivers/input/keyboard/corgikbd.c b/drivers/input/keyboard/corgikbd.c
index 564bb36..3210d29 100644
--- a/drivers/input/keyboard/corgikbd.c
+++ b/drivers/input/keyboard/corgikbd.c
@@ -259,24 +259,22 @@ static void corgikbd_hinge_timer(unsigne
 }
 
 #ifdef CONFIG_PM
-static int corgikbd_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int corgikbd_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		struct corgikbd *corgikbd = dev_get_drvdata(dev);
-		corgikbd->suspended = 1;
-	}
+	struct corgikbd *corgikbd = dev_get_drvdata(dev);
+	corgikbd->suspended = 1;
+
 	return 0;
 }
 
-static int corgikbd_resume(struct device *dev, uint32_t level)
+static int corgikbd_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		struct corgikbd *corgikbd = dev_get_drvdata(dev);
+	struct corgikbd *corgikbd = dev_get_drvdata(dev);
+
+	/* Upon resume, ignore the suspend key for a short while */
+	corgikbd->suspend_jiffies=jiffies;
+	corgikbd->suspended = 0;
 
-		/* Upon resume, ignore the suspend key for a short while */
-		corgikbd->suspend_jiffies=jiffies;
-		corgikbd->suspended = 0;
-	}
 	return 0;
 }
 #else
diff --git a/drivers/input/keyboard/spitzkbd.c b/drivers/input/keyboard/spitzkbd.c
index 732fb31..cee9c73 100644
--- a/drivers/input/keyboard/spitzkbd.c
+++ b/drivers/input/keyboard/spitzkbd.c
@@ -309,34 +309,32 @@ static void spitzkbd_hinge_timer(unsigne
 }
 
 #ifdef CONFIG_PM
-static int spitzkbd_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int spitzkbd_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		int i;
-		struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
-		spitzkbd->suspended = 1;
-
-		/* Set Strobe lines as inputs - *except* strobe line 0 leave this
-		   enabled so we can detect a power button press for resume */
-		for (i = 1; i < SPITZ_KEY_STROBE_NUM; i++)
-			pxa_gpio_mode(spitz_strobes[i] | GPIO_IN);
-	}
+	int i;
+	struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
+	spitzkbd->suspended = 1;
+
+	/* Set Strobe lines as inputs - *except* strobe line 0 leave this
+	   enabled so we can detect a power button press for resume */
+	for (i = 1; i < SPITZ_KEY_STROBE_NUM; i++)
+		pxa_gpio_mode(spitz_strobes[i] | GPIO_IN);
+
 	return 0;
 }
 
-static int spitzkbd_resume(struct device *dev, uint32_t level)
+static int spitzkbd_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		int i;
-		struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
-
-		for (i = 0; i < SPITZ_KEY_STROBE_NUM; i++)
-			pxa_gpio_mode(spitz_strobes[i] | GPIO_OUT | GPIO_DFLT_HIGH);
-
-		/* Upon resume, ignore the suspend key for a short while */
-		spitzkbd->suspend_jiffies = jiffies;
-		spitzkbd->suspended = 0;
-	}
+	int i;
+	struct spitzkbd *spitzkbd = dev_get_drvdata(dev);
+
+	for (i = 0; i < SPITZ_KEY_STROBE_NUM; i++)
+		pxa_gpio_mode(spitz_strobes[i] | GPIO_OUT | GPIO_DFLT_HIGH);
+
+	/* Upon resume, ignore the suspend key for a short while */
+	spitzkbd->suspend_jiffies = jiffies;
+	spitzkbd->suspended = 0;
+
 	return 0;
 }
 #else
diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
index 40d451c..4bc40f1 100644
--- a/drivers/input/serio/i8042.c
+++ b/drivers/input/serio/i8042.c
@@ -911,12 +911,10 @@ static long i8042_panic_blink(long count
  * Here we try to restore the original BIOS settings
  */
 
-static int i8042_suspend(struct device *dev, pm_message_t state, u32 level)
+static int i8042_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_DISABLE) {
-		del_timer_sync(&i8042_timer);
-		i8042_controller_reset();
-	}
+	del_timer_sync(&i8042_timer);
+	i8042_controller_reset();
 
 	return 0;
 }
@@ -926,13 +924,10 @@ static int i8042_suspend(struct device *
  * Here we try to reset everything back to a state in which suspended
  */
 
-static int i8042_resume(struct device *dev, u32 level)
+static int i8042_resume(struct device *dev)
 {
 	int i;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	if (i8042_ctl_test())
 		return -1;
 
diff --git a/drivers/input/touchscreen/corgi_ts.c b/drivers/input/touchscreen/corgi_ts.c
index 40ae183..0ba3e65 100644
--- a/drivers/input/touchscreen/corgi_ts.c
+++ b/drivers/input/touchscreen/corgi_ts.c
@@ -231,34 +231,32 @@ static irqreturn_t ts_interrupt(int irq,
 }
 
 #ifdef CONFIG_PM
-static int corgits_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int corgits_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
-
-		if (corgi_ts->pendown) {
-			del_timer_sync(&corgi_ts->timer);
-			corgi_ts->tc.pressure = 0;
-			new_data(corgi_ts, NULL);
-			corgi_ts->pendown = 0;
-		}
-		corgi_ts->power_mode = PWR_MODE_SUSPEND;
+	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
 
-		corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
+	if (corgi_ts->pendown) {
+		del_timer_sync(&corgi_ts->timer);
+		corgi_ts->tc.pressure = 0;
+		new_data(corgi_ts, NULL);
+		corgi_ts->pendown = 0;
 	}
+	corgi_ts->power_mode = PWR_MODE_SUSPEND;
+
+	corgi_ssp_ads7846_putget((1u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
+
 	return 0;
 }
 
-static int corgits_resume(struct device *dev, uint32_t level)
+static int corgits_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
+	struct corgi_ts *corgi_ts = dev_get_drvdata(dev);
+
+	corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
+	/* Enable Falling Edge */
+	set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
+	corgi_ts->power_mode = PWR_MODE_ACTIVE;
 
-		corgi_ssp_ads7846_putget((4u << ADSCTRL_ADR_SH) | ADSCTRL_STS);
-		/* Enable Falling Edge */
-		set_irq_type(corgi_ts->irq_gpio, IRQT_FALLING);
-		corgi_ts->power_mode = PWR_MODE_ACTIVE;
-	}
 	return 0;
 }
 #else
diff --git a/drivers/media/video/msp3400.c b/drivers/media/video/msp3400.c
index f0d43fc..262890c 100644
--- a/drivers/media/video/msp3400.c
+++ b/drivers/media/video/msp3400.c
@@ -1420,8 +1420,8 @@ static int msp_detach(struct i2c_client 
 static int msp_probe(struct i2c_adapter *adap);
 static int msp_command(struct i2c_client *client, unsigned int cmd, void *arg);
 
-static int msp_suspend(struct device * dev, pm_message_t state, u32 level);
-static int msp_resume(struct device * dev, u32 level);
+static int msp_suspend(struct device * dev, pm_message_t state);
+static int msp_resume(struct device * dev);
 
 static void msp_wake_thread(struct i2c_client *client);
 
@@ -1821,7 +1821,7 @@ static int msp_command(struct i2c_client
 	return 0;
 }
 
-static int msp_suspend(struct device * dev, pm_message_t state, u32 level)
+static int msp_suspend(struct device * dev, pm_message_t state)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
@@ -1830,7 +1830,7 @@ static int msp_suspend(struct device * d
 	return 0;
 }
 
-static int msp_resume(struct device * dev, u32 level)
+static int msp_resume(struct device * dev)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 
diff --git a/drivers/media/video/tda9887.c b/drivers/media/video/tda9887.c
index 0456dda..94053f1 100644
--- a/drivers/media/video/tda9887.c
+++ b/drivers/media/video/tda9887.c
@@ -784,13 +784,13 @@ tda9887_command(struct i2c_client *clien
 	return 0;
 }
 
-static int tda9887_suspend(struct device * dev, pm_message_t state, u32 level)
+static int tda9887_suspend(struct device * dev, pm_message_t state)
 {
 	dprintk("tda9887: suspend\n");
 	return 0;
 }
 
-static int tda9887_resume(struct device * dev, u32 level)
+static int tda9887_resume(struct device * dev)
 {
 	struct i2c_client *c = container_of(dev, struct i2c_client, dev);
 	struct tda9887 *t = i2c_get_clientdata(c);
diff --git a/drivers/media/video/tuner-core.c b/drivers/media/video/tuner-core.c
index 0557202..ad85bef 100644
--- a/drivers/media/video/tuner-core.c
+++ b/drivers/media/video/tuner-core.c
@@ -697,7 +697,7 @@ static int tuner_command(struct i2c_clie
 	return 0;
 }
 
-static int tuner_suspend(struct device *dev, pm_message_t state, u32 level)
+static int tuner_suspend(struct device *dev, pm_message_t state)
 {
 	struct i2c_client *c = container_of (dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata (c);
@@ -707,7 +707,7 @@ static int tuner_suspend(struct device *
 	return 0;
 }
 
-static int tuner_resume(struct device *dev, u32 level)
+static int tuner_resume(struct device *dev)
 {
 	struct i2c_client *c = container_of (dev, struct i2c_client, dev);
 	struct tuner *t = i2c_get_clientdata (c);
diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index e9806fb..720e7a3 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -219,26 +219,24 @@ static int mcp_sa11x0_remove(struct devi
 	return 0;
 }
 
-static int mcp_sa11x0_suspend(struct device *dev, pm_message_t state, u32 level)
+static int mcp_sa11x0_suspend(struct device *dev, pm_message_t state)
 {
 	struct mcp *mcp = dev_get_drvdata(dev);
 
-	if (level == SUSPEND_DISABLE) {
-		priv(mcp)->mccr0 = Ser4MCCR0;
-		priv(mcp)->mccr1 = Ser4MCCR1;
-		Ser4MCCR0 &= ~MCCR0_MCE;
-	}
+	priv(mcp)->mccr0 = Ser4MCCR0;
+	priv(mcp)->mccr1 = Ser4MCCR1;
+	Ser4MCCR0 &= ~MCCR0_MCE;
+
 	return 0;
 }
 
-static int mcp_sa11x0_resume(struct device *dev, u32 level)
+static int mcp_sa11x0_resume(struct device *dev)
 {
 	struct mcp *mcp = dev_get_drvdata(dev);
 
-	if (level == RESUME_RESTORE_STATE) {
-		Ser4MCCR1 = priv(mcp)->mccr1;
-		Ser4MCCR0 = priv(mcp)->mccr0;
-	}
+	Ser4MCCR1 = priv(mcp)->mccr1;
+	Ser4MCCR0 = priv(mcp)->mccr0;
+
 	return 0;
 }
 
diff --git a/drivers/mmc/pxamci.c b/drivers/mmc/pxamci.c
index b53af57..8eba373 100644
--- a/drivers/mmc/pxamci.c
+++ b/drivers/mmc/pxamci.c
@@ -571,23 +571,23 @@ static int pxamci_remove(struct device *
 }
 
 #ifdef CONFIG_PM
-static int pxamci_suspend(struct device *dev, pm_message_t state, u32 level)
+static int pxamci_suspend(struct device *dev, pm_message_t state)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (mmc && level == SUSPEND_DISABLE)
+	if (mmc)
 		ret = mmc_suspend_host(mmc, state);
 
 	return ret;
 }
 
-static int pxamci_resume(struct device *dev, u32 level)
+static int pxamci_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (mmc && level == RESUME_ENABLE)
+	if (mmc)
 		ret = mmc_resume_host(mmc);
 
 	return ret;
diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index 3cbca7c..25f7ce7 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1955,14 +1955,14 @@ static void __devexit wbsd_pnp_remove(st
  */
 
 #ifdef CONFIG_PM
-static int wbsd_suspend(struct device *dev, pm_message_t state, u32 level)
+static int wbsd_suspend(struct device *dev, pm_message_t state)
 {
 	DBGF("Not yet supported\n");
 
 	return 0;
 }
 
-static int wbsd_resume(struct device *dev, u32 level)
+static int wbsd_resume(struct device *dev)
 {
 	DBGF("Not yet supported\n");
 
diff --git a/drivers/mtd/maps/sa1100-flash.c b/drivers/mtd/maps/sa1100-flash.c
index 8dcaa35..55f21dd 100644
--- a/drivers/mtd/maps/sa1100-flash.c
+++ b/drivers/mtd/maps/sa1100-flash.c
@@ -402,21 +402,21 @@ static int __exit sa1100_mtd_remove(stru
 }
 
 #ifdef CONFIG_PM
-static int sa1100_mtd_suspend(struct device *dev, pm_message_t state, u32 level)
+static int sa1100_mtd_suspend(struct device *dev, pm_message_t state)
 {
 	struct sa_info *info = dev_get_drvdata(dev);
 	int ret = 0;
 
-	if (info && level == SUSPEND_SAVE_STATE)
+	if (info)
 		ret = info->mtd->suspend(info->mtd);
 
 	return ret;
 }
 
-static int sa1100_mtd_resume(struct device *dev, u32 level)
+static int sa1100_mtd_resume(struct device *dev)
 {
 	struct sa_info *info = dev_get_drvdata(dev);
-	if (info && level == RESUME_RESTORE_STATE)
+	if (info)
 		info->mtd->resume(info->mtd);
 	return 0;
 }
diff --git a/drivers/net/dm9000.c b/drivers/net/dm9000.c
index e54fc10..abce1f7 100644
--- a/drivers/net/dm9000.c
+++ b/drivers/net/dm9000.c
@@ -1140,11 +1140,11 @@ dm9000_phy_write(struct net_device *dev,
 }
 
 static int
-dm9000_drv_suspend(struct device *dev, pm_message_t state, u32 level)
+dm9000_drv_suspend(struct device *dev, pm_message_t state)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 
-	if (ndev && level == SUSPEND_DISABLE) {
+	if (ndev) {
 		if (netif_running(ndev)) {
 			netif_device_detach(ndev);
 			dm9000_shutdown(ndev);
@@ -1154,12 +1154,12 @@ dm9000_drv_suspend(struct device *dev, p
 }
 
 static int
-dm9000_drv_resume(struct device *dev, u32 level)
+dm9000_drv_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	board_info_t *db = (board_info_t *) ndev->priv;
 
-	if (ndev && level == RESUME_ENABLE) {
+	if (ndev) {
 
 		if (netif_running(ndev)) {
 			dm9000_reset(db);
diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
index 8d34ac6..0688330 100644
--- a/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -291,12 +291,12 @@ static void sa1100_irda_shutdown(struct 
 /*
  * Suspend the IrDA interface.
  */
-static int sa1100_irda_suspend(struct device *_dev, pm_message_t state, u32 level)
+static int sa1100_irda_suspend(struct device *_dev, pm_message_t state)
 {
 	struct net_device *dev = dev_get_drvdata(_dev);
 	struct sa1100_irda *si;
 
-	if (!dev || level != SUSPEND_DISABLE)
+	if (!dev)
 		return 0;
 
 	si = dev->priv;
@@ -316,12 +316,12 @@ static int sa1100_irda_suspend(struct de
 /*
  * Resume the IrDA interface.
  */
-static int sa1100_irda_resume(struct device *_dev, u32 level)
+static int sa1100_irda_resume(struct device *_dev)
 {
 	struct net_device *dev = dev_get_drvdata(_dev);
 	struct sa1100_irda *si;
 
-	if (!dev || level != RESUME_ENABLE)
+	if (!dev)
 		return 0;
 
 	si = dev->priv;
diff --git a/drivers/net/irda/smsc-ircc2.c b/drivers/net/irda/smsc-ircc2.c
index dd89bda..bbac720 100644
--- a/drivers/net/irda/smsc-ircc2.c
+++ b/drivers/net/irda/smsc-ircc2.c
@@ -213,8 +213,8 @@ static int  smsc_ircc_probe_transceiver_
 
 /* Power Management */
 
-static int smsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level);
-static int smsc_ircc_resume(struct device *dev, u32 level);
+static int smsc_ircc_suspend(struct device *dev, pm_message_t state);
+static int smsc_ircc_resume(struct device *dev);
 
 static struct device_driver smsc_ircc_driver = {
 	.name		= SMSC_IRCC2_DRIVER_NAME,
@@ -1646,13 +1646,13 @@ static int smsc_ircc_net_close(struct ne
 	return 0;
 }
 
-static int smsc_ircc_suspend(struct device *dev, pm_message_t state, u32 level)
+static int smsc_ircc_suspend(struct device *dev, pm_message_t state)
 {
 	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
 
 	IRDA_MESSAGE("%s, Suspending\n", driver_name);
 
-	if (level == SUSPEND_DISABLE && !self->io.suspended) {
+	if (!self->io.suspended) {
 		smsc_ircc_net_close(self->netdev);
 		self->io.suspended = 1;
 	}
@@ -1660,11 +1660,11 @@ static int smsc_ircc_suspend(struct devi
 	return 0;
 }
 
-static int smsc_ircc_resume(struct device *dev, u32 level)
+static int smsc_ircc_resume(struct device *dev)
 {
 	struct smsc_ircc_cb *self = dev_get_drvdata(dev);
 
-	if (level == RESUME_ENABLE && self->io.suspended) {
+	if (self->io.suspended) {
 
 		smsc_ircc_net_open(self->netdev);
 		self->io.suspended = 0;
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 9063067..ad93b0d 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -133,13 +133,9 @@ static int mdio_bus_suspend(struct devic
 	int ret = 0;
 	struct device_driver *drv = dev->driver;
 
-	if (drv && drv->suspend) {
-		ret = drv->suspend(dev, state, SUSPEND_DISABLE);
-		if (ret == 0)
-			ret = drv->suspend(dev, state, SUSPEND_SAVE_STATE);
-		if (ret == 0)
-			ret = drv->suspend(dev, state, SUSPEND_POWER_DOWN);
-	}
+	if (drv && drv->suspend)
+		ret = drv->suspend(dev, state);
+
 	return ret;
 }
 
@@ -148,13 +144,9 @@ static int mdio_bus_resume(struct device
 	int ret = 0;
 	struct device_driver *drv = dev->driver;
 
-	if (drv && drv->resume) {
-		ret = drv->resume(dev, RESUME_POWER_ON);
-		if (ret == 0)
-			ret = drv->resume(dev, RESUME_RESTORE_STATE);
-		if (ret == 0)
-			ret = drv->resume(dev, RESUME_ENABLE);
-	}
+	if (drv && drv->resume)
+		ret = drv->resume(dev);
+
 	return ret;
 }
 
diff --git a/drivers/net/smc91x.c b/drivers/net/smc91x.c
index 1438fdd..0ddaa61 100644
--- a/drivers/net/smc91x.c
+++ b/drivers/net/smc91x.c
@@ -2291,11 +2291,11 @@ static int smc_drv_remove(struct device 
 	return 0;
 }
 
-static int smc_drv_suspend(struct device *dev, pm_message_t state, u32 level)
+static int smc_drv_suspend(struct device *dev, pm_message_t state)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 
-	if (ndev && level == SUSPEND_DISABLE) {
+	if (ndev) {
 		if (netif_running(ndev)) {
 			netif_device_detach(ndev);
 			smc_shutdown(ndev);
@@ -2305,12 +2305,12 @@ static int smc_drv_suspend(struct device
 	return 0;
 }
 
-static int smc_drv_resume(struct device *dev, u32 level)
+static int smc_drv_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct net_device *ndev = dev_get_drvdata(dev);
 
-	if (ndev && level == RESUME_ENABLE) {
+	if (ndev) {
 		struct smc_local *lp = netdev_priv(ndev);
 		smc_enable_device(pdev);
 		if (netif_running(ndev)) {
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 393e0ce..14f05d2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -61,7 +61,7 @@ static int pcie_port_remove_service(stru
 
 static void pcie_port_shutdown_service(struct device *dev) {}
 
-static int pcie_port_suspend_service(struct device *dev, pm_message_t state, u32 level)
+static int pcie_port_suspend_service(struct device *dev, pm_message_t state)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
@@ -76,7 +76,7 @@ static int pcie_port_suspend_service(str
 	return 0;
 }
 
-static int pcie_port_resume_service(struct device *dev, u32 level)
+static int pcie_port_resume_service(struct device *dev)
 {
 	struct pcie_device *pciedev;
 	struct pcie_port_service_driver *driver;
diff --git a/drivers/pcmcia/au1000_generic.c b/drivers/pcmcia/au1000_generic.c
index 470ef75..d90a634 100644
--- a/drivers/pcmcia/au1000_generic.c
+++ b/drivers/pcmcia/au1000_generic.c
@@ -519,30 +519,13 @@ static int au1x00_drv_pcmcia_probe(struc
 }
 
 
-static int au1x00_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int au1x00_drv_pcmcia_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
-
 static struct device_driver au1x00_pcmcia_driver = {
 	.probe		= au1x00_drv_pcmcia_probe,
 	.remove		= au1x00_drv_pcmcia_remove,
 	.name		= "au1x00-pcmcia",
 	.bus		= &platform_bus_type,
-	.suspend	= au1x00_drv_pcmcia_suspend,
-	.resume		= au1x00_drv_pcmcia_resume
+	.suspend	= pcmcia_socket_dev_suspend,
+	.resume		= pcmcia_socket_dev_resume,
 };
 
 static struct platform_device au1x00_device = {
diff --git a/drivers/pcmcia/hd64465_ss.c b/drivers/pcmcia/hd64465_ss.c
index 316f8bc..b57a0b9 100644
--- a/drivers/pcmcia/hd64465_ss.c
+++ b/drivers/pcmcia/hd64465_ss.c
@@ -844,27 +844,11 @@ static void hs_exit_socket(hs_socket_t *
 	local_irq_restore(flags);
 }
 
-static int hd64465_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int hd64465_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
 static struct device_driver hd64465_driver = {
 	.name = "hd64465-pcmcia",
 	.bus = &platform_bus_type,
-	.suspend = hd64465_suspend,
-	.resume = hd64465_resume,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device hd64465_device = {
diff --git a/drivers/pcmcia/i82365.c b/drivers/pcmcia/i82365.c
index a713015..4a41f67 100644
--- a/drivers/pcmcia/i82365.c
+++ b/drivers/pcmcia/i82365.c
@@ -1332,27 +1332,11 @@ static struct pccard_operations pcic_ope
 
 /*====================================================================*/
 
-static int i82365_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int i82365_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
 static struct device_driver i82365_driver = {
 	.name = "i82365",
 	.bus = &platform_bus_type,
-	.suspend = i82365_suspend,
-	.resume = i82365_resume,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device i82365_device = {
diff --git a/drivers/pcmcia/m32r_cfc.c b/drivers/pcmcia/m32r_cfc.c
index 65f3ee3..c6ed70e 100644
--- a/drivers/pcmcia/m32r_cfc.c
+++ b/drivers/pcmcia/m32r_cfc.c
@@ -731,28 +731,11 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int m32r_pcc_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
-
 static struct device_driver pcc_driver = {
 	.name = "cfc",
 	.bus = &platform_bus_type,
-	.suspend = m32r_pcc_suspend,
-	.resume = m32r_pcc_resume,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device pcc_device = {
diff --git a/drivers/pcmcia/m32r_pcc.c b/drivers/pcmcia/m32r_pcc.c
index 7b14d7e..3397ff2 100644
--- a/drivers/pcmcia/m32r_pcc.c
+++ b/drivers/pcmcia/m32r_pcc.c
@@ -695,28 +695,11 @@ static struct pccard_operations pcc_oper
 
 /*====================================================================*/
 
-static int m32r_pcc_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int m32r_pcc_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
-
 static struct device_driver pcc_driver = {
 	.name = "pcc",
 	.bus = &platform_bus_type,
-	.suspend = m32r_pcc_suspend,
-	.resume = m32r_pcc_resume,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device pcc_device = {
diff --git a/drivers/pcmcia/omap_cf.c b/drivers/pcmcia/omap_cf.c
index 94be9e5..2558c3c 100644
--- a/drivers/pcmcia/omap_cf.c
+++ b/drivers/pcmcia/omap_cf.c
@@ -329,27 +329,13 @@ static int __devexit omap_cf_remove(stru
 	return 0;
 }
 
-static int omap_cf_suspend(struct device *dev, pm_message_t mesg, u32 level)
-{
-	if (level != SUSPEND_SAVE_STATE)
-		return 0;
-	return pcmcia_socket_dev_suspend(dev, mesg);
-}
-
-static int omap_cf_resume(struct device *dev, u32 level)
-{
-	if (level != RESUME_RESTORE_STATE)
-		return 0;
-	return pcmcia_socket_dev_resume(dev);
-}
-
 static struct device_driver omap_cf_driver = {
 	.name		= (char *) driver_name,
 	.bus		= &platform_bus_type,
 	.probe		= omap_cf_probe,
 	.remove		= __devexit_p(omap_cf_remove),
-	.suspend 	= omap_cf_suspend,
-	.resume 	= omap_cf_resume,
+	.suspend 	= pcmcia_socket_dev_suspend,
+	.resume 	= pcmcia_socket_dev_resume,
 };
 
 static int __init omap_cf_init(void)
diff --git a/drivers/pcmcia/pxa2xx_base.c b/drivers/pcmcia/pxa2xx_base.c
index 325c992..c2a12d5 100644
--- a/drivers/pcmcia/pxa2xx_base.c
+++ b/drivers/pcmcia/pxa2xx_base.c
@@ -205,32 +205,20 @@ int pxa2xx_drv_pcmcia_probe(struct devic
 }
 EXPORT_SYMBOL(pxa2xx_drv_pcmcia_probe);
 
-static int pxa2xx_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
+static int pxa2xx_drv_pcmcia_resume(struct device *dev)
 {
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
+	struct pcmcia_low_level *ops = dev->platform_data;
+	int nr = ops ? ops->nr : 0;
 
-static int pxa2xx_drv_pcmcia_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-	{
-		struct pcmcia_low_level *ops = dev->platform_data;
-		int nr = ops ? ops->nr : 0;
-
-		MECR = nr > 1 ? MECR_CIT | MECR_NOS : (nr > 0 ? MECR_CIT : 0);
-		ret = pcmcia_socket_dev_resume(dev);
-	}
-	return ret;
+	MECR = nr > 1 ? MECR_CIT | MECR_NOS : (nr > 0 ? MECR_CIT : 0);
+
+	return pcmcia_socket_dev_resume(dev);
 }
 
 static struct device_driver pxa2xx_pcmcia_driver = {
 	.probe		= pxa2xx_drv_pcmcia_probe,
 	.remove		= soc_common_drv_pcmcia_remove,
-	.suspend 	= pxa2xx_drv_pcmcia_suspend,
+	.suspend 	= pcmcia_socket_dev_suspend,
 	.resume 	= pxa2xx_drv_pcmcia_resume,
 	.name		= "pxa2xx-pcmcia",
 	.bus		= &platform_bus_type,
diff --git a/drivers/pcmcia/sa1100_generic.c b/drivers/pcmcia/sa1100_generic.c
index d4ed508..b768fa8 100644
--- a/drivers/pcmcia/sa1100_generic.c
+++ b/drivers/pcmcia/sa1100_generic.c
@@ -74,29 +74,13 @@ static int sa11x0_drv_pcmcia_probe(struc
 	return ret;
 }
 
-static int sa11x0_drv_pcmcia_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int sa11x0_drv_pcmcia_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
 static struct device_driver sa11x0_pcmcia_driver = {
 	.probe		= sa11x0_drv_pcmcia_probe,
 	.remove		= soc_common_drv_pcmcia_remove,
 	.name		= "sa11x0-pcmcia",
 	.bus		= &platform_bus_type,
-	.suspend 	= sa11x0_drv_pcmcia_suspend,
-	.resume 	= sa11x0_drv_pcmcia_resume,
+	.suspend 	= pcmcia_socket_dev_suspend,
+	.resume 	= pcmcia_socket_dev_resume,
 };
 
 /* sa11x0_pcmcia_init()
diff --git a/drivers/pcmcia/tcic.c b/drivers/pcmcia/tcic.c
index d5a61ea..f158b67 100644
--- a/drivers/pcmcia/tcic.c
+++ b/drivers/pcmcia/tcic.c
@@ -372,27 +372,11 @@ static int __init get_tcic_id(void)
 
 /*====================================================================*/
 
-static int tcic_drv_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int ret = 0;
-	if (level == SUSPEND_SAVE_STATE)
-		ret = pcmcia_socket_dev_suspend(dev, state);
-	return ret;
-}
-
-static int tcic_drv_resume(struct device *dev, u32 level)
-{
-	int ret = 0;
-	if (level == RESUME_RESTORE_STATE)
-		ret = pcmcia_socket_dev_resume(dev);
-	return ret;
-}
-
 static struct device_driver tcic_driver = {
 	.name = "tcic-pcmcia",
 	.bus = &platform_bus_type,
-	.suspend = tcic_drv_suspend,
-	.resume = tcic_drv_resume,
+	.suspend = pcmcia_socket_dev_suspend,
+	.resume = pcmcia_socket_dev_resume,
 };
 
 static struct platform_device tcic_device = {
diff --git a/drivers/pcmcia/vrc4171_card.c b/drivers/pcmcia/vrc4171_card.c
index 17bb2da..3d2dca6 100644
--- a/drivers/pcmcia/vrc4171_card.c
+++ b/drivers/pcmcia/vrc4171_card.c
@@ -774,31 +774,11 @@ static int __devinit vrc4171_card_setup(
 
 __setup("vrc4171_card=", vrc4171_card_setup);
 
-static int vrc4171_card_suspend(struct device *dev, pm_message_t state, u32 level)
-{
-	int retval = 0;
-
-	if (level == SUSPEND_SAVE_STATE)
-		retval = pcmcia_socket_dev_suspend(dev, state);
-
-	return retval;
-}
-
-static int vrc4171_card_resume(struct device *dev, u32 level)
-{
-	int retval = 0;
-
-	if (level == RESUME_RESTORE_STATE)
-		retval = pcmcia_socket_dev_resume(dev);
-
-	return retval;
-}
-
 static struct device_driver vrc4171_card_driver = {
 	.name		= vrc4171_card_name,
 	.bus		= &platform_bus_type,
-	.suspend	= vrc4171_card_suspend,
-	.resume		= vrc4171_card_resume,
+	.suspend	= pcmcia_socket_dev_suspend,
+	.resume		= pcmcia_socket_dev_resume,
 };
 
 static int __devinit vrc4171_card_init(void)
diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 4d75cdf..afb7ddf 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2358,13 +2358,10 @@ static int __devexit serial8250_remove(s
 	return 0;
 }
 
-static int serial8250_suspend(struct device *dev, pm_message_t state, u32 level)
+static int serial8250_suspend(struct device *dev, pm_message_t state)
 {
 	int i;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
@@ -2375,13 +2372,10 @@ static int serial8250_suspend(struct dev
 	return 0;
 }
 
-static int serial8250_resume(struct device *dev, u32 level)
+static int serial8250_resume(struct device *dev)
 {
 	int i;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	for (i = 0; i < UART_NR; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 
diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index bdb4e45..5b3933b 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -921,21 +921,21 @@ static struct uart_driver imx_reg = {
 	.cons           = IMX_CONSOLE,
 };
 
-static int serial_imx_suspend(struct device *_dev, pm_message_t state, u32 level)
+static int serial_imx_suspend(struct device *_dev, pm_message_t state)
 {
         struct imx_port *sport = dev_get_drvdata(_dev);
 
-        if (sport && level == SUSPEND_DISABLE)
+        if (sport)
                 uart_suspend_port(&imx_reg, &sport->port);
 
         return 0;
 }
 
-static int serial_imx_resume(struct device *_dev, u32 level)
+static int serial_imx_resume(struct device *_dev)
 {
         struct imx_port *sport = dev_get_drvdata(_dev);
 
-        if (sport && level == RESUME_ENABLE)
+        if (sport)
                 uart_resume_port(&imx_reg, &sport->port);
 
         return 0;
diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index 0585ab2..8a79968 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -781,22 +781,22 @@ mpc52xx_uart_remove(struct device *dev)
 
 #ifdef CONFIG_PM
 static int
-mpc52xx_uart_suspend(struct device *dev, pm_message_t state, u32 level)
+mpc52xx_uart_suspend(struct device *dev, pm_message_t state)
 {
 	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
 
-	if (sport && level == SUSPEND_DISABLE)
+	if (sport)
 		uart_suspend_port(&mpc52xx_uart_driver, port);
 
 	return 0;
 }
 
 static int
-mpc52xx_uart_resume(struct device *dev, u32 level)
+mpc52xx_uart_resume(struct device *dev)
 {
 	struct uart_port *port = (struct uart_port *) dev_get_drvdata(dev);
 
-	if (port && level == RESUME_ENABLE)
+	if (port)
 		uart_resume_port(&mpc52xx_uart_driver, port);
 
 	return 0;
diff --git a/drivers/serial/pxa.c b/drivers/serial/pxa.c
index 90c2a86..7999686 100644
--- a/drivers/serial/pxa.c
+++ b/drivers/serial/pxa.c
@@ -786,21 +786,21 @@ static struct uart_driver serial_pxa_reg
 	.cons		= PXA_CONSOLE,
 };
 
-static int serial_pxa_suspend(struct device *_dev, pm_message_t state, u32 level)
+static int serial_pxa_suspend(struct device *_dev, pm_message_t state)
 {
         struct uart_pxa_port *sport = dev_get_drvdata(_dev);
 
-        if (sport && level == SUSPEND_DISABLE)
+        if (sport)
                 uart_suspend_port(&serial_pxa_reg, &sport->port);
 
         return 0;
 }
 
-static int serial_pxa_resume(struct device *_dev, u32 level)
+static int serial_pxa_resume(struct device *_dev)
 {
         struct uart_pxa_port *sport = dev_get_drvdata(_dev);
 
-        if (sport && level == RESUME_ENABLE)
+        if (sport)
                 uart_resume_port(&serial_pxa_reg, &sport->port);
 
         return 0;
diff --git a/drivers/serial/s3c2410.c b/drivers/serial/s3c2410.c
index 52692aa..06a17df 100644
--- a/drivers/serial/s3c2410.c
+++ b/drivers/serial/s3c2410.c
@@ -1134,23 +1134,22 @@ static int s3c24xx_serial_remove(struct 
 
 #ifdef CONFIG_PM
 
-static int s3c24xx_serial_suspend(struct device *dev, pm_message_t state,
-				  u32 level)
+static int s3c24xx_serial_suspend(struct device *dev, pm_message_t state)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 
-	if (port && level == SUSPEND_DISABLE)
+	if (port)
 		uart_suspend_port(&s3c24xx_uart_drv, port);
 
 	return 0;
 }
 
-static int s3c24xx_serial_resume(struct device *dev, u32 level)
+static int s3c24xx_serial_resume(struct device *dev)
 {
 	struct uart_port *port = s3c24xx_dev_to_port(dev);
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
-	if (port && level == RESUME_ENABLE) {
+	if (port) {
 		clk_enable(ourport->clk);
 		s3c24xx_serial_resetport(port, s3c24xx_port_to_cfg(port));
 		clk_disable(ourport->clk);
diff --git a/drivers/serial/sa1100.c b/drivers/serial/sa1100.c
index dd8aed2..c4a789e 100644
--- a/drivers/serial/sa1100.c
+++ b/drivers/serial/sa1100.c
@@ -834,21 +834,21 @@ static struct uart_driver sa1100_reg = {
 	.cons			= SA1100_CONSOLE,
 };
 
-static int sa1100_serial_suspend(struct device *_dev, pm_message_t state, u32 level)
+static int sa1100_serial_suspend(struct device *_dev, pm_message_t state)
 {
 	struct sa1100_port *sport = dev_get_drvdata(_dev);
 
-	if (sport && level == SUSPEND_DISABLE)
+	if (sport)
 		uart_suspend_port(&sa1100_reg, &sport->port);
 
 	return 0;
 }
 
-static int sa1100_serial_resume(struct device *_dev, u32 level)
+static int sa1100_serial_resume(struct device *_dev)
 {
 	struct sa1100_port *sport = dev_get_drvdata(_dev);
 
-	if (sport && level == RESUME_ENABLE)
+	if (sport)
 		uart_resume_port(&sa1100_reg, &sport->port);
 
 	return 0;
diff --git a/drivers/serial/vr41xx_siu.c b/drivers/serial/vr41xx_siu.c
index 0c5d65a..2b623ab 100644
--- a/drivers/serial/vr41xx_siu.c
+++ b/drivers/serial/vr41xx_siu.c
@@ -976,14 +976,11 @@ static int siu_remove(struct device *dev
 	return 0;
 }
 
-static int siu_suspend(struct device *dev, pm_message_t state, u32 level)
+static int siu_suspend(struct device *dev, pm_message_t state)
 {
 	struct uart_port *port;
 	int i;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	for (i = 0; i < siu_uart_driver.nr; i++) {
 		port = &siu_uart_ports[i];
 		if ((port->type == PORT_VR41XX_SIU ||
@@ -995,14 +992,11 @@ static int siu_suspend(struct device *de
 	return 0;
 }
 
-static int siu_resume(struct device *dev, u32 level)
+static int siu_resume(struct device *dev)
 {
 	struct uart_port *port;
 	int i;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	for (i = 0; i < siu_uart_driver.nr; i++) {
 		port = &siu_uart_ports[i];
 		if ((port->type == PORT_VR41XX_SIU ||
diff --git a/drivers/usb/gadget/dummy_hcd.c b/drivers/usb/gadget/dummy_hcd.c
index 583db7c..f2bdf4e 100644
--- a/drivers/usb/gadget/dummy_hcd.c
+++ b/drivers/usb/gadget/dummy_hcd.c
@@ -935,14 +935,10 @@ static int dummy_udc_remove (struct devi
 	return 0;
 }
 
-static int dummy_udc_suspend (struct device *dev, pm_message_t state,
-		u32 level)
+static int dummy_udc_suspend (struct device *dev, pm_message_t state)
 {
 	struct dummy	*dum = dev_get_drvdata(dev);
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	dev_dbg (dev, "%s\n", __FUNCTION__);
 	spin_lock_irq (&dum->lock);
 	dum->udc_suspended = 1;
@@ -954,13 +950,10 @@ static int dummy_udc_suspend (struct dev
 	return 0;
 }
 
-static int dummy_udc_resume (struct device *dev, u32 level)
+static int dummy_udc_resume (struct device *dev)
 {
 	struct dummy	*dum = dev_get_drvdata(dev);
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	dev_dbg (dev, "%s\n", __FUNCTION__);
 	spin_lock_irq (&dum->lock);
 	dum->udc_suspended = 0;
@@ -1936,14 +1929,10 @@ static int dummy_hcd_remove (struct devi
 	return 0;
 }
 
-static int dummy_hcd_suspend (struct device *dev, pm_message_t state,
-		u32 level)
+static int dummy_hcd_suspend (struct device *dev, pm_message_t state)
 {
 	struct usb_hcd		*hcd;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	dev_dbg (dev, "%s\n", __FUNCTION__);
 	hcd = dev_get_drvdata (dev);
 
@@ -1958,13 +1947,10 @@ static int dummy_hcd_suspend (struct dev
 	return 0;
 }
 
-static int dummy_hcd_resume (struct device *dev, u32 level)
+static int dummy_hcd_resume (struct device *dev)
 {
 	struct usb_hcd		*hcd;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	dev_dbg (dev, "%s\n", __FUNCTION__);
 	hcd = dev_get_drvdata (dev);
 	hcd->state = HC_STATE_RUNNING;
diff --git a/drivers/usb/gadget/omap_udc.c b/drivers/usb/gadget/omap_udc.c
index ff5533e..58b3ec9 100644
--- a/drivers/usb/gadget/omap_udc.c
+++ b/drivers/usb/gadget/omap_udc.c
@@ -2909,12 +2909,10 @@ static int __exit omap_udc_remove(struct
  * may involve talking to an external transceiver (e.g. isp1301).
  */
 
-static int omap_udc_suspend(struct device *dev, pm_message_t message, u32 level)
+static int omap_udc_suspend(struct device *dev, pm_message_t message)
 {
 	u32	devstat;
 
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
 	devstat = UDC_DEVSTAT_REG;
 
 	/* we're requesting 48 MHz clock if the pullup is enabled
@@ -2931,11 +2929,8 @@ static int omap_udc_suspend(struct devic
 	return 0;
 }
 
-static int omap_udc_resume(struct device *dev, u32 level)
+static int omap_udc_resume(struct device *dev)
 {
-	if (level != RESUME_POWER_ON)
-		return 0;
-
 	DBG("resume + wakeup/SRP\n");
 	omap_pullup(&udc->gadget, 1);
 
diff --git a/drivers/usb/gadget/pxa2xx_udc.c b/drivers/usb/gadget/pxa2xx_udc.c
index 73f8c94..00dfe42 100644
--- a/drivers/usb/gadget/pxa2xx_udc.c
+++ b/drivers/usb/gadget/pxa2xx_udc.c
@@ -2602,24 +2602,23 @@ static int __exit pxa2xx_udc_remove(stru
  * VBUS IRQs should probably be ignored so that the PXA device just acts
  * "dead" to USB hosts until system resume.
  */
-static int pxa2xx_udc_suspend(struct device *dev, pm_message_t state, u32 level)
+static int pxa2xx_udc_suspend(struct device *dev, pm_message_t state)
 {
 	struct pxa2xx_udc	*udc = dev_get_drvdata(dev);
 
-	if (level == SUSPEND_POWER_DOWN) {
-		if (!udc->mach->udc_command)
-			WARN("USB host won't detect disconnect!\n");
-		pullup(udc, 0);
-	}
+	if (!udc->mach->udc_command)
+		WARN("USB host won't detect disconnect!\n");
+	pullup(udc, 0);
+
 	return 0;
 }
 
-static int pxa2xx_udc_resume(struct device *dev, u32 level)
+static int pxa2xx_udc_resume(struct device *dev)
 {
 	struct pxa2xx_udc	*udc = dev_get_drvdata(dev);
 
-	if (level == RESUME_POWER_ON)
-		pullup(udc, 1);
+	pullup(udc, 1);
+
 	return 0;
 }
 
diff --git a/drivers/usb/host/isp116x-hcd.c b/drivers/usb/host/isp116x-hcd.c
index e142056..0f6183a 100644
--- a/drivers/usb/host/isp116x-hcd.c
+++ b/drivers/usb/host/isp116x-hcd.c
@@ -1774,15 +1774,12 @@ static int __init isp116x_probe(struct d
 /*
   Suspend of platform device
 */
-static int isp116x_suspend(struct device *dev, pm_message_t state, u32 phase)
+static int isp116x_suspend(struct device *dev, pm_message_t state)
 {
 	int ret = 0;
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
-	VDBG("%s: state %x, phase %x\n", __func__, state, phase);
-
-	if (phase != SUSPEND_DISABLE && phase != SUSPEND_POWER_DOWN)
-		return 0;
+	VDBG("%s: state %x\n", __func__, state);
 
 	ret = usb_suspend_device(hcd->self.root_hub, state);
 	if (!ret) {
@@ -1797,15 +1794,12 @@ static int isp116x_suspend(struct device
 /*
   Resume platform device
 */
-static int isp116x_resume(struct device *dev, u32 phase)
+static int isp116x_resume(struct device *dev)
 {
 	int ret = 0;
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
 
-	VDBG("%s:  state %x, phase %x\n", __func__, dev->power.power_state,
-	     phase);
-	if (phase != RESUME_POWER_ON)
-		return 0;
+	VDBG("%s:  state %x\n", __func__, dev->power.power_state);
 
 	ret = usb_resume_device(hcd->self.root_hub);
 	if (!ret) {
diff --git a/drivers/usb/host/ohci-omap.c b/drivers/usb/host/ohci-omap.c
index d8f3ba7..a574216 100644
--- a/drivers/usb/host/ohci-omap.c
+++ b/drivers/usb/host/ohci-omap.c
@@ -455,14 +455,11 @@ static int ohci_hcd_omap_drv_remove(stru
 
 #ifdef	CONFIG_PM
 
-static int ohci_omap_suspend(struct device *dev, pm_message_t message, u32 level)
+static int ohci_omap_suspend(struct device *dev, pm_message_t message)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
 	int		status = -EINVAL;
 
-	if (level != SUSPEND_POWER_DOWN)
-		return 0;
-
 	down(&ohci_to_hcd(ohci)->self.root_hub->serialize);
 	status = ohci_hub_suspend(ohci_to_hcd(ohci));
 	if (status == 0) {
@@ -476,14 +473,11 @@ static int ohci_omap_suspend(struct devi
 	return status;
 }
 
-static int ohci_omap_resume(struct device *dev, u32 level)
+static int ohci_omap_resume(struct device *dev)
 {
 	struct ohci_hcd	*ohci = hcd_to_ohci(dev_get_drvdata(dev));
 	int		status = 0;
 
-	if (level != RESUME_POWER_ON)
-		return 0;
-
 	if (time_before(jiffies, ohci->next_statechange))
 		msleep(5);
 	ohci->next_statechange = jiffies;
diff --git a/drivers/usb/host/ohci-pxa27x.c b/drivers/usb/host/ohci-pxa27x.c
index 2fdb262..f042261 100644
--- a/drivers/usb/host/ohci-pxa27x.c
+++ b/drivers/usb/host/ohci-pxa27x.c
@@ -309,7 +309,7 @@ static int ohci_hcd_pxa27x_drv_remove(st
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, pm_message_t state, u32 level)
+static int ohci_hcd_pxa27x_drv_suspend(struct device *dev, pm_message_t state)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
@@ -318,7 +318,7 @@ static int ohci_hcd_pxa27x_drv_suspend(s
 	return 0;
 }
 
-static int ohci_hcd_pxa27x_drv_resume(struct device *dev, u32 level)
+static int ohci_hcd_pxa27x_drv_resume(struct device *dev)
 {
 //	struct platform_device *pdev = to_platform_device(dev);
 //	struct usb_hcd *hcd = dev_get_drvdata(dev);
diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index d42a15d..03cf6ac 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1784,15 +1784,12 @@ sl811h_probe(struct device *dev)
  */
 
 static int
-sl811h_suspend(struct device *dev, pm_message_t state, u32 phase)
+sl811h_suspend(struct device *dev, pm_message_t state)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 	int		retval = 0;
 
-	if (phase != SUSPEND_POWER_DOWN)
-		return retval;
-
 	if (state.event == PM_EVENT_FREEZE)
 		retval = sl811h_hub_suspend(hcd);
 	else if (state.event == PM_EVENT_SUSPEND)
@@ -1803,14 +1800,11 @@ sl811h_suspend(struct device *dev, pm_me
 }
 
 static int
-sl811h_resume(struct device *dev, u32 phase)
+sl811h_resume(struct device *dev)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct sl811	*sl811 = hcd_to_sl811(hcd);
 
-	if (phase != RESUME_POWER_ON)
-		return 0;
-
 	/* with no "check to see if VBUS is still powered" board hook,
 	 * let's assume it'd only be powered to enable remote wakeup.
 	 */
diff --git a/drivers/video/backlight/corgi_bl.c b/drivers/video/backlight/corgi_bl.c
index 3c72c62..1991fdb 100644
--- a/drivers/video/backlight/corgi_bl.c
+++ b/drivers/video/backlight/corgi_bl.c
@@ -73,17 +73,15 @@ static void corgibl_blank(int blank)
 }
 
 #ifdef CONFIG_PM
-static int corgibl_suspend(struct device *dev, pm_message_t state, u32 level)
+static int corgibl_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN)
-		corgibl_blank(FB_BLANK_POWERDOWN);
+	corgibl_blank(FB_BLANK_POWERDOWN);
 	return 0;
 }
 
-static int corgibl_resume(struct device *dev, u32 level)
+static int corgibl_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON)
-		corgibl_blank(FB_BLANK_UNBLANK);
+	corgibl_blank(FB_BLANK_UNBLANK);
 	return 0;
 }
 #else
diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index 1d54d3d..0b9301f 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -424,23 +424,21 @@ static void imxfb_setup_gpio(struct imxf
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int imxfb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int imxfb_suspend(struct device *dev, pm_message_t state)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(dev);
 	pr_debug("%s\n",__FUNCTION__);
 
-	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN)
-		imxfb_disable_controller(fbi);
+	imxfb_disable_controller(fbi);
 	return 0;
 }
 
-static int imxfb_resume(struct device *dev, u32 level)
+static int imxfb_resume(struct device *dev)
 {
 	struct imxfb_info *fbi = dev_get_drvdata(dev);
 	pr_debug("%s\n",__FUNCTION__);
 
-	if (level == RESUME_ENABLE)
-		imxfb_enable_controller(fbi);
+	imxfb_enable_controller(fbi);
 	return 0;
 }
 #else
diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index 194eed0..6206da9 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -981,21 +981,19 @@ pxafb_freq_policy(struct notifier_block 
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int pxafb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int pxafb_suspend(struct device *dev, pm_message_t state)
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
-	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN)
-		set_ctrlr_state(fbi, C_DISABLE_PM);
+	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }
 
-static int pxafb_resume(struct device *dev, u32 level)
+static int pxafb_resume(struct device *dev)
 {
 	struct pxafb_info *fbi = dev_get_drvdata(dev);
 
-	if (level == RESUME_ENABLE)
-		set_ctrlr_state(fbi, C_ENABLE_PM);
+	set_ctrlr_state(fbi, C_ENABLE_PM);
 	return 0;
 }
 #else
diff --git a/drivers/video/s1d13xxxfb.c b/drivers/video/s1d13xxxfb.c
index fa98d91..cb2f7a1 100644
--- a/drivers/video/s1d13xxxfb.c
+++ b/drivers/video/s1d13xxxfb.c
@@ -655,7 +655,7 @@ bail:
 }
 
 #ifdef CONFIG_PM
-static int s1d13xxxfb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int s1d13xxxfb_suspend(struct device *dev, pm_message_t state)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct s1d13xxxfb_par *s1dfb = info->par;
@@ -702,15 +702,12 @@ static int s1d13xxxfb_suspend(struct dev
 		return 0;
 }
 
-static int s1d13xxxfb_resume(struct device *dev, u32 level)
+static int s1d13xxxfb_resume(struct device *dev)
 {
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct s1d13xxxfb_par *s1dfb = info->par;
 	struct s1d13xxxfb_pdata *pdata = NULL;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	/* awaken the chip */
 	s1d13xxxfb_writereg(s1dfb, S1DREG_PS_CNF, 0x10);
 
diff --git a/drivers/video/s3c2410fb.c b/drivers/video/s3c2410fb.c
index 5ab79af..3862d3c 100644
--- a/drivers/video/s3c2410fb.c
+++ b/drivers/video/s3c2410fb.c
@@ -847,37 +847,32 @@ static int s3c2410fb_remove(struct devic
 
 /* suspend and resume support for the lcd controller */
 
-static int s3c2410fb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int s3c2410fb_suspend(struct device *dev, pm_message_t state)
 {
 	struct fb_info	   *fbinfo = dev_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN) {
-		s3c2410fb_stop_lcd();
+	s3c2410fb_stop_lcd();
 
-		/* sleep before disabling the clock, we need to ensure
-		 * the LCD DMA engine is not going to get back on the bus
-		 * before the clock goes off again (bjd) */
-
-		msleep(1);
-		clk_disable(info->clk);
-	}
+	/* sleep before disabling the clock, we need to ensure
+	 * the LCD DMA engine is not going to get back on the bus
+	 * before the clock goes off again (bjd) */
+
+	msleep(1);
+	clk_disable(info->clk);
 
 	return 0;
 }
 
-static int s3c2410fb_resume(struct device *dev, u32 level)
+static int s3c2410fb_resume(struct device *dev)
 {
 	struct fb_info	   *fbinfo = dev_get_drvdata(dev);
 	struct s3c2410fb_info *info = fbinfo->par;
 
-	if (level == RESUME_ENABLE) {
-		clk_enable(info->clk);
-		msleep(1);
-
-		s3c2410fb_init_registers(info);
+	clk_enable(info->clk);
+	msleep(1);
 
-	}
+	s3c2410fb_init_registers(info);
 
 	return 0;
 }
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index 8000890..78e5f19 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1309,21 +1309,19 @@ sa1100fb_freq_policy(struct notifier_blo
  * Power management hooks.  Note that we won't be called from IRQ context,
  * unlike the blank functions above, so we may sleep.
  */
-static int sa1100fb_suspend(struct device *dev, pm_message_t state, u32 level)
+static int sa1100fb_suspend(struct device *dev, pm_message_t state)
 {
 	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
 
-	if (level == SUSPEND_DISABLE || level == SUSPEND_POWER_DOWN)
-		set_ctrlr_state(fbi, C_DISABLE_PM);
+	set_ctrlr_state(fbi, C_DISABLE_PM);
 	return 0;
 }
 
-static int sa1100fb_resume(struct device *dev, u32 level)
+static int sa1100fb_resume(struct device *dev)
 {
 	struct sa1100fb_info *fbi = dev_get_drvdata(dev);
 
-	if (level == RESUME_ENABLE)
-		set_ctrlr_state(fbi, C_ENABLE_PM);
+	set_ctrlr_state(fbi, C_ENABLE_PM);
 	return 0;
 }
 #else
diff --git a/drivers/video/w100fb.c b/drivers/video/w100fb.c
index 0030c07..752bf88 100644
--- a/drivers/video/w100fb.c
+++ b/drivers/video/w100fb.c
@@ -438,36 +438,34 @@ static void w100fb_restore_vidmem(struct
 	}
 }
 
-static int w100fb_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int w100fb_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		struct fb_info *info = dev_get_drvdata(dev);
-		struct w100fb_par *par=info->par;
-		struct w100_tg_info *tg = par->mach->tg;
-
-		w100fb_save_vidmem(par);
-		if(tg && tg->suspend)
-			tg->suspend(par);
-		w100_suspend(W100_SUSPEND_ALL);
-		par->blanked = 1;
-	}
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+	struct w100_tg_info *tg = par->mach->tg;
+
+	w100fb_save_vidmem(par);
+	if(tg && tg->suspend)
+		tg->suspend(par);
+	w100_suspend(W100_SUSPEND_ALL);
+	par->blanked = 1;
+
 	return 0;
 }
 
-static int w100fb_resume(struct device *dev, uint32_t level)
+static int w100fb_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		struct fb_info *info = dev_get_drvdata(dev);
-		struct w100fb_par *par=info->par;
-		struct w100_tg_info *tg = par->mach->tg;
-
-		w100_hw_init(par);
-		w100fb_activate_var(par);
-		w100fb_restore_vidmem(par);
-		if(tg && tg->resume)
-			tg->resume(par);
-		par->blanked = 0;
-	}
+	struct fb_info *info = dev_get_drvdata(dev);
+	struct w100fb_par *par=info->par;
+	struct w100_tg_info *tg = par->mach->tg;
+
+	w100_hw_init(par);
+	w100fb_activate_var(par);
+	w100fb_restore_vidmem(par);
+	if(tg && tg->resume)
+		tg->resume(par);
+	par->blanked = 0;
+
 	return 0;
 }
 #else
diff --git a/include/linux/device.h b/include/linux/device.h
index 10ab780..a9e72ac 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -28,19 +28,6 @@
 #define BUS_ID_SIZE		KOBJ_NAME_LEN
 
 
-enum {
-	SUSPEND_NOTIFY,
-	SUSPEND_SAVE_STATE,
-	SUSPEND_DISABLE,
-	SUSPEND_POWER_DOWN,
-};
-
-enum {
-	RESUME_POWER_ON,
-	RESUME_RESTORE_STATE,
-	RESUME_ENABLE,
-};
-
 struct device;
 struct device_driver;
 struct class;
@@ -115,8 +102,8 @@ struct device_driver {
 	int	(*probe)	(struct device * dev);
 	int	(*remove)	(struct device * dev);
 	void	(*shutdown)	(struct device * dev);
-	int	(*suspend)	(struct device * dev, pm_message_t state, u32 level);
-	int	(*resume)	(struct device * dev, u32 level);
+	int	(*suspend)	(struct device * dev, pm_message_t state);
+	int	(*resume)	(struct device * dev);
 };
 
 
diff --git a/sound/arm/pxa2xx-ac97.c b/sound/arm/pxa2xx-ac97.c
index 38b20ef..877bb00 100644
--- a/sound/arm/pxa2xx-ac97.c
+++ b/sound/arm/pxa2xx-ac97.c
@@ -275,23 +275,23 @@ static int pxa2xx_ac97_do_resume(snd_car
 	return 0;
 }
 
-static int pxa2xx_ac97_suspend(struct device *_dev, pm_message_t state, u32 level)
+static int pxa2xx_ac97_suspend(struct device *_dev, pm_message_t state)
 {
 	snd_card_t *card = dev_get_drvdata(_dev);
 	int ret = 0;
 
-	if (card && level == SUSPEND_DISABLE)
+	if (card)
 		ret = pxa2xx_ac97_do_suspend(card, PMSG_SUSPEND);
 
 	return ret;
 }
 
-static int pxa2xx_ac97_resume(struct device *_dev, u32 level)
+static int pxa2xx_ac97_resume(struct device *_dev)
 {
 	snd_card_t *card = dev_get_drvdata(_dev);
 	int ret = 0;
 
-	if (card && level == RESUME_ENABLE)
+	if (card)
 		ret = pxa2xx_ac97_do_resume(card);
 
 	return ret;
diff --git a/sound/core/init.c b/sound/core/init.c
index c72a791..59202de 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -676,8 +676,8 @@ struct snd_generic_device {
 #define SND_GENERIC_NAME	"snd_generic"
 
 #ifdef CONFIG_PM
-static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level);
-static int snd_generic_resume(struct device *dev, u32 level);
+static int snd_generic_suspend(struct device *dev, pm_message_t state);
+static int snd_generic_resume(struct device *dev);
 #endif
 
 /* initialized in sound.c */
@@ -818,13 +818,10 @@ int snd_card_set_pm_callback(snd_card_t 
 
 #ifdef CONFIG_SND_GENERIC_DRIVER
 /* suspend/resume callbacks for snd_generic platform device */
-static int snd_generic_suspend(struct device *dev, pm_message_t state, u32 level)
+static int snd_generic_suspend(struct device *dev, pm_message_t state)
 {
 	snd_card_t *card;
 
-	if (level != SUSPEND_DISABLE)
-		return 0;
-
 	card = get_snd_generic_card(dev);
 	if (card->power_state == SNDRV_CTL_POWER_D3hot)
 		return 0;
@@ -834,13 +831,10 @@ static int snd_generic_suspend(struct de
 	return 0;
 }
 
-static int snd_generic_resume(struct device *dev, u32 level)
+static int snd_generic_resume(struct device *dev)
 {
 	snd_card_t *card;
 
-	if (level != RESUME_ENABLE)
-		return 0;
-
 	card = get_snd_generic_card(dev);
 	if (card->power_state == SNDRV_CTL_POWER_D0)
 		return 0;
diff --git a/sound/pci/ac97/ac97_bus.c b/sound/pci/ac97/ac97_bus.c
index becbc42..ec70fad 100644
--- a/sound/pci/ac97/ac97_bus.c
+++ b/sound/pci/ac97/ac97_bus.c
@@ -31,7 +31,8 @@ static int ac97_bus_suspend(struct devic
 	int ret = 0;
 
 	if (dev->driver && dev->driver->suspend)
-		ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
+		ret = dev->driver->suspend(dev, state);
+
 	return ret;
 }
 
@@ -40,7 +41,8 @@ static int ac97_bus_resume(struct device
 	int ret = 0;
 
 	if (dev->driver && dev->driver->resume)
-		ret = dev->driver->resume(dev, RESUME_POWER_ON);
+		ret = dev->driver->resume(dev);
+
 	return ret;
 }
 

