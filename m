Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261501AbSJDGNd>; Fri, 4 Oct 2002 02:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbSJDGNd>; Fri, 4 Oct 2002 02:13:33 -0400
Received: from 200-171-183-235.dsl.telesp.net.br ([200.171.183.235]:9745 "EHLO
	techlinux.com.br") by vger.kernel.org with ESMTP id <S261501AbSJDGN2>;
	Fri, 4 Oct 2002 02:13:28 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carlos E Gorges <carlos@techlinux.com.br>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40 - DMA-mapping && misc
Date: Fri, 4 Oct 2002 03:19:00 -0300
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210040319.00136.carlos@techlinux.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/53c7,8xx.c linux-2.5/drivers/scsi/53c7,8xx.c
--- linux-2.5.40/drivers/scsi/53c7,8xx.c	Tue Oct  1 04:06:15 2002
+++ linux-2.5/drivers/scsi/53c7,8xx.c	Fri Oct  4 02:53:48 2002
@@ -62,8 +62,6 @@
  *  the fourth byte from 50 to 25.
  */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/config.h>
 
 #ifdef CONFIG_SCSI_NCR53C7xx_sync
@@ -3788,7 +3786,9 @@
     for (i = 0; cmd->use_sg ? (i < cmd->use_sg) : !i; cmd_datain += 4, 
 	cmd_dataout += 4, ++i) {
 	u32 buf = cmd->use_sg ? 
-	    virt_to_bus(((struct scatterlist *)cmd->buffer)[i].address) :
+	    virt_to_bus(
+		page_address(((struct scatterlist *)cmd->buffer)[i].page) +
+		((struct scatterlist *)cmd->buffer)[i].offset ) :
 	    virt_to_bus(cmd->request_buffer);
 	u32 count = cmd->use_sg ?
 	    ((struct scatterlist *)cmd->buffer)[i].length :
@@ -5735,7 +5735,7 @@
 	(struct NCR53c7x0_cmd *) cmd->host_scribble;
     int offset = 0, buffers;
     struct scatterlist *segment;
-    char *ptr;
+    char *ptr, *seg_addr;
     int found = 0;
 
 /*
@@ -5753,18 +5753,20 @@
 	    ptr = bus_to_virt(le32_to_cpu(insn[3]));
 
 	    if ((buffers = cmd->use_sg)) {
-    	    	for (offset = 0, 
-		     	segment = (struct scatterlist *) cmd->buffer;
-    	    	     buffers && !((found = ((ptr >= segment->address) && 
-    	    	    	    (ptr < (segment->address + segment->length)))));
+		segment = (struct scatterlist *) cmd->buffer;
+		seg_addr = page_address(segment->page) + segment->offset;
+		
+    	    	for (offset = 0;
+    	    	     buffers && !((found = ((ptr >= seg_addr) && 
+    	    	    	    (ptr < (seg_addr + segment->length)))));
     	    	     --buffers, offset += segment->length, ++segment)
 #if 0
 		    printk("scsi%d: comparing 0x%p to 0x%p\n", 
-			cmd->host->host_no, saved, segment->address);
+			cmd->host->host_no, saved, seg_addr);
 #else
 		    ;
 #endif
-    	    	    offset += ptr - segment->address;
+    	    	    offset += ptr - seg_addr;
     	    } else {
 		found = 1;
     	    	offset = ptr - (char *) (cmd->request_buffer);
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/NCR53c406a.c linux-2.5/drivers/scsi/NCR53c406a.c
--- linux-2.5.40/drivers/scsi/NCR53c406a.c	Tue Oct  1 04:06:59 2002
+++ linux-2.5/drivers/scsi/NCR53c406a.c	Fri Oct  4 02:53:48 2002
@@ -896,7 +896,7 @@
                 sgcount = current_SC->use_sg;
                 sglist = current_SC->request_buffer;
                 while( sgcount-- ) {
-                    NCR53c406a_pio_write(sglist->address, sglist->length);
+                    NCR53c406a_pio_write(sglist->address, page_address(sglist->page) + sglist->offset);
                     sglist++;
                 }
             }
@@ -925,7 +925,7 @@
                 sgcount = current_SC->use_sg;
                 sglist = current_SC->request_buffer;
                 while( sgcount-- ) {
-                    NCR53c406a_pio_read(sglist->address, sglist->length);
+                    NCR53c406a_pio_read(sglist->address, page_address(sglist->page) + sglist->offset);
                     sglist++;
                 }
             }
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/dpt_i2o.c linux-2.5/drivers/scsi/dpt_i2o.c
--- linux-2.5.40/drivers/scsi/dpt_i2o.c	Tue Oct  1 04:06:27 2002
+++ linux-2.5/drivers/scsi/dpt_i2o.c	Fri Oct  4 02:53:48 2002
@@ -28,8 +28,6 @@
 
 #define ADDR32 (0)
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/version.h>
 #include <linux/module.h>
 
@@ -2138,7 +2136,7 @@
 		for(i = 0 ; i < cmd->use_sg; i++) {
 			*mptr++ = direction|0x10000000|sg->length;
 			len+=sg->length;
-			*mptr++ = virt_to_bus(sg->address);
+			*mptr++ = virt_to_bus(page_address(sg->page) + sg->offset);
 			sg++;
 		}
 		/* Make this an end of list */
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/eata_dma.c linux-2.5/drivers/scsi/eata_dma.c
--- linux-2.5.40/drivers/scsi/eata_dma.c	Tue Oct  1 04:06:13 2002
+++ linux-2.5/drivers/scsi/eata_dma.c	Fri Oct  4 02:53:48 2002
@@ -63,8 +63,6 @@
 
 /* Look in eata_dma.h for configuration and revision information */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
@@ -574,7 +572,7 @@
 	ccb->cp_datalen = htonl(cmd->use_sg * sizeof(struct eata_sg_list));
 	sl=(struct scatterlist *)cmd->request_buffer;
 	for(i = 0; i < cmd->use_sg; i++, sl++){
-	    ccb->sg_list[i].data = htonl(virt_to_bus(sl->address));
+	    ccb->sg_list[i].data = htonl(virt_to_bus(page_address(sl->page) + sl->offset));
 	    ccb->sg_list[i].len = htonl((u32) sl->length);
 	}
     } else {
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/eata_pio.c linux-2.5/drivers/scsi/eata_pio.c
--- linux-2.5.40/drivers/scsi/eata_pio.c	Tue Oct  1 04:07:10 2002
+++ linux-2.5/drivers/scsi/eata_pio.c	Fri Oct  4 02:53:48 2002
@@ -99,7 +99,7 @@
 	else
 	{
 	    SCp->buffer++;
-	    SCp->ptr=SCp->buffer->address;
+	    SCp->ptr=page_address(SCp->buffer->page) + SCp->buffer->offset;
 	    SCp->this_residual=SCp->buffer->length;
 	}
     }
@@ -372,7 +372,7 @@
     } else {
 	cmd->SCp.buffer = cmd->request_buffer;
 	cmd->SCp.buffers_residual = cmd->use_sg;
-	cmd->SCp.ptr = cmd->SCp.buffer->address;
+	cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
 	cmd->SCp.this_residual = cmd->SCp.buffer->length;
     }
     cmd->SCp.Status = (cmd->SCp.this_residual != 0);  /* TRUE as long as bytes 
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/fdomain.c linux-2.5/drivers/scsi/fdomain.c
--- linux-2.5.40/drivers/scsi/fdomain.c	Tue Oct  1 04:06:19 2002
+++ linux-2.5/drivers/scsi/fdomain.c	Fri Oct  4 02:53:48 2002
@@ -1565,7 +1565,7 @@
 	    if (current_SC->SCp.buffers_residual) {
 	       --current_SC->SCp.buffers_residual;
 	       ++current_SC->SCp.buffer;
-	       current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	       current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	       current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	    } else
 		  break;
@@ -1598,7 +1598,7 @@
 	     && current_SC->SCp.buffers_residual) {
 	    --current_SC->SCp.buffers_residual;
 	    ++current_SC->SCp.buffer;
-	    current_SC->SCp.ptr = current_SC->SCp.buffer->address;
+	    current_SC->SCp.ptr = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
 	    current_SC->SCp.this_residual = current_SC->SCp.buffer->length;
 	 }
       }
@@ -1684,7 +1684,7 @@
    if (current_SC->use_sg) {
       current_SC->SCp.buffer =
 	    (struct scatterlist *)current_SC->request_buffer;
-      current_SC->SCp.ptr              = current_SC->SCp.buffer->address;
+      current_SC->SCp.ptr              = page_address(current_SC->SCp.buffer->page) + current_SC->SCp.buffer->offset;
       current_SC->SCp.this_residual    = current_SC->SCp.buffer->length;
       current_SC->SCp.buffers_residual = current_SC->use_sg - 1;
    } else {
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/in2000.c linux-2.5/drivers/scsi/in2000.c
--- linux-2.5.40/drivers/scsi/in2000.c	Tue Oct  1 04:07:33 2002
+++ linux-2.5/drivers/scsi/in2000.c	Fri Oct  4 02:53:48 2002
@@ -355,7 +355,7 @@
    if (cmd->use_sg) {
       cmd->SCp.buffer = (struct scatterlist *)cmd->buffer;
       cmd->SCp.buffers_residual = cmd->use_sg - 1;
-      cmd->SCp.ptr = (char *)cmd->SCp.buffer->address;
+      cmd->SCp.ptr = page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
       cmd->SCp.this_residual = cmd->SCp.buffer->length;
       }
    else {
@@ -762,8 +762,8 @@
       ++cmd->SCp.buffer;
       --cmd->SCp.buffers_residual;
       cmd->SCp.this_residual = cmd->SCp.buffer->length;
-      cmd->SCp.ptr = cmd->SCp.buffer->address;
-      }
+      cmd->SCp.ptr =  page_address(cmd->SCp.buffer->page) + cmd->SCp.buffer->offset;
+   }
 
 /* Set up hardware registers */
 
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/ini9100u.c linux-2.5/drivers/scsi/ini9100u.c
--- linux-2.5.40/drivers/scsi/ini9100u.c	Tue Oct  1 04:06:26 2002
+++ linux-2.5/drivers/scsi/ini9100u.c	Fri Oct  4 02:53:48 2002
@@ -108,8 +108,6 @@
 
 #define CVT_LINUX_VERSION(V,P,S)        (V * 65536 + P * 256 + S)
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #ifndef LINUX_VERSION_CODE
 #include <linux/version.h>
 #endif
@@ -491,7 +489,7 @@
 	if (SCpnt->use_sg) {
 		pSrbSG = (struct scatterlist *) SCpnt->request_buffer;
 		if (SCpnt->use_sg == 1) {	/* If only one entry in the list *//*      treat it as regular I/O */
-			pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(pSrbSG->address);
+			pSCB->SCB_BufPtr = (U32) VIRT_TO_BUS(page_address(pSrbSG->page)+pSrbSG->offset);
 			TotalLen = pSrbSG->length;
 			pSCB->SCB_SGLen = 0;
 		} else {	/* Assign SG physical address   */
@@ -500,7 +498,7 @@
 			for (i = 0, TotalLen = 0, pSG = &pSCB->SCB_SGList[0];	/* 1.01g */
 			     i < SCpnt->use_sg;
 			     i++, pSG++, pSrbSG++) {
-				pSG->SG_Ptr = (U32) VIRT_TO_BUS(pSrbSG->address);
+				pSG->SG_Ptr = (U32) VIRT_TO_BUS(page_address(pSrbSG->page)+pSrbSG->offset);
 				TotalLen += pSG->SG_Len = pSrbSG->length;
 			}
 			pSCB->SCB_SGLen = i;
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/pci2000.c linux-2.5/drivers/scsi/pci2000.c
--- linux-2.5.40/drivers/scsi/pci2000.c	Tue Oct  1 04:07:11 2002
+++ linux-2.5/drivers/scsi/pci2000.c	Fri Oct  4 02:53:48 2002
@@ -505,8 +505,9 @@
 			
 			if ( SCpnt->use_sg )
 				{
-				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, ((struct scatterlist *)SCpnt->request_buffer)->address, 
-										  SCpnt->request_bufflen, scsi_to_pci_dma_dir (SCpnt->sc_data_direction));
+				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, 
+								page_address(((struct scatterlist *)SCpnt->request_buffer)->page) + ((struct scatterlist *)SCpnt->request_buffer)->offset,
+								SCpnt->request_bufflen, scsi_to_pci_dma_dir (SCpnt->sc_data_direction));
 				}
 			else
 				{
@@ -528,8 +529,9 @@
 		case SCSIOP_READ_CAPACITY:			  	// read capacity CDB
 			if ( SCpnt->use_sg )
 				{
-				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, ((struct scatterlist *)(SCpnt->request_buffer))->address,
-										  8, PCI_DMA_FROMDEVICE);
+				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, 
+								page_address(((struct scatterlist *)SCpnt->request_buffer)->page) + ((struct scatterlist *)SCpnt->request_buffer)->offset,
+								8, PCI_DMA_FROMDEVICE);
 				}
 			else
 				SCpnt->SCp.have_data_in = pci_map_single (padapter->pdev, SCpnt->request_buffer, 8, PCI_DMA_FROMDEVICE);
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/pci2220i.c linux-2.5/drivers/scsi/pci2220i.c
--- linux-2.5.40/drivers/scsi/pci2220i.c	Tue Oct  1 04:06:13 2002
+++ linux-2.5/drivers/scsi/pci2220i.c	Fri Oct  4 02:53:48 2002
@@ -34,8 +34,6 @@
  *
  ****************************************************************************/
 
-#error Convert me to understand page+offset based scatterlists
-
 //#define DEBUG 1
 
 #include <linux/module.h>
@@ -464,7 +462,9 @@
 			{
 			if ( padapter->nextSg < padapter->SCpnt->use_sg )
 				{
-				padapter->currentSgBuffer = ((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].address;
+				padapter->currentSgBuffer = 
+						page_address(((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].page) +
+						 ((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].offset;
 				padapter->currentSgCount = ((struct scatterlist *)padapter->SCpnt->request_buffer)[padapter->nextSg].length;
 				padapter->nextSg++;
 				}
@@ -2050,7 +2050,9 @@
 
 	if ( SCpnt->use_sg )
 		{
-		padapter->currentSgBuffer = ((struct scatterlist *)SCpnt->request_buffer)[0].address;
+		padapter->currentSgBuffer = 
+			page_address(((struct scatterlist *)SCpnt->request_buffer)[0].page) +
+			((struct scatterlist *)SCpnt->request_buffer)[0].offset;
 		padapter->currentSgCount = ((struct scatterlist *)SCpnt->request_buffer)[0].length;
 		}
 	else
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/scsiiom.c linux-2.5/drivers/scsi/scsiiom.c
--- linux-2.5.40/drivers/scsi/scsiiom.c	Tue Oct  1 04:06:16 2002
+++ linux-2.5/drivers/scsi/scsiiom.c	Fri Oct  4 02:53:48 2002
@@ -6,8 +6,6 @@
  ***********************************************************************/
 /* $Id: scsiiom.c,v 2.55.2.17 2000/12/20 00:39:37 garloff Exp $ */
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 static void __inline__
 dc390_freetag (PDCB pDCB, PSRB pSRB)
 {
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/seagate.c linux-2.5/drivers/scsi/seagate.c
--- linux-2.5.40/drivers/scsi/seagate.c	Tue Oct  1 04:06:58 2002
+++ linux-2.5/drivers/scsi/seagate.c	Fri Oct  4 02:53:48 2002
@@ -1069,7 +1069,7 @@
 
 			buffer = (struct scatterlist *) SCint->buffer;
 			len = buffer->length;
-			data = (unsigned char *) buffer->address;
+			data = (unsigned char *) (page_address(buffer->page) + buffer->offset);
 		} else {
 			DPRINTK (DEBUG_SG,
 				 "scsi%d : scatter gather not requested.\n",
@@ -1336,7 +1336,7 @@
 					++buffer;
 					len = buffer->length;
 					data =
-					    (unsigned char *) buffer->address;
+					    (unsigned char *) (page_address(buffer->page) + buffer->offset);
 					DPRINTK (DEBUG_SG,
 						 "scsi%d : next scatter-gather buffer len = %d address = %08x\n",
 						 hostno, len, data);
@@ -1520,7 +1520,7 @@
 					++buffer;
 					len = buffer->length;
 					data =
-					    (unsigned char *) buffer->address;
+					    (unsigned char *) (page_address(buffer->page) + buffer->offset);
 					DPRINTK (DEBUG_SG,
 						 "scsi%d : next scatter-gather buffer len = %d address = %08x\n",
 						 hostno, len, data);
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/sym53c416.c linux-2.5/drivers/scsi/sym53c416.c
--- linux-2.5.40/drivers/scsi/sym53c416.c	Tue Oct  1 04:06:18 2002
+++ linux-2.5/drivers/scsi/sym53c416.c	Fri Oct  4 02:53:48 2002
@@ -449,7 +449,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_write(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_write(base, page_address(sglist->page) + sglist->offset,	sglist->length);
 						sglist++;
 					}
 				}
@@ -475,7 +475,7 @@
 					sglist = current_command->request_buffer;
 					while(sgcount--)
 					{
-						tot_trans += sym53c416_read(base, sglist->address, sglist->length);
+						tot_trans += sym53c416_read(base, page_address(sglist->page) + sglist->offset, sglist->length);
 						sglist++;
 					}
 				}
diff -uar --exclude=*.o --exclude=*.cmd linux-2.5.40/drivers/scsi/wd7000.c linux-2.5/drivers/scsi/wd7000.c
--- linux-2.5.40/drivers/scsi/wd7000.c	Tue Oct  1 04:07:45 2002
+++ linux-2.5/drivers/scsi/wd7000.c	Fri Oct  4 02:53:48 2002
@@ -621,14 +621,13 @@
 	(void)get_options(str, ARRAY_SIZE(ints), ints);
 
 	if (wd7000_card_num >= NUM_CONFIGS) {
-		printk(KERN_ERR __FUNCTION__
-			": Too many \"wd7000=\" configurations in "
+		printk(KERN_ERR ": Too many \"wd7000=\" configurations in "
 			"command line!\n");
 		return 0;
 	}
 
 	if ((ints[0] < 3) || (ints[0] > 5)) {
-		printk(KERN_ERR __FUNCTION__ ": Error in command line!  "
+		printk(KERN_ERR ": Error in command line!  "
 			"Usage: wd7000=<IRQ>,<DMA>,IO>[,<BUS_ON>"
 			"[,<BUS_OFF>]]\n");
 	} else {
@@ -1743,7 +1742,7 @@
 	    ip[2] = info[2];
 
 	    if (info[0] == 255)
-		printk(KERN_INFO __FUNCTION__ ": current partition table is "
+		printk(KERN_INFO ": current partition table is "
 			"using extended translation.\n");
 	}
     }
--

http://www.techlinux.com.br/~carlos/tmp/2.5.40-DMA-mapping_misc.diff

-- 
	 _________________________
	 Carlos E Gorges          
	 (carlos@techlinux.com.br)
	 Tech informática LTDA
	 Brazil                   
	 _________________________


