Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbVJaNoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbVJaNoI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 08:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVJaNoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 08:44:07 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65227 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751145AbVJaNoH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 08:44:07 -0500
Date: Mon, 31 Oct 2005 14:42:55 +0100
From: Pavel Machek <pavel@ucw.cz>
To: rpurdie@rpsys.net, kernel list <linux-kernel@vger.kernel.org>
Subject: Make spitz compile again
Message-ID: <20051031134255.GA8093@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is what I needed to do after update to latest linus
kernel. Perhaps it helps someone. 

Signed-off-by: Pavel Machek <pavel@suse.cz>

, but it is against Richard's tree merged into my tree, so do not
expect to apply it over mainline. Akita code movement is needed if I
want to compile kernel without akita support...


							Pavel

Fix compilation after update to latest 2.6.14.

---
commit 84a41bb5e3a0a46b271929818f6699357f9c03e9
tree b6e836af503cb9e1c0bffe21413ec03eb0845644
parent 128aac988a7eaaa882a71670109831265d24c121
author <pavel@amd.(none)> Mon, 31 Oct 2005 14:40:01 +0100
committer <pavel@amd.(none)> Mon, 31 Oct 2005 14:40:01 +0100

 arch/arm/mach-pxa/pxa_keys.c   |   20 ++++++++------------
 arch/arm/mach-pxa/sharpsl_pm.c |   37 ++++++++++++++++---------------------
 arch/arm/mach-pxa/spitz.c      |   24 +++++++++++-------------
 config.3000                    |   19 ++++++++++++++++---
 drivers/i2c/busses/i2c-pxa.c   |    6 ++----
 5 files changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm/mach-pxa/pxa_keys.c b/arch/arm/mach-pxa/pxa_keys.c
--- a/arch/arm/mach-pxa/pxa_keys.c
+++ b/arch/arm/mach-pxa/pxa_keys.c
@@ -55,24 +55,20 @@ pxa_keys_isr (int irq, void *dev_id, str
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
diff --git a/arch/arm/mach-pxa/sharpsl_pm.c b/arch/arm/mach-pxa/sharpsl_pm.c
--- a/arch/arm/mach-pxa/sharpsl_pm.c
+++ b/arch/arm/mach-pxa/sharpsl_pm.c
@@ -634,36 +634,31 @@ static int sharpsl_ac_check(void)
 
 #ifdef CONFIG_PM
 
-static int corgi_batt_suspend(struct device *dev, pm_message_t state, uint32_t level)
+static int corgi_batt_suspend(struct device *dev, pm_message_t state)
 {
-	if (level == SUSPEND_POWER_DOWN) {
+	DPRINTK("SharpSL Battery Suspending \n");
+	sharpsl_pm.suspended=1;
 
-		DPRINTK("SharpSL Battery Suspending \n");
-		sharpsl_pm.suspended=1;
-
-		flush_scheduled_work();
+	flush_scheduled_work();
 		
-		if (sharpsl_pm.charge_mode == CHRG_ON)
-			sharpsl_pm.offline_charge_activate = 1;
-		else
-			sharpsl_pm.offline_charge_activate = 0;
-	}
+	if (sharpsl_pm.charge_mode == CHRG_ON)
+		sharpsl_pm.offline_charge_activate = 1;
+	else
+		sharpsl_pm.offline_charge_activate = 0;
+
 	return 0;
 }	
 		
-static int corgi_batt_resume(struct device *dev, uint32_t level)
+static int corgi_batt_resume(struct device *dev)
 {
-	if (level == RESUME_POWER_ON) {
+	DPRINTK("SharpSL Battery Resuming \n");
 
-		DPRINTK("SharpSL Battery Resuming \n");
-	
-		/* Clear the reset source indicators as they break the bootloader upon reboot */
-		RCSR=0x0f;
-		apm_event_queued = 0;
-		sharpsl_average_clear();
+	/* Clear the reset source indicators as they break the bootloader upon reboot */
+	RCSR=0x0f;
+	apm_event_queued = 0;
+	sharpsl_average_clear();
 
-		sharpsl_pm.suspended = 0;
-	}
+	sharpsl_pm.suspended = 0;
 	return 0;
 }
 
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -412,19 +412,6 @@ static void __init spitz_init(void)
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
-	common_init();
-	platform_device_register(&akitaioexp_device);
-}
-
 static void __init fixup_spitz(struct machine_desc *desc,
 		struct tag *tags, char **cmdline, struct meminfo *mi)
 {
@@ -462,6 +449,17 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_MACH_AKITA
+static void __init akita_init(void)
+{
+	/* We just pretend the second element of the array doesn't exist */
+	scoop_num = 1;
+	scoop_devs = &spitz_pcmcia_scoop[0];
+	spitz_bl_machinfo.set_bl_intensity = akita_bl_set_intensity;
+
+	common_init();
+	platform_device_register(&akitaioexp_device);
+}
+
 MACHINE_START(AKITA, "SHARP Akita")
 	.phys_ram	= 0xa0000000,
 	.phys_io	= 0x40000000,
diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
--- a/drivers/i2c/busses/i2c-pxa.c
+++ b/drivers/i2c/busses/i2c-pxa.c
@@ -1009,11 +1009,9 @@ static int i2c_pxa_remove(struct device 
 }
 
 #ifdef CONFIG_PM
-static int i2c_pxa_resume(struct device *dev, u32 level)
+static int i2c_pxa_resume(struct device *dev)
 {
-	if (level == RESUME_ENABLE) {
-		i2c_pxa_reset(dev_get_drvdata(dev));
-	}
+	i2c_pxa_reset(dev_get_drvdata(dev));
 	return 0;
 }
 


-- 
Thanks, Sharp!
