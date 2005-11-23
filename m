Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbVKWUXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbVKWUXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbVKWUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:23:36 -0500
Received: from digitalimplant.org ([64.62.235.95]:56201 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932289AbVKWUXf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:35 -0500
Date: Wed, 23 Nov 2005 12:23:28 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 1/6] [OSS] Remove deprecated PM interface from ad1848 driver.
Message-ID: <Pine.LNX.4.50.0511231215370.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree ce8c2299f594d1d1c115b629e541208919be9b3f (from 2d0ebb36038c0626cde662a3b06da9787cfb68c3)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:43:46 2005 -0800

    [OSS] Remove deprecated PM interface from ad1848 driver.

    This change removes the old, deprecated interface from the
    ad1848 driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 1372bdfc1c79b8bb6b5669fef7d00995eec4ed00 90c9c18df1a44670e4d5c9777ba3abde96ffb73d M	sound

diffstat:

 sound/oss/ad1848.c |   92 -----------------------------------------------------
 1 files changed, 92 deletions(-)

---

ce8c2299f594d1d1c115b629e541208919be9b3f
diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 3f30c57..49796be 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -46,8 +46,6 @@
 #include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/stddef.h>
-#include <linux/pm.h>
-#include <linux/pm_legacy.h>
 #include <linux/isapnp.h>
 #include <linux/pnp.h>
 #include <linux/spinlock.h>
@@ -105,9 +103,6 @@ typedef struct
 	int             irq_ok;
 	mixer_ents     *mix_devices;
 	int             mixer_output_port;
-
-	/* Power management */
-	struct		pm_dev *pmdev;
 } ad1848_info;

 typedef struct ad1848_port_info
@@ -201,7 +196,6 @@ static void     ad1848_halt(int dev);
 static void     ad1848_halt_input(int dev);
 static void     ad1848_halt_output(int dev);
 static void     ad1848_trigger(int dev, int bits);
-static int	ad1848_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data);

 #ifndef EXCLUDE_TIMERS
 static int ad1848_tmr_install(int dev);
@@ -2027,10 +2021,6 @@ int ad1848_init (char *name, struct reso

 	nr_ad1848_devs++;

-	devc->pmdev = pm_register(PM_ISA_DEV, my_dev, ad1848_pm_callback);
-	if (devc->pmdev)
-		devc->pmdev->data = devc;
-
 	ad1848_init_hw(devc);

 	if (irq > 0)
@@ -2197,9 +2187,6 @@ void ad1848_unload(int io_base, int irq,
 		if(mixer>=0)
 			sound_unload_mixerdev(mixer);

-		if (devc->pmdev)
-			pm_unregister(devc->pmdev);
-
 		nr_ad1848_devs--;
 		for ( ; i < nr_ad1848_devs ; i++)
 			adev_info[i] = adev_info[i+1];
@@ -2811,85 +2798,6 @@ static int ad1848_tmr_install(int dev)
 }
 #endif /* EXCLUDE_TIMERS */

-static int ad1848_suspend(ad1848_info *devc)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&devc->lock,flags);
-
-	ad_mute(devc);
-
-	spin_unlock_irqrestore(&devc->lock,flags);
-	return 0;
-}
-
-static int ad1848_resume(ad1848_info *devc)
-{
-	int mixer_levels[32], i;
-
-	/* Thinkpad is a bit more of PITA than normal. The BIOS tends to
-	   restore it in a different config to the one we use.  Need to
-	   fix this somehow */
-
-	/* store old mixer levels */
-	memcpy(mixer_levels, devc->levels, sizeof (mixer_levels));
-	ad1848_init_hw(devc);
-
-	/* restore mixer levels */
-	for (i = 0; i < 32; i++)
-		ad1848_mixer_set(devc, devc->dev_no, mixer_levels[i]);
-
-	if (!devc->subtype) {
-		static signed char interrupt_bits[12] = { -1, -1, -1, -1, -1, 0x00, -1, 0x08, -1, 0x10, 0x18, 0x20 };
-		static char dma_bits[4] = { 1, 2, 0, 3 };
-		unsigned long flags;
-		signed char bits;
-		char dma2_bit = 0;
-
-		int config_port = devc->base + 0;
-
-		bits = interrupt_bits[devc->irq];
-		if (bits == -1) {
-			printk(KERN_ERR "MSS: Bad IRQ %d\n", devc->irq);
-			return -1;
-		}
-
-		spin_lock_irqsave(&devc->lock,flags);
-
-		outb((bits | 0x40), config_port);
-
-		if (devc->dma2 != -1 && devc->dma2 != devc->dma1)
-			if ( (devc->dma1 == 0 && devc->dma2 == 1) ||
-			     (devc->dma1 == 1 && devc->dma2 == 0) ||
-			     (devc->dma1 == 3 && devc->dma2 == 0))
-				dma2_bit = 0x04;
-
-		outb((bits | dma_bits[devc->dma1] | dma2_bit), config_port);
-		spin_unlock_irqrestore(&devc->lock,flags);
-	}
-
-	return 0;
-}
-
-static int ad1848_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	ad1848_info *devc = dev->data;
-	if (devc) {
-		DEB(printk("ad1848: pm event received: 0x%x\n", rqst));
-
-		switch (rqst) {
-		case PM_SUSPEND:
-			ad1848_suspend(devc);
-			break;
-		case PM_RESUME:
-			ad1848_resume(devc);
-			break;
-		}
-	}
-	return 0;
-}
-
-
 EXPORT_SYMBOL(ad1848_detect);
 EXPORT_SYMBOL(ad1848_init);
 EXPORT_SYMBOL(ad1848_unload);
