Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRAVXor>; Mon, 22 Jan 2001 18:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135626AbRAVXoi>; Mon, 22 Jan 2001 18:44:38 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:23889
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S132754AbRAVXmt>; Mon, 22 Jan 2001 18:42:49 -0500
Date: Tue, 23 Jan 2001 00:42:42 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] drivers/scsi/inia100.c cleanup (241p9)
Message-ID: <20010123004242.O602@jaquet.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

The following patch makes drivers/scsi/inia100.c refrain from 
calling panic(), makes it check the return code of request_region
and makes it release a lot of resources on error.

It applies cleanly against ac10 and 241p9.

Comments?


--- linux-ac10-clean/drivers/scsi/inia100.c	Sun Nov 12 04:01:11 2000
+++ linux-ac10/drivers/scsi/inia100.c	Sun Jan 21 23:57:30 2001
@@ -119,7 +119,6 @@
 static void inia100_intr6(int irq, void *dev_id, struct pt_regs *);
 static void inia100_intr7(int irq, void *dev_id, struct pt_regs *);
 
-static void inia100_panic(char *msg);
 void inia100SCBPost(BYTE * pHcb, BYTE * pScb);
 
 /* ---- EXTERNAL VARIABLES ---- */
@@ -192,8 +191,10 @@
 *****************************************************************************/
 void inia100_setup(char *str, int *ints)
 {
-	if (setup_called)
-		inia100_panic("inia100: inia100_setup called twice.\n");
+	if (setup_called) {
+		printk(KERN_ERR "inia100: inia100_setup called twice.\n");
+		return;
+	}
 
 	setup_called = ints[0];
 	setup_str = str;
@@ -204,8 +205,8 @@
  Description	: This function will scan PCI bus to get all Orchid card
  Input		: None.
  Output		: None.
- Return		: SUCCESSFUL	- Successful scan
-		  ohterwise	- No drives founded
+ Return		: n > 0	- n adapters found
+		  0	- No drives found
 *****************************************************************************/
 int orc_ReturnNumberOfAdapters(void)
 {
@@ -261,9 +262,9 @@
 					bPCIBusNum = pdev->bus->number;
 					bPCIDeviceNum = pdev->devfn;
 					dRegValue = pci_resource_start(pdev, 0);
-					if (dRegValue == -1) {	/* Check return code            */
+					if (dRegValue == NULL) {	/* Check return code            */
 						printk("\n\rinia100: orchid read configuration error.\n");
-						return (0);	/* Read configuration space error  */
+						return (iAdapters);	/* Read configuration space error  */
 					}
 
 					/* <02> read from base address + 0x50 offset to get the wBIOS balue. */
@@ -281,10 +282,6 @@
 					base = wBASE & PAGE_MASK;
 					page_offset = wBASE - base;
 
-					/*
-					 * replace the next line with this one if you are using 2.1.x:
-					 * temp_p->maddr = ioremap(base, page_offset + 256);
-					 */
 					wBASE = ioremap(base, page_offset + 256);
 					if (wBASE) {
 						wBASE += page_offset;
@@ -314,6 +311,7 @@
 	struct Scsi_Host *hreg;
 	U32 sz;
 	U32 i;			/* 01/14/98                     */
+	U32 n;
 	int ok = 0, iAdapters;
 	ULONG dBiosAdr;
 	BYTE *pbBiosAdr;
@@ -354,7 +352,7 @@
 		sz = orc_num_scb * sizeof(ORC_SCB);
 		if ((pHCB->HCS_virScbArray = (PVOID) kmalloc(sz, GFP_ATOMIC | GFP_DMA)) == NULL) {
 			printk("inia100: SCB memory allocation error\n");
-			return (0);
+			goto err_out;
 		}
 		memset((unsigned char *) pHCB->HCS_virScbArray, 0, sz);
 		pHCB->HCS_physScbArray = (U32) VIRT_TO_BUS(pHCB->HCS_virScbArray);
@@ -363,8 +361,7 @@
 		sz = orc_num_scb * sizeof(ESCB);
 		if ((pHCB->HCS_virEscbArray = (PVOID) kmalloc(sz, GFP_ATOMIC | GFP_DMA)) == NULL) {
 			printk("inia100: ESCB memory allocation error\n");
-			/* ?? does pHCB->HCS_virtScbArray leak ??*/
-			return (0);
+			goto err_kfree;
 		}
 		memset((unsigned char *) pHCB->HCS_virEscbArray, 0, sz);
 		pHCB->HCS_physEscbArray = (U32) VIRT_TO_BUS(pHCB->HCS_virEscbArray);
@@ -378,15 +375,14 @@
 
 		if (init_orchid(pHCB)) {	/* Initial orchid chip    */
 			printk("inia100: initial orchid fail!!\n");
-			return (0);
+			goto err_kfreeII;
 		}
-		request_region(pHCB->HCS_Base, 256, "inia100");	/* Register */
+		if (!request_region(pHCB->HCS_Base, 256, "inia100"))	/* Register */
+			goto err_kfreeII;
 
 		hreg = scsi_register(tpnt, sizeof(ORC_HCS));
-		if (hreg == NULL) {
-			release_region(pHCB->HCS_Base, 256);	/* Register */
-			return 0;
-		}
+		if (hreg == NULL)
+			goto err_release;
 		hreg->io_port = pHCB->HCS_Base;
 		hreg->n_io_port = 0xff;
 		hreg->can_queue = orc_num_scb;	/* 03/05/98                   */
@@ -436,8 +432,8 @@
 			ok = request_irq(pHCB->HCS_Intr, inia100_intr7, SA_INTERRUPT | SA_SHIRQ, "inia100", hreg);
 			break;
 		default:
-			inia100_panic("inia100: Too many host adapters\n");
-			break;
+			printk(KERN_WARNING"inia100: Too many host adapters\n");
+			goto err_unregister;
 		}
 
 		if (ok < 0) {
@@ -453,13 +449,34 @@
 					printk("         Contact author.\n");
 				}
 			}
-			inia100_panic("inia100: driver needs an IRQ.\n");
+			goto err_unregister;
 		}
 	}
 
 	tpnt->this_id = -1;
 	tpnt->can_queue = 1;
 	return 1;
+
+ err_unregister:
+	scsi_unregister(hreg);
+ err_release:
+	release_region(pHCB->HCS_Base, 256);
+ err_kfreeII:
+	kfree(pHCB->HCS_virtEscbArray);
+ err_kfree:
+	kfree(pHCB->HCS_virtScbArray);
+ err_out: 
+#ifdef MMAPIO
+	for(n=i; n<orc_num_ch; n++) {
+		unsigmed long base = inia100_adpt[n].ADPT_BASE & PAGE_MASK;
+		unsigned long page_offset = inia100_adpt[n].ADPT_BASE - base;
+		iounmap( base, page_offset+256);
+	}
+#endif
+
+	if (i > 0)
+		return 1;
+	return 0;
 }
 
 /*****************************************************************************
@@ -775,15 +792,6 @@
 static void inia100_intr7(int irqno, void *dev_id, struct pt_regs *regs)
 {
 	subIntr(&orc_hcs[7], irqno);
-}
-
-/* 
- * Dump the current driver status and panic...
- */
-static void inia100_panic(char *msg)
-{
-	printk("\ninia100_panic: %s\n", msg);
-	panic("inia100 panic");
 }
 
 /*

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

With searching comes loss
and the presence of absence:
"My Novel" not found.     --- Error messages in haiku
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
