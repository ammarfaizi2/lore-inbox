Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbVKAUlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKAUlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 15:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbVKAUlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 15:41:31 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:27586 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751199AbVKAUla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 15:41:30 -0500
Date: Tue, 1 Nov 2005 21:40:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Make spitz compile again
Message-ID: <20051101204052.GD7172@elf.ucw.cz>
References: <20051031134255.GA8093@elf.ucw.cz> <1130773530.8353.39.camel@localhost.localdomain> <20051101193135.GA7075@elf.ucw.cz> <1130875849.8489.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130875849.8489.21.camel@localhost.localdomain>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I needed this to get it to compile... Please apply (probably modulo //
> > part).
> > 
> > Signed-off-by: Pavel Machek <pavel@suse.cz>

Fixed patch follows.

--- clean-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 19:32:56.000000000 +0100
+++ linux-rp/arch/arm/mach-pxa/pxa_keys.c	2005-11-01 20:17:38.000000000 +0100
@@ -55,24 +55,20 @@
 }
 
 #ifdef CONFIG_PM
-static int pxa_keys_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int pxa_keys_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
-		struct pxa_keys_platform_data *k = dev_get_drvdata(dev);
-		k->suspended = 1;
-	}
+	struct pxa_keys_platform_data *k = dev_get_drvdata(dev);
+	k->suspended = 1;
 	return 0;
 }
 
-static int pxa_keys_resume(struct device *dev, uint32_t level)
+static int pxa_keys_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
-		struct pxa_keys_platform_data *k = dev_get_drvdata(dev);
+	struct pxa_keys_platform_data *k = dev_get_drvdata(dev);
 
-		/* Upon resume, ignore the suspend key for a short while */
-		k->suspend_jiffies=jiffies;
-		k->suspended = 0;
-	}
+	/* Upon resume, ignore the suspend key for a short while */
+	k->suspend_jiffies=jiffies;
+	k->suspended = 0;
 	return 0;
 }
 #else
--- clean-rp/arch/arm/mach-pxa/spitz.c	2005-11-01 19:32:56.000000000 +0100
+++ linux-rp/arch/arm/mach-pxa/spitz.c	2005-11-01 21:38:19.000000000 +0100
@@ -332,6 +332,7 @@
 		reset_scoop_gpio(&spitzscoop2_device.dev, SPITZ_SCP2_IR_ON);
 }
 
+#ifdef CONFIG_MACH_AKITA
 static void akita_irda_transceiver_mode(struct device *dev, int mode)
 {
 	if (mode & IR_OFF)
@@ -339,6 +340,7 @@
 	else
 		akita_reset_ioexp(&akitaioexp_device.dev, AKITA_IOEXP_IR_ON);
 }
+#endif
 
 static struct pxaficp_platform_data spitz_ficp_platform_data = {
 	.transceiver_cap  = IR_SIRMODE | IR_OFF,
@@ -422,21 +424,6 @@
 	platform_device_register(&spitzscoop2_device);
 }
 
-static void __init akita_init(void)
-{
-	spitz_ficp_platform_data.transceiver_mode = akita_irda_transceiver_mode;
-
-	/* We just pretend the second element of the array doesn't exist */
-	scoop_num = 1;
-	scoop_devs = &spitz_pcmcia_scoop[0];
-	spitz_bl_machinfo.set_bl_intensity = akita_bl_set_intensity;
-
-	platform_device_register(&akitaioexp_device);
-
-	spitzscoop_device.dev.parent=&akitaioexp_device.dev;
-	common_init();
-}
-
 static void __init fixup_spitz(struct machine_desc *desc,
 		struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -474,6 +461,21 @@
 #endif
 
 #ifdef CONFIG_MACH_AKITA
+static void __init akita_init(void)
+{
+	spitz_ficp_platform_data.transceiver_mode = akita_irda_transceiver_mode;
+
+	/* We just pretend the second element of the array doesn't exist */
+	scoop_num = 1;
+	scoop_devs = &spitz_pcmcia_scoop[0];
+	spitz_bl_machinfo.set_bl_intensity = akita_bl_set_intensity;
+
+	platform_device_register(&akitaioexp_device);
+
+	spitzscoop_device.dev.parent=&akitaioexp_device.dev;
+	common_init();
+}
+
 MACHINE_START(AKITA, "SHARP Akita")
 	.phys_ram	= 0xa0000000,
 	.phys_io	= 0x40000000,


-- 
Thanks, Sharp!
