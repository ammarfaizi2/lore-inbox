Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129977AbQKVCyO>; Tue, 21 Nov 2000 21:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131008AbQKVCyE>; Tue, 21 Nov 2000 21:54:04 -0500
Received: from [209.249.10.20] ([209.249.10.20]:4574 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S129977AbQKVCx6>;
	Tue, 21 Nov 2000 21:53:58 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Tue, 21 Nov 2000 18:23:47 -0800
Message-Id: <200011220223.SAA00416@baldur.yggdrasil.com>
To: jgarzik@mandrakesoft.com
Subject: Re: Patch: linux-2.4.0-test11/drivers/sound/maestro.c port to new PCI interface
Cc: linux-kernel@vger.kernel.org, zab@zabbo.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik critiqued my patch for linux-2.4.0-test11/drivers/sound/maestro.c:
>[...]  if the intention
>was to serialize access to the mixer, there are surely better ways to do
>it.  Why are interrupts disabled?

	As far as I can tell, I agree with you, but I do not think
that is related to the move to the new PCI interface.

	I also agree that the ioctl patch is kind of a bandaid over
the problems that you described, and, while Zach Brown can speak
for himself, let me take a bit of responsibility for nagging Zach
to make a release anyhow, on the grounds that (1) Zach is already
planning a rewrite to a new interface that I understand that you
and a number of other kernel people are working on, so we are
reasonably assured that this bandaid will not make the underlying
problem permanent, and (2) it is an incremental improvement over
the status quo.

	That said, I am willing to help try to clean up the
locking code in maestro if Zach thinks it is worth doing right
now, since I have a notebook computer with a maestro chip in
it, and I normally run an SMP-capable kernel on it (so as run
the same kernel everywhere).

>In any case it will probably change
>when maestro goes ac97_codec (tested patches in gkernel CVS)... which it
>needs to do <nudge nudge> ;-)

	Yes, that is why I think a bandaid in this case will not
become a crutch (if you'll pardon the mixed metaphor).


>This driver needs __devxxx, I've heard mention of some hotpluggable
>audio that is based on the maestro chipset (which chip I don't remember)

	I thought I had fixed that, but, upon closer inspection I
see a routine that needed __dev, and found a couple others that
could have it too.  I have attached an updated patch below.

>The formatting of pci_device_id data is awful.  Named initializers
>-reduce- the readability of the code here, are highly redundant, and its
>usage is totally inconsistent with -all- other PCI drivers in the
>kernel.

	We have been discussing this in direct email.  Perhaps we
need to bring it to this wider forum.

	I agree that named initializers can be redundant when
all of the matches have the same format, which is usually the
case for PCI drivers.  However, I think the following advantages
of named initializers outweigh that disadvantage:

	1. Most importantly, named initializers make it much easier
	   to extend the pci_device_id structure, such as adding
	   a "priority" field to prefer some matches (say, a vendor
	   specific match for a USB controller) over others, or to
	   add a "match" field to control ID matching when a value
	   was 0xFFFF, so that we could shrink {,sub}{vendor,device}
	   from longs to shorts if the number of PCI ID's that
	   we need to care about grows enormously.  I am not advocating
	   these specific changes, but just using these examples to
	   show that there is enough of a probability that we may
	   want to make such a change in the future that we should
	   not adopt a convention that will require changing the
	   127 files in linux-2.4.0-test11/drivers/ that use
	   pci_find* and do not yet have a MODULE_DEVICE_TABLE.
	   
	 2. I subjectively find named initializers in this case 
	    more readable and less error prone.  Without them, I almost
	    always have to bring up a copy of include/linux/pci.h to
	    see which fields exactly are being matched and which are being
	    wildcarded.

	 3. The seventeen net drivers and four sound drivers that I have
	    generated MODULE_DEVICE_TABLE's for use named initializers.
	    The way that my maestro.c patch's use of named initializers
	    is "totally inconsistent with -all- other PCI drivers" is
	    that, per your previous email, you are converting my changes
	    to the less maintainable form.

	 4. The use of named initializers in other driver structures,
	    where essentially the same arguments apply, seems to be
	    the trend in Linus's kernels.  So, in the larger picture,
	    you are the one advocating inconsistency.


	I am still open to being rationally convinced that not using
named initializers is better.

	I am also willing to produce what I regard as the less maintainable
version if I believe that that will really make the difference as to
whether MODULE_DEVICE_TABLE support (and, in some cases, new style PCI
support) for these drivers gets into the stock kernels or not.  I
recognize that people are better off with pci_device_id's done your
way than with no pci_device_id's.  If Linus Torvalds or Alan Cox would
tell me that that is how they want it, then that would convince me
that that is the political situation.  I am also guaging this from
whether whether the drivers/net changes that I sent to you for
shepherding into Linus's kernel actually get incorporated (presumably
with your changes the pci_device_id table format, which we are arguing
about).  Finally, if driver maintainer specifically insists one format
or the other, I am happy to accomodate for that driver, again, because
I think that will make it more likely that this facility will get into
Linus's released and will achieve full ubiquity.

	Let me also say that I appreciate the effort that you (Jeff) put
into critiquing my patches and those of others and your quick
responsiveness.  I try to quickly implement your requests that I do
not have a problem with, and I think that higher quality has resulted
from your input.  I also keep in mind that we are arguing about how to
achieve the same goal (make the best patches).


>To make Zab's life a little easier, use pci_{get,set}_drvdata to make it
>easier to port the code back to 2.2.x.  Since pci_dev::driver_data
>doesn't exist on 2.2.x, you have to ugly up the code with ifdefs, or use
>a compatibility macro (like, say, pci_xxx_drvdata.. :))

	Thanks for the tip.  I have done this in the patch attached.

>Unrelated to your change:  the maestro reboot notifier shouldn't need to
>unregister all that stuff.  Who cares if the sound devices are freed,
>since we are rebooting.  free_irq+maestro_power seems sufficient.  or
>maybe stop_dma+free_irq+poweroff.

	I think the idea here is to avoid having to maintain
a data structure to keep track of all of the PCI cards when the
PCI subsystem already does this.

>Unrelated to your change:  Feel free to submit patches to update
>Documentation/pci.txt if you feel it is missing information.

	Thanks for that suggestion.  Documentation/pci.txt does not
give examples one way or the the other on initializing the
pci_device_id table.  I would be happy to submit an example using
named fields, but preferably not in a way that would be taken as flame
war tactic.

	I guess at some point I would also like to change
Documentation/pci.txt to recommend that all PCI drivers be hotplug
drivers when feasible so as to support "hot" docking stations
(regardless of whether the core PCI Linux code supports this yet),
pluggable bridges, and possible future versions of the device, since
any device with the same core logic is allowed to have the same PCI
device ID and vendor ID.

       Anyhow, here is the maestro.c patch, version 1.2.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

---------------------------------CUT HERE---------------------------------

--- linux-2.4.0-test11/drivers/sound/maestro.c	Sat Nov 11 18:33:13 2000
+++ linux/drivers/sound/maestro.c	Tue Nov 21 16:15:17 2000
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
@@ -814,7 +858,7 @@
  *	The PT101 setup is untested.
  */
  
-static u16 __init maestro_ac97_init(struct ess_card *card)
+static u16 __devinit maestro_ac97_init(struct ess_card *card)
 {
 	u16 vend1, vend2, caps;
 
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
@@ -3261,7 +3306,7 @@
 /* this guy tries to find the pci power management
  * register bank.  this should really be in core
  * code somewhere.  1 on success. */
-int
+static int __devinit
 parse_power(struct ess_card *card, struct pci_dev *pcidev)
 {
 	u32 n;
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
+	pci_set_drvdata(pcidev, card);
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
+	struct ess_card *card = pci_get_drvdata(pdev);
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
+	struct ess_card *card = pci_get_drvdata(pcidev);
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
+	struct ess_card *card = pci_get_drvdata(pcidev);
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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
