Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315239AbSEQAv7>; Thu, 16 May 2002 20:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315245AbSEQAv6>; Thu, 16 May 2002 20:51:58 -0400
Received: from roc-24-95-199-137.rochester.rr.com ([24.95.199.137]:56817 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S315239AbSEQAv4>;
	Thu, 16 May 2002 20:51:56 -0400
Date: Thu, 16 May 2002 20:51:46 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Cc: davej@suse.de
Subject: [RFC][PATCH] cpqarray-1: Convert to modern module_init mechanism
Message-ID: <20020517005146.GA32719@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Below is a patch (against 2.5.15-dj1) to convert cpqarray over to the modern
module_init mechanism. This eliminates the need to call cpqarray_init() from
genhd.c and starts the process of simplifying the cpqarray init sequence.
It lays the groundwork for converting over to the "new" PCI registration
mechanism as well. Also included in the patch are some simple cleanups for
a few obvious formatting flaws.

Comments and critique are welcome. I'm also curious if this work is
considered worthwhile. If so, I'll continue on and do the PCI init conversion
(and any other fixups that may be warranted) as well.

--Adam


--- linux-2.5.15-dj1-virgin/drivers/block/cpqarray.c	Tue May 14 23:09:31 2002
+++ linux-2.5.15-dj1/drivers/block/cpqarray.c	Tue May 14 23:18:16 2002
@@ -115,7 +115,6 @@
 /* Debug Extra Paranoid... */
 #define DBGPX(s) do { } while(0)
 
-int cpqarray_init(void);
 static int cpqarray_pci_detect(void);
 static int cpqarray_pci_init(ctlr_info_t *c, struct pci_dev *pdev);
 static void *remap_pci_mem(ulong base, ulong size);
@@ -293,20 +292,7 @@
 }
 #endif /* CONFIG_PROC_FS */
 
-#ifdef MODULE
-
-MODULE_PARM(eisa, "1-8i");
-EXPORT_NO_SYMBOLS;
-
-/* This is a bit of a hack... */
-int __init init_module(void)
-{
-	if (cpqarray_init() == 0) /* all the block dev numbers already used */
-		return -EIO;	  /* or no controllers were found */
-	return 0;
-}
-
-void cleanup_module(void)
+void __exit cpqarray_exit(void)
 {
 	int i;
 	char buff[4]; 
@@ -339,12 +325,12 @@
 	kfree(ida);
 	kfree(ida_sizes);
 }
-#endif /* MODULE */
+
 
 /*
  *  This is it.  Find all the controllers and register them.  I really hate
  *  stealing all these major device numbers.
- *  returns the number of block devices registered.
+ *  returns 0 on success, -EIO on failure
  */
 int __init cpqarray_init(void)
 {
@@ -357,7 +343,7 @@
 	cpqarray_eisa_detect();
 	
 	if (nr_ctlr == 0)
-		return(num_cntlrs_reg);
+		return -EIO;
 
 	printk(DRIVER_NAME "\n");
 	printk("Found %d controller(s)\n", nr_ctlr);
@@ -367,7 +353,7 @@
 	if(ida==NULL)
 	{
 		printk( KERN_ERR "cpqarray: out of memory");
-		return(num_cntlrs_reg);
+		return -EIO;
 	}
 	
 	ida_sizes = kmalloc(sizeof(int)*nr_ctlr*NWD*16, GFP_KERNEL);
@@ -375,7 +361,7 @@
 	{
 		kfree(ida); 
 		printk( KERN_ERR "cpqarray: out of memory");
-		return(num_cntlrs_reg);
+		return -EIO;
 	}
 
 	memset(ida, 0, sizeof(struct hd_struct)*nr_ctlr*NWD*16);
@@ -396,7 +382,6 @@
                         continue;
                 }
 
-	
 		hba[i]->access.set_intr_mask(hba[i], 0);
 		if (request_irq(hba[i]->intr, do_ida_intr,
 			SA_INTERRUPT|SA_SHIRQ, hba[i]->devname, hba[i])) {
@@ -413,7 +398,7 @@
 		hba[i]->cmd_pool_bits = (__u32*)kmalloc(
 				((NR_CMDS+31)/32)*sizeof(__u32), GFP_KERNEL);
 		
-	if(hba[i]->cmd_pool_bits == NULL || hba[i]->cmd_pool == NULL)
+		if(hba[i]->cmd_pool_bits == NULL || hba[i]->cmd_pool == NULL)
 		{
 			nr_ctlr = i; 
 			if(hba[i]->cmd_pool_bits)
@@ -427,20 +412,9 @@
 			unregister_blkdev(MAJOR_NR+i, hba[i]->devname);
 			num_cntlrs_reg--;
                 	printk( KERN_ERR "cpqarray: out of memory");
-
-			/* If num_cntlrs_reg == 0, no controllers worked. 
-			 *	init_module will fail, so clean up global 
-			 *	memory that clean_module would do.
-			*/	
-	
-			if (num_cntlrs_reg == 0) 
-			{
-				kfree(ida);
-				kfree(ida_sizes);
-			}
-                	return(num_cntlrs_reg);
-	
+			break;
 		}
+	
 		memset(hba[i]->cmd_pool, 0, NR_CMDS * sizeof(cmdlist_t));
 		memset(hba[i]->cmd_pool_bits, 0, ((NR_CMDS+31)/32)*sizeof(__u32));
 		printk(KERN_INFO "cpqarray: Finding drives on %s", 
@@ -489,10 +463,24 @@
 				16, &ida_fops, hba[i]->drv[j].nr_blks);
 
 	}
-	/* done ! */
-	return(num_cntlrs_reg);
+
+	/* Clean up if no controllers were registered */
+	if (num_cntlrs_reg == 0) {
+		kfree(ida);
+		kfree(ida_sizes);
+		return -EIO;
+	}
+
+	return 0;
 }
 
+MODULE_PARM(eisa, "1-8i");
+EXPORT_NO_SYMBOLS;
+
+module_init(cpqarray_init);
+module_exit(cpqarray_exit);
+
+
 /*
  * Find the controller and initialize it
  *  Cannot use the class code to search, because older array controllers use
@@ -504,9 +492,17 @@
 	struct pci_dev *pdev;
 
 #define IDA_BOARD_TYPES 3
-	static int ida_vendor_id[IDA_BOARD_TYPES] = { PCI_VENDOR_ID_DEC, 
-		PCI_VENDOR_ID_NCR, PCI_VENDOR_ID_COMPAQ };
-	static int ida_device_id[IDA_BOARD_TYPES] = { PCI_DEVICE_ID_COMPAQ_42XX,		PCI_DEVICE_ID_NCR_53C1510, PCI_DEVICE_ID_COMPAQ_SMART2P };
+
+	static int ida_vendor_id[IDA_BOARD_TYPES] = {
+		PCI_VENDOR_ID_DEC,
+		PCI_VENDOR_ID_NCR,
+		PCI_VENDOR_ID_COMPAQ };
+
+	static int ida_device_id[IDA_BOARD_TYPES] = {
+		PCI_DEVICE_ID_COMPAQ_42XX,
+		PCI_DEVICE_ID_NCR_53C1510,
+		PCI_DEVICE_ID_COMPAQ_SMART2P };
+
 	int brdtype;
 	
 	/* search for all PCI board types that could be for this driver */
@@ -526,9 +522,10 @@
 				break;
 			}
 			
-/* if it is a PCI_DEVICE_ID_NCR_53C1510, make sure it's 				the Compaq version of the chip */ 
-
-			if (ida_device_id[brdtype] == PCI_DEVICE_ID_NCR_53C1510)			{	
+			/* if it is a PCI_DEVICE_ID_NCR_53C1510, make sure it's
+			   the Compaq version of the chip */
+			if (ida_device_id[brdtype] == PCI_DEVICE_ID_NCR_53C1510)
+			{
 				unsigned short subvendor=pdev->subsystem_vendor;
 				if(subvendor !=  PCI_VENDOR_ID_COMPAQ)
 				{
@@ -538,7 +535,8 @@
 				}
 			}
 
-			hba[nr_ctlr] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);			if(hba[nr_ctlr]==NULL)
+			hba[nr_ctlr] = kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);
+			if(hba[nr_ctlr]==NULL)
 			{
 				printk(KERN_ERR "cpqarray: out of memory.\n");
 				continue;
@@ -659,12 +657,10 @@
         return (page_remapped ? (page_remapped + page_offs) : NULL);
 }
 
-#ifndef MODULE
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
 /*
  * Config string is a comma seperated set of i/o addresses of EISA cards.
  */
-static int cpqarray_setup(char *str)
+static __init int cpqarray_setup(char *str)
 {
 	int i, ints[9];
 
@@ -677,20 +673,6 @@
 
 __setup("smart2=", cpqarray_setup);
 
-#else
-
-/*
- * Copy the contents of the ints[] array passed to us by init.
- */
-void cpqarray_setup(char *str, int *ints)
-{
-	int i;
-	for(i=0; i<ints[0] && i<8; i++)
-		eisa[i] = ints[i+1];
-}
-#endif
-#endif
-
 /*
  * Find an EISA controller's signature.  Set up an hba if we find it.
  */
@@ -713,7 +695,8 @@
 
 		if (j == NR_PRODUCTS) {
 			printk(KERN_WARNING "cpqarray: Sorry, I don't know how"
-				" to access the SMART Array controller %08lx\n",				 (unsigned long)board_id);
+				" to access the SMART Array controller %08lx\n",
+				(unsigned long)board_id);
 			continue;
 		}
 		hba[nr_ctlr] = (ctlr_info_t *) kmalloc(sizeof(ctlr_info_t), GFP_KERNEL);


