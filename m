Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbTFGBix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 21:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbTFGBix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 21:38:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:54797 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262465AbTFGBie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 21:38:34 -0400
Date: Sat, 7 Jun 2003 03:42:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.70bk - drivers/net/sk98lin/skge.c to pci style init
Message-ID: <20030607034202.A23704@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Organisation: Hungry patch-scripts (c) users
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

- PCI API init style conversion for drivers/net/sk98lin/skge.c;
- new helpers: SkGeDev{Init/CleanUp};
- sk_devs_lock moved around as it's needed early.

Please review carefully.

 drivers/net/sk98lin/skge.c |  599 +++++++++++++++++++++------------------------
 1 files changed, 292 insertions(+), 307 deletions(-)

diff -puN drivers/net/sk98lin/skge.c~drivers-sk98-pci-style-init drivers/net/sk98lin/skge.c
--- linux-2.5.70-1.1229.8.33-to-1.1316/drivers/net/sk98lin/skge.c~drivers-sk98-pci-style-init	Sat Jun  7 03:14:32 2003
+++ linux-2.5.70-1.1229.8.33-to-1.1316-fr/drivers/net/sk98lin/skge.c	Sat Jun  7 03:14:32 2003
@@ -48,6 +48,9 @@
  * History:
  *
  *	$Log: skge.c,v $
+ *	Revision x.xx.x.x  2003/06/07 02:31:17  romieu@fr.zoreil.com
+ *      pci api style init.
+ *
  *	Revision 1.29.2.6  2001/05/21 07:59:29  mlindner
  *	fix: MTU init problems
  *	
@@ -275,6 +278,10 @@
 #include	"h/skdrv2nd.h"
 
 /* defines ******************************************************************/
+
+#define DRV_MODULE_NAME		"sk98lin"
+#define PFX DRV_MODULE_NAME	": "
+
 /* for debuging on x86 only */
 /* #define BREAKPOINT() asm(" int $3"); */
 
@@ -361,9 +368,7 @@ static void	DumpLong(char*, int);
 
 
 /* global variables *********************************************************/
-static const char *BootString = BOOT_STRING;
-struct net_device *sk98lin_root_dev = NULL;
-static int probed __initdata = 0;
+static int boards_found;
 struct inode_operations SkInodeOps;
 //static struct file_operations SkFileOps;  /* with open/relase */
 
@@ -371,239 +376,219 @@ struct inode_operations SkInodeOps;
 static uintptr_t TxQueueAddr[SK_MAX_MACS][2] = {{0x680, 0x600},{0x780, 0x700}};
 static uintptr_t RxQueueAddr[SK_MAX_MACS] = {0x400, 0x480};
 
+spinlock_t sk_devs_lock = SPIN_LOCK_UNLOCKED;
+
+static int SkGeDevInit(struct net_device *dev)
+{
+	DEV_NET *pNet = dev->priv;
+	int ret = 0;
+
+	dev->open =		&SkGeOpen;
+	dev->stop =		&SkGeClose;
+	dev->hard_start_xmit =	&SkGeXmit;
+	dev->get_stats =	&SkGeStats;
+	dev->set_multicast_list = &SkGeSetRxMode;
+	dev->set_mac_address =	&SkGeSetMacAddr;
+	dev->do_ioctl =		&SkGeIoctl;
+	dev->change_mtu =	&SkGeChangeMtu;
+
+	if (register_netdev(dev) != 0) {
+		printk(KERN_ERR "Unable to register etherdev\n");
+		ret = -ENOMEM;
+		goto out;
+	}
+	pNet->proc = create_proc_entry(dev->name, S_IFREG | 0444, pSkRootDir);
+	if (pNet->proc) {
+		pNet->proc->data = dev;
+		pNet->proc->owner = THIS_MODULE;
+		pNet->proc->proc_fops = &sk_proc_fops;
+	}
+out:
+	return ret;
+}
+
+static void SkGeDevCleanUp(struct net_device *dev)
+{
+	DEV_NET *pNet = dev->priv;
+	
+	if (pNet->proc) {
+		spin_lock(&sk_devs_lock);
+		pNet->proc->data = NULL;
+		spin_unlock(&sk_devs_lock);
+		remove_proc_entry(dev->name, pSkRootDir);
+	}
+	unregister_netdev(dev);
+}
 
 /*****************************************************************************
  *
- * 	skge_probe - find all SK-98xx adapters
+ * 	skge_init_one - init a single instance of a SK-98xx adapter
  *
  * Description:
- *	This function scans the PCI bus for SK-98xx adapters. Resources for
- *	each adapter are allocated and the adapter is brought into Init 1
- *	state.
+ *	This function allocates resources for an SK-98xx adapter and brings
+ *	it into Init 1 state.
  *
  * Returns:
  *	0, if everything is ok
- *	!=0, on error
+ *	<0, on error
  */
-static int __init skge_probe (void)
+static int __devinit skge_init_one(struct pci_dev *pdev,
+				   const struct pci_device_id *ent)
 {
-	int			proc_root_initialized = 0;
-	int 		boards_found = 0;
-	int			version_disp = 0;
 	SK_AC		*pAC;
-	DEV_NET		*pNet = NULL;
-	struct 		pci_dev	*pdev = NULL;
-	unsigned long		base_address;
-	struct net_device *dev = NULL;
-
-	if (probed)
-		return -ENODEV;
-	probed++;
-	
-	/* display driver info */
-	if (!version_disp)
-	{
-		/* set display flag to TRUE so that */
-		/* we only display this string ONCE */
-		version_disp = 1;
-		printk("%s\n", BootString);
-	}
+	DEV_NET		*pNet;
+	unsigned long	base_address;
+	struct net_device *dev;
+	int ret;
+
+#ifndef MODULE
+	static int	version_disp = 0;
 
-	if (!pci_present())		/* is PCI support present? */
-		return -ENODEV;
+if (!version_disp++)
+		printk(KERN_INFO "%s\n", BOOT_STRING);
+#endif
+	ret = pci_enable_device(pdev);
+	if (ret)
+		goto out;
 
-	while((pdev = pci_find_device(PCI_VENDOR_ID_SYSKONNECT,
-				      PCI_DEVICE_ID_SYSKONNECT_GE, pdev)) != NULL) {
+	/* Configure DMA attributes. */
+	if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffff)) {
+		ret = pci_set_dma_mask(pdev, (u64) 0xffffffff);
+		if (ret) {
+			printk(KERN_ERR PFX "No usable DMA configuration\n");
+			goto out_disable;
+		}
+	}
 
-		pNet = NULL;
+	ret = -ENOMEM;
 
-		if (pci_enable_device(pdev))
-			continue;
+	dev = alloc_etherdev(sizeof(DEV_NET));
+	if (!dev) {
+		printk(KERN_ERR "Unable to allocate etherdev structure!\n");
+		goto out_disable;
+	}
 
-		/* Configure DMA attributes. */
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL) &&
-		    pci_set_dma_mask(pdev, (u64) 0xffffffff))
-				continue;
-
-		dev = alloc_etherdev(sizeof(DEV_NET));
-		if (!dev) {
-			printk(KERN_ERR "Unable to allocate etherdev "
-			       "structure!\n");
-			break;
-		}
+	pNet = dev->priv;
 
-		pNet = dev->priv;
-		pNet->pAC = kmalloc(sizeof(SK_AC), GFP_KERNEL);
-		if (pNet->pAC == NULL){
-			kfree(dev);
-			printk(KERN_ERR "Unable to allocate adapter "
-			       "structure!\n");
-			break;
-		}
+	pAC = kmalloc(sizeof(*pAC), GFP_KERNEL);
+	if (pAC == NULL){
+		printk(KERN_ERR "Unable to allocate adapter structure!\n");
+		goto out_free_dev;
+	}
 
-		memset(pNet->pAC, 0, sizeof(SK_AC));
-		pAC = pNet->pAC;
-		pAC->PciDev = *pdev;
-		pAC->PciDevId = pdev->device;
-		pAC->dev[0] = dev;
-		pAC->dev[1] = dev;
-		sprintf(pAC->Name, "SysKonnect SK-98xx");
-		pAC->CheckQueue = SK_FALSE;
+	memset(pAC, 0, sizeof(SK_AC));
+	pNet->pAC = pAC;
+	pAC->PciDev = *pdev;
+	pAC->PciDevId = pdev->device;
+	pAC->dev[0] = dev;
+	pAC->dev[1] = dev;
+	sprintf(pAC->Name, "SysKonnect SK-98xx");
+	pAC->CheckQueue = SK_FALSE;
 		
-		pNet->Mtu = 1500;
-		pNet->Up = 0;
-		dev->irq = pdev->irq;
+	pNet->Mtu = 1500;
+	pNet->Up = 0;
+	dev->irq = pdev->irq;
 
-		SET_MODULE_OWNER(dev);
-		SET_NETDEV_DEV(dev, &pdev->dev);
-		dev->open =		&SkGeOpen;
-		dev->stop =		&SkGeClose;
-		dev->hard_start_xmit =	&SkGeXmit;
-		dev->get_stats =	&SkGeStats;
-		dev->set_multicast_list = &SkGeSetRxMode;
-		dev->set_mac_address =	&SkGeSetMacAddr;
-		dev->do_ioctl =		&SkGeIoctl;
-		dev->change_mtu =	&SkGeChangeMtu;
-
-		if(!proc_root_initialized) {
-			pSkRootDir = create_proc_entry(SK_Root_Dir_entry,
-				S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO, proc_net);
-			pSkRootDir->owner = THIS_MODULE;
-			proc_root_initialized = 1;
-		}
+	SET_MODULE_OWNER(dev);
+	SET_NETDEV_DEV(dev, &pdev->dev);
+	ret = SkGeDevInit(dev);
+	if (ret < 0)
+		goto out_free_priv;
 
-		/*
-		 * Dummy value.
-		 */
-		dev->base_addr = 42;
-		pci_set_master(pdev);
-		base_address = pci_resource_start (pdev, 0);
+	/*
+	 * Dummy value.
+	 */
+	dev->base_addr = 42;
+	pci_set_master(pdev);
+	base_address = pci_resource_start(pdev, 0);
 
 #ifdef SK_BIG_ENDIAN
-		/*
-		 * On big endian machines, we use the adapter's aibility of
-		 * reading the descriptors as big endian.
-		 */
-		{
+	/*
+	 * On big endian machines, we use the adapter's ability of
+	 * reading the descriptors as big endian.
+	 */
+	{
 		SK_U32		our2;
-			SkPciReadCfgDWord(pAC, PCI_OUR_REG_2, &our2);
-			our2 |= PCI_REV_DESC;
-			SkPciWriteCfgDWord(pAC, PCI_OUR_REG_2, our2);
-		}
+		SkPciReadCfgDWord(pAC, PCI_OUR_REG_2, &our2);
+		our2 |= PCI_REV_DESC;
+		SkPciWriteCfgDWord(pAC, PCI_OUR_REG_2, our2);
+	}
 #endif /* BIG ENDIAN */
 
-		/*
-		 * Remap the regs into kernel space.
-		 */
+	/*
+	 * Remap the regs into kernel space.
+	 */
 
-		pAC->IoBase = (char*)ioremap(base_address, 0x4000);
-		if (!pAC->IoBase){
-			printk(KERN_ERR "%s:  Unable to map I/O register, "
-			       "SK 98xx No. %i will be disabled.\n",
-			       dev->name, boards_found);
-			kfree(dev);
-			break;
-		}
-		pAC->Index = boards_found;
+	pAC->IoBase = (char*)ioremap(base_address, 0x4000);
+	if (!pAC->IoBase) {
+		printk(KERN_ERR PFX "unable to map I/O register. "
+		       "SK 98xx device disabled.\n");
+		ret = -EIO;
+		goto out_dev_uninit;
+	}
+	pAC->Index = boards_found++;
+
+	ret = SkGeBoardInit(dev, pAC);
+	if (ret < 0)
+		goto out_free_resources;
+
+	memcpy((caddr_t) &dev->dev_addr,
+		(caddr_t) &pAC->Addr.Net[0].CurrentMacAddress, 6);
+
+	pNet->PortNr = 0;
+	pNet->NetNr = 0;
+
+	/* More then one port found */
+	if ((pAC->GIni.GIMacsFound == 2 ) && (pAC->RlmtNets == 2)) {
+		struct net_device *sec_dev;
+
+		sec_dev = alloc_etherdev(sizeof(DEV_NET));
+		if (!sec_dev) {
+			printk(KERN_ERR PFX
+				"Unable to allocate etherdev structure!\n");
+			ret = -ENOMEM;
+			goto out_free_resources;
+		}
+
+		pAC->dev[1] = sec_dev;
+		pNet = sec_dev->priv;
+		pNet->PortNr = 1;
+		pNet->NetNr = 1;
+		pNet->pAC = pAC;
+		pNet->Mtu = 1500;
+		pNet->Up = 0;
 
-		if (SkGeBoardInit(dev, pAC)) {
-			FreeResources(dev);
-			kfree(dev);
-			continue;
-		}
+		ret = SkGeDevInit(sec_dev);
+		if (ret < 0)
+			goto out_free_secondary_dev;
 
-		memcpy((caddr_t) &dev->dev_addr,
+		memcpy((caddr_t) &sec_dev->dev_addr,
 			(caddr_t) &pAC->Addr.Net[0].CurrentMacAddress, 6);
 
-		pNet->PortNr = 0;
-		pNet->NetNr = 0;
-
-		if (register_netdev(dev) != 0) {
-			printk(KERN_ERR "Unable to register etherdev\n");
-			sk98lin_root_dev = pAC->Next;
-			remove_proc_entry(dev->name, pSkRootDir);
-			FreeResources(dev);
-			kfree(dev);
-			continue;
-		}
-
-		pNet->proc = create_proc_entry(dev->name, 
-						S_IFREG | 0444, pSkRootDir);
-		if (pNet->proc) {
-			pNet->proc->data = dev;
-			pNet->proc->owner = THIS_MODULE;
-			pNet->proc->proc_fops = &sk_proc_fops;
-		}
-
-		boards_found++;
-
-		/* More then one port found */
-		if ((pAC->GIni.GIMacsFound == 2 ) && (pAC->RlmtNets == 2)) {
-			dev = alloc_etherdev(sizeof(DEV_NET));
-			if (!dev) {
-				printk(KERN_ERR "Unable to allocate etherdev "
-					"structure!\n");
-				break;
-			}
-
-			pAC->dev[1] = dev;
-			pNet = dev->priv;
-			pNet->PortNr = 1;
-			pNet->NetNr = 1;
-			pNet->pAC = pAC;
-			pNet->Mtu = 1500;
-			pNet->Up = 0;
-
-			dev->open =		&SkGeOpen;
-			dev->stop =		&SkGeClose;
-			dev->hard_start_xmit =	&SkGeXmit;
-			dev->get_stats =	&SkGeStats;
-			dev->set_multicast_list = &SkGeSetRxMode;
-			dev->set_mac_address =	&SkGeSetMacAddr;
-			dev->do_ioctl =		&SkGeIoctl;
-			dev->change_mtu =	&SkGeChangeMtu;
-
-			memcpy((caddr_t) &dev->dev_addr,
-			(caddr_t) &pAC->Addr.Net[1].CurrentMacAddress, 6);
-	
-			printk("%s: %s\n", dev->name, pAC->DeviceStr);
-			printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
-
-			if (register_netdev(dev) != 0) {
-				printk(KERN_ERR "Unable to register etherdev\n");
-				kfree(dev);
-				break;
-			}
-
-			pNet->proc = create_proc_entry(dev->name, 
-						S_IFREG | 0444, pSkRootDir);
-			if (pNet->proc) {
-				pNet->proc->data = dev;
-				pNet->proc->owner = THIS_MODULE;
-				pNet->proc->proc_fops = &sk_proc_fops;
-			}
-		
-		}
-
-
-		/*
-		 * This is bollocks, but we need to tell the net-init
-		 * code that it shall go for the next device.
-		 */
-#ifndef MODULE
-		dev->base_addr = 0;
-#endif
+		printk("%s: %s\n", sec_dev->name, pAC->DeviceStr);
+		printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
 	}
+	pci_set_drvdata(pdev, dev);
 
-	/*
-	 * If we're at this point we're going through skge_probe() for
-	 * the first time.  Return success (0) if we've initialized 1
-	 * or more boards. Otherwise, return failure (-ENODEV).
-	 */
-
-	return boards_found;
-} /* skge_probe */
+	ret = 0;
+out:
+	return ret;
+
+out_free_secondary_dev:
+	kfree(pAC->dev[1]);
+out_free_resources:
+	FreeResources(dev);
+out_dev_uninit:
+	SkGeDevCleanUp(dev);
+out_free_priv:
+	kfree(pAC);
+out_free_dev:
+	kfree(dev);
+out_disable:
+	pci_disable_device(pdev);
+	goto out;
 
+} /* skge_init_one */
 
 /*****************************************************************************
  *
@@ -721,39 +706,9 @@ static char *RlmtMode[SK_MAX_CARD_PARAM]
 static int debug = 0; /* not used */
 static int options[SK_MAX_CARD_PARAM] = {0, }; /* not used */
 
-
-/*****************************************************************************
- *
- * 	skge_init_module - module initialization function
- *
- * Description:
- *	Very simple, only call skge_probe and return approriate result.
- *
- * Returns:
- *	0, if everything is ok
- *	!=0, on error
- */
-static int __init skge_init_module(void)
-{
-	int cards;
-	sk98lin_root_dev = NULL;
-	
-	/* just to avoid warnings ... */
-	debug = 0;
-	options[0] = 0;
-
-	cards = skge_probe();
-	if (cards == 0) {
-		printk("No adapter found\n");
-	}
-	return cards ? 0 : -ENODEV;
-} /* skge_init_module */
-
-spinlock_t sk_devs_lock = SPIN_LOCK_UNLOCKED;
-
 /*****************************************************************************
  *
- * 	skge_cleanup_module - module unload function
+ * 	skge_remove_one - remove a single instance of a SK-98xx adapter
  *
  * Description:
  *	Disable adapter if it is still running, free resources,
@@ -761,82 +716,65 @@ spinlock_t sk_devs_lock = SPIN_LOCK_UNLO
  *
  * Returns: N/A
  */
-static void __exit skge_cleanup_module(void)
+static void __devexit skge_remove_one(struct pci_dev *pdev)
 {
-DEV_NET		*pNet;
-SK_AC		*pAC;
-struct net_device *next;
-unsigned long Flags;
-SK_EVPARA EvPara;
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET	*pNet = dev->priv;
+	SK_AC *pAC = pNet->pAC;
+	unsigned long Flags;
+	SK_EVPARA EvPara;
 
-	while (sk98lin_root_dev) {
-		pNet = (DEV_NET*) sk98lin_root_dev->priv;
-		pAC = pNet->pAC;
-		next = pAC->Next;
 
-		netif_stop_queue(sk98lin_root_dev);
-		SkGeYellowLED(pAC, pAC->IoBase, 0);
-		if (pNet->proc) {
-			spin_lock(&sk_devs_lock);
-			pNet->proc->data = NULL;
-			spin_unlock(&sk_devs_lock);
-		}
-
-		if(pAC->BoardLevel == 2) {
-			/* board is still alive */
-			spin_lock_irqsave(&pAC->SlowPathLock, Flags);
-			EvPara.Para32[0] = 0;
-			EvPara.Para32[1] = -1;
-			SkEventQueue(pAC, SKGE_RLMT, SK_RLMT_STOP, EvPara);
-			EvPara.Para32[0] = 1;
-			EvPara.Para32[1] = -1;
-			SkEventQueue(pAC, SKGE_RLMT, SK_RLMT_STOP, EvPara);
-			SkEventDispatcher(pAC, pAC->IoBase);
-			/* disable interrupts */
-			SK_OUT32(pAC->IoBase, B0_IMSK, 0);
-			SkGeDeInit(pAC, pAC->IoBase); 
-			spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
-			pAC->BoardLevel = 0;
-			/* We do NOT check here, if IRQ was pending, of course*/
-		}
-
-		if(pAC->BoardLevel == 1) {
-			/* board is still alive */
-			SkGeDeInit(pAC, pAC->IoBase); 
-			pAC->BoardLevel = 0;
-		}
-
-		if ((pAC->GIni.GIMacsFound == 2) && pAC->RlmtNets == 2){
-			pNet = (DEV_NET*) pAC->dev[1]->priv;
-			if (pNet->proc) {
-				spin_lock(&sk_devs_lock);
-				pNet->proc->data = NULL;
-				spin_unlock(&sk_devs_lock);
-			}
-			unregister_netdev(pAC->dev[1]);
-			kfree(pAC->dev[1]);
-		}
+	netif_stop_queue(dev);
+	SkGeYellowLED(pAC, pAC->IoBase, 0);
+	if (pNet->proc) {
+		spin_lock(&sk_devs_lock);
+		pNet->proc->data = NULL;
+		spin_unlock(&sk_devs_lock);
+		remove_proc_entry(dev->name, pSkRootDir);
+	}
 
-		FreeResources(sk98lin_root_dev);
+	if (pAC->BoardLevel == 2) {
+		/* board is still alive */
+		spin_lock_irqsave(&pAC->SlowPathLock, Flags);
+		EvPara.Para32[0] = 0;
+		EvPara.Para32[1] = -1;
+		SkEventQueue(pAC, SKGE_RLMT, SK_RLMT_STOP, EvPara);
+		EvPara.Para32[0] = 1;
+		EvPara.Para32[1] = -1;
+		SkEventQueue(pAC, SKGE_RLMT, SK_RLMT_STOP, EvPara);
+		SkEventDispatcher(pAC, pAC->IoBase);
+		/* disable interrupts */
+		SK_OUT32(pAC->IoBase, B0_IMSK, 0);
+		SkGeDeInit(pAC, pAC->IoBase); 
+		spin_unlock_irqrestore(&pAC->SlowPathLock, Flags);
+		pAC->BoardLevel = 0;
+		/* We do NOT check here, if IRQ was pending, of course*/
+	}
 
-		sk98lin_root_dev->get_stats = NULL;
-		/* 
-		 * otherwise unregister_netdev calls get_stats with
-		 * invalid IO ...  :-(
-		 */
-		unregister_netdev(sk98lin_root_dev);
-		kfree(sk98lin_root_dev);
-		kfree(pAC);
-		sk98lin_root_dev = next;
+	if (pAC->BoardLevel == 1) {
+		/* board is still alive */
+		SkGeDeInit(pAC, pAC->IoBase); 
+		pAC->BoardLevel = 0;
 	}
 
-	/* clear proc-dir */
-	remove_proc_entry(pSkRootDir->name, proc_net);
+	if ((pAC->GIni.GIMacsFound == 2) && pAC->RlmtNets == 2) {
+		SkGeDevCleanUp(pAC->dev[1]);
+		kfree(pAC->dev[1]);
+	}
 
-} /* skge_cleanup_module */
+	FreeResources(dev);
 
-module_init(skge_init_module);
-module_exit(skge_cleanup_module);
+	dev->get_stats = NULL;
+	/* 
+	 * otherwise unregister_netdev calls get_stats with
+	 * invalid IO ...  :-(
+	 */
+	unregister_netdev(dev);
+	kfree(dev);
+	kfree(pAC);
+	boards_found--;
+} /* skge_remove_one */
 
 /*****************************************************************************
  *
@@ -971,12 +909,6 @@ int	Ret;			/* return code of request_irq
 
 	SkGeYellowLED(pAC, pAC->IoBase, 1);
 
-	/*
-	 * Register the device here
-	 */
-	pAC->Next = sk98lin_root_dev;
-	sk98lin_root_dev = dev;
-
 	return (0);
 } /* SkGeBoardInit */
 
@@ -4100,9 +4032,62 @@ int	l;
 
 #endif /* DEBUG */
 
+static struct pci_device_id skge_pci_tbl[] __devinitdata = {
+	{ PCI_VENDOR_ID_SYSKONNECT, PCI_DEVICE_ID_SYSKONNECT_GE,
+		PCI_ANY_ID, PCI_ANY_ID, },
+	{ 0,}
+};
+MODULE_DEVICE_TABLE(pci, skge_pci_tbl);
+
+static struct pci_driver skge_driver = {
+	.name		= DRV_MODULE_NAME,
+	.id_table	= skge_pci_tbl,
+	.probe		= skge_init_one,
+	.remove		= __devexit_p(skge_remove_one),
+};
+
+/*****************************************************************************
+ *
+ * 	skge_init - module initialization function
+ *
+ * Description:
+ *	Very simple, only call skge_probe and return approriate result.
+ *
+ * Returns:
+ *	0, if everything is ok
+ *	!=0, on error
+ */
+static int __init skge_init(void)
+{
+	int ret = -ENOMEM;
+	
+	/* just to avoid warnings ... */
+	debug = 0;
+	options[0] = 0;
+
+	pSkRootDir = create_proc_entry(DRV_MODULE_NAME,
+			S_IFDIR | S_IWUSR | S_IRUGO | S_IXUGO, proc_net);
+	if (pSkRootDir) {
+		pSkRootDir->owner = THIS_MODULE;
+		ret = pci_module_init(&skge_driver);
+		if (ret)
+			remove_proc_entry(pSkRootDir->name, proc_net);
+	}
+	return ret;
+} /* skge_init */
+
+
+static void __exit skge_cleanup(void)
+{
+	remove_proc_entry(pSkRootDir->name, proc_net);
+	pci_unregister_driver(&skge_driver);
+}
+
+module_init(skge_init);
+module_exit(skge_cleanup);
+
 /*
  * Local variables:
  * compile-command: "make"
  * End:
  */
-

_
