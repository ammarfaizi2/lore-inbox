Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130095AbQKUXdR>; Tue, 21 Nov 2000 18:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130510AbQKUXdI>; Tue, 21 Nov 2000 18:33:08 -0500
Received: from freya.yggdrasil.com ([209.249.10.20]:12239 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S130095AbQKUXcz>; Tue, 21 Nov 2000 18:32:55 -0500
Date: Tue, 21 Nov 2000 15:02:46 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: jgarzik@mandrakesoft.com, zab@zabbo.net
Subject: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI interface
Message-ID: <20001121150246.A5608@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Here is a patch which ports drivers/sound/maestro.c to the new PCI
interface, which Zach Brown asked me to post here for comments.
This patch includes Zach's changes eliminating the ioctl lockups which
he posted separately, just to make it easier to generate the final
product from pristine 2.4.0-test11.  I could actually divide this
patch into three phases if need be:
	(a) The ioctl lockup fix which Zach has already submitted for
	    (presumably) the next "-pre" release.
	(b) The pci_device_id table declaration and MODULE_DEVICE_TABLE.
	(c) Moving to the new PCI interface.  If I were to conform to
	    Jeff Garzick's requests on __initdata and __devinitdata, this would
	    include changes that would change an __initdata delcaration in
	    (b) to __devinitdata.

At this point, my preference would be to see (a) in test12-pre1, and
(b) or (b)+(c) in test12-pre2; however, I do not feel strongly about it.

Anyhow, I am sure any feedback would be appreciated.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="maestro.c.diffs"

--- linux-2.4.0-test11/drivers/sound/maestro.c	Sat Nov 11 18:33:13 2000
+++ linux/drivers/sound/maestro.c	Wed Nov 15 22:25:42 2000
@@ -243,7 +243,6 @@
 #include <linux/bitops.h>
 
 #include <linux/pm.h>
-static int maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *d);
 
 #include "maestro.h"
 
@@ -355,6 +354,51 @@
 	TYPE_MAESTRO2E
 };
 
+static struct pci_device_id maestro_pci_ids[] __devinitdata = {
+	{
+	  vendor: PCI_VENDOR_ESS,
+	  device: PCI_DEVICE_ID_ESS_ESS1968,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  driver_data: TYPE_MAESTRO2
+	},
+	{
+	  vendor: PCI_VENDOR_ESS,
+	  device: PCI_DEVICE_ID_ESS_ESS1978,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  driver_data: TYPE_MAESTRO2E
+	},
+	{
+	  vendor: PCI_VENDOR_ESS_OLD,
+	  device: PCI_DEVICE_ID_ESS_ESS0100,
+	  subvendor: PCI_ANY_ID,
+	  subdevice: PCI_ANY_ID,
+	  driver_data: TYPE_MAESTRO
+	},
+	{ }			/* Terminating entry */
+};
+
+MODULE_DEVICE_TABLE(pci, maestro_pci_ids);
+
+static int __devinit maestro_probe(struct pci_dev *pcidev,
+				   const struct pci_device_id *id);
+static void __devexit maestro_remove(struct pci_dev *pdev);
+static void maestro_suspend(struct pci_dev *pcidev);
+static void maestro_resume(struct pci_dev *pcidev);
+
+static struct pci_driver maestro_driver = {
+	name:		"maestro",
+	id_table:	maestro_pci_ids,
+	probe:		maestro_probe,
+	remove:		maestro_remove,
+#ifdef	CONFIG_PM
+	suspend:	maestro_suspend,
+	resume:		maestro_resume,
+#endif	/* PM */
+};
+
+
 static const char *card_names[]={
 	[TYPE_MAESTRO] = "ESS Maestro",
 	[TYPE_MAESTRO2] = "ESS Maestro 2",
@@ -1958,6 +2002,7 @@
 static int mixer_ioctl(struct ess_card *card, unsigned int cmd, unsigned long arg)
 {
 	int i, val=0;
+	unsigned long flags;
 
 	VALIDATE_CARD(card);
         if (cmd == SOUND_MIXER_INFO) {
@@ -1990,9 +2035,9 @@
 			if(!card->mix.recmask_io) {
 				val = 0;
 			} else {
-				spin_lock(&card->lock);
+				spin_lock_irqsave(&card->lock, flags);
 				val = card->mix.recmask_io(card,1,0);
-				spin_unlock(&card->lock);
+				spin_unlock_irqrestore(&card->lock, flags);
 			}
 			break;
 			
@@ -2019,9 +2064,9 @@
 				return -EINVAL;
 
 			/* do we ever want to touch the hardware? */
-/*			spin_lock(&card->lock);
+/*			spin_lock_irqsave(&card->lock, flags);
 			val = card->mix.read_mixer(card,i);
-			spin_unlock(&card->lock);*/
+			spin_unlock_irqrestore(&card->lock, flags);*/
 
 			val = card->mix.mixer_state[i];
 /*			M_printk("returned 0x%x for mixer %d\n",val,i);*/
@@ -2046,9 +2091,9 @@
 		if(!val) return 0;
 		if(! (val &= card->mix.record_sources)) return -EINVAL;
 
-		spin_lock(&card->lock);
+		spin_lock_irqsave(&card->lock, flags);
 		card->mix.recmask_io(card,0,val);
-		spin_unlock(&card->lock);
+		spin_unlock_irqrestore(&card->lock, flags);
 		return 0;
 
 	default:
@@ -2057,9 +2102,9 @@
 		if ( ! supported_mixer(card,i)) 
 			return -EINVAL;
 
-		spin_lock(&card->lock);
+		spin_lock_irqsave(&card->lock, flags);
 		set_mixer(card,i,val);
-		spin_unlock(&card->lock);
+		spin_unlock_irqrestore(&card->lock, flags);
 
 		return 0;
 	}
@@ -3292,15 +3337,15 @@
 	return card->power_regs ? 1 : 0;
 }
 
-static int __init
-maestro_install(struct pci_dev *pcidev, int card_type)
+static int __devinit
+maestro_probe(struct pci_dev *pcidev, const struct pci_device_id *id)
 {
+	const int card_type = id->driver_data;
 	u32 n;
 	int iobase;
 	int i;
 	struct ess_card *card;
 	struct ess_state *ess;
-	struct pm_dev *pmdev;
 	int num = 0;
 
 	/* don't pick up weird modem maestros */
@@ -3334,11 +3379,6 @@
 	memset(card, 0, sizeof(*card));
 	card->pcidev = pcidev;
 
-	pmdev = pm_register(PM_PCI_DEV, PM_PCI_ID(pcidev),
-			maestro_pm_callback);
-	if (pmdev)
-		pmdev->data = card;
-
 	if (register_reboot_notifier(&maestro_nb)) {
 		printk(KERN_WARNING "maestro: reboot notifier registration failed; may not reboot properly.\n");
 	}
@@ -3350,6 +3390,7 @@
 	card->magic = ESS_CARD_MAGIC;
 	spin_lock_init(&card->lock);
 	init_waitqueue_head(&card->suspend_queue);
+	pcidev->driver_data = card;
 	devs = card;
 	
 	/* init our groups of 6 apus */
@@ -3465,15 +3506,8 @@
 
 int __init init_maestro(void)
 {
-	struct pci_dev *pcidev = NULL;
-	int foundone = 0;
-
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
 	printk(KERN_INFO "maestro: version " DRIVER_VERSION " time " __TIME__ " " __DATE__ "\n");
 
-	pcidev = NULL;
-
 	if (dsps_order < 0)   {
 		dsps_order = 1;
 		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
@@ -3483,74 +3517,43 @@
 		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
 	}
 
-	/*
-	 *	Find the ESS Maestro 2.
-	 */
-
-	while( (pcidev = pci_find_device(PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1968, pcidev))!=NULL ) {
-		if (maestro_install(pcidev, TYPE_MAESTRO2))
-			foundone=1;
-	}
-
-	/*
-	 *	Find the ESS Maestro 2E
-	 */
-
-	while( (pcidev = pci_find_device(PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1978, pcidev))!=NULL) {
-		if (maestro_install(pcidev, TYPE_MAESTRO2E))
-			foundone=1;
-	}
-
-	/*
-	 *	ESS Maestro 1
-	 */
-
-	while((pcidev = pci_find_device(PCI_VENDOR_ESS_OLD, PCI_DEVICE_ID_ESS_ESS0100, pcidev))!=NULL) {
-		if (maestro_install(pcidev, TYPE_MAESTRO))
-			foundone=1;
-	}
-	if( ! foundone ) {
-		printk("maestro: no devices found.\n");
-		return -ENODEV;
-	}
-	return 0;
+	return pci_module_init(&maestro_driver);
 }
 
-static void nuke_maestros(void)
+static void __devexit
+maestro_remove(struct pci_dev *pdev)
 {
-	struct ess_card *card;
-
-	/* we do these unconditionally, which is probably wrong */
-	pm_unregister_all(maestro_pm_callback);
-	unregister_reboot_notifier(&maestro_nb);
+	struct ess_card *card = pdev->driver_data;
+	struct ess_card **pCard;
+	int i;
 
-	while ((card = devs)) {
-		int i;
-		devs = devs->next;
-	
-		/* XXX maybe should force stop bob, but should be all 
-			stopped by _release by now */
-		free_irq(card->irq, card);
-		unregister_sound_mixer(card->dev_mixer);
-		for(i=0;i<NR_DSPS;i++)
-		{
-			struct ess_state *ess = &card->channels[i];
-			if(ess->dev_audio != -1)
-				unregister_sound_dsp(ess->dev_audio);
-		}
-		/* Goodbye, Mr. Bond. */
-		maestro_power(card,ACPI_D3);
-		release_region(card->iobase, 256);
-		kfree(card);
-	}
-	devs = NULL;
+	/* Remove this card from the list. */
+	for (pCard = &devs; *pCard != NULL && *pCard != card;
+	     pCard = &(*pCard)->next)
+		;
+	*pCard = (*pCard)->next;
+
+	/* XXX maybe should force stop bob, but should be all 
+	   stopped by _release by now */
+	free_irq(card->irq, card);
+	unregister_sound_mixer(card->dev_mixer);
+	for(i=0;i<NR_DSPS;i++)
+	{
+		struct ess_state *ess = &card->channels[i];
+		if(ess->dev_audio != -1)
+			unregister_sound_dsp(ess->dev_audio);
+	}
+	/* Goodbye, Mr. Bond. */
+	maestro_power(card,ACPI_D3);
+	release_region(card->iobase, 256);
+	kfree(card);
 }
 
 static int maestro_notifier(struct notifier_block *nb, unsigned long event, void *buf)
 {
 	/* this notifier is called when the kernel is really shut down. */
 	M_printk("maestro: shutting down\n");
-	nuke_maestros();
+	pci_unregister_driver (&maestro_driver);
 	return NOTIFY_OK;
 }
 
@@ -3564,12 +3567,6 @@
 #endif
 MODULE_PARM(dsps_order,"i");
 MODULE_PARM(use_pm,"i");
-
-void cleanup_module(void) {
-	M_printk("maestro: unloading\n");
-	nuke_maestros();
-}
-
 #endif
 
 /* --------------------------------------------------------------------- */
@@ -3589,9 +3586,10 @@
 	current->state = TASK_RUNNING;
 }
 
-static int 
-maestro_suspend(struct ess_card *card)
+static void
+maestro_suspend(struct pci_dev *pcidev)
 {
+	struct ess_card *card = pcidev->driver_data;
 	unsigned long flags;
 	int i,j;
 
@@ -3630,11 +3628,12 @@
 	 * XXX I'm also not sure that in_suspend will protect
 	 * against all reg accesses from here on out. 
 	 */
-	return 0;
 }
-static int 
-maestro_resume(struct ess_card *card)
+
+static void
+maestro_resume(struct pci_dev *pcidev)
 {
+	struct ess_card *card = pcidev->driver_data;
 	unsigned long flags;
 	int i;
 
@@ -3698,35 +3697,14 @@
 		wake up people who were using the device
 		when we suspended */
 	wake_up(&(card->suspend_queue));
-
-	return 0;
 }
 
-int 
-maestro_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data) 
+static void __exit exit_maestro (void)
 {
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
+	/* we do these unconditionally, which is probably wrong */
+	unregister_reboot_notifier(&maestro_nb);
+	pci_unregister_driver (&maestro_driver);
 }
 
 module_init(init_maestro);
+module_exit(exit_maestro);

--ZGiS0Q5IWpPtfppv--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
