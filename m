Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUKIIGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUKIIGa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 03:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbUKIIG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 03:06:29 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:48547 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S261427AbUKIICb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 03:02:31 -0500
Date: Tue, 9 Nov 2004 19:02:26 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [6/6] PPC64 iSeries last of the cleanups fo the MF code
Message-Id: <20041109190226.035641e0.sfr@canb.auug.org.au>
In-Reply-To: <20041109185759.493d19fd.sfr@canb.auug.org.au>
References: <20041109184223.16ea3414.sfr@canb.auug.org.au>
	<20041109184551.03b8a32c.sfr@canb.auug.org.au>
	<20041109184813.1a6e02cf.sfr@canb.auug.org.au>
	<20041109185131.29e6eabd.sfr@canb.auug.org.au>
	<20041109185547.6eaf99ee.sfr@canb.auug.org.au>
	<20041109185759.493d19fd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__9_Nov_2004_19_02_26_+1100_n4l6cYpkq7QI7.gv"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__9_Nov_2004_19_02_26_+1100_n4l6cYpkq7QI7.gv
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

This last patch is a bit if a mess because it mainly consists of combining
some single use small functions into their callers and rearranging some
other code.

Some intermediate variables are introduced and some code is restructured
to improve its readablility (and hopefully maintainability).

Overall there are no semantic changes.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN linus-bk-mf.0.9/arch/ppc64/kernel/iSeries_setup.c linus-bk-mf.1/arch/ppc64/kernel/iSeries_setup.c
--- linus-bk-mf.0.9/arch/ppc64/kernel/iSeries_setup.c	2004-11-09 16:48:02.000000000 +1100
+++ linus-bk-mf.1/arch/ppc64/kernel/iSeries_setup.c	2004-11-09 14:14:38.000000000 +1100
@@ -55,6 +55,7 @@
 #include <asm/iSeries/IoHriMainStore.h>
 #include <asm/iSeries/iSeries_proc.h>
 #include <asm/iSeries/mf.h>
+#include <asm/iSeries/HvLpEvent.h>
 
 extern void hvlog(char *fmt, ...);
 
diff -ruN linus-bk-mf.0.9/arch/ppc64/kernel/mf.c linus-bk-mf.1/arch/ppc64/kernel/mf.c
--- linus-bk-mf.0.9/arch/ppc64/kernel/mf.c	2004-11-09 18:19:18.000000000 +1100
+++ linus-bk-mf.1/arch/ppc64/kernel/mf.c	2004-11-09 16:26:01.000000000 +1100
@@ -25,24 +25,21 @@
   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
   */
 
-#include <asm/iSeries/mf.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
-#include <linux/mm.h>
-#include <linux/module.h>
 #include <linux/completion.h>
-#include <asm/iSeries/HvLpConfig.h>
-#include <linux/slab.h>
 #include <linux/delay.h>
-#include <asm/nvram.h>
-#include <asm/time.h>
-#include <asm/iSeries/ItSpCommArea.h>
-#include <asm/uaccess.h>
 #include <linux/dma-mapping.h>
 #include <linux/bcd.h>
+
+#include <asm/time.h>
+#include <asm/uaccess.h>
 #include <asm/iSeries/vio.h>
+#include <asm/iSeries/mf.h>
+#include <asm/iSeries/HvLpConfig.h>
+#include <asm/iSeries/ItSpCommArea.h>
 
 /*
  * This is the structure layout for the Machine Facilites LPAR event
@@ -198,8 +195,8 @@
 		hv_rc = HvCallEvent_signalLpEvent(
 				&pending_event_head->event.hp_lp_event);
 		if (hv_rc != HvLpEvent_Rc_Good) {
-			printk(KERN_ERR "mf.c: HvCallEvent_signalLpEvent() failed with %d\n",
-					(int)hv_rc);
+			printk(KERN_ERR "mf.c: HvCallEvent_signalLpEvent() "
+					"failed with %d\n", (int)hv_rc);
 
 			spin_lock_irqsave(&pending_event_spinlock, flags);
 			ev1 = pending_event_head;
@@ -238,12 +235,13 @@
 		pending_event_avail = pending_event_avail->next;
 	}
 	spin_unlock_irqrestore(&pending_event_spinlock, flags);
-	if (ev == NULL)
-		ev = kmalloc(sizeof(struct pending_event),GFP_ATOMIC);
 	if (ev == NULL) {
-		printk(KERN_ERR "mf.c: unable to kmalloc %ld bytes\n",
-				sizeof(struct pending_event));
-		return NULL;
+		ev = kmalloc(sizeof(struct pending_event), GFP_ATOMIC);
+		if (ev == NULL) {
+			printk(KERN_ERR "mf.c: unable to kmalloc %ld bytes\n",
+					sizeof(struct pending_event));
+			return NULL;
+		}
 	}
 	memset(ev, 0, sizeof(struct pending_event));
 	hev = &ev->event.hp_lp_event;
@@ -254,7 +252,7 @@
 	hev->xType = HvLpEvent_Type_MachineFac;
 	hev->xSourceLp = HvLpConfig_getLpIndex();
 	hev->xTargetLp = primary_lp;
-	hev->xSizeMinus1 = sizeof(ev->event)-1;
+	hev->xSizeMinus1 = sizeof(ev->event) - 1;
 	hev->xRc = HvLpEvent_Rc_Good;
 	hev->xSourceInstanceId = HvCallEvent_getSourceLpInstanceId(primary_lp,
 			HvLpEvent_Type_MachineFac);
@@ -373,8 +371,10 @@
  */
 static void handle_int(struct io_mf_lp_event *event)
 {
-	int free_it = 0;
-	struct pending_event *two = NULL;
+	struct ce_msg_data *ce_msg_data;
+	struct ce_msg_data *pce_msg_data;
+	unsigned long flags;
+	struct pending_event *pev;
 
 	/* ack the interrupt */
 	event->hp_lp_event.xRc = HvLpEvent_Rc_Good;
@@ -383,49 +383,42 @@
 	/* process interrupt */
 	switch (event->hp_lp_event.xSubtype) {
 	case 0:	/* CE message */
-		switch (event->data.ce_msg.ce_msg[3]) {
+		ce_msg_data = &event->data.ce_msg;
+		switch (ce_msg_data->ce_msg[3]) {
 		case 0x5B:	/* power control notification */
-			if ((event->data.ce_msg.ce_msg[5] & 0x20) != 0) {
+			if ((ce_msg_data->ce_msg[5] & 0x20) != 0) {
 				printk(KERN_INFO "mf.c: Commencing partition shutdown\n");
 				if (shutdown() == 0)
 					signal_ce_msg_simple(0xDB, NULL);
 			}
 			break;
 		case 0xC0:	/* get time */
-			if ((pending_event_head == NULL) ||
-			    (pending_event_head->event.data.ce_msg.ce_msg[3]
-			     != 0x40))
+			spin_lock_irqsave(&pending_event_spinlock, flags);
+			pev = pending_event_head;
+			if (pev != NULL)
+				pending_event_head = pending_event_head->next;
+			spin_unlock_irqrestore(&pending_event_spinlock, flags);
+			if (pev == NULL)
 				break;
-			free_it = 1;
-			if (pending_event_head->event.data.ce_msg.completion != 0) {
-				ce_msg_comp_hdlr handler = pending_event_head->event.data.ce_msg.completion->handler;
-				void *token = pending_event_head->event.data.ce_msg.completion->token;
+			pce_msg_data = &pev->event.data.ce_msg;
+			if (pce_msg_data->ce_msg[3] != 0x40)
+				break;
+			if (pce_msg_data->completion != NULL) {
+				ce_msg_comp_hdlr handler =
+					pce_msg_data->completion->handler;
+				void *token = pce_msg_data->completion->token;
 
 				if (handler != NULL)
-					(*handler)(token, &(event->data.ce_msg));
+					(*handler)(token, ce_msg_data);
 			}
-			break;
-		}
-
-		/* remove from queue */
-		if (free_it == 1) {
-			unsigned long flags;
-
 			spin_lock_irqsave(&pending_event_spinlock, flags);
-			if (pending_event_head != NULL) {
-				struct pending_event *oldHead =
-					pending_event_head;
-
-				pending_event_head = pending_event_head->next;
-				two = pending_event_head;
-				free_pending_event(oldHead);
-			}
+			free_pending_event(pev);
 			spin_unlock_irqrestore(&pending_event_spinlock, flags);
+			/* send next waiting event */
+			if (pending_event_head != NULL)
+				signal_event(NULL);
+			break;
 		}
-
-		/* send next waiting event */
-		if (two != NULL)
-			signal_event(NULL);
 		break;
 	case 1:	/* IT sys shutdown */
 		printk(KERN_INFO "mf.c: Commencing system shutdown\n");
@@ -442,52 +435,57 @@
 static void handle_ack(struct io_mf_lp_event *event)
 {
 	unsigned long flags;
-	struct pending_event * two = NULL;
+	struct pending_event *two = NULL;
 	unsigned long free_it = 0;
+	struct ce_msg_data *ce_msg_data;
+	struct ce_msg_data *pce_msg_data;
+	struct vsp_rsp_data *rsp;
 
 	/* handle current event */
-	if (pending_event_head != NULL) {
-		switch (event->hp_lp_event.xSubtype) {
-		case 0:     /* CE msg */
-			if (event->data.ce_msg.ce_msg[3] == 0x40) {
-				if (event->data.ce_msg.ce_msg[2] != 0) {
-					free_it = 1;
-					if (pending_event_head->event.data.ce_msg.completion
-							!= 0) {
-						ce_msg_comp_hdlr handler = pending_event_head->event.data.ce_msg.completion->handler;
-						void *token = pending_event_head->event.data.ce_msg.completion->token;
-
-						if (handler != NULL)
-							(*handler)(token, &(event->data.ce_msg));
-					}
-				}
-			} else
-				free_it = 1;
-			break;
-		case 4:	/* allocate */
-		case 5:	/* deallocate */
-			if (pending_event_head->hdlr != NULL) {
-				(*pending_event_head->hdlr)((void *)event->hp_lp_event.xCorrelationToken, event->data.alloc.count);
-			}
+	if (pending_event_head == NULL) {
+		printk(KERN_ERR "mf.c: stack empty for receiving ack\n");
+		return;
+	}
+
+	switch (event->hp_lp_event.xSubtype) {
+	case 0:     /* CE msg */
+		ce_msg_data = &event->data.ce_msg;
+		if (ce_msg_data->ce_msg[3] != 0x40) {
 			free_it = 1;
 			break;
-		case 6:
-			{
-				struct vsp_rsp_data *rsp = (struct vsp_rsp_data *)event->data.vsp_cmd.token;
-
-				if (rsp != NULL) {
-					if (rsp->response != NULL)
-						memcpy(rsp->response, &(event->data.vsp_cmd), sizeof(event->data.vsp_cmd));
-					complete(&rsp->com);
-				} else
-					printk(KERN_ERR "mf.c: no rsp\n");
-				free_it = 1;
-			}
+		}
+		if (ce_msg_data->ce_msg[2] == 0)
 			break;
+		free_it = 1;
+		pce_msg_data = &pending_event_head->event.data.ce_msg;
+		if (pce_msg_data->completion != NULL) {
+			ce_msg_comp_hdlr handler =
+				pce_msg_data->completion->handler;
+			void *token = pce_msg_data->completion->token;
+
+			if (handler != NULL)
+				(*handler)(token, ce_msg_data);
 		}
+		break;
+	case 4:	/* allocate */
+	case 5:	/* deallocate */
+		if (pending_event_head->hdlr != NULL)
+			(*pending_event_head->hdlr)((void *)event->hp_lp_event.xCorrelationToken, event->data.alloc.count);
+		free_it = 1;
+		break;
+	case 6:
+		free_it = 1;
+		rsp = (struct vsp_rsp_data *)event->data.vsp_cmd.token;
+		if (rsp == NULL) {
+			printk(KERN_ERR "mf.c: no rsp\n");
+			break;
+		}
+		if (rsp->response != NULL)
+			memcpy(rsp->response, &event->data.vsp_cmd,
+					sizeof(event->data.vsp_cmd));
+		complete(&rsp->com);
+		break;
 	}
-	else
-		printk(KERN_ERR "mf.c: stack empty for receiving ack\n");
 
 	/* remove from queue */
 	spin_lock_irqsave(&pending_event_spinlock, flags);
@@ -618,7 +616,9 @@
 {
 	u8 ce[12];
 
-	memcpy(ce, "\x00\x00\x00\x4A\x00\x00\x00\x01\x00\x00\x00\x00", 12);
+	memset(ce, 0, sizeof(ce));
+	ce[3] = 0x4a;
+	ce[7] = 0x01;
 	ce[8] = word >> 24;
 	ce[9] = word >> 16;
 	ce[10] = word >> 8;
@@ -677,232 +677,8 @@
 	signal_ce_msg_simple(0x57, NULL);
 
 	/* initialization complete */
-	printk(KERN_NOTICE "mf.c: iSeries Linux LPAR Machine Facilities initialized\n");
-}
-
-void mf_setSide(char side)
-{
-	u64 new_side;
-	struct vsp_cmd_data vsp_cmd;
-
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-	switch (side) {
-	case 'A':	new_side = 0;
-			break;
-	case 'B':	new_side = 1;
-			break;
-	case 'C':	new_side = 2;
-			break;
-	default:	new_side = 3;
-			break;
-	}
-	vsp_cmd.sub_data.ipl_type = new_side;
-	vsp_cmd.cmd = 10;
-
-	(void)signal_vsp_instruction(&vsp_cmd);
-}
-
-char mf_getSide(void)
-{
-	char return_value = ' ';
-	int rc = 0;
-	struct vsp_cmd_data vsp_cmd;
-
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-	vsp_cmd.cmd = 2;
-	vsp_cmd.sub_data.ipl_type = 0;
-	mb();
-	rc = signal_vsp_instruction(&vsp_cmd);
-
-	if (rc != 0)
-		return return_value;
-
-	if (vsp_cmd.result_code == 0) {
-		switch (vsp_cmd.sub_data.ipl_type) {
-		case 0:	return_value = 'A';
-			break;
-		case 1:	return_value = 'B';
-			break;
-		case 2:	return_value = 'C';
-			break;
-		default:	return_value = 'D';
-			break;
-		}
-	}
-	return return_value;
-}
-
-void mf_getSrcHistory(char *buffer, int size)
-{
-#if 0
-	struct IplTypeReturnStuff return_stuff;
-	struct pending_event *ev = new_pending_event();
-	int rc = 0;
-	char *pages[4];
-
-	pages[0] = kmalloc(4096, GFP_ATOMIC);
-	pages[1] = kmalloc(4096, GFP_ATOMIC);
-	pages[2] = kmalloc(4096, GFP_ATOMIC);
-	pages[3] = kmalloc(4096, GFP_ATOMIC);
-	if ((ev == NULL) || (pages[0] == NULL) || (pages[1] == NULL)
-			 || (pages[2] == NULL) || (pages[3] == NULL))
-		return -ENOMEM;
-
-	return_stuff.xType = 0;
-	return_stuff.xRc = 0;
-	return_stuff.xDone = 0;
-	ev->event.hp_lp_event.xSubtype = 6;
-	ev->event.hp_lp_event.x.xSubtypeData =
-		subtype_data('M', 'F', 'V', 'I');
-	ev->event.data.vsp_cmd.xEvent = &return_stuff;
-	ev->event.data.vsp_cmd.cmd = 4;
-	ev->event.data.vsp_cmd.lp_index = HvLpConfig_getLpIndex();
-	ev->event.data.vsp_cmd.result_code = 0xFF;
-	ev->event.data.vsp_cmd.reserved = 0;
-	ev->event.data.vsp_cmd.sub_data.page[0] = ISERIES_HV_ADDR(pages[0]);
-	ev->event.data.vsp_cmd.sub_data.page[1] = ISERIES_HV_ADDR(pages[1]);
-	ev->event.data.vsp_cmd.sub_data.page[2] = ISERIES_HV_ADDR(pages[2]);
-	ev->event.data.vsp_cmd.sub_data.page[3] = ISERIES_HV_ADDR(pages[3]);
-	mb();
-	if (signal_event(ev) != 0)
-		return;
-
- 	while (return_stuff.xDone != 1)
- 		udelay(10);
- 	if (return_stuff.xRc == 0)
- 		memcpy(buffer, pages[0], size);
-	kfree(pages[0]);
-	kfree(pages[1]);
-	kfree(pages[2]);
-	kfree(pages[3]);
-#endif
-}
-
-void mf_setCmdLine(const char *cmdline, int size, u64 side)
-{
-	struct vsp_cmd_data vsp_cmd;
-	dma_addr_t dma_addr = 0;
-	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
-			GFP_ATOMIC);
-
-	if (page == NULL) {
-		printk(KERN_ERR "mf.c: couldn't allocate memory to set command line\n");
-		return;
-	}
-
-	copy_from_user(page, cmdline, size);
-
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-	vsp_cmd.cmd = 31;
-	vsp_cmd.sub_data.kern.token = dma_addr;
-	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	vsp_cmd.sub_data.kern.side = side;
-	vsp_cmd.sub_data.kern.length = size;
-	mb();
-	(void)signal_vsp_instruction(&vsp_cmd);
-
-	dma_free_coherent(iSeries_vio_dev, size, page, dma_addr);
-}
-
-int mf_getCmdLine(char *cmdline, int *size, u64 side)
-{
-	struct vsp_cmd_data vsp_cmd;
-	int rc;
-	int len = *size;
-	dma_addr_t dma_addr;
-
-	dma_addr = dma_map_single(iSeries_vio_dev, cmdline, len,
-			DMA_FROM_DEVICE);
-	memset(cmdline, 0, len);
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-	vsp_cmd.cmd = 33;
-	vsp_cmd.sub_data.kern.token = dma_addr;
-	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	vsp_cmd.sub_data.kern.side = side;
-	vsp_cmd.sub_data.kern.length = len;
-	mb();
-	rc = signal_vsp_instruction(&vsp_cmd);
-
-	if (rc == 0) {
-		if (vsp_cmd.result_code == 0)
-			len = vsp_cmd.sub_data.length_out;
-#if 0
-		else
-			memcpy(cmdline, "Bad cmdline", 11);
-#endif
-	}
-
-	dma_unmap_single(iSeries_vio_dev, dma_addr, *size, DMA_FROM_DEVICE);
-
-	return len;
-}
-
-
-int mf_setVmlinuxChunk(const char *buffer, int size, int offset, u64 side)
-{
-	struct vsp_cmd_data vsp_cmd;
-	int rc;
-	dma_addr_t dma_addr = 0;
-	char *page = dma_alloc_coherent(iSeries_vio_dev, size, &dma_addr,
-			GFP_ATOMIC);
-
-	if (page == NULL) {
-		printk(KERN_ERR "mf.c: couldn't allocate memory to set vmlinux chunk\n");
-		return -ENOMEM;
-	}
-
-	copy_from_user(page, buffer, size);
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-
-	vsp_cmd.cmd = 30;
-	vsp_cmd.sub_data.kern.token = dma_addr;
-	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	vsp_cmd.sub_data.kern.side = side;
-	vsp_cmd.sub_data.kern.offset = offset;
-	vsp_cmd.sub_data.kern.length = size;
-	mb();
-	rc = signal_vsp_instruction(&vsp_cmd);
-	if (rc == 0) {
-		if (vsp_cmd.result_code == 0)
-			rc = 0;
-		else
-			rc = -ENOMEM;
-	}
-
-	dma_free_coherent(iSeries_vio_dev, size, page, dma_addr);
-
-	return rc;
-}
-
-int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side)
-{
-	struct vsp_cmd_data vsp_cmd;
-	int rc;
-	int len = *size;
-	dma_addr_t dma_addr;
-
-	dma_addr = dma_map_single(iSeries_vio_dev, buffer, len,
-			DMA_FROM_DEVICE);
-	memset(buffer, 0, len);
-	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
-	vsp_cmd.cmd = 32;
-	vsp_cmd.sub_data.kern.token = dma_addr;
-	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
-	vsp_cmd.sub_data.kern.side = side;
-	vsp_cmd.sub_data.kern.offset = offset;
-	vsp_cmd.sub_data.kern.length = len;
-	mb();
-	rc = signal_vsp_instruction(&vsp_cmd);
-	if (rc == 0) {
-		if (vsp_cmd.result_code == 0)
-			*size = vsp_cmd.sub_data.length_out;
-		else
-			rc = -ENOMEM;
-	}
-
-	dma_unmap_single(iSeries_vio_dev, dma_addr, len, DMA_FROM_DEVICE);
-
-	return rc;
+	printk(KERN_NOTICE "mf.c: iSeries Linux LPAR Machine Facilities "
+			"initialized\n");
 }
 
 struct rtc_time_data {
@@ -932,68 +708,66 @@
 	ce_complete.handler = &get_rtc_time_complete;
 	ce_complete.token = &rtc_data;
 	rc = signal_ce_msg_simple(0x40, &ce_complete);
-	if (rc == 0) {
-		wait_for_completion(&rtc_data.com);
-
-		if (rtc_data.rc == 0) {
-			if ((rtc_data.ce_msg.ce_msg[2] == 0xa9) ||
-			    (rtc_data.ce_msg.ce_msg[2] == 0xaf)) {
-				/* TOD clock is not set */
-				tm->tm_sec = 1;
-				tm->tm_min = 1;
-				tm->tm_hour = 1;
-				tm->tm_mday = 10;
-				tm->tm_mon = 8;
-				tm->tm_year = 71;
-				mf_set_rtc(tm);
-			}
-			{
-				u8 *ce_msg = rtc_data.ce_msg.ce_msg;
-				u8 year = ce_msg[5];
-				u8 sec = ce_msg[6];
-				u8 min = ce_msg[7];
-				u8 hour = ce_msg[8];
-				u8 day = ce_msg[10];
-				u8 mon = ce_msg[11];
-
-				BCD_TO_BIN(sec);
-				BCD_TO_BIN(min);
-				BCD_TO_BIN(hour);
-				BCD_TO_BIN(day);
-				BCD_TO_BIN(mon);
-				BCD_TO_BIN(year);
-
-				if (year <= 69)
-					year += 100;
-
-				tm->tm_sec = sec;
-				tm->tm_min = min;
-				tm->tm_hour = hour;
-				tm->tm_mday = day;
-				tm->tm_mon = mon;
-				tm->tm_year = year;
-			}
-		} else {
-			rc = rtc_data.rc;
-			tm->tm_sec = 0;
-			tm->tm_min = 0;
-			tm->tm_hour = 0;
-			tm->tm_mday = 15;
-			tm->tm_mon = 5;
-			tm->tm_year = 52;
-
-		}
-		tm->tm_wday = 0;
-		tm->tm_yday = 0;
-		tm->tm_isdst = 0;
+	if (rc)
+		return rc;
+	wait_for_completion(&rtc_data.com);
+	tm->tm_wday = 0;
+	tm->tm_yday = 0;
+	tm->tm_isdst = 0;
+	if (rtc_data.rc) {
+		tm->tm_sec = 0;
+		tm->tm_min = 0;
+		tm->tm_hour = 0;
+		tm->tm_mday = 15;
+		tm->tm_mon = 5;
+		tm->tm_year = 52;
+		return rtc_data.rc;
+	}
+
+	if ((rtc_data.ce_msg.ce_msg[2] == 0xa9) ||
+	    (rtc_data.ce_msg.ce_msg[2] == 0xaf)) {
+		/* TOD clock is not set */
+		tm->tm_sec = 1;
+		tm->tm_min = 1;
+		tm->tm_hour = 1;
+		tm->tm_mday = 10;
+		tm->tm_mon = 8;
+		tm->tm_year = 71;
+		mf_set_rtc(tm);
+	}
+	{
+		u8 *ce_msg = rtc_data.ce_msg.ce_msg;
+		u8 year = ce_msg[5];
+		u8 sec = ce_msg[6];
+		u8 min = ce_msg[7];
+		u8 hour = ce_msg[8];
+		u8 day = ce_msg[10];
+		u8 mon = ce_msg[11];
+
+		BCD_TO_BIN(sec);
+		BCD_TO_BIN(min);
+		BCD_TO_BIN(hour);
+		BCD_TO_BIN(day);
+		BCD_TO_BIN(mon);
+		BCD_TO_BIN(year);
+
+		if (year <= 69)
+			year += 100;
+
+		tm->tm_sec = sec;
+		tm->tm_min = min;
+		tm->tm_hour = hour;
+		tm->tm_mday = day;
+		tm->tm_mon = mon;
+		tm->tm_year = year;
 	}
 
-	return rc;
+	return 0;
 }
 
 int mf_set_rtc(struct rtc_time *tm)
 {
-	char ce_time[12] = "\x00\x00\x00\x41\x00\x00\x00\x00\x00\x00\x00\x00";
+	char ce_time[12];
 	u8 day, mon, hour, min, sec, y1, y2;
 	unsigned year;
 
@@ -1015,6 +789,8 @@
 	BIN_TO_BCD(y1);
 	BIN_TO_BCD(y2);
 
+	memset(ce_time, 0, sizeof(ce_time));
+	ce_time[3] = 0x41;
 	ce_time[4] = y1;
 	ce_time[5] = y2;
 	ce_time[6] = sec;
@@ -1026,34 +802,96 @@
 	return signal_ce_msg(ce_time, NULL);
 }
 
+#ifdef CONFIG_PROC_FS
+
 static int proc_mf_dump_cmdline(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
-	int len = count;
+	int len;
 	char *p;
+	struct vsp_cmd_data vsp_cmd;
+	int rc;
+	dma_addr_t dma_addr;
 
-	if (off) {
-		*eof = 1;
+	/* The HV appears to return no more than 256 bytes of command line */
+	if (off >= 256)
 		return 0;
-	}
-
-	len = mf_getCmdLine(page, &len, (u64)data);
+	if ((off + count) > 256)
+		count = 256 - off;
 
+	dma_addr = dma_map_single(iSeries_vio_dev, page, off + count,
+			DMA_FROM_DEVICE);
+	if (dma_mapping_error(dma_addr))
+		return -ENOMEM;
+	memset(page, 0, off + count);
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 33;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = (u64)data;
+	vsp_cmd.sub_data.kern.length = off + count;
+	mb();
+	rc = signal_vsp_instruction(&vsp_cmd);
+	dma_unmap_single(iSeries_vio_dev, dma_addr, off + count,
+			DMA_FROM_DEVICE);
+	if (rc)
+		return rc;
+	if (vsp_cmd.result_code != 0)
+		return -ENOMEM;
 	p = page;
-	while (len < (count - 1)) {
-		if (!*p || *p == '\n')
+	len = 0;
+	while (len < (off + count)) {
+		if ((*p == '\0') || (*p == '\n')) {
+			if (*p == '\0')
+				*p = '\n';
+			p++;
+			len++;
+			*eof = 1;
 			break;
+		}
 		p++;
 		len++;
 	}
-	*p = '\n';
-	p++;
-	*p = 0;
 
-	return p - page;
+	if (len < off) {
+		*eof = 1;
+		len = 0;
+	}
+	return len;
 }
 
 #if 0
+static int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side)
+{
+	struct vsp_cmd_data vsp_cmd;
+	int rc;
+	int len = *size;
+	dma_addr_t dma_addr;
+
+	dma_addr = dma_map_single(iSeries_vio_dev, buffer, len,
+			DMA_FROM_DEVICE);
+	memset(buffer, 0, len);
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 32;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = side;
+	vsp_cmd.sub_data.kern.offset = offset;
+	vsp_cmd.sub_data.kern.length = len;
+	mb();
+	rc = signal_vsp_instruction(&vsp_cmd);
+	if (rc == 0) {
+		if (vsp_cmd.result_code == 0)
+			*size = vsp_cmd.sub_data.length_out;
+		else
+			rc = -ENOMEM;
+	}
+
+	dma_unmap_single(iSeries_vio_dev, dma_addr, len, DMA_FROM_DEVICE);
+
+	return rc;
+}
+
 static int proc_mf_dump_vmlinux(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
@@ -1079,7 +917,28 @@
 		int count, int *eof, void *data)
 {
 	int len;
-	char mf_current_side = mf_getSide();
+	char mf_current_side = ' ';
+	struct vsp_cmd_data vsp_cmd;
+
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 2;
+	vsp_cmd.sub_data.ipl_type = 0;
+	mb();
+
+	if (signal_vsp_instruction(&vsp_cmd) == 0) {
+		if (vsp_cmd.result_code == 0) {
+			switch (vsp_cmd.sub_data.ipl_type) {
+			case 0:	mf_current_side = 'A';
+				break;
+			case 1:	mf_current_side = 'B';
+				break;
+			case 2:	mf_current_side = 'C';
+				break;
+			default:	mf_current_side = 'D';
+				break;
+			}
+		}
+	}
 
 	len = sprintf(page, "%c\n", mf_current_side);
 
@@ -1097,30 +956,92 @@
 static int proc_mf_change_side(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
-	char stkbuf[10];
+	char side;
+	u64 newSide;
+	struct vsp_cmd_data vsp_cmd;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (count > (sizeof(stkbuf) - 1))
-		count = sizeof(stkbuf) - 1;
-	if (copy_from_user(stkbuf, buffer, count))
+	if (count == 0)
+		return 0;
+
+	if (get_user(side, buffer))
 		return -EFAULT;
-	stkbuf[count] = 0;
-	if ((*stkbuf != 'A') && (*stkbuf != 'B') &&
-	    (*stkbuf != 'C') && (*stkbuf != 'D')) {
+
+	switch (side) {
+	case 'A':	newSide = 0;
+			break;
+	case 'B':	newSide = 1;
+			break;
+	case 'C':	newSide = 2;
+			break;
+	case 'D':	newSide = 3;
+			break;
+	default:
 		printk(KERN_ERR "mf_proc.c: proc_mf_change_side: invalid side\n");
 		return -EINVAL;
 	}
 
-	mf_setSide(*stkbuf);
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.sub_data.ipl_type = newSide;
+	vsp_cmd.cmd = 10;
+
+	(void)signal_vsp_instruction(&vsp_cmd);
 
 	return count;
 }
 
+#if 0
+static void mf_getSrcHistory(char *buffer, int size)
+{
+	struct IplTypeReturnStuff return_stuff;
+	struct pending_event *ev = new_pending_event();
+	int rc = 0;
+	char *pages[4];
+
+	pages[0] = kmalloc(4096, GFP_ATOMIC);
+	pages[1] = kmalloc(4096, GFP_ATOMIC);
+	pages[2] = kmalloc(4096, GFP_ATOMIC);
+	pages[3] = kmalloc(4096, GFP_ATOMIC);
+	if ((ev == NULL) || (pages[0] == NULL) || (pages[1] == NULL)
+			 || (pages[2] == NULL) || (pages[3] == NULL))
+		return -ENOMEM;
+
+	return_stuff.xType = 0;
+	return_stuff.xRc = 0;
+	return_stuff.xDone = 0;
+	ev->event.hp_lp_event.xSubtype = 6;
+	ev->event.hp_lp_event.x.xSubtypeData =
+		subtype_data('M', 'F', 'V', 'I');
+	ev->event.data.vsp_cmd.xEvent = &return_stuff;
+	ev->event.data.vsp_cmd.cmd = 4;
+	ev->event.data.vsp_cmd.lp_index = HvLpConfig_getLpIndex();
+	ev->event.data.vsp_cmd.result_code = 0xFF;
+	ev->event.data.vsp_cmd.reserved = 0;
+	ev->event.data.vsp_cmd.sub_data.page[0] = ISERIES_HV_ADDR(pages[0]);
+	ev->event.data.vsp_cmd.sub_data.page[1] = ISERIES_HV_ADDR(pages[1]);
+	ev->event.data.vsp_cmd.sub_data.page[2] = ISERIES_HV_ADDR(pages[2]);
+	ev->event.data.vsp_cmd.sub_data.page[3] = ISERIES_HV_ADDR(pages[3]);
+	mb();
+	if (signal_event(ev) != 0)
+		return;
+
+ 	while (return_stuff.xDone != 1)
+ 		udelay(10);
+ 	if (return_stuff.xRc == 0)
+ 		memcpy(buffer, pages[0], size);
+	kfree(pages[0]);
+	kfree(pages[1]);
+	kfree(pages[2]);
+	kfree(pages[3]);
+}
+#endif
+
 static int proc_mf_dump_src(char *page, char **start, off_t off,
 		int count, int *eof, void *data)
 {
+#if 0
 	int len;
 
 	mf_getSrcHistory(page, count);
@@ -1134,6 +1055,9 @@
 		len = count;
 	*start = page + off;
 	return len;
+#else
+	return 0;
+#endif
 }
 
 static int proc_mf_change_src(struct file *file, const char __user *buffer,
@@ -1162,34 +1086,91 @@
 	return count;
 }
 
-static int proc_mf_change_cmdline(struct file *file, const char *buffer,
+static int proc_mf_change_cmdline(struct file *file, const char __user *buffer,
 		unsigned long count, void *data)
 {
+	struct vsp_cmd_data vsp_cmd;
+	dma_addr_t dma_addr;
+	char *page;
+	int ret = -EACCES;
+
 	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
+		goto out;
 
-	mf_setCmdLine(buffer, count, (u64)data);
+	dma_addr = 0;
+	page = dma_alloc_coherent(iSeries_vio_dev, count, &dma_addr,
+			GFP_ATOMIC);
+	ret = -ENOMEM;
+	if (page == NULL)
+		goto out;
+
+	ret = -EFAULT;
+	if (copy_from_user(page, buffer, count))
+		goto out_free;
 
-	return count;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 31;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = (u64)data;
+	vsp_cmd.sub_data.kern.length = count;
+	mb();
+	(void)signal_vsp_instruction(&vsp_cmd);
+	ret = count;
+
+out_free:
+	dma_free_coherent(iSeries_vio_dev, count, page, dma_addr);
+out:
+	return ret;
 }
 
 static ssize_t proc_mf_change_vmlinux(struct file *file,
 				      const char __user *buf,
 				      size_t count, loff_t *ppos)
 {
-	struct inode * inode = file->f_dentry->d_inode;
-	struct proc_dir_entry * dp = PDE(inode);
-	int rc;
+	struct proc_dir_entry *dp = PDE(file->f_dentry->d_inode);
+	ssize_t rc;
+	dma_addr_t dma_addr;
+	char *page;
+	struct vsp_cmd_data vsp_cmd;
+
+	rc = -EACCES;
 	if (!capable(CAP_SYS_ADMIN))
-		return -EACCES;
+		goto out;
 
-	rc = mf_setVmlinuxChunk(buf, count, *ppos, (u64)dp->data);
-	if (rc < 0)
-		return rc;
+	dma_addr = 0;
+	page = dma_alloc_coherent(iSeries_vio_dev, count, &dma_addr,
+			GFP_ATOMIC);
+	rc = -ENOMEM;
+	if (page == NULL) {
+		printk(KERN_ERR "mf.c: couldn't allocate memory to set vmlinux chunk\n");
+		goto out;
+	}
+	rc = -EFAULT;
+	if (copy_from_user(page, buf, count))
+		goto out_free;
 
-	*ppos += count;
+	memset(&vsp_cmd, 0, sizeof(vsp_cmd));
+	vsp_cmd.cmd = 30;
+	vsp_cmd.sub_data.kern.token = dma_addr;
+	vsp_cmd.sub_data.kern.address_type = HvLpDma_AddressType_TceIndex;
+	vsp_cmd.sub_data.kern.side = (u64)dp->data;
+	vsp_cmd.sub_data.kern.offset = *ppos;
+	vsp_cmd.sub_data.kern.length = count;
+	mb();
+	rc = signal_vsp_instruction(&vsp_cmd);
+	if (rc)
+		goto out_free;
+	rc = -ENOMEM;
+	if (vsp_cmd.result_code != 0)
+		goto out_free;
 
-	return count;
+	*ppos += count;
+	rc = count;
+out_free:
+	dma_free_coherent(iSeries_vio_dev, count, page, dma_addr);
+out:
+	return rc;
 }
 
 static struct file_operations proc_vmlinux_operations = {
@@ -1254,3 +1235,5 @@
 }
 
 __initcall(mf_proc_init);
+
+#endif /* CONFIG_PROC_FS */
diff -ruN linus-bk-mf.0.9/include/asm-ppc64/iSeries/mf.h linus-bk-mf.1/include/asm-ppc64/iSeries/mf.h
--- linus-bk-mf.0.9/include/asm-ppc64/iSeries/mf.h	2004-11-09 17:27:54.000000000 +1100
+++ linus-bk-mf.1/include/asm-ppc64/iSeries/mf.h	2004-11-09 17:31:44.000000000 +1100
@@ -24,13 +24,13 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  */
-#ifndef MF_H_INCLUDED
-#define MF_H_INCLUDED
+#ifndef _ASM_PPC64_ISERIES_MF_H
+#define _ASM_PPC64_ISERIES_MF_H
 
-#include <linux/proc_fs.h>
+#include <linux/types.h>
 
 #include <asm/iSeries/HvTypes.h>
-#include <asm/iSeries/HvLpEvent.h>
+#include <asm/iSeries/HvCallEvent.h>
 
 struct rtc_time;
 
@@ -51,19 +51,7 @@
 
 extern void mf_init(void);
 
-extern void mf_setSide(char side);
-extern char mf_getSide(void);
-
-extern void mf_setCmdLine(const char *cmdline, int size, u64 side);
-extern int  mf_getCmdLine(char *cmdline, int *size, u64 side);
-
-extern void mf_getSrcHistory(char *buffer, int size);
-
-extern int mf_setVmlinuxChunk(const char *buffer, int size, int offset,
-		u64 side);
-extern int mf_getVmlinuxChunk(char *buffer, int *size, int offset, u64 side);
-
 extern int mf_get_rtc(struct rtc_time *tm);
 extern int mf_set_rtc(struct rtc_time *tm);
 
-#endif /* MF_H_INCLUDED */
+#endif /* _ASM_PPC64_ISERIES_MF_H */

--Signature=_Tue__9_Nov_2004_19_02_26_+1100_n4l6cYpkq7QI7.gv
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBkHmS4CJfqux9a+8RAp4oAJ4+NtzCskfDSnzbCphseX3SZkAUGwCeNRf3
CbpM3WMrY4gWpT2puK2mUoI=
=iUmm
-----END PGP SIGNATURE-----

--Signature=_Tue__9_Nov_2004_19_02_26_+1100_n4l6cYpkq7QI7.gv--
