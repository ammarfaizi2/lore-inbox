Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932317AbVKWUYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932317AbVKWUYX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbVKWUYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:24:18 -0500
Received: from digitalimplant.org ([64.62.235.95]:63881 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S932317AbVKWUXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:23:40 -0500
Date: Wed, 23 Nov 2005 12:23:36 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org, "" <linux-pm@lists.osdl.org>,
       "" <linux-sound@vger.kernel.org>
cc: akpm@osdl.org
Subject: [Patch 4/6] [OSS] Remove deprecated PM interface from maestro driver.
Message-ID: <Pine.LNX.4.50.0511231220440.16769-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff-tree d4637f6330e57390156e151d15c06247cca7c78f (from 879a82d748d397be6dce2d4cafaa98c06a71acf2)
Author: Patrick Mochel <mochel@linux.intel.com>
Date:   Wed Nov 23 11:54:22 2005 -0800

    [OSS] Remove deprecated PM interface from maestrodriver.

    This change removes the old, deprecated interface from the
    maestro driver, including the pm_{,un}register() calls, the
    local storage of the pmdev object and the reference to the
    old header files. This change is done to assist in eradicating
    the users of the legacy interface so as to help facilitate
    the removal of the interface itself.

    The check_suspend() function and associated logic was not
    removed, even though it is now unnecessary.

    Note that this driver has been obsoleted by an ALSA equivalent.

    Acked-By Zach Brown <zab@zabbo.net>
    Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

:040000 040000 6820ab87e68259b3602ecd3290fad6d7960b12bc 87f4944625899f3a0bbd1656f1ca1546ef304b29 M	sound

diffstat:

 sound/oss/maestro.c |  149 ----------------------------------------------------
 1 files changed, 149 deletions(-)

---

d4637f6330e57390156e151d15c06247cca7c78f
diff --git a/sound/oss/maestro.c b/sound/oss/maestro.c
index 3abd354..f9ac5b1 100644
--- a/sound/oss/maestro.c
+++ b/sound/oss/maestro.c
@@ -230,10 +230,6 @@
 #include <asm/page.h>
 #include <asm/uaccess.h>

-#include <linux/pm.h>
-#include <linux/pm_legacy.h>
-static int maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *d);
-
 #include "maestro.h"

 static struct pci_driver maestro_pci_driver;
@@ -3404,7 +3400,6 @@ maestro_probe(struct pci_dev *pcidev,con
 	int i, ret;
 	struct ess_card *card;
 	struct ess_state *ess;
-	struct pm_dev *pmdev;
 	int num = 0;

 /* when built into the kernel, we only print version if device is found */
@@ -3450,11 +3445,6 @@ maestro_probe(struct pci_dev *pcidev,con
 	memset(card, 0, sizeof(*card));
 	card->pcidev = pcidev;

-	pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev),
-			maestro_pm_callback);
-	if (pmdev)
-		pmdev->data = card;
-
 	card->iobase = iobase;
 	card->card_type = card_type;
 	card->irq = pcidev->irq;
@@ -3670,7 +3660,6 @@ static int maestro_notifier(struct notif
 static void cleanup_maestro(void) {
 	M_printk("maestro: unloading\n");
 	pci_unregister_driver(&maestro_pci_driver);
-	pm_unregister_all(maestro_pm_callback);
 	unregister_reboot_notifier(&maestro_nb);
 }

@@ -3691,143 +3680,5 @@ check_suspend(struct ess_card *card)
 	current->state = TASK_RUNNING;
 }

-static int
-maestro_suspend(struct ess_card *card)
-{
-	unsigned long flags;
-	int i,j;
-
-	spin_lock_irqsave(&card->lock,flags); /* over-kill */
-
-	M_printk("maestro: apm in dev %p\n",card);
-
-	/* we have to read from the apu regs, need
-		to power it up */
-	maestro_power(card,ACPI_D0);
-
-	for(i=0;i<NR_DSPS;i++) {
-		struct ess_state *s = &card->channels[i];
-
-		if(s->dev_audio == -1)
-			continue;
-
-		M_printk("maestro: stopping apus for device %d\n",i);
-		stop_dac(s);
-		stop_adc(s);
-		for(j=0;j<6;j++)
-			card->apu_map[s->apu[j]][5]=apu_get_register(s,j,5);
-
-	}
-
-	/* get rid of interrupts? */
-	if( card->dsps_open > 0)
-		stop_bob(&card->channels[0]);
-
-	card->in_suspend++;
-
-	spin_unlock_irqrestore(&card->lock,flags);
-
-	/* we trust in the bios to power down the chip on suspend.
-	 * XXX I'm also not sure that in_suspend will protect
-	 * against all reg accesses from here on out.
-	 */
-	return 0;
-}
-static int
-maestro_resume(struct ess_card *card)
-{
-	unsigned long flags;
-	int i;
-
-	spin_lock_irqsave(&card->lock,flags); /* over-kill */
-
-	card->in_suspend = 0;
-
-	M_printk("maestro: resuming card at %p\n",card);
-
-	/* restore all our config */
-	maestro_config(card);
-	/* need to restore the base pointers.. */
-	if(card->dmapages)
-		set_base_registers(&card->channels[0],card->dmapages);
-
-	mixer_push_state(card);
-
-	/* set each channels' apu control registers before
-	 * restoring audio
-	 */
-	for(i=0;i<NR_DSPS;i++) {
-		struct ess_state *s = &card->channels[i];
-		int chan,reg;
-
-		if(s->dev_audio == -1)
-			continue;
-
-		for(chan = 0 ; chan < 6 ; chan++) {
-			wave_set_register(s,s->apu[chan]<<3,s->apu_base[chan]);
-			for(reg = 1 ; reg < NR_APU_REGS ; reg++)
-				apu_set_register(s,chan,reg,s->card->apu_map[s->apu[chan]][reg]);
-		}
-		for(chan = 0 ; chan < 6 ; chan++)
-			apu_set_register(s,chan,0,s->card->apu_map[s->apu[chan]][0] & 0xFF0F);
-	}
-
-	/* now we flip on the music */
-
-	if( card->dsps_open <= 0) {
-		/* this card's idle */
-		maestro_power(card,ACPI_D2);
-	} else {
-		/* ok, we're actually playing things on
-			this card */
-		maestro_power(card,ACPI_D0);
-		start_bob(&card->channels[0]);
-		for(i=0;i<NR_DSPS;i++) {
-			struct ess_state *s = &card->channels[i];
-
-			/* these use the apu_mode, and can handle
-				spurious calls */
-			start_dac(s);
-			start_adc(s);
-		}
-	}
-
-	spin_unlock_irqrestore(&card->lock,flags);
-
-	/* all right, we think things are ready,
-		wake up people who were using the device
-		when we suspended */
-	wake_up(&(card->suspend_queue));
-
-	return 0;
-}
-
-int
-maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
-{
-	struct ess_card *card = (struct ess_card*) dev->data;
-
-	if ( ! card ) goto out;
-
-	M_printk("maestro: pm event 0x%x received for card %p\n", rqst, card);
-
-	switch (rqst) {
-		case PM_SUSPEND:
-			maestro_suspend(card);
-		break;
-		case PM_RESUME:
-			maestro_resume(card);
-		break;
-		/*
-		 * we'd also like to find out about
-		 * power level changes because some biosen
-		 * do mean things to the maestro when they
-		 * change their power state.
-		 */
-        }
-out:
-	return 0;
-}
-
 module_init(init_maestro);
 module_exit(cleanup_maestro);
