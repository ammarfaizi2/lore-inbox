Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932295AbVKGRGZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbVKGRGZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932296AbVKGRGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:06:25 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:9945
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932295AbVKGRGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:06:24 -0500
Subject: [PATCH] update synclink to use DMA mapping API
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1131383114.6625.4.camel@deimos.microgate.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 07 Nov 2005 11:05:14 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update synclink to use DMA mapping API.
This removes warning about isa_virt_to_bus()
usage on architectures other than i386

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.14/drivers/char/synclink.c	2005-10-27 19:02:08.000000000 -0500
+++ linux-2.6.14-mg/drivers/char/synclink.c	2005-11-07 10:59:08.000000000 -0600
@@ -1,7 +1,7 @@
 /*
  * linux/drivers/char/synclink.c
  *
- * $Id: synclink.c,v 4.37 2005/09/07 13:13:19 paulkf Exp $
+ * $Id: synclink.c,v 4.38 2005/11/07 16:30:34 paulkf Exp $
  *
  * Device driver for Microgate SyncLink ISA and PCI
  * high speed multiprotocol serial adapters.
@@ -101,6 +101,7 @@
 #include <linux/termios.h>
 #include <linux/workqueue.h>
 #include <linux/hdlc.h>
+#include <linux/dma-mapping.h>
 
 #ifdef CONFIG_HDLC_MODULE
 #define CONFIG_HDLC 1
@@ -148,6 +149,7 @@ typedef struct _DMABUFFERENTRY
 	u32 link;	/* 32-bit flat link to next buffer entry */
 	char *virt_addr;	/* virtual address of data buffer */
 	u32 phys_entry;	/* physical address of this buffer entry */
+	dma_addr_t dma_addr;
 } DMABUFFERENTRY, *DMAPBUFFERENTRY;
 
 /* The queue of BH actions to be performed */
@@ -233,7 +235,8 @@ struct mgsl_struct {
 	int ri_chkcount;
 
 	char *buffer_list;		/* virtual address of Rx & Tx buffer lists */
-	unsigned long buffer_list_phys;
+	u32 buffer_list_phys;
+	dma_addr_t buffer_list_dma_addr;
 
 	unsigned int rx_buffer_count;	/* count of total allocated Rx buffers */
 	DMABUFFERENTRY *rx_buffer_list;	/* list of receive buffer entries */
@@ -896,7 +899,7 @@ module_param_array(txdmabufs, int, NULL,
 module_param_array(txholdbufs, int, NULL, 0);
 
 static char *driver_name = "SyncLink serial driver";
-static char *driver_version = "$Revision: 4.37 $";
+static char *driver_version = "$Revision: 4.38 $";
 
 static int synclink_init_one (struct pci_dev *dev,
 				     const struct pci_device_id *ent);
@@ -3811,11 +3814,10 @@ static int mgsl_alloc_buffer_list_memory
 		/* inspect portions of the buffer while other portions are being */
 		/* updated by the adapter using Bus Master DMA. */
 
-		info->buffer_list = kmalloc(BUFFERLISTSIZE, GFP_KERNEL | GFP_DMA);
-		if ( info->buffer_list == NULL )
+		info->buffer_list = dma_alloc_coherent(NULL, BUFFERLISTSIZE, &info->buffer_list_dma_addr, GFP_KERNEL);
+		if (info->buffer_list == NULL)
 			return -ENOMEM;
-			
-		info->buffer_list_phys = isa_virt_to_bus(info->buffer_list);
+		info->buffer_list_phys = (u32)(info->buffer_list_dma_addr);
 	}
 
 	/* We got the memory for the buffer entry lists. */
@@ -3882,8 +3884,8 @@ static int mgsl_alloc_buffer_list_memory
  */
 static void mgsl_free_buffer_list_memory( struct mgsl_struct *info )
 {
-	if ( info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI )
-		kfree(info->buffer_list);
+	if (info->buffer_list && info->bus_type != MGSL_BUS_TYPE_PCI)
+		dma_free_coherent(NULL, BUFFERLISTSIZE, info->buffer_list, info->buffer_list_dma_addr);
 		
 	info->buffer_list = NULL;
 	info->rx_buffer_list = NULL;
@@ -3910,7 +3912,7 @@ static void mgsl_free_buffer_list_memory
 static int mgsl_alloc_frame_memory(struct mgsl_struct *info,DMABUFFERENTRY *BufferList,int Buffercount)
 {
 	int i;
-	unsigned long phys_addr;
+	u32 phys_addr;
 
 	/* Allocate page sized buffers for the receive buffer list */
 
@@ -3922,11 +3924,10 @@ static int mgsl_alloc_frame_memory(struc
 			info->last_mem_alloc += DMABUFFERSIZE;
 		} else {
 			/* ISA adapter uses system memory. */
-			BufferList[i].virt_addr = 
-				kmalloc(DMABUFFERSIZE, GFP_KERNEL | GFP_DMA);
-			if ( BufferList[i].virt_addr == NULL )
+			BufferList[i].virt_addr = dma_alloc_coherent(NULL, DMABUFFERSIZE, &BufferList[i].dma_addr, GFP_KERNEL);
+			if (BufferList[i].virt_addr == NULL)
 				return -ENOMEM;
-			phys_addr = isa_virt_to_bus(BufferList[i].virt_addr);
+			phys_addr = (u32)(BufferList[i].dma_addr);
 		}
 		BufferList[i].phys_addr = phys_addr;
 	}
@@ -3957,7 +3958,7 @@ static void mgsl_free_frame_memory(struc
 		for ( i = 0 ; i < Buffercount ; i++ ) {
 			if ( BufferList[i].virt_addr ) {
 				if ( info->bus_type != MGSL_BUS_TYPE_PCI )
-					kfree(BufferList[i].virt_addr);
+					dma_free_coherent(NULL, DMABUFFERSIZE, BufferList[i].virt_addr, BufferList[i].dma_addr);
 				BufferList[i].virt_addr = NULL;
 			}
 		}


