Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262390AbREUVXh>; Mon, 21 May 2001 17:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262492AbREUVX2>; Mon, 21 May 2001 17:23:28 -0400
Received: from ns.caldera.de ([212.34.180.1]:9119 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262390AbREUVXV>;
	Mon, 21 May 2001 17:23:21 -0400
Date: Mon, 21 May 2001 23:23:06 +0200
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: Francois Romieu <romieu@cogenit.fr>
Cc: Marcus Meissner <Marcus.Meissner@caldera.de>, linux-kernel@vger.kernel.org,
        zab@zabbo.net, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: maestro ported to 2.4 PCI API
Message-ID: <20010521232306.A13673@caldera.de>
In-Reply-To: <20010521173707.A10692@caldera.de> <20010521190545.A3522@se1.cogenit.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010521190545.A3522@se1.cogenit.fr>; from romieu@cogenit.fr on Mon, May 21, 2001 at 07:05:45PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -3406,7 +3429,7 @@
> >  	if(card == NULL)
> >  	{
> >  		printk(KERN_WARNING "maestro: out of memory\n");
> > -		return 0;
> > +		return -ENOMEM;
> 
> request_region is unbalanced in this return path.

Thanks! 

Fixed patch below.

Ciao, Marcus

Index: drivers/sound/maestro.c
===================================================================
RCS file: /build/mm/work/repository/linux-mm/drivers/sound/maestro.c,v
retrieving revision 1.7
diff -u -r1.7 maestro.c
--- drivers/sound/maestro.c	2001/05/18 08:06:38	1.7
+++ drivers/sound/maestro.c	2001/05/21 21:06:55
@@ -115,6 +115,10 @@
  *	themselves, but we'll see.  
  *	
  * History
+ *  v0.15 - May 21 2001 - Marcus Meissner <mm@caldera.de>
+ *      Ported to Linux 2.4 PCI API. Some clean ups, global devs list
+ *      removed (now using pci device driver data).
+ *      PM needs to be polished still. Bumped version.
  *  (still kind of v0.14) May 13 2001 - Ben Pfaff <pfaffben@msu.edu>
  *      Add support for 978 docking and basic hardware volume control
  *  (still kind of v0.14) Nov 23 - Alan Cox <alan@redhat.com>
@@ -206,28 +210,6 @@
 #include <linux/sched.h>
 #include <linux/smp_lock.h>
 #include <linux/wrapper.h>
-
-#if LINUX_VERSION_CODE < KERNEL_VERSION(2,3,0)
-
- #define DECLARE_WAITQUEUE(QUEUE,INIT) struct wait_queue QUEUE = {INIT, NULL}
- #define wait_queue_head_t struct wait_queue *
- #define SILLY_PCI_BASE_ADDRESS(PCIDEV) (PCIDEV->base_address[0] & PCI_BASE_ADDRESS_IO_MASK)
- #define SILLY_INIT_SEM(SEM) SEM=MUTEX;
- #define init_waitqueue_head init_waitqueue
- #define SILLY_MAKE_INIT(FUNC) __initfunc(FUNC)
- #define SILLY_OFFSET(VMA) ((VMA)->vm_offset)
-
-
-#else
-
- #define SILLY_PCI_BASE_ADDRESS(PCIDEV) (PCIDEV->resource[0].start)
- #define SILLY_INIT_SEM(SEM) init_MUTEX(&SEM)
- #define SILLY_MAKE_INIT(FUNC) __init FUNC
- #define SILLY_OFFSET(VMA) ((VMA)->vm_pgoff)
-
-
-#endif
-
 #include <linux/string.h>
 #include <linux/ctype.h>
 #include <linux/ioport.h>
@@ -251,6 +233,8 @@
 
 #include "maestro.h"
 
+static struct pci_driver maestro_pci_driver;
+
 /* --------------------------------------------------------------------- */
 
 #define M_DEBUG 1
@@ -271,8 +255,17 @@
 	
 static int clocking=48000;
 
+MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Alan Cox <alan@redhat.com>");
+MODULE_DESCRIPTION("ESS Maestro Driver");
+#ifdef M_DEBUG
+MODULE_PARM(debug,"i");
+#endif
+MODULE_PARM(dsps_order,"i");
+MODULE_PARM(use_pm,"i");
+MODULE_PARM(clocking, "i");
+
 /* --------------------------------------------------------------------- */
-#define DRIVER_VERSION "0.14"
+#define DRIVER_VERSION "0.15"
 
 #ifndef PCI_VENDOR_ESS
 #define PCI_VENDOR_ESS			0x125D
@@ -354,6 +347,11 @@
 	[ACPI_D3] = ACPI_NONE
 };
 
+static char version[] __devinitdata =
+KERN_INFO "maestro: version " DRIVER_VERSION " time " __TIME__ " " __DATE__ "\n";
+
+
+
 static const unsigned sample_size[] = { 1, 2, 2, 4 };
 static const unsigned sample_shift[] = { 0, 1, 1, 2 };
 
@@ -522,8 +520,6 @@
 
 static void check_suspend(struct ess_card *card);
 
-static struct ess_card *devs = NULL;
-
 /* --------------------------------------------------------------------- */
 
 
@@ -2133,17 +2129,25 @@
 }
 
 /* --------------------------------------------------------------------- */
-
 static int ess_open_mixdev(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
-	struct ess_card *card = devs;
-
-	while (card && card->dev_mixer != minor)
-		card = card->next;
+	struct ess_card *card = NULL;
+	struct pci_dev *pdev;
+	struct pci_driver *drvr;
+
+	pci_for_each_dev(pdev) {
+		drvr = pci_dev_driver (pdev);
+		if (drvr == &maestro_pci_driver) {
+			card = (struct ess_card*)pci_get_drvdata (pdev);
+			if (!card)
+				continue;
+			if (card->dev_mixer == minor)
+				break;
+		}
+	}
 	if (!card)
 		return -ENODEV;
-
 	file->private_data = card;
 	return 0;
 }
@@ -2505,7 +2509,7 @@
 #endif
 		goto out;
 	ret = -EINVAL;
-	if (SILLY_OFFSET(vma) != 0)
+	if (vma->vm_pgoff != 0)
 		goto out;
 	size = vma->vm_end - vma->vm_start;
 	if (size > (PAGE_SIZE << db->buforder))
@@ -2969,33 +2973,40 @@
 ess_open(struct inode *inode, struct file *file)
 {
 	int minor = MINOR(inode->i_rdev);
-	struct ess_card *c = devs;
-	struct ess_state *s = NULL, *sp;
-	int i;
+	struct ess_state *s = NULL;
 	unsigned char fmtm = ~0, fmts = 0;
-
+	struct pci_dev *pdev;
 	/*
 	 *	Scan the cards and find the channel. We only
 	 *	do this at open time so it is ok
 	 */
-	 
-	while (c!=NULL)
-	{
-		for(i=0;i<NR_DSPS;i++)
-		{
-			sp=&c->channels[i];
-			if(sp->dev_audio < 0)
-				continue;
-			if((sp->dev_audio ^ minor) & ~0xf)
+
+	pci_for_each_dev(pdev) {
+		struct ess_card *c;
+		struct pci_driver *drvr;
+
+		drvr = pci_dev_driver (pdev);
+		if (drvr == &maestro_pci_driver) {
+			int i;
+			struct ess_state *sp;
+
+			c = (struct ess_card*)pci_get_drvdata (pdev);
+			if (!c)
 				continue;
-			s=sp;
+			for(i=0;i<NR_DSPS;i++)
+			{
+				sp=&c->channels[i];
+				if(sp->dev_audio < 0)
+					continue;
+				if((sp->dev_audio ^ minor) & ~0xf)
+					continue;
+				s=sp;
+			}
 		}
-		c=c->next;
 	}
-		
 	if (!s)
 		return -ENODEV;
-		
+
        	VALIDATE_STATE(s);
 	file->private_data = s;
 	/* wait for device to become free */
@@ -3371,32 +3382,44 @@
 }
 
 static int __init
-maestro_install(struct pci_dev *pcidev, int card_type)
+maestro_probe(struct pci_dev *pcidev,const struct pci_device_id *pdid)
 {
+	int card_type = pdid->driver_data;
 	u32 n;
 	int iobase;
-	int i;
+	int i, ret;
 	struct ess_card *card;
 	struct ess_state *ess;
 	struct pm_dev *pmdev;
 	int num = 0;
 
+/* when built into the kernel, we only print version if device is found */
+#ifndef MODULE
+	static int printed_version;
+	if (!printed_version++)
+		printk(version);
+#endif
+
 	/* don't pick up weird modem maestros */
 	if(((pcidev->class >> 8) & 0xffff) != PCI_CLASS_MULTIMEDIA_AUDIO)
-		return 0;
+		return -ENODEV;
+
+
+	if ((ret=pci_enable_device(pcidev)))
+		return ret;
 			
-	iobase = SILLY_PCI_BASE_ADDRESS(pcidev); 
+	iobase = pci_resource_start(pcidev,0);
+	if (!iobase || !(pci_resource_flags(pcidev, 0 ) & IORESOURCE_IO))
+		return -ENODEV;
+
+	if(pcidev->irq == 0)
+		return -ENODEV;
 
 	/* stake our claim on the iospace */
 	if( request_region(iobase, 256, card_names[card_type]) == NULL )
 	{
 		printk(KERN_WARNING "maestro: can't allocate 256 bytes I/O at 0x%4.4x\n", iobase);
-		return 0;
-	}
-
-	/* this was tripping up some machines */
-	if(pcidev->irq == 0) {
-		printk(KERN_WARNING "maestro: pci subsystem reports irq 0, this might not be correct.\n");
+		return -EBUSY;
 	}
 
 	/* just to be sure */
@@ -3406,7 +3429,8 @@
 	if(card == NULL)
 	{
 		printk(KERN_WARNING "maestro: out of memory\n");
-		return 0;
+		release_region(iobase, 256);
+		return -ENOMEM;
 	}
 	
 	memset(card, 0, sizeof(*card));
@@ -3417,18 +3441,12 @@
 	if (pmdev)
 		pmdev->data = card;
 
-	if (register_reboot_notifier(&maestro_nb)) {
-		printk(KERN_WARNING "maestro: reboot notifier registration failed; may not reboot properly.\n");
-	}
-
 	card->iobase = iobase;
 	card->card_type = card_type;
 	card->irq = pcidev->irq;
-	card->next = devs;
 	card->magic = ESS_CARD_MAGIC;
 	spin_lock_init(&card->lock);
 	init_waitqueue_head(&card->suspend_queue);
-	devs = card;
 
 	card->dock_mute_vol = 50;
 	
@@ -3444,7 +3462,7 @@
 		init_waitqueue_head(&s->dma_dac.wait);
 		init_waitqueue_head(&s->open_wait);
 		spin_lock_init(&s->lock);
-		SILLY_INIT_SEM(s->open_sem);
+		init_MUTEX(&s->open_sem);
 		s->magic = ESS_STATE_MAGIC;
 		
 		s->apu[0] = 6*i;
@@ -3472,19 +3490,6 @@
 	
 	ess = &card->channels[0];
 
-	if (pci_enable_device(pcidev)) {
-		printk (KERN_ERR "maestro: pci_enable_device() failed\n");
-		for (i = 0; i < NR_DSPS; i++) {
-			struct ess_state *s = &card->channels[i];
-			if (s->dev_audio != -1)
-				unregister_sound_dsp(s->dev_audio);
-		}
-		release_region(card->iobase, 256);
-		unregister_reboot_notifier(&maestro_nb);
-		kfree(card);
-		return 0;
-	}
-
 	/*
 	 *	Ok card ready. Begin setup proper
 	 */
@@ -3534,7 +3539,7 @@
 		mixer_push_state(card);
 	}
 	
-	if(request_irq(card->irq, ess_interrupt, SA_SHIRQ, card_names[card_type], card))
+	if((ret=request_irq(card->irq, ess_interrupt, SA_SHIRQ, card_names[card_type], card)))
 	{
 		printk(KERN_ERR "maestro: unable to allocate irq %d,\n", card->irq);
 		unregister_sound_mixer(card->dev_mixer);
@@ -3547,26 +3552,61 @@
 		release_region(card->iobase, 256);		
 		unregister_reboot_notifier(&maestro_nb);
 		kfree(card);
-		return 0;
+		return ret;
 	}
+	pci_set_drvdata(pcidev,card);
 	/* now go to sleep 'till something interesting happens */
 	maestro_power(card,ACPI_D2);
 
 	printk(KERN_INFO "maestro: %d channels configured.\n", num);
-	return 1; 
+	return 0; 
 }
 
-int __init init_maestro(void)
-{
-	struct pci_dev *pcidev = NULL;
-	int foundone = 0;
+static void maestro_remove(struct pci_dev *pcidev) {
+	struct ess_card *card = pci_get_drvdata(pcidev);
+	int i;
+	
+	/* XXX maybe should force stop bob, but should be all 
+		stopped by _release by now */
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
+	pci_set_drvdata(pcidev,NULL);
+}
+
+static struct pci_device_id maestro_pci_tbl[] __devinitdata = {
+	{PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1968, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO2},
+	{PCI_VENDOR_ESS, PCI_DEVICE_ID_ESS_ESS1978, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO2E},
+	{PCI_VENDOR_ESS_OLD, PCI_DEVICE_ID_ESS_ESS0100, PCI_ANY_ID, PCI_ANY_ID, 0, 0, TYPE_MAESTRO},
+	{0,}
+};
+MODULE_DEVICE_TABLE(pci, maestro_pci_tbl);
 
-	if (!pci_present())   /* No PCI bus in this machine! */
-		return -ENODEV;
-	printk(KERN_INFO "maestro: version " DRIVER_VERSION " time " __TIME__ " " __DATE__ "\n");
+static struct pci_driver maestro_pci_driver = {
+	name:"maestro",
+	id_table:maestro_pci_tbl,
+	probe:maestro_probe,
+	remove:maestro_remove,
+};
 
-	pcidev = NULL;
+int __init init_maestro(void)
+{
+	pci_module_init(&maestro_pci_driver);
 
+	if (register_reboot_notifier(&maestro_nb))
+		printk(KERN_WARNING "maestro: reboot notifier registration failed; may not reboot properly.\n");
+#ifdef MODULE
+	printk(version);
+#endif
 	if (dsps_order < 0)   {
 		dsps_order = 1;
 		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
@@ -3575,97 +3615,29 @@
 		dsps_order = MAX_DSP_ORDER;
 		printk(KERN_WARNING "maestro: clipping dsps_order to %d\n",dsps_order);
 	}
-
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
 	return 0;
 }
 
-static void nuke_maestros(void)
-{
-	struct ess_card *card;
-
-	/* we do these unconditionally, which is probably wrong */
-	pm_unregister_all(maestro_pm_callback);
-	unregister_reboot_notifier(&maestro_nb);
-
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
-}
-
 static int maestro_notifier(struct notifier_block *nb, unsigned long event, void *buf)
 {
 	/* this notifier is called when the kernel is really shut down. */
 	M_printk("maestro: shutting down\n");
-	nuke_maestros();
+	/* this will remove all card instances too */
+	pci_unregister_driver(&maestro_pci_driver);
+	/* XXX dunno about power management */
 	return NOTIFY_OK;
 }
 
 /* --------------------------------------------------------------------- */
 
-#ifdef MODULE
-MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Alan Cox <alan@redhat.com>");
-MODULE_DESCRIPTION("ESS Maestro Driver");
-#ifdef M_DEBUG
-MODULE_PARM(debug,"i");
-#endif
-MODULE_PARM(dsps_order,"i");
-MODULE_PARM(use_pm,"i");
-MODULE_PARM(clocking, "i");
 
-void cleanup_module(void) {
+void cleanup_maestro(void) {
 	M_printk("maestro: unloading\n");
-	nuke_maestros();
+	pci_unregister_driver(&maestro_pci_driver);
+	pm_unregister_all(maestro_pm_callback);
+	unregister_reboot_notifier(&maestro_nb);
 }
 
-#endif
-
 /* --------------------------------------------------------------------- */
 
 void
@@ -3824,3 +3796,4 @@
 }
 
 module_init(init_maestro);
+module_exit(cleanup_maestro);
