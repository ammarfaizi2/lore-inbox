Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311456AbSCNAjo>; Wed, 13 Mar 2002 19:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311457AbSCNAjg>; Wed, 13 Mar 2002 19:39:36 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:28298 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S311456AbSCNAjI>; Wed, 13 Mar 2002 19:39:08 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 13 Mar 2002 16:39:04 -0800
Message-Id: <200203140039.QAA05438@adam.yggdrasil.com>
To: Deanna_Bonds@adaptec.com
Subject: Patch?: dpt_i2o.c port to 2.5.7-pre1
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This code is very similar to the i2o subsystem, yet it is not the same.
>When I get free of my current project I will work on updating this module
>(unless someone beats me to it).
>
>Deanna


	Thanks for your response about the dpt_i2o driver.  From your
comments and Alan Cox's, I understood that I should not try to figure
out how to get drivers/messags/i2o/ take over any of the dpt_i2o.c code.

	Here is a first pass at porting dpt_i2o.c to the DMA mapping
system in linux-2.5.7-pre1.  I haven't started testing any of these
drivers, so this code is likely not to work at this stage.

	This patch also requires the changes to
linux/drivers/{scsi.{c,h},hosts.h} that I posted with other scsi
changes.  I can send you those changes separately if you want.

	Here are a few things that you might want to look at when
you get free of your current project:

	- Bug?: In adpt_i2o_query_scalar, you set opblk[4] to -1 if
	  field is -1.  Did you mean to do this or did you mean to
	  set opblk[3] instead?  I ask because the "whole group" comment
	  make me wonder if you are trying to set the location where
	  where you stored the value of "group" (that is, opblk[3]).
	  (Also note that I have changed it to pHba->opblk due to
	  the DMA mapping stuff.)

	- There are a lot of calls to pci_alloc_consistent because of
	  the need to allocate variable length data blocks for
	  pHba->hrt and pHba->lct.  If you could figure out an upper
	  bound for their sizes, then allocation of this data could
	  be rolled into the allocation of reply_pool at device
	  initialization time.  Currently pci_alloc_consistent
	  allocates memory in page sized increments (may change in the
	  future).  So, the current scheme probably wastes almost two
	  pages.  More importantly, it puts memory allocations that
	  take time and might fail in what may be the path for
	  doing regular I/O operations (not sure).  So, the driver
	  may fail when there is a memory shortage (if so, you
	  do not want to put your swap device on one of these).

	- gcc-3.0.4 complains that the variable DebugFlags is
	  not used anywhere.

	- I believe that the GCC complaint that the operation on line
	  1170 may be undefined is actually a compiler bug.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."


--- linux-2.5.7-pre1/drivers/scsi/dpti.h	Thu Mar  7 18:18:03 2002
+++ linux/drivers/scsi/dpti.h	Wed Mar 13 16:05:53 2002
@@ -95,7 +95,9 @@
 	sg_tablesize: 0,		/* max scatter-gather cmds    */\
 	cmd_per_lun: 256,		/* cmds per lun (linked cmds) */\
 	use_clustering: ENABLE_CLUSTERING,				\
-	proc_name: "dpt_i2o"	/* this is the name of our proc node*/	\
+	proc_name: "dpt_i2o",	/* this is the name of our proc node*/	\
+	dma_map_request: 1,						\
+	dma_map_sense: 0,						\
 }
 #endif
 
@@ -255,6 +257,10 @@
 #define DPTI_STATE_RESET	(0x01)
 #define DPTI_STATE_IOCTL	(0x02)
 
+#define OPBLK_SIZE		(2*6) /* An I2o_PARAMS_FIELD_GET command */
+#define RESBLK_MAX_SIZE		40 /* 8 + max buflen parameter given to
+				      adpt_i2o_query_scalar */
+
 typedef struct _adpt_hba {
 	struct _adpt_hba *next;
 	struct pci_dev *pDev;
@@ -272,22 +278,37 @@
 	ulong base_addr_virt;
 	ulong msg_addr_virt;
 	ulong base_addr_phys;
+	ulong msg_addr_phys;
 	ulong  post_port;
+	dma_addr_t post_port_dma;
 	ulong  reply_port;
+	dma_addr_t reply_port_dma;;
 	ulong  irq_mask;
+	dma_addr_t irq_mask_dma;
 	u16  post_count;
 	u32  post_fifo_size;
 	u32  reply_fifo_size;
 	u32* reply_pool;
+	int reply_pool_size;
+	dma_addr_t reply_pool_dma;
 	u32  sg_tablesize;	// Scatter/Gather List Size.       
 	u8  top_scsi_channel;
 	u8  top_scsi_id;
 	u8  top_scsi_lun;
 
-	i2o_status_block* status_block;
+	unsigned char *opblk;
+	dma_addr_t opblk_dma;
+	void *resblk;
+	dma_addr_t resblk_dma;
+
+	i2o_status_block status_block;
+	dma_addr_t status_block_bus;
 	i2o_hrt* hrt;
+	int hrt_size;
+	dma_addr_t hrt_dma;
 	i2o_lct* lct;
 	uint lct_size;
+	dma_addr_t lct_dma;
 	struct i2o_device* devices;
 	struct adpt_channel channel[MAX_CHANNEL];
 	struct proc_dir_entry* proc_entry;	/* /proc dir */
@@ -325,7 +346,9 @@
 static const char *adpt_i2o_get_class_name(int class);
 #endif
 static int adpt_i2o_issue_params(int cmd, adpt_hba* pHba, int tid, 
-		  void *opblk, int oplen, void *resblk, int reslen);
+				 dma_addr_t opblk_dma, int oplen,
+				 void *resblk, dma_addr_t resblk_dma,
+				 int reslen);
 static int adpt_i2o_post_wait(adpt_hba* pHba, u32* msg, int len, int timeout);
 static int adpt_i2o_lct_get(adpt_hba* pHba);
 static int adpt_i2o_parse_lct(adpt_hba* pHba);
--- linux-2.5.7-pre1/drivers/scsi/dpt_i2o.c	Thu Mar  7 18:18:19 2002
+++ linux/drivers/scsi/dpt_i2o.c	Wed Mar 13 16:28:24 2002
@@ -28,8 +28,6 @@
 
 #define ADDR32 (0)
 
-#error Please convert me to Documentation/DMA-mapping.txt
-
 #include <linux/version.h>
 #include <linux/module.h>
 
@@ -62,7 +60,7 @@
 
 #include <asm/processor.h>	/* for boot_cpu_data */
 #include <asm/pgtable.h>
-#include <asm/io.h>		/* for virt_to_bus, etc. */
+#include <asm/io.h>		/* for ioremap, etc. */
 
 #include "scsi.h"
 #include "hosts.h"
@@ -289,11 +287,13 @@
 	u32 len;
 	u32 reqlen;
 	u8* buf;
+	dma_addr_t buf_dma;
 	u8  scb[16];
 	s32 rcode;
+	const int bufsize = 80;
 
 	memset(msg, 0, sizeof(msg));
-	buf = (u8*)kmalloc(80,GFP_KERNEL|ADDR32);
+	buf = pci_alloc_consistent(pHba->pDev, bufsize, &buf_dma);
 	if(!buf){
 		printk(KERN_ERR"%s: Could not allocate buffer\n",pHba->name);
 		return;
@@ -338,7 +338,7 @@
 	/* Now fill in the SGList and command */
 	*lenptr = len;
 	*mptr++ = 0xD0000000|direction|len;
-	*mptr++ = virt_to_bus(buf);
+	*mptr++ = buf_dma;
 
 	// Send it on it's way
 	rcode = adpt_i2o_post_wait(pHba, msg, reqlen<<2, 120);
@@ -354,7 +354,7 @@
 		memcpy(&(pHba->detail[44]), (u8*) &buf[32], 4);
 		pHba->detail[48] = '\0';	/* precautionary */
 	}
-	kfree(buf);
+	pci_free_consistent(pHba->pDev, bufsize, buf, buf_dma);
 	adpt_i2o_status_get(pHba);
 	return ;
 }
@@ -894,6 +894,7 @@
 				hba_map0_area_size = 0x100000;
 			}
 		}
+		base_addr1_phys = base_addr0_phys;
 	} else {// Raptor split BAR config
 		// Use BAR1 in this configuration
 		base_addr1_phys = pci_resource_start(pDev,1);
@@ -953,18 +954,24 @@
 
 	pHba->pDev = pDev;
 	pHba->base_addr_phys = base_addr0_phys;
+	pHba->msg_addr_phys = base_addr1_phys;
 
 	// Set up the Virtual Base Address of the I2O Device
 	pHba->base_addr_virt = base_addr_virt;
 	pHba->msg_addr_virt = msg_addr_virt;  
+
 	pHba->irq_mask = (ulong)(base_addr_virt+0x30);
+	pHba->irq_mask_dma = base_addr0_phys + 0x30;
+
 	pHba->post_port = (ulong)(base_addr_virt+0x40);
+	pHba->post_port_dma = base_addr0_phys + 0x40;
+
 	pHba->reply_port = (ulong)(base_addr_virt+0x44);
+	pHba->reply_port_dma = base_addr0_phys + 0x44;
 
 	pHba->hrt = NULL;
 	pHba->lct = NULL;
 	pHba->lct_size = 0;
-	pHba->status_block = NULL;
 	pHba->post_count = 0;
 	pHba->state = DPTI_STATE_RESET;
 	pHba->pDev = pDev;
@@ -982,6 +989,15 @@
 		printk(KERN_INFO"     BAR1 %lx - size= %x\n",msg_addr_virt,hba_map1_area_size);
 	}
 
+	pHba->status_block_bus = pci_map_single(pDev, &pHba->status_block,
+						sizeof(pHba->status_block),
+						PCI_DMA_FROMDEVICE);
+	if (!pHba->status_block_bus) {
+		printk(KERN_ERR "%s: Couldn't map status block for DMA",
+		       pHba->name);
+		adpt_i2o_delete_hba(pHba);
+		return -EINVAL;
+	}
 	if (request_irq (pDev->irq, adpt_isr, SA_SHIRQ, pHba->name, pHba)) {
 		printk(KERN_ERR"%s: Couldn't register IRQ %d\n", pHba->name, pDev->irq);
 		adpt_i2o_delete_hba(pHba);
@@ -1005,6 +1021,13 @@
 
 
 	down(&adpt_configuration_lock);
+
+	if (pHba->status_block_bus)
+		pci_unmap_single(pHba->pDev, pHba->status_block_bus,
+				 sizeof(pHba->status_block),
+				 PCI_DMA_FROMDEVICE);
+
+
 	// scsi_unregister calls our adpt_release which
 	// does a quiese
 	if(pHba->host){
@@ -1035,16 +1058,18 @@
 		iounmap((void*)pHba->msg_addr_virt);
 	}
 	if(pHba->hrt) {
-		kfree(pHba->hrt);
+		pci_free_consistent(pHba->pDev, pHba->hrt_size,
+				    pHba->hrt, pHba->hrt_dma);
 	}
 	if(pHba->lct){
-		kfree(pHba->lct);
-	}
-	if(pHba->status_block) {
-		kfree(pHba->status_block);
+		pci_free_consistent(pHba->pDev, pHba->lct_size,
+				    pHba->lct, pHba->lct_dma);
 	}
 	if(pHba->reply_pool){
-		kfree(pHba->reply_pool);
+		pci_free_consistent(pHba->pDev,
+				    pHba->reply_fifo_size * REPLY_FRAME_SIZE*4
+				    + OPBLK_SIZE + RESBLK_MAX_SIZE,
+				    pHba->reply_pool, pHba->reply_pool_dma);
 	}
 
 	for(d = pHba->devices; d ; d = next){
@@ -1272,8 +1297,10 @@
 {
 	u32 msg[8];
 	u8* status;
+	dma_addr_t status_dma;
 	u32 m = EMPTY_QUEUE ;
 	ulong timeout = jiffies + (TMOUT_IOPRESET*HZ);
+	int err = 0;
 
 	if(pHba->initialized  == FALSE) {	// First time reset should be quick
 		timeout = jiffies + (25*HZ);
@@ -1299,6 +1326,14 @@
 		printk(KERN_ERR"IOP reset failed - no free memory.\n");
 		return -ENOMEM;
 	}
+	status_dma = pci_map_single(pHba->pDev, status, 4, PCI_DMA_FROMDEVICE);
+	if (status_dma == 0) {
+		kfree(status);
+		adpt_send_nop(pHba, m);
+		printk(KERN_ERR"IOP reset failed - no free memory.\n");
+		return -ENOMEM;
+	}
+
 	memset(status,0,4);
 
 	msg[0]=EIGHT_WORD_MSG_SIZE|SGL_OFFSET_0;
@@ -1307,7 +1342,7 @@
 	msg[3]=0;
 	msg[4]=0;
 	msg[5]=0;
-	msg[6]=virt_to_bus(status);
+	msg[6]=status_dma;
 	msg[7]=0;     
 
 	memcpy_toio(pHba->msg_addr_virt+m, msg, sizeof(msg));
@@ -1318,8 +1353,8 @@
 	while(*status == 0){
 		if(time_after(jiffies,timeout)){
 			printk(KERN_WARNING"%s: IOP Reset Timeout\n",pHba->name);
-			kfree(status);
-			return -ETIMEDOUT;
+			err = -ETIMEDOUT;
+			goto done;
 		}
 		rmb();
 	}
@@ -1336,7 +1371,8 @@
 			}
 			if(time_after(jiffies,timeout)){
 				printk(KERN_ERR "%s:Timeout waiting for IOP Reset.\n",pHba->name);
-				return -ETIMEDOUT;
+				err = -ETIMEDOUT;
+				goto done;
 			}
 		} while (m == EMPTY_QUEUE);
 		// Flush the offset
@@ -1344,20 +1380,22 @@
 	}
 	adpt_i2o_status_get(pHba);
 	if(*status == 0x02 ||
-			pHba->status_block->iop_state != ADAPTER_STATE_RESET) {
+			pHba->status_block.iop_state != ADAPTER_STATE_RESET) {
 		printk(KERN_WARNING"%s: Reset reject, trying to clear\n",
 				pHba->name);
 	} else {
 		PDEBUG("%s: Reset completed.\n", pHba->name);
 	}
 
+ done:
+	pci_unmap_single(pHba->pDev, status_dma, 4, PCI_DMA_FROMDEVICE);
 	kfree(status);
 #ifdef UARTDELAY
 	// This delay is to allow someone attached to the card through the debug UART to 
 	// set up the dump levels that they want before the rest of the initialization sequence
 	adpt_delay(20000);
 #endif
-	return 0;
+	return err;
 }
 
 
@@ -1614,6 +1652,7 @@
 {
 	u32 msg[MAX_MESSAGE_SIZE];
 	u32* reply = NULL;
+	dma_addr_t reply_dma;
 	u32 size = 0;
 	u32 reply_size = 0;
 	u32* user_msg = (u32*)arg;
@@ -1622,10 +1661,11 @@
 	u32 sg_offset = 0;
 	u32 sg_count = 0;
 	int sg_index = 0;
-	u32 i = 0;
+	u32 i;
 	u32 rcode = 0;
-	ulong p = 0;
 	ulong flags = 0;
+	int alloc_size;
+	struct sg_simple_element *sg = NULL;
 
 	memset(&msg, 0, MAX_MESSAGE_SIZE*4);
 	// get user msg size in u32s 
@@ -1650,44 +1690,58 @@
 		reply_size = REPLY_FRAME_SIZE;
 	}
 	reply_size *= 4;
-	reply = kmalloc(REPLY_FRAME_SIZE*4, GFP_KERNEL);
-	if(reply == NULL) {
-		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",pHba->name);
-		return -ENOMEM;
-	}
-	memset(reply,0,REPLY_FRAME_SIZE*4);
+	reply = pci_alloc_consistent(pHba->pDev,REPLY_FRAME_SIZE*4,&reply_dma);
+	alloc_size = REPLY_FRAME_SIZE*4;
 	sg_offset = (msg[0]>>4)&0xf;
 	msg[2] = 0x40000000; // IOCTL context
-	msg[3] = (u32)reply;
+	msg[3] = (u32)reply_dma;
 	memset(sg_list,0, sizeof(sg_list[0])*pHba->sg_tablesize);
 	if(sg_offset) {
 		// TODO 64bit fix
-		struct sg_simple_element *sg =  (struct sg_simple_element*) (msg+sg_offset);
 		sg_count = (size - sg_offset*4) / sizeof(struct sg_simple_element);
 		if (sg_count > pHba->sg_tablesize){
 			printk(KERN_DEBUG"%s:IOCTL SG List too large (%u)\n", pHba->name,sg_count);
-			kfree (reply);
 			return -EINVAL;
 		}
-
+		sg =  (struct sg_simple_element*) (msg+sg_offset);
 		for(i = 0; i < sg_count; i++) {
-			int sg_size;
-
+			alloc_size += sg[i].flag_count & 0xffffff;
 			if (!(sg[i].flag_count & 0x10000000 /*I2O_SGL_FLAGS_SIMPLE_ADDRESS_ELEMENT*/)) {
 				printk(KERN_DEBUG"%s:Bad SG element %d - not simple (%x)\n",pHba->name,i,  sg[i].flag_count);
-				rcode = -EINVAL;
-				goto cleanup;
+				return -EINVAL;
 			}
+		}
+
+	}
+
+	reply = pci_alloc_consistent(pHba->pDev, alloc_size, &reply_dma);
+	if(reply == NULL) {
+		printk(KERN_WARNING"%s: Could not allocate reply buffer\n",pHba->name);
+		return -ENOMEM;
+	}
+	memset(reply,0,REPLY_FRAME_SIZE*4);
+
+	/* TODO: Since we are now copying the data in contiguously, we
+	   could construct a one element scatter/gather list for the whole
+	   thing, like so:
+	   	new_sg_list[0].addr_bus = p_dma;
+	   	new_sg_list[0].flags_count = sg_total_size
+
+	   It is unclear to me if the results returned by the controller
+	   might be different (for example, if there is some packetization
+	   information that would be lost). --Adam Richter.
+	*/
+
+	if(sg_offset) {
+		void *p = ((void*) reply) + (REPLY_FRAME_SIZE*4);
+		dma_addr_t p_dma = reply_dma + (REPLY_FRAME_SIZE*4);
+
+		for(i = 0; i < sg_count; i++) {
+			int sg_size;
+
 			sg_size = sg[i].flag_count & 0xffffff;      
 			/* Allocate memory for the transfer */
-			p = (ulong)kmalloc(sg_size, GFP_KERNEL|ADDR32);
-			if(p == 0) {
-				printk(KERN_DEBUG"%s: Could not allocate SG buffer - size = %d buffer number %d of %d\n",
-						pHba->name,sg_size,i,sg_count);
-				rcode = -ENOMEM;
-				goto cleanup;
-			}
-			sg_list[sg_index++] = p; // sglist indexed with input frame, not our internal frame.
+			sg_list[sg_index++] = (u32) p; // sglist indexed with input frame, not our internal frame.
 			/* Copy in the user's SG buffer if necessary */
 			if(sg[i].flag_count & 0x04000000 /*I2O_SGL_FLAGS_DIR*/) {
 				// TODO 64bit fix
@@ -1698,7 +1752,9 @@
 				}
 			}
 			//TODO 64bit fix
-			sg[i].addr_bus = (u32)virt_to_bus((void*)p);
+			sg[i].addr_bus = p_dma;
+			p += sg_size;
+			p_dma += sg_size;
 		}
 	}
 
@@ -1772,12 +1828,7 @@
 
 
 cleanup:
-	kfree (reply);
-	while(sg_index) {
-		if(sg_list[--sg_index]) {
-			kfree((void*)(sg_list[sg_index]));
-		}
-	}
+	pci_free_consistent(pHba->pDev, alloc_size, reply, reply_dma);
 	return rcode;
 }
 
@@ -2011,7 +2062,7 @@
 				goto out;
 			}
 		}
-		reply = (ulong)bus_to_virt(m);
+		reply = m + (pHba->msg_addr_virt - pHba->msg_addr_phys);
 
 		if (readl(reply) & MSG_FAIL) {
 			u32 old_m = readl(reply+28); 
@@ -2077,6 +2128,7 @@
 	u32 len;
 	u32 reqlen;
 	s32 rcode;
+	struct scatterlist *sg;
 
 	memset(msg, 0 , sizeof(msg));
 	len = cmd->request_bufflen;
@@ -2136,32 +2188,23 @@
 	lenptr=mptr++;		/* Remember me - fill in when we know */
 	reqlen = 14;		// SINGLE SGE
 	/* Now fill in the SGList and command */
-	if(cmd->use_sg) {
-		struct scatterlist *sg = (struct scatterlist *)cmd->request_buffer;
-		len = 0;
-		for(i = 0 ; i < cmd->use_sg; i++) {
-			*mptr++ = direction|0x10000000|sg->length;
-			len+=sg->length;
-			*mptr++ = virt_to_bus(sg->address);
-			sg++;
-		}
-		/* Make this an end of list */
-		mptr[-2] = direction|0xD0000000|(sg-1)->length;
-		reqlen = mptr - msg;
-		*lenptr = len;
+
+	sg = cmd->SCp.buffer;
+	len = 0;
+	for(i = 0 ; i < cmd->SCp.buffers_residual; i++) {
+		*mptr++ = direction|0x10000000|sg->length;
+		len+= sg_dma_len(sg);
+		*mptr++ = sg_dma_address(sg);
+		sg++;
+	}
+	/* Make this an end of list */
+	mptr[-2] = direction|0xD0000000|(sg-1)->length;
+	reqlen = mptr - msg;
+	*lenptr = len;
 		
-		if(cmd->underflow && len != cmd->underflow){
-			printk(KERN_WARNING"Cmd len %08X Cmd underflow %08X\n",
-				len, cmd->underflow);
-		}
-	} else {
-		*lenptr = len = cmd->request_bufflen;
-		if(len == 0) {
-			reqlen = 12;
-		} else {
-			*mptr++ = 0xD0000000|direction|cmd->request_bufflen;
-			*mptr++ = virt_to_bus(cmd->request_buffer);
-		}
+	if(cmd->underflow && len != cmd->underflow){
+		printk(KERN_WARNING"Cmd len %08X Cmd underflow %08X\n",
+		       len, cmd->underflow);
 	}
 	
 	/* Stick the headers on */
@@ -2203,6 +2246,7 @@
 	host->sg_tablesize = pHba->sg_tablesize;
 	host->can_queue = pHba->post_fifo_size;
 	host->select_queue_depths = adpt_select_queue_depths;
+	host->pci_dev = sht->pDev;
 
 	return 0;
 }
@@ -2562,17 +2606,17 @@
 			}
 		}
 
-		if(pHba->status_block->iop_state == ADAPTER_STATE_FAULTED) {
+		if(pHba->status_block.iop_state == ADAPTER_STATE_FAULTED) {
 			printk(KERN_CRIT "%s: hardware fault\n", pHba->name);
 			return -1;
 		}
 
-		if (pHba->status_block->iop_state == ADAPTER_STATE_READY ||
-		    pHba->status_block->iop_state == ADAPTER_STATE_OPERATIONAL ||
-		    pHba->status_block->iop_state == ADAPTER_STATE_HOLD ||
-		    pHba->status_block->iop_state == ADAPTER_STATE_FAILED) {
+		if (pHba->status_block.iop_state == ADAPTER_STATE_READY ||
+		    pHba->status_block.iop_state == ADAPTER_STATE_OPERATIONAL ||
+		    pHba->status_block.iop_state == ADAPTER_STATE_HOLD ||
+		    pHba->status_block.iop_state == ADAPTER_STATE_FAILED) {
 			adpt_i2o_reset_hba(pHba);			
-			if (adpt_i2o_status_get(pHba) < 0 || pHba->status_block->iop_state != ADAPTER_STATE_RESET) {
+			if (adpt_i2o_status_get(pHba) < 0 || pHba->status_block.iop_state != ADAPTER_STATE_RESET) {
 				printk(KERN_ERR "%s: Failed to initialize.\n", pHba->name);
 				return -1;
 			}
@@ -2649,10 +2693,11 @@
 static s32 adpt_i2o_init_outbound_q(adpt_hba* pHba)
 {
 	u8 *status;
+	dma_addr_t status_dma;
 	u32 *msg = NULL;
 	int i;
 	ulong timeout = jiffies + TMOUT_INITOUTBOUND*HZ;
-	u32* ptr;
+	dma_addr_t dma_addr;
 	u32 outbound_frame;  // This had to be a 32 bit address
 	u32 m;
 
@@ -2678,6 +2723,13 @@
 			pHba->name);
 		return -ENOMEM;
 	}
+	status_dma = pci_map_single(pHba->pDev, status, 4, PCI_DMA_FROMDEVICE);
+	if (status_dma == 0) {
+		kfree(status);
+		adpt_send_nop(pHba, m);
+		printk(KERN_ERR"IOP reset failed - no free memory.\n");
+		return -ENOMEM;
+	}
 	memset(status, 0, 4);
 
 	writel(EIGHT_WORD_MSG_SIZE| SGL_OFFSET_6, &msg[0]);
@@ -2687,7 +2739,7 @@
 	writel(4096, &msg[4]);		/* Host page frame size */
 	writel((REPLY_FRAME_SIZE)<<16|0x80, &msg[5]);	/* Outbound msg frame size and Initcode */
 	writel(0xD0000004, &msg[6]);		/* Simple SG LE, EOB */
-	writel(virt_to_bus(status), &msg[7]);
+	writel(status_dma, &msg[7]);
 
 	writel(m, pHba->post_port);
 	wmb();
@@ -2702,11 +2754,15 @@
 		rmb();
 		if(time_after(jiffies,timeout)){
 			printk(KERN_WARNING"%s: Timeout Initializing\n",pHba->name);
+			pci_unmap_single(pHba->pDev, status_dma, 4,
+					 PCI_DMA_FROMDEVICE);
 			kfree((void*)status);
 			return -ETIMEDOUT;
 		}
 	} while (1);
 
+	pci_unmap_single(pHba->pDev, status_dma, 4, PCI_DMA_FROMDEVICE);
+
 	// If the command was successful, fill the fifo with our reply
 	// message packets
 	if(*status != 0x04 /*I2O_EXEC_OUTBOUND_INIT_COMPLETE*/) {
@@ -2715,23 +2771,31 @@
 	}
 	kfree((void*)status);
 
-	if(pHba->reply_pool != NULL){
-		kfree(pHba->reply_pool);
-	}
+	pHba->reply_pool = pci_alloc_consistent(pHba->pDev,
+						pHba->reply_fifo_size *
+						REPLY_FRAME_SIZE * 4 +
+						OPBLK_SIZE + RESBLK_MAX_SIZE,
+						&pHba->reply_pool_dma);
 
-	pHba->reply_pool = (u32*)kmalloc(pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4, GFP_KERNEL|ADDR32);
 	if(!pHba->reply_pool){
 		printk(KERN_ERR"%s: Could not allocate reply pool\n",pHba->name);
 		return -1;
 	}
 	memset(pHba->reply_pool, 0 , pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4);
+	pHba->opblk = ((void*) pHba->reply_pool) +
+		pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4;
+	pHba->opblk_dma = pHba->reply_pool_dma +
+		pHba->reply_fifo_size * REPLY_FRAME_SIZE * 4;
+
+	pHba->resblk = pHba->opblk + OPBLK_SIZE;
+	pHba->resblk_dma = pHba->opblk_dma + OPBLK_SIZE;
 
-	ptr = pHba->reply_pool;
+	dma_addr = pHba->reply_pool_dma;
 	for(i = 0; i < pHba->reply_fifo_size; i++) {
-		outbound_frame = (u32)virt_to_bus(ptr);
+		outbound_frame = dma_addr;
 		writel(outbound_frame, pHba->reply_port);
 		wmb();
-		ptr +=  REPLY_FRAME_SIZE;
+		dma_addr +=  REPLY_FRAME_SIZE;
 	}
 	adpt_i2o_status_get(pHba);
 	return 0;
@@ -2755,21 +2819,9 @@
 	u32 m;
 	u32 *msg;
 	u8 *status_block=NULL;
-	ulong status_block_bus;
 
-	if(pHba->status_block == NULL) {
-		pHba->status_block = (i2o_status_block*)
-			kmalloc(sizeof(i2o_status_block),GFP_KERNEL|ADDR32);
-		if(pHba->status_block == NULL) {
-			printk(KERN_ERR
-			"dpti%d: Get Status Block failed; Out of memory. \n", 
-			pHba->unit);
-			return -ENOMEM;
-		}
-	}
-	memset(pHba->status_block, 0, sizeof(i2o_status_block));
-	status_block = (u8*)(pHba->status_block);
-	status_block_bus = virt_to_bus(pHba->status_block);
+	memset(&pHba->status_block, 0, sizeof(i2o_status_block));
+	status_block = (u8*)(&pHba->status_block);
 	timeout = jiffies+TMOUT_GETSTATUS*HZ;
 	do {
 		rmb();
@@ -2793,7 +2845,7 @@
 	writel(0, &msg[3]);
 	writel(0, &msg[4]);
 	writel(0, &msg[5]);
-	writel(((u32)status_block_bus)&0xffffffff, &msg[6]);
+	writel(((u32)pHba->status_block_bus)&0xffffffff, &msg[6]);
 	writel(0, &msg[7]);
 	writel(sizeof(i2o_status_block), &msg[8]); // 88 bytes
 
@@ -2811,18 +2863,18 @@
 	}
 
 	// Set up our number of outbound and inbound messages
-	pHba->post_fifo_size = pHba->status_block->max_inbound_frames;
+	pHba->post_fifo_size = pHba->status_block.max_inbound_frames;
 	if (pHba->post_fifo_size > MAX_TO_IOP_MESSAGES) {
 		pHba->post_fifo_size = MAX_TO_IOP_MESSAGES;
 	}
 
-	pHba->reply_fifo_size = pHba->status_block->max_outbound_frames;
+	pHba->reply_fifo_size = pHba->status_block.max_outbound_frames;
 	if (pHba->reply_fifo_size > MAX_FROM_IOP_MESSAGES) {
 		pHba->reply_fifo_size = MAX_FROM_IOP_MESSAGES;
 	}
 
 	// Calculate the Scatter Gather list size
-	pHba->sg_tablesize = (pHba->status_block->inbound_frame_size * 4 -40)/ sizeof(struct sg_simple_element);
+	pHba->sg_tablesize = (pHba->status_block.inbound_frame_size * 4 -40)/ sizeof(struct sg_simple_element);
 	if (pHba->sg_tablesize > SG_LIST_ELEMENTS) {
 		pHba->sg_tablesize = SG_LIST_ELEMENTS;
 	}
@@ -2830,7 +2882,7 @@
 
 #ifdef DEBUG
 	printk("dpti%d: State = ",pHba->unit);
-	switch(pHba->status_block->iop_state) {
+	switch(pHba->status_block.iop_state) {
 		case 0x01:
 			printk("INIT\n");
 			break;
@@ -2853,7 +2905,7 @@
 			printk("FAULTED\n");
 			break;
 		default:
-			printk("%x (unknown!!)\n",pHba->status_block->iop_state);
+			printk("%x (unknown!!)\n",pHba->status_block.iop_state);
 	}
 #endif
 	return 0;
@@ -2869,11 +2921,13 @@
 	u32 buf[16];
 
 	if ((pHba->lct_size == 0) || (pHba->lct == NULL)){
-		pHba->lct_size = pHba->status_block->expected_lct_size;
+		pHba->lct_size = pHba->status_block.expected_lct_size;
 	}
 	do {
 		if (pHba->lct == NULL) {
-			pHba->lct = kmalloc(pHba->lct_size, GFP_KERNEL|ADDR32);
+			pHba->lct = pci_alloc_consistent(pHba->pDev,
+							 pHba->lct_size,
+							 &pHba->lct_dma);
 			if(pHba->lct == NULL) {
 				printk(KERN_CRIT "%s: Lct Get failed. Out of memory.\n",
 					pHba->name);
@@ -2889,7 +2943,7 @@
 		msg[4] = 0xFFFFFFFF;	/* All devices */
 		msg[5] = 0x00000000;	/* Report now */
 		msg[6] = 0xD0000000|pHba->lct_size;
-		msg[7] = virt_to_bus(pHba->lct);
+		msg[7] = pHba->lct_dma;
 
 		if ((ret=adpt_i2o_post_wait(pHba, msg, sizeof(msg), 360))) {
 			printk(KERN_ERR "%s: LCT Get failed (status=%#10x.\n", 
@@ -2900,7 +2954,8 @@
 
 		if ((pHba->lct->table_size << 2) > pHba->lct_size) {
 			pHba->lct_size = pHba->lct->table_size << 2;
-			kfree(pHba->lct);
+			pci_free_consistent(pHba->pDev, pHba->lct_size,
+					    pHba->lct, pHba->lct_dma);
 			pHba->lct = NULL;
 		}
 	} while (pHba->lct == NULL);
@@ -2952,17 +3007,17 @@
 			continue; // try next one	
 		}
 
-		sys_tbl->iops[count].org_id = pHba->status_block->org_id;
+		sys_tbl->iops[count].org_id = pHba->status_block.org_id;
 		sys_tbl->iops[count].iop_id = pHba->unit + 2;
 		sys_tbl->iops[count].seg_num = 0;
-		sys_tbl->iops[count].i2o_version = pHba->status_block->i2o_version;
-		sys_tbl->iops[count].iop_state = pHba->status_block->iop_state;
-		sys_tbl->iops[count].msg_type = pHba->status_block->msg_type;
-		sys_tbl->iops[count].frame_size = pHba->status_block->inbound_frame_size;
+		sys_tbl->iops[count].i2o_version = pHba->status_block.i2o_version;
+		sys_tbl->iops[count].iop_state = pHba->status_block.iop_state;
+		sys_tbl->iops[count].msg_type = pHba->status_block.msg_type;
+		sys_tbl->iops[count].frame_size = pHba->status_block.inbound_frame_size;
 		sys_tbl->iops[count].last_changed = sys_tbl_ind - 1; // ??
-		sys_tbl->iops[count].iop_capabilities = pHba->status_block->iop_capabilities;
-		sys_tbl->iops[count].inbound_low = (u32)virt_to_bus((void*)pHba->post_port);
-		sys_tbl->iops[count].inbound_high = (u32)((u64)virt_to_bus((void*)pHba->post_port)>>32);
+		sys_tbl->iops[count].iop_capabilities = pHba->status_block.iop_capabilities;
+		sys_tbl->iops[count].inbound_low = pHba->post_port_dma;
+		sys_tbl->iops[count].inbound_high = ((u64)pHba->post_port_dma)>>32;
 
 		count++;
 	}
@@ -3098,11 +3153,13 @@
 
 	do {
 		if (pHba->hrt == NULL) {
-			pHba->hrt=kmalloc(size, GFP_KERNEL|ADDR32);
+			pHba->hrt = pci_alloc_consistent(pHba->pDev, size,
+							 &pHba->hrt_dma);
 			if (pHba->hrt == NULL) {
 				printk(KERN_CRIT "%s: Hrt Get failed; Out of memory.\n", pHba->name);
 				return -ENOMEM;
 			}
+			pHba->hrt_size = size;
 		}
 
 		msg[0]= SIX_WORD_MSG_SIZE| SGL_OFFSET_4;
@@ -3110,7 +3167,7 @@
 		msg[2]= 0;
 		msg[3]= 0;
 		msg[4]= (0xD0000000 | size);    /* Simple transaction */
-		msg[5]= virt_to_bus(pHba->hrt);   /* Dump it here */
+		msg[5]= pHba->hrt_dma;		/* Dump it here */
 
 		if ((ret = adpt_i2o_post_wait(pHba, msg, sizeof(msg),20))) {
 			printk(KERN_ERR "%s: Unable to get HRT (status=%#10x)\n", pHba->name, ret);
@@ -3119,7 +3176,8 @@
 
 		if (pHba->hrt->num_entries * pHba->hrt->entry_len << 2 > size) {
 			size = pHba->hrt->num_entries * pHba->hrt->entry_len << 2;
-			kfree(pHba->hrt);
+			pci_free_consistent(pHba->pDev, pHba->hrt_size,
+					    pHba->hrt, pHba->hrt_dma);
 			pHba->hrt = NULL;
 		}
 	} while(pHba->hrt == NULL);
@@ -3133,16 +3191,22 @@
 			int group, int field, void *buf, int buflen)
 {
 	u16 opblk[] = { 1, 0, I2O_PARAMS_FIELD_GET, group, 1, field };
-	u8  resblk[8+buflen]; /* 8 bytes for header */
 	int size;
+	const int resblk_size = buflen + 8;
+
+	if (resblk_size > RESBLK_MAX_SIZE)
+		panic ("adpt_i2o_query_scalar: buflen too large");
 
+	memcpy(pHba->opblk, opblk, sizeof(opblk));
 	if (field == -1)  		/* whole group */
-			opblk[4] = -1;
+			pHba->opblk[4] = -1;
 
 	size = adpt_i2o_issue_params(I2O_CMD_UTIL_PARAMS_GET, pHba, tid, 
-		opblk, sizeof(opblk), resblk, sizeof(resblk));
-			
-	memcpy(buf, resblk+8, buflen);  /* cut off header */
+				     pHba->opblk_dma, sizeof(opblk),
+				     pHba->resblk, pHba->resblk_dma,
+				     resblk_size);
+
+	memcpy(buf, pHba->resblk+8, buflen);  /* cut off header */
 
 	if (size < 0)
 		return size;	
@@ -3160,7 +3224,9 @@
  *	ResultCount, ErrorInfoSize, BlockStatus and BlockSize.
  */
 static int adpt_i2o_issue_params(int cmd, adpt_hba* pHba, int tid, 
-		  void *opblk, int oplen, void *resblk, int reslen)
+				 dma_addr_t opblk_dma, int oplen,
+				 void *resblk, dma_addr_t resblk_dma,
+				 int reslen)
 {
 	u32 msg[9]; 
 	u32 *res = (u32 *)resblk;
@@ -3172,10 +3238,9 @@
 	msg[3] = 0;
 	msg[4] = 0;
 	msg[5] = 0x54000000 | oplen;	/* OperationBlock */
-	msg[6] = virt_to_bus(opblk);
+	msg[6] = opblk_dma;
 	msg[7] = 0xD0000000 | reslen;	/* ResultBlock */
-	msg[8] = virt_to_bus(resblk);
-
+	msg[8] = resblk_dma;
 	if ((wait_status = adpt_i2o_post_wait(pHba, msg, sizeof(msg), 20))) {
    		return wait_status; 	/* -DetailedStatus */
 	}
@@ -3203,8 +3268,8 @@
 
 	/* SysQuiesce discarded if IOP not in READY or OPERATIONAL state */
 
-	if((pHba->status_block->iop_state != ADAPTER_STATE_READY) &&
-   	   (pHba->status_block->iop_state != ADAPTER_STATE_OPERATIONAL)){
+	if((pHba->status_block.iop_state != ADAPTER_STATE_READY) &&
+   	   (pHba->status_block.iop_state != ADAPTER_STATE_OPERATIONAL)){
 		return 0;
 	}
 
@@ -3234,14 +3299,11 @@
 	int ret;
 	
 	adpt_i2o_status_get(pHba);
-	if(!pHba->status_block){
-		return -ENOMEM;
-	}
 	/* Enable only allowed on READY state */
-	if(pHba->status_block->iop_state == ADAPTER_STATE_OPERATIONAL)
+	if(pHba->status_block.iop_state == ADAPTER_STATE_OPERATIONAL)
 		return 0;
 
-	if(pHba->status_block->iop_state != ADAPTER_STATE_READY)
+	if(pHba->status_block.iop_state != ADAPTER_STATE_READY)
 		return -EINVAL;
 
 	msg[0]=FOUR_WORD_MSG_SIZE|SGL_OFFSET_0;
