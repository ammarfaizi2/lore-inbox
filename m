Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265725AbUGDPRB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbUGDPRB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbUGDPRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:17:01 -0400
Received: from [213.146.154.40] ([213.146.154.40]:36561 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265725AbUGDPPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:15:11 -0400
Date: Sun, 4 Jul 2004 16:15:09 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bernd-schubert@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7: sk98lin unload oops
Message-ID: <20040704151509.GA5100@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Bernd Schubert <bernd-schubert@web.de>,
	linux-kernel@vger.kernel.org
References: <200407041342.18821.bernd-schubert@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407041342.18821.bernd-schubert@web.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fortunality everything still works fine (I'm running the script over the 
> network of the syskonnect cards).
> 
> This machine has two of those syskonnect cards, on another machine which has 
> only one syskonnect card this oops doesn't occur.

As a colleteral damage the following huge patch should fix it, and I need
testers for it anyway ;-)


--- 1.39/drivers/net/sk98lin/skge.c	2004-07-02 10:43:46 +02:00
+++ edited/drivers/net/sk98lin/skge.c	2004-07-03 22:00:05 +02:00
@@ -239,7 +239,7 @@
 
 #ifdef CONFIG_PROC_FS
 static const char 	SK_Root_Dir_entry[] = "sk98lin";
-static struct		proc_dir_entry *pSkRootDir = NULL;
+static struct		proc_dir_entry *pSkRootDir;
 extern struct	file_operations sk_proc_fops;
 #endif
 
@@ -255,303 +255,13 @@
 #endif
 
 /* global variables *********************************************************/
-static const char *BootString = BOOT_STRING;
 struct SK_NET_DEVICE *SkGeRootDev = NULL;
-static int probed __initdata = 0;
 static SK_BOOL DoPrintInterfaceChange = SK_TRUE;
 
 /* local variables **********************************************************/
 static uintptr_t TxQueueAddr[SK_MAX_MACS][2] = {{0x680, 0x600},{0x780, 0x700}};
 static uintptr_t RxQueueAddr[SK_MAX_MACS] = {0x400, 0x480};
 
-
-#ifdef CONFIG_PROC_FS
-static struct proc_dir_entry	*pSkRootDir;
-#endif
-
-
-
-/*****************************************************************************
- *
- * 	skge_probe - find all SK-98xx adapters
- *
- * Description:
- *	This function scans the PCI bus for SK-98xx adapters. Resources for
- *	each adapter are allocated and the adapter is brought into Init 1
- *	state.
- *
- * Returns:
- *	0, if everything is ok
- *	!=0, on error
- */
-static int __init skge_probe (void)
-{
-	int			boards_found = 0;
-	int			vendor_flag = SK_FALSE;
-	SK_AC			*pAC;
-	DEV_NET			*pNet = NULL;
-	struct pci_dev	*pdev = NULL;
-	struct SK_NET_DEVICE *dev = NULL;
-	SK_BOOL DeviceFound = SK_FALSE;
-	SK_BOOL BootStringCount = SK_FALSE;
-	int			retval;
-#ifdef CONFIG_PROC_FS
-	struct proc_dir_entry	*pProcFile;
-#endif
-
-	if (probed)
-		return -ENODEV;
-	probed++;
-
-
-	while((pdev = pci_find_class(PCI_CLASS_NETWORK_ETHERNET << 8, pdev))) {
-
-                if (pci_enable_device(pdev)) {
-                        continue;
-                }
-		dev = NULL;
-		pNet = NULL;
-
-		/* Don't handle Yukon2 cards at the moment */
-		/* 12-feb-2004 ---- mlindner@syskonnect.de */
-		if (pdev->vendor == 0x11ab) {
-			if ( (pdev->device == 0x4360) || (pdev->device == 0x4361) )
-				continue;
-		}
-
-		SK_PCI_ISCOMPLIANT(vendor_flag, pdev);
-		if (!vendor_flag)
-			continue;
-
-		/* Configure DMA attributes. */
-		if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL) &&
-			pci_set_dma_mask(pdev, (u64) 0xffffffff))
-			continue;
-
-
-		if ((dev = alloc_etherdev(sizeof(DEV_NET))) == NULL) {
-			printk(KERN_ERR "Unable to allocate etherdev "
-			       "structure!\n");
-			break;
-		}
-
-		pNet = dev->priv;
-		pNet->pAC = kmalloc(sizeof(SK_AC), GFP_KERNEL);
-		if (pNet->pAC == NULL){
-			free_netdev(dev);
-			printk(KERN_ERR "Unable to allocate adapter "
-			       "structure!\n");
-			break;
-		}
-
-		/* Print message */
-		if (!BootStringCount) {
-			/* set display flag to TRUE so that */
-			/* we only display this string ONCE */
-			BootStringCount = SK_TRUE;
-			printk("%s\n", BootString);
-		}
-
-		memset(pNet->pAC, 0, sizeof(SK_AC));
-		pAC = pNet->pAC;
-		pAC->PciDev = pdev;
-		pAC->PciDevId = pdev->device;
-		pAC->dev[0] = dev;
-		pAC->dev[1] = dev;
-		sprintf(pAC->Name, "SysKonnect SK-98xx");
-		pAC->CheckQueue = SK_FALSE;
-
-		pNet->Mtu = 1500;
-		pNet->Up = 0;
-		dev->irq = pdev->irq;
-		retval = SkGeInitPCI(pAC);
-		if (retval) {
-			printk("SKGE: PCI setup failed: %i\n", retval);
-			free_netdev(dev);
-			continue;
-		}
-
-		SET_MODULE_OWNER(dev);
-		dev->open =		&SkGeOpen;
-		dev->stop =		&SkGeClose;
-		dev->hard_start_xmit =	&SkGeXmit;
-		dev->get_stats =	&SkGeStats;
-		dev->last_stats =	&SkGeStats;
-		dev->set_multicast_list = &SkGeSetRxMode;
-		dev->set_mac_address =	&SkGeSetMacAddr;
-		dev->do_ioctl =		&SkGeIoctl;
-		dev->change_mtu =	&SkGeChangeMtu;
-		dev->flags &= 		~IFF_RUNNING;
-		SET_NETDEV_DEV(dev, &pdev->dev);
-
-#ifdef SK_ZEROCOPY
-#ifdef USE_SK_TX_CHECKSUM
-
-		if (pAC->ChipsetType) {
-			/* Use only if yukon hardware */
-			/* SK and ZEROCOPY - fly baby... */
-			dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
-		}
-#endif
-#endif
-
-		pAC->Index = boards_found;
-
-		if (SkGeBoardInit(dev, pAC)) {
-			free_netdev(dev);
-			continue;
-		}
-
-		/* Register net device */
-		if (register_netdev(dev)) {
-			printk(KERN_ERR "SKGE: Could not register device.\n");
-			FreeResources(dev);
-			free_netdev(dev);
-			continue;
-		}
-
-		/* Print adapter specific string from vpd */
-		ProductStr(pAC);
-		printk("%s: %s\n", dev->name, pAC->DeviceStr);
-
-		/* Print configuration settings */
-		printk("      PrefPort:%c  RlmtMode:%s\n",
-			'A' + pAC->Rlmt.Net[0].Port[pAC->Rlmt.Net[0].PrefPort]->PortNumber,
-			(pAC->RlmtMode==0)  ? "Check Link State" :
-			((pAC->RlmtMode==1) ? "Check Link State" :
-			((pAC->RlmtMode==3) ? "Check Local Port" :
-			((pAC->RlmtMode==7) ? "Check Segmentation" :
-			((pAC->RlmtMode==17) ? "Dual Check Link State" :"Error")))));
-
-		SkGeYellowLED(pAC, pAC->IoBase, 1);
-
-
-		memcpy((caddr_t) &dev->dev_addr,
-			(caddr_t) &pAC->Addr.Net[0].CurrentMacAddress, 6);
-
-		/* First adapter... Create proc and print message */
-#ifdef CONFIG_PROC_FS
-		if (!DeviceFound) {
-			DeviceFound = SK_TRUE;
-			SK_MEMCPY(&SK_Root_Dir_entry, BootString,
-				sizeof(SK_Root_Dir_entry) - 1);
-
-			/*Create proc (directory)*/
-			if(!pSkRootDir) {
-				pSkRootDir = proc_mkdir(SK_Root_Dir_entry, proc_net);
-				if (!pSkRootDir) {
-					printk(KERN_WARNING "%s: Unable to create /proc/net/%s",
-						dev->name, SK_Root_Dir_entry);
-				} else {
-					pSkRootDir->owner = THIS_MODULE;
-				}
-			}
-		}
-
-		/* Create proc file */
-		if (pSkRootDir && 
-			(pProcFile = create_proc_entry(dev->name, S_IRUGO,
-				pSkRootDir))) {
-			pProcFile->proc_fops = &sk_proc_fops;
-			pProcFile->data      = dev;
-		}
-
-#endif
-
-		pNet->PortNr = 0;
-		pNet->NetNr  = 0;
-
-		boards_found++;
-
-		/* More then one port found */
-		if ((pAC->GIni.GIMacsFound == 2 ) && (pAC->RlmtNets == 2)) {
-			if ((dev = alloc_etherdev(sizeof(DEV_NET))) == 0) {
-				printk(KERN_ERR "Unable to allocate etherdev "
-					"structure!\n");
-				break;
-			}
-
-			pAC->dev[1]   = dev;
-			pNet          = dev->priv;
-			pNet->PortNr  = 1;
-			pNet->NetNr   = 1;
-			pNet->pAC     = pAC;
-			pNet->Mtu     = 1500;
-			pNet->Up      = 0;
-
-			dev->open               = &SkGeOpen;
-			dev->stop               = &SkGeClose;
-			dev->hard_start_xmit    = &SkGeXmit;
-			dev->get_stats          = &SkGeStats;
-			dev->last_stats         = &SkGeStats;
-			dev->set_multicast_list = &SkGeSetRxMode;
-			dev->set_mac_address    = &SkGeSetMacAddr;
-			dev->do_ioctl           = &SkGeIoctl;
-			dev->change_mtu         = &SkGeChangeMtu;
-			dev->flags             &= ~IFF_RUNNING;
-
-#ifdef SK_ZEROCOPY
-#ifdef USE_SK_TX_CHECKSUM
-			if (pAC->ChipsetType) {
-				/* SG and ZEROCOPY - fly baby... */
-				dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
-			}
-#endif
-#endif
-
-			if (register_netdev(dev)) {
-				printk(KERN_ERR "SKGE: Could not register device.\n");
-				free_netdev(dev);
-				pAC->dev[1] = pAC->dev[0];
-			} else {
-#ifdef CONFIG_PROC_FS
-				if (pSkRootDir 
-				    && (pProcFile = create_proc_entry(dev->name, 
-								S_IRUGO, pSkRootDir))) {
-					pProcFile->proc_fops = &sk_proc_fops;
-					pProcFile->data      = dev;
-				}
-#endif
-
-			memcpy((caddr_t) &dev->dev_addr,
-			(caddr_t) &pAC->Addr.Net[1].CurrentMacAddress, 6);
-	
-			printk("%s: %s\n", dev->name, pAC->DeviceStr);
-			printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
-			}
-		}
-
-		/* Save the hardware revision */
-		pAC->HWRevision = (((pAC->GIni.GIPciHwRev >> 4) & 0x0F)*10) +
-			(pAC->GIni.GIPciHwRev & 0x0F);
-
-		/* Set driver globals */
-		pAC->Pnmi.pDriverFileName    = DRIVER_FILE_NAME;
-		pAC->Pnmi.pDriverReleaseDate = DRIVER_REL_DATE;
-
-		SK_MEMSET(&(pAC->PnmiBackup), 0, sizeof(SK_PNMI_STRUCT_DATA));
-		SK_MEMCPY(&(pAC->PnmiBackup), &(pAC->PnmiStruct), 
-				sizeof(SK_PNMI_STRUCT_DATA));
-
-		/*
-		 * This is bollocks, but we need to tell the net-init
-		 * code that it shall go for the next device.
-		 */
-#ifndef MODULE
-		dev->base_addr = 0;
-#endif
-	}
-
-	/*
-	 * If we're at this point we're going through skge_probe() for
-	 * the first time.  Return success (0) if we've initialized 1
-	 * or more boards. Otherwise, return failure (-ENODEV).
-	 */
-
-	return boards_found;
-} /* skge_probe */
-
-
 /*****************************************************************************
  *
  * 	SkGeInitPCI - Init the PCI resources
@@ -666,9 +376,6 @@
 MODULE_PARM(ConType,	"1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "s");
 MODULE_PARM(PrefPort,   "1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "s");
 MODULE_PARM(RlmtMode,   "1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "s");
-/* not used, just there because every driver should have them: */
-MODULE_PARM(options,    "1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "i");
-MODULE_PARM(debug,      "i");
 /* used for interrupt moderation */
 MODULE_PARM(IntsPerSec,     "1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "i");
 MODULE_PARM(Moderation,     "1-" __MODULE_STRING(SK_MAX_CARD_PARAM) "s");
@@ -755,123 +462,12 @@
 static char *RlmtMode[SK_MAX_CARD_PARAM] = {"", };
 #endif
 
-static int debug = 0; /* not used */
-static int options[SK_MAX_CARD_PARAM] = {0, }; /* not used */
-
 static int   IntsPerSec[SK_MAX_CARD_PARAM];
 static char *Moderation[SK_MAX_CARD_PARAM];
 static char *ModerationMask[SK_MAX_CARD_PARAM];
 static char *AutoSizing[SK_MAX_CARD_PARAM];
 static char *Stats[SK_MAX_CARD_PARAM];
 
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
-	SkGeRootDev = NULL;
-	
-	/* just to avoid warnings ... */
-	debug = 0;
-	options[0] = 0;
-
-	cards = skge_probe();
-	if (cards == 0) {
-		printk("sk98lin: No adapter found.\n");
-	}
-	return cards ? 0 : -ENODEV;
-} /* skge_init_module */
-
-
-/*****************************************************************************
- *
- * 	skge_cleanup_module - module unload function
- *
- * Description:
- *	Disable adapter if it is still running, free resources,
- *	free device struct.
- *
- * Returns: N/A
- */
-static void __exit skge_cleanup_module(void)
-{
-DEV_NET		*pNet;
-SK_AC		*pAC;
-struct SK_NET_DEVICE *next;
-unsigned long Flags;
-SK_EVPARA EvPara;
-
-	while (SkGeRootDev) {
-		pNet = (DEV_NET*) SkGeRootDev->priv;
-		pAC = pNet->pAC;
-		next = pAC->Next;
-
-		netif_stop_queue(SkGeRootDev);
-		SkGeYellowLED(pAC, pAC->IoBase, 0);
-
-		if(pAC->BoardLevel == SK_INIT_RUN) {
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
-			pAC->BoardLevel = SK_INIT_DATA;
-			/* We do NOT check here, if IRQ was pending, of course*/
-		}
-
-		if(pAC->BoardLevel == SK_INIT_IO) {
-			/* board is still alive */
-			SkGeDeInit(pAC, pAC->IoBase);
-			pAC->BoardLevel = SK_INIT_DATA;
-		}
-
-		if ((pAC->GIni.GIMacsFound == 2) && pAC->RlmtNets == 2){
-			unregister_netdev(pAC->dev[1]);
-			free_netdev(pAC->dev[1]);
-		}
-
-		FreeResources(SkGeRootDev);
-
-		SkGeRootDev->get_stats = NULL;
-		/*
-		 * otherwise unregister_netdev calls get_stats with
-		 * invalid IO ...  :-(
-		 */
-		unregister_netdev(SkGeRootDev);
-		free_netdev(SkGeRootDev);
-		kfree(pAC);
-		SkGeRootDev = next;
-	}
-
-#ifdef CONFIG_PROC_FS
-	/* clear proc-dir */
-	remove_proc_entry(pSkRootDir->name, proc_net);
-#endif
-
-} /* skge_cleanup_module */
-
-module_init(skge_init_module);
-module_exit(skge_cleanup_module);
-
-
 /*****************************************************************************
  *
  * 	SkGeBoardInit - do level 0 and 1 initialization
@@ -5311,8 +4907,316 @@
 
 #endif
 
-/*******************************************************************************
- *
- * End of file
- *
- ******************************************************************************/
+static int __devinit skge_probe_one(struct pci_dev *pdev,
+		const struct pci_device_id *ent)
+{
+	SK_AC			*pAC;
+	DEV_NET			*pNet = NULL;
+	struct net_device	*dev = NULL;
+#ifdef CONFIG_PROC_FS
+	struct proc_dir_entry	*pProcFile;
+#endif
+	static int boards_found = 0;
+	int error = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto out;
+ 
+	/* Configure DMA attributes. */
+	if (pci_set_dma_mask(pdev, (u64) 0xffffffffffffffffULL) &&
+	    pci_set_dma_mask(pdev, (u64) 0xffffffff))
+		goto out_disable_device;
+
+
+	if ((dev = alloc_etherdev(sizeof(DEV_NET))) == NULL) {
+		printk(KERN_ERR "Unable to allocate etherdev "
+		       "structure!\n");
+		goto out_disable_device;
+	}
+
+	pNet = dev->priv;
+	pNet->pAC = kmalloc(sizeof(SK_AC), GFP_KERNEL);
+	if (!pNet->pAC) {
+		printk(KERN_ERR "Unable to allocate adapter "
+		       "structure!\n");
+		goto out_free_netdev;
+	}
+
+	memset(pNet->pAC, 0, sizeof(SK_AC));
+	pAC = pNet->pAC;
+	pAC->PciDev = pdev;
+	pAC->PciDevId = pdev->device;
+	pAC->dev[0] = dev;
+	pAC->dev[1] = dev;
+	sprintf(pAC->Name, "SysKonnect SK-98xx");
+	pAC->CheckQueue = SK_FALSE;
+
+	pNet->Mtu = 1500;
+	pNet->Up = 0;
+	dev->irq = pdev->irq;
+	error = SkGeInitPCI(pAC);
+	if (error) {
+		printk("SKGE: PCI setup failed: %i\n", error);
+		goto out_free_netdev;
+	}
+
+	SET_MODULE_OWNER(dev);
+	dev->open =		&SkGeOpen;
+	dev->stop =		&SkGeClose;
+	dev->hard_start_xmit =	&SkGeXmit;
+	dev->get_stats =	&SkGeStats;
+	dev->last_stats =	&SkGeStats;
+	dev->set_multicast_list = &SkGeSetRxMode;
+	dev->set_mac_address =	&SkGeSetMacAddr;
+	dev->do_ioctl =		&SkGeIoctl;
+	dev->change_mtu =	&SkGeChangeMtu;
+	dev->flags &= 		~IFF_RUNNING;
+	SET_NETDEV_DEV(dev, &pdev->dev);
+
+#ifdef SK_ZEROCOPY
+#ifdef USE_SK_TX_CHECKSUM
+	if (pAC->ChipsetType) {
+		/* Use only if yukon hardware */
+		/* SK and ZEROCOPY - fly baby... */
+		dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
+	}
+#endif
+#endif
+
+	pAC->Index = boards_found++;
+
+	if (SkGeBoardInit(dev, pAC))
+		goto out_free_netdev;
+
+	/* Register net device */
+	if (register_netdev(dev)) {
+		printk(KERN_ERR "SKGE: Could not register device.\n");
+		goto out_free_resources;
+	}
+
+	/* Print adapter specific string from vpd */
+	ProductStr(pAC);
+	printk("%s: %s\n", dev->name, pAC->DeviceStr);
+
+	/* Print configuration settings */
+	printk("      PrefPort:%c  RlmtMode:%s\n",
+		'A' + pAC->Rlmt.Net[0].Port[pAC->Rlmt.Net[0].PrefPort]->PortNumber,
+		(pAC->RlmtMode==0)  ? "Check Link State" :
+		((pAC->RlmtMode==1) ? "Check Link State" :
+		((pAC->RlmtMode==3) ? "Check Local Port" :
+		((pAC->RlmtMode==7) ? "Check Segmentation" :
+		((pAC->RlmtMode==17) ? "Dual Check Link State" :"Error")))));
+
+	SkGeYellowLED(pAC, pAC->IoBase, 1);
+
+
+	memcpy(&dev->dev_addr, &pAC->Addr.Net[0].CurrentMacAddress, 6);
+
+#ifdef CONFIG_PROC_FS
+	pProcFile = create_proc_entry(dev->name, S_IRUGO, pSkRootDir);
+	if (pProcFile) {
+		pProcFile->proc_fops = &sk_proc_fops;
+		pProcFile->data = dev;
+		pProcFile->owner = THIS_MODULE;
+	}
+#endif
+
+	pNet->PortNr = 0;
+	pNet->NetNr  = 0;
+
+	boards_found++;
+
+	/* More then one port found */
+	if ((pAC->GIni.GIMacsFound == 2 ) && (pAC->RlmtNets == 2)) {
+		if ((dev = alloc_etherdev(sizeof(DEV_NET))) == 0) {
+			printk(KERN_ERR "Unable to allocate etherdev "
+				"structure!\n");
+			goto out;
+		}
+
+		pAC->dev[1]   = dev;
+		pNet          = dev->priv;
+		pNet->PortNr  = 1;
+		pNet->NetNr   = 1;
+		pNet->pAC     = pAC;
+		pNet->Mtu     = 1500;
+		pNet->Up      = 0;
+
+		dev->open               = &SkGeOpen;
+		dev->stop               = &SkGeClose;
+		dev->hard_start_xmit    = &SkGeXmit;
+		dev->get_stats          = &SkGeStats;
+		dev->last_stats         = &SkGeStats;
+		dev->set_multicast_list = &SkGeSetRxMode;
+		dev->set_mac_address    = &SkGeSetMacAddr;
+		dev->do_ioctl           = &SkGeIoctl;
+		dev->change_mtu         = &SkGeChangeMtu;
+		dev->flags             &= ~IFF_RUNNING;
+
+#ifdef SK_ZEROCOPY
+#ifdef USE_SK_TX_CHECKSUM
+		if (pAC->ChipsetType) {
+			/* SG and ZEROCOPY - fly baby... */
+			dev->features |= NETIF_F_SG | NETIF_F_IP_CSUM;
+		}
+#endif
+#endif
+
+		if (register_netdev(dev)) {
+			printk(KERN_ERR "SKGE: Could not register device.\n");
+			free_netdev(dev);
+			pAC->dev[1] = pAC->dev[0];
+		} else {
+#ifdef CONFIG_PROC_FS
+			pProcFile = create_proc_entry(dev->name, S_IRUGO,
+					pSkRootDir);
+			if (pProcFile) {
+				pProcFile->proc_fops = &sk_proc_fops;
+				pProcFile->data = dev;
+				pProcFile->owner = THIS_MODULE;
+			}
+#endif
+
+			memcpy(&dev->dev_addr,
+					&pAC->Addr.Net[1].CurrentMacAddress, 6);
+	
+			printk("%s: %s\n", dev->name, pAC->DeviceStr);
+			printk("      PrefPort:B  RlmtMode:Dual Check Link State\n");
+		}
+	}
+
+	/* Save the hardware revision */
+	pAC->HWRevision = (((pAC->GIni.GIPciHwRev >> 4) & 0x0F)*10) +
+		(pAC->GIni.GIPciHwRev & 0x0F);
+
+	/* Set driver globals */
+	pAC->Pnmi.pDriverFileName    = DRIVER_FILE_NAME;
+	pAC->Pnmi.pDriverReleaseDate = DRIVER_REL_DATE;
+
+	memset(&pAC->PnmiBackup, 0, sizeof(SK_PNMI_STRUCT_DATA));
+	memcpy(&pAC->PnmiBackup, &pAC->PnmiStruct, sizeof(SK_PNMI_STRUCT_DATA));
+
+	pci_set_drvdata(pdev, dev);
+	return 0;
+
+ out_free_resources:
+	FreeResources(dev);
+ out_free_netdev:
+	free_netdev(dev);
+ out_disable_device:
+	pci_disable_device(pdev);
+ out:
+	return error;
+}
+
+static void __devexit skge_remove_one(struct pci_dev *pdev)
+{
+	struct net_device *dev = pci_get_drvdata(pdev);
+	DEV_NET *pNet = (DEV_NET *) dev->priv;
+	SK_AC *pAC = pNet->pAC;
+	int have_second_mac = 0;
+
+	if ((pAC->GIni.GIMacsFound == 2) && pAC->RlmtNets == 2)
+		have_second_mac = 1;
+
+	unregister_netdev(dev);
+	if (have_second_mac)
+		unregister_netdev(pAC->dev[1]);
+
+	SkGeYellowLED(pAC, pAC->IoBase, 0);
+
+	if (pAC->BoardLevel == SK_INIT_RUN) {
+		SK_EVPARA EvPara;
+		unsigned long Flags;
+
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
+		pAC->BoardLevel = SK_INIT_DATA;
+		/* We do NOT check here, if IRQ was pending, of course*/
+	}
+
+	if (pAC->BoardLevel == SK_INIT_IO) {
+		/* board is still alive */
+		SkGeDeInit(pAC, pAC->IoBase);
+		pAC->BoardLevel = SK_INIT_DATA;
+	}
+
+	FreeResources(dev);
+	free_netdev(dev);
+	if (have_second_mac)
+		free_netdev(pAC->dev[1]);
+	kfree(pAC);
+}
+
+static struct pci_device_id skge_pci_tbl[] = {
+	{ PCI_VENDOR_ID_3COM, 0x1700, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_3COM, 0x80eb, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SYSKONNECT, 0x4300, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_SYSKONNECT, 0x4320, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_DLINK, 0x4c00, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_MARVELL, 0x4320, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+#if 0	/* don't handle Yukon2 cards at the moment -- mlindner@syskonnect.de */
+	{ PCI_VENDOR_ID_MARVELL, 0x4360, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_MARVELL, 0x4361, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+#endif
+	{ PCI_VENDOR_ID_MARVELL, 0x5005, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_CNET, 0x434e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_LINKSYS, 0x1032, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ PCI_VENDOR_ID_LINKSYS, 0x1064, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0, }
+};
+
+static struct pci_driver skge_driver = {
+	.name		= "skge",
+	.id_table	= skge_pci_tbl,
+	.probe		= skge_probe_one,
+	.remove		= __devexit_p(skge_remove_one),
+};
+
+static int __init skge_init(void)
+{
+	int error;
+
+	memcpy(&SK_Root_Dir_entry, BOOT_STRING, sizeof(SK_Root_Dir_entry) - 1);
+
+#ifdef CONFIG_PROC_FS
+	pSkRootDir = proc_mkdir(SK_Root_Dir_entry, proc_net);
+	if (!pSkRootDir) {
+		printk(KERN_WARNING "Unable to create /proc/net/%s",
+				SK_Root_Dir_entry);
+		return -ENOMEM;
+	}
+	pSkRootDir->owner = THIS_MODULE;
+#endif
+
+	error = pci_module_init(&skge_driver);
+	if (error) {
+#ifdef CONFIG_PROC_FS
+		remove_proc_entry(pSkRootDir->name, proc_net);
+#endif
+	}
+
+	return error;
+}
+
+static void __exit skge_exit(void)
+{
+	 pci_unregister_driver(&skge_driver);
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry(pSkRootDir->name, proc_net);
+#endif
+}
+
+module_init(skge_init);
+module_exit(skge_exit);
===== drivers/net/sk98lin/h/skdrv2nd.h 1.11 vs edited =====
--- 1.11/drivers/net/sk98lin/h/skdrv2nd.h	2004-06-22 16:36:50 +02:00
+++ edited/drivers/net/sk98lin/h/skdrv2nd.h	2004-07-03 21:57:55 +02:00
@@ -53,60 +53,6 @@
 #include "h/skrlmt.h"
 #include "h/skgedrv.h"
 
-#define SK_PCI_ISCOMPLIANT(result, pdev) {     \
-    result = SK_FALSE; /* default */     \
-    /* 3Com (0x10b7) */     \
-    if (pdev->vendor == 0x10b7) {     \
-        /* Gigabit Ethernet Adapter (0x1700) */     \
-        if ((pdev->device == 0x1700) || \
-            (pdev->device == 0x80eb)) { \
-            result = SK_TRUE;     \
-        }     \
-    /* SysKonnect (0x1148) */     \
-    } else if (pdev->vendor == 0x1148) {     \
-        /* SK-98xx Gigabit Ethernet Server Adapter (0x4300) */     \
-        /* SK-98xx V2.0 Gigabit Ethernet Adapter (0x4320) */     \
-        if ((pdev->device == 0x4300) || \
-            (pdev->device == 0x4320)) { \
-            result = SK_TRUE;     \
-        }     \
-    /* D-Link (0x1186) */     \
-    } else if (pdev->vendor == 0x1186) {     \
-        /* Gigabit Ethernet Adapter (0x4c00) */     \
-        if ((pdev->device == 0x4c00)) { \
-            result = SK_TRUE;     \
-        }     \
-    /* Marvell (0x11ab) */     \
-    } else if (pdev->vendor == 0x11ab) {     \
-        /* Gigabit Ethernet Adapter (0x4320) */     \
-        /* Gigabit Ethernet Adapter (0x4360) */     \
-        /* Gigabit Ethernet Adapter (0x4361) */     \
-        /* Belkin (0x5005) */     \
-        if ((pdev->device == 0x4320) || \
-            (pdev->device == 0x4360) || \
-            (pdev->device == 0x4361) || \
-            (pdev->device == 0x5005)) { \
-            result = SK_TRUE;     \
-        }     \
-    /* CNet (0x1371) */     \
-    } else if (pdev->vendor == 0x1371) {     \
-        /* GigaCard Network Adapter (0x434e) */     \
-        if ((pdev->device == 0x434e)) { \
-            result = SK_TRUE;     \
-        }     \
-    /* Linksys (0x1737) */     \
-    } else if (pdev->vendor == 0x1737) {     \
-        /* Gigabit Network Adapter (0x1032) */     \
-        /* Gigabit Network Adapter (0x1064) */     \
-        if ((pdev->device == 0x1032) || \
-            (pdev->device == 0x1064)) { \
-            result = SK_TRUE;     \
-        }     \
-    } else {     \
-        result = SK_FALSE;     \
-    }     \
-}
-
 
 extern SK_MBUF		*SkDrvAllocRlmtMbuf(SK_AC*, SK_IOC, unsigned);
 extern void		SkDrvFreeRlmtMbuf(SK_AC*, SK_IOC, SK_MBUF*);
