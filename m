Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261781AbVA3Uyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbVA3Uyp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 15:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVA3Uyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 15:54:45 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:41907 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261781AbVA3Uyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 15:54:39 -0500
Message-ID: <41FD498C.9000708@comcast.net>
Date: Sun, 30 Jan 2005 15:54:36 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: bcollins@debian.org, linux-kernel <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ohci1394: dma_pool_destroy while in_atomic() && irqs_disabled()
Content-Type: multipart/mixed;
 boundary="------------020607070605060307020003"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020607070605060307020003
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Problem - ohci1394.c:ohci_devctl ends up calling dma_pool_destroy from 
invalid context. Below is the dmesg output when I exit Kino after video 
capture -

Debug: sleeping function called from invalid context at 
include/asm/semaphore.h:107
in_atomic():1, irqs_disabled():1
 [<c0104c2e>] dump_stack+0x1e/0x20
 [<c011f8a2>] __might_sleep+0xa2/0xc0
 [<c028c660>] dma_pool_destroy+0x20/0x140
 [<f0b7affe>] free_dma_rcv_ctx+0x8e/0x150 [ohci1394]
 [<f0b774a4>] ohci_devctl+0x214/0x9b0 [ohci1394]
 [<f0e7aa99>] handle_iso_listen+0x2d9/0x310 [raw1394]
 [<f0e7f22b>] state_connected+0x29b/0x2b0 [raw1394]
 [<f0e7f2de>] raw1394_write+0x9e/0xd0 [raw1394]
 [<c0183ef2>] vfs_write+0xc2/0x170
 [<c018406b>] sys_write+0x4b/0x80
 [<c0103cb1>] sysenter_past_esp+0x52/0x75

Attached patch against 2.6.11-rc2 (tested to work normally with a  
camcorder device) enables ohci_devctl to defer the work of destroying 
the dma pool by using a work queue, so the dma pool is destroyed in a 
valid context and we no longer get an error in dmesg (duh :)

Note : There still exists  one more similar problem with ohci1394 - that 
is with dma_pool_create being called from invalid context - this happens 
in response to ISO_LISTEN_CHANNEL. I get dmesg debug for this case which 
is similar to the above. My analysis is that this one is non-trivial to 
fix. More on this in a separate mail.

Patch is attached since T'Bird messes up with the inlined one. (Pls. 
suggest a good email client for kernel patch stuff :)

Signed-off-by: Parag Warudkar (kernel-stuff@comcast.net)


Parag



--------------020607070605060307020003
Content-Type: text/plain;
 name="patch-ohci1394"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-ohci1394"

--- drivers/ieee1394/ohci1394.c.orig	2004-12-24 16:35:25.000000000 -0500
+++ drivers/ieee1394/ohci1394.c	2005-01-30 15:46:34.000000000 -0500
@@ -99,6 +99,7 @@
 #include <asm/uaccess.h>
 #include <linux/delay.h>
 #include <linux/spinlock.h>
+#include <linux/workqueue.h>
 
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -164,6 +165,7 @@
 static char version[] __devinitdata =
 	"$Rev: 1223 $ Ben Collins <bcollins@debian.org>";
 
+
 /* Module Parameters */
 static int phys_dma = 1;
 module_param(phys_dma, int, 0644);
@@ -184,6 +186,8 @@
 
 static void ohci1394_pci_remove(struct pci_dev *pdev);
 
+static void ohci_free_dma_work_fn(void* data);
+
 #ifndef __LITTLE_ENDIAN
 static unsigned hdr_sizes[] =
 {
@@ -1130,6 +1134,13 @@
 	return retval;
 }
 
+static void ohci_free_dma_work_fn(void* data)
+{
+	struct pci_pool* prg_pool = (struct pci_pool*) data;
+	pci_pool_destroy(prg_pool);
+	OHCI_DMA_FREE("dma_rcv prg pool");
+}
+
 /***********************************
  * rawiso ISO reception            *
  ***********************************/
@@ -2898,13 +2909,14 @@
 		kfree(d->buf_bus);
 	}
 	if (d->prg_cpu) {
+		struct work_struct ohci_free_dma_work;
 		for (i=0; i<d->num_desc; i++)
 			if (d->prg_cpu[i] && d->prg_bus[i]) {
 				pci_pool_free(d->prg_pool, d->prg_cpu[i], d->prg_bus[i]);
 				OHCI_DMA_FREE("consistent dma_rcv prg[%d]", i);
 			}
-		pci_pool_destroy(d->prg_pool);
-		OHCI_DMA_FREE("dma_rcv prg pool");
+		INIT_WORK(&ohci_free_dma_work, ohci_free_dma_work_fn, (void*) d->prg_pool);
+		schedule_work(&ohci_free_dma_work);
 		kfree(d->prg_cpu);
 		kfree(d->prg_bus);
 	}

--------------020607070605060307020003--
