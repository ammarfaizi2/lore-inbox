Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261441AbVAaXbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261441AbVAaXbu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVAaXaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:30:20 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:2460 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261441AbVAaX1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:27:14 -0500
Message-ID: <41FEBEC2.5050501@comcast.net>
Date: Mon, 31 Jan 2005 18:26:58 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: Andrew Morton <akpm@osdl.org>, bcollins@debian.org,
       linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
References: <41FD498C.9000708@comcast.net>	<20050130131723.781991d3.akpm@osdl.org>	<41FD6478.9040404@comcast.net> <20050130150224.33299170.akpm@osdl.org> <41FD8796.2020509@comcast.net>
In-Reply-To: <41FD8796.2020509@comcast.net>
Content-Type: multipart/mixed;
 boundary="------------050708050100020602080902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708050100020602080902
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Forgot to attach ohci.h diff which is affected by this change as well.

Meanwhile, David Brownell suggested it would be much simpler to move the 
dma allocations to _probe and  deallocations to _remove.
I am working on it and so far haven't got it to work.

Andrew - What do you think? If you too feel allocating pci_pool for the 
legacy contexts (only disadvantage I see is that the pool will be 
allocated even if it is not used, that is if ISO_LISTEN_CHANNEL isn't 
called any time)  in _probe an removing it in _remove is a better thing 
to do, I will concentrate on getting that to work and we can forget 
about this patch. I feel there might be some reason why the current code 
treats the legacy IR and IT DMA ctxs differently (on-demand  
allocation).. Ben?

Parag

Parag Warudkar wrote:

> Attached is the reworked patch to take care of Andrew's suggestions -
>
> 1) Allocate the work struct dynamically in struct ti_ohci during  
> device probe, free it during device remove
> 2) In ohci1394_pci_remove, ensure queued work, if any, is flushed 
> before the device is removed (As I understand, this should work for 
> both device removal cases as well as module removal - correct?)
> 3) Rework the free_dma_rcv_ctx  - It is called in multiple contexts by 
> different callers - teach it to free the dma according to caller's 
> wish - either direct free where caller determines the context is safe 
> to sleep OR delayed via schedule_work when caller wants to call it 
> from a context where it cannot sleep.  So it now takes 2 extra 
> arguments - method to free - direct or delayed and if it is to be  
> freed delayed, an appropriate work_struct.
>
> Andrew - flush_scheduled_work does not touch work which isn't 
> shceduled - so I don't think INIT_WORK in setup is necessary. Let me 
> know if I am missing something here. (I tried INIT_WORK in 
> ochi1394_pci_probe and putting flush_scheduled_work in 
> ohci1394_pci_remove - It did not result in calling the work function 
> after I did rmmod, since it wasn't scheduled.)
>
> Parag
>
>
>------------------------------------------------------------------------
>
>--- drivers/ieee1394/ohci1394.c.orig	2004-12-24 16:35:25.000000000 -0500
>+++ drivers/ieee1394/ohci1394.c	2005-01-30 20:00:42.000000000 -0500
>@@ -99,6 +99,7 @@
> #include <asm/uaccess.h>
> #include <linux/delay.h>
> #include <linux/spinlock.h>
>+#include <linux/workqueue.h>
> 
> #include <asm/pgtable.h>
> #include <asm/page.h>
>@@ -161,6 +162,10 @@
> #define PRINT(level, fmt, args...) \
> printk(level "%s: fw-host%d: " fmt "\n" , OHCI1394_DRIVER_NAME, ohci->host->id , ## args)
> 
>+/* Instruct free_dma_rcv_ctx how to free dma pools */
>+#define OHCI_FREE_DMA_CTX_DIRECT 0
>+#define OHCI_FREE_DMA_CTX_DELAYED 1
>+
> static char version[] __devinitdata =
> 	"$Rev: 1223 $ Ben Collins <bcollins@debian.org>";
> 
>@@ -176,7 +181,8 @@
> 			     enum context_type type, int ctx, int num_desc,
> 			     int buf_size, int split_buf_size, int context_base);
> static void stop_dma_rcv_ctx(struct dma_rcv_ctx *d);
>-static void free_dma_rcv_ctx(struct dma_rcv_ctx *d);
>+static void free_dma_rcv_ctx(struct dma_rcv_ctx *d , int method,
>+			     struct work_struct* work);
> 
> static int alloc_dma_trm_ctx(struct ti_ohci *ohci, struct dma_trm_ctx *d,
> 			     enum context_type type, int ctx, int num_desc,
>@@ -184,6 +190,8 @@
> 
> static void ohci1394_pci_remove(struct pci_dev *pdev);
> 
>+static void ohci_free_irlc_pci_pool(void* data);
>+
> #ifndef __LITTLE_ENDIAN
> static unsigned hdr_sizes[] =
> {
>@@ -1117,7 +1125,8 @@
> 
> 		if (ohci->ir_legacy_channels == 0) {
> 			stop_dma_rcv_ctx(&ohci->ir_legacy_context);
>-			free_dma_rcv_ctx(&ohci->ir_legacy_context);
>+			INIT_WORK(ohci->irlc_free_dma, ohci_free_irlc_pci_pool, ohci->ir_legacy_context.prg_pool);
>+			free_dma_rcv_ctx(&ohci->ir_legacy_context, OHCI_FREE_DMA_CTX_DELAYED, ohci->irlc_free_dma);
> 			DBGMSG("ISO receive legacy context deactivated");
> 		}
>                 break;
>@@ -2876,7 +2885,8 @@
> }
> 
> 
>-static void free_dma_rcv_ctx(struct dma_rcv_ctx *d)
>+static void free_dma_rcv_ctx(struct dma_rcv_ctx *d, int method,
>+		struct work_struct* work)
> {
> 	int i;
> 	struct ti_ohci *ohci = d->ohci;
>@@ -2903,8 +2913,20 @@
> 				pci_pool_free(d->prg_pool, d->prg_cpu[i], d->prg_bus[i]);
> 				OHCI_DMA_FREE("consistent dma_rcv prg[%d]", i);
> 			}
>-		pci_pool_destroy(d->prg_pool);
>-		OHCI_DMA_FREE("dma_rcv prg pool");
>+		if(method == OHCI_FREE_DMA_CTX_DIRECT)
>+		{
>+			pci_pool_destroy(d->prg_pool);
>+			OHCI_DMA_FREE("dma_rcv prg pool");
>+		}
>+		
>+		else if(method == OHCI_FREE_DMA_CTX_DELAYED)
>+		{
>+			schedule_work(work);
>+		}
>+
>+		else
>+			PRINT(KERN_ERR, "Invalid method passed - %d", method);
>+
> 		kfree(d->prg_cpu);
> 		kfree(d->prg_bus);
> 	}
>@@ -2938,7 +2960,7 @@
> 
> 	if (d->buf_cpu == NULL || d->buf_bus == NULL) {
> 		PRINT(KERN_ERR, "Failed to allocate dma buffer");
>-		free_dma_rcv_ctx(d);
>+		free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 		return -ENOMEM;
> 	}
> 	memset(d->buf_cpu, 0, d->num_desc * sizeof(quadlet_t*));
>@@ -2950,7 +2972,7 @@
> 
> 	if (d->prg_cpu == NULL || d->prg_bus == NULL) {
> 		PRINT(KERN_ERR, "Failed to allocate dma prg");
>-		free_dma_rcv_ctx(d);
>+		free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 		return -ENOMEM;
> 	}
> 	memset(d->prg_cpu, 0, d->num_desc * sizeof(struct dma_cmd*));
>@@ -2960,7 +2982,7 @@
> 
> 	if (d->spb == NULL) {
> 		PRINT(KERN_ERR, "Failed to allocate split buffer");
>-		free_dma_rcv_ctx(d);
>+		free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 		return -ENOMEM;
> 	}
> 
>@@ -2979,7 +3001,7 @@
> 		} else {
> 			PRINT(KERN_ERR,
> 			      "Failed to allocate dma buffer");
>-			free_dma_rcv_ctx(d);
>+			free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 			return -ENOMEM;
> 		}
> 
>@@ -2991,7 +3013,7 @@
> 		} else {
> 			PRINT(KERN_ERR,
> 			      "Failed to allocate dma prg");
>-			free_dma_rcv_ctx(d);
>+			free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 			return -ENOMEM;
> 		}
> 	}
>@@ -3005,7 +3027,7 @@
> 		if (ohci1394_register_iso_tasklet(ohci,
> 						  &ohci->ir_legacy_tasklet) < 0) {
> 			PRINT(KERN_ERR, "No IR DMA context available");
>-			free_dma_rcv_ctx(d);
>+			free_dma_rcv_ctx(d, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 			return -EBUSY;
> 		}
> 
>@@ -3355,6 +3377,7 @@
> 
> 	/* the IR DMA context is allocated on-demand; mark it inactive */
> 	ohci->ir_legacy_context.ohci = NULL;
>+	ohci->ir_legacy_context.prg_pool = NULL;
> 
> 	/* same for the IT DMA context */
> 	ohci->it_legacy_context.ohci = NULL;
>@@ -3377,16 +3400,32 @@
> 	if (hpsb_add_host(host))
> 		FAIL(-ENOMEM, "Failed to register host with highlevel");
> 
>+	ohci->irlc_free_dma = kmalloc(sizeof(struct work_struct), GFP_KERNEL);
>+	if(ohci->irlc_free_dma == NULL)
>+		FAIL(-ENOMEM, "Failed to allocate memory for ohci->irlc_free_dma");
>+
> 	ohci->init_state = OHCI_INIT_DONE;
> 
> 	return 0;
> #undef FAIL
> }
> 
>+static void ohci_free_irlc_pci_pool(void *data)
>+{
>+	if(data == NULL)
>+		return;
>+	pci_pool_destroy(data);
>+	OHCI_DMA_FREE("dma_rcv prg pool");
>+	return;
>+}
>+	
> static void ohci1394_pci_remove(struct pci_dev *pdev)
> {
> 	struct ti_ohci *ohci;
> 	struct device *dev;
>+	
>+	/* Ensure all dma ctx are freed */
>+	flush_scheduled_work();
> 
> 	ohci = pci_get_drvdata(pdev);
> 	if (!ohci)
>@@ -3432,18 +3471,21 @@
> 		/* The ohci_soft_reset() stops all DMA contexts, so we
> 		 * dont need to do this.  */
> 		/* Free AR dma */
>-		free_dma_rcv_ctx(&ohci->ar_req_context);
>-		free_dma_rcv_ctx(&ohci->ar_resp_context);
>+		free_dma_rcv_ctx(&ohci->ar_req_context, OHCI_FREE_DMA_CTX_DIRECT, NULL);
>+		free_dma_rcv_ctx(&ohci->ar_resp_context, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 
> 		/* Free AT dma */
> 		free_dma_trm_ctx(&ohci->at_req_context);
> 		free_dma_trm_ctx(&ohci->at_resp_context);
> 
> 		/* Free IR dma */
>-		free_dma_rcv_ctx(&ohci->ir_legacy_context);
>+		free_dma_rcv_ctx(&ohci->ir_legacy_context, OHCI_FREE_DMA_CTX_DIRECT, NULL);
> 
> 		/* Free IT dma */
> 		free_dma_trm_ctx(&ohci->it_legacy_context);
>+		
>+		/* Free work struct for IR Legacy DMA */
>+		kfree(ohci->irlc_free_dma);
> 
> 	case OHCI_INIT_HAVE_SELFID_BUFFER:
> 		pci_free_consistent(ohci->dev, OHCI1394_SI_DMA_BUF_SIZE,
>  
>


--------------050708050100020602080902
Content-Type: text/plain;
 name="ohci1394.h.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ohci1394.h.patch"

--- drivers/ieee1394/ohci1394.h.orig	2004-12-24 16:34:00.000000000 -0500
+++ drivers/ieee1394/ohci1394.h	2005-01-31 18:16:31.000000000 -0500
@@ -197,6 +197,8 @@
 				   it is safe to free the legacy API context */
 
 	struct dma_rcv_ctx ir_legacy_context;
+	struct work_struct* irlc_free_dma;
+	
 	struct ohci1394_iso_tasklet ir_legacy_tasklet;
 
         /* iso transmit */

--------------050708050100020602080902--
