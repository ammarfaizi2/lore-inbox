Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262312AbUKWH1E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262312AbUKWH1E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:27:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262302AbUKWH1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:27:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:2709 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262312AbUKWH0Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:26:24 -0500
Date: Mon, 22 Nov 2004 23:26:18 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: <marcelo.tosatti@cyclades.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: USB: ohci fix by Jes&Pete for Jessie
Message-ID: <20041122232618.0e9e8818@lembas.zaitcev.lan>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.13; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In usb-ohci of 2.4.28 it is possibe for del_urb called from a timer to access
a thread stack under a stack pointer, when trying to wake the thread. On ia64
this causes an exception, which causes Jessie's Altix to collapse on reboot if
a USB keyboard is not connected. It is obviously a bug everywhere, but for some
reason it always worked dandy on i386.

In my opinion, the root cause is a misguided attempt to save memory by
allocating pointers to waitqueue heads intstead of waitqueue heads themselves,
so I solve the problem by allocating waitqueue heads.

This problem was analyzed and fixed by Jes Sorensen in a different way
which wasn't radical enough for me, so this is a counter patch.

diff -urp -X dontdiff linux-2.4.28-bk3-ohci/drivers/usb/host/usb-ohci.c linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.c
--- linux-2.4.28-bk3-ohci/drivers/usb/host/usb-ohci.c	2004-04-14 17:33:16.000000000 -0700
+++ linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.c	2004-11-16 15:15:44.000000000 -0800
@@ -677,7 +677,8 @@ static int sohci_submit_urb (struct urb 
 		return -ENOMEM;
 	}
 	memset (urb_priv, 0, sizeof (urb_priv_t) + size * sizeof (td_t *));
-	
+	init_waitqueue_head (&urb_priv->wait);
+
 	/* fill the private part of the URB */
 	urb_priv->length = size;
 	urb_priv->ed = ed;	
@@ -823,12 +824,10 @@ static int sohci_unlink_urb (struct urb 
 			urb_priv->ed->state |= ED_URB_DEL;
 
 			if (!(urb->transfer_flags & USB_ASYNC_UNLINK)) {
-				DECLARE_WAIT_QUEUE_HEAD (unlink_wakeup); 
 				DECLARE_WAITQUEUE (wait, current);
 				int timeout = OHCI_UNLINK_TIMEOUT;
 
-				add_wait_queue (&unlink_wakeup, &wait);
-				urb_priv->wait = &unlink_wakeup;
+				add_wait_queue(&urb_priv->wait, &wait);
 				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 
 				/* wait until all TDs are deleted */
@@ -838,7 +837,16 @@ static int sohci_unlink_urb (struct urb 
 					set_current_state(TASK_UNINTERRUPTIBLE);
 				}
 				set_current_state(TASK_RUNNING);
-				remove_wait_queue (&unlink_wakeup, &wait); 
+
+				/*
+				 * A waitqueue head is self-locked, but we try
+				 * to interlock with the dl_del_urb() which may
+				 * be doing wake_up() right now, least
+				 * urb->complete poisons over the urb->wait.
+				 */
+				spin_lock_irqsave(&ohci->ohci_lock, flags);
+				remove_wait_queue(&urb_priv->wait, &wait); 
+				spin_unlock_irqrestore(&ohci->ohci_lock, flags);
 				if (urb->status == USB_ST_URB_PENDING) {
 					err ("unlink URB timeout");
 					return -ETIMEDOUT;
@@ -943,18 +951,16 @@ static int sohci_free_dev (struct usb_de
 				warn ("TD leak, %d", cnt);
 
 			} else if (!in_interrupt ()) {
-				DECLARE_WAIT_QUEUE_HEAD (freedev_wakeup); 
 				DECLARE_WAITQUEUE (wait, current);
 				int timeout = OHCI_UNLINK_TIMEOUT;
 
 				/* SF interrupt handler calls dl_del_list */
-				add_wait_queue (&freedev_wakeup, &wait);
-				dev->wait = &freedev_wakeup;
+				add_wait_queue (&dev->wait, &wait);
 				set_current_state(TASK_UNINTERRUPTIBLE);
 				while (timeout && dev->ed_cnt)
 					timeout = schedule_timeout (timeout);
 				set_current_state(TASK_RUNNING);
-				remove_wait_queue (&freedev_wakeup, &wait);
+				remove_wait_queue (&dev->wait, &wait);
 				if (dev->ed_cnt) {
 					err ("free device %d timeout", usb_dev->devnum);
 					return -ETIMEDOUT;
@@ -1560,7 +1566,7 @@ static void dl_transfer_length(td_t * td
 
 static void dl_del_urb (ohci_t *ohci, struct urb * urb)
 {
-	wait_queue_head_t * wait_head = ((urb_priv_t *)(urb->hcpriv))->wait;
+ 	urb_priv_t * urb_priv = urb->hcpriv;
 
 	urb_rm_priv_locked (urb);
 
@@ -1571,8 +1577,7 @@ static void dl_del_urb (ohci_t *ohci, st
 		urb->status = -ENOENT;
 
 		/* unblock sohci_unlink_urb */
-		if (wait_head)
-			wake_up (wait_head);
+		wake_up(&urb_priv->wait);
 	}
 }
 
@@ -1664,13 +1669,8 @@ static void dl_del_list (ohci_t  * ohci,
 			ed->state = ED_NEW;
 			hash_free_ed(ohci, ed);
    	 		/* if all eds are removed wake up sohci_free_dev */
-   	 		if (!--dev->ed_cnt) {
-				wait_queue_head_t *wait_head = dev->wait;
-
-				dev->wait = 0;
-				if (wait_head)
-					wake_up (wait_head);
-			}
+   	 		if (!--dev->ed_cnt)
+				wake_up(&dev->wait);
    	 	} else {
    	 		ed->state &= ~ED_URB_DEL;
 			tdHeadP = dma_to_td (ohci, le32_to_cpup (&ed->hwHeadP) & 0xfffffff0);
diff -urp -X dontdiff linux-2.4.28-bk3-ohci/drivers/usb/host/usb-ohci.h linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.h
--- linux-2.4.28-bk3-ohci/drivers/usb/host/usb-ohci.h	2004-05-16 00:16:52.000000000 -0700
+++ linux-2.4.28-rc1-usb/drivers/usb/host/usb-ohci.h	2004-10-28 00:41:54.000000000 -0700
@@ -336,7 +336,7 @@ typedef struct 
 	__u16 length;	// number of tds associated with this request
 	__u16 td_cnt;	// number of tds already serviced
 	int   state;
-	wait_queue_head_t * wait;
+	wait_queue_head_t wait;
 	td_t * td[0];	// list pointer to all corresponding TDs associated with this request
 
 } urb_priv_t;
@@ -417,7 +417,7 @@ struct ohci_device {
 	ed_t 	ed[NUM_EDS];
 	dma_addr_t dma;
 	int ed_cnt;
-	wait_queue_head_t * wait;
+	wait_queue_head_t wait;
 };
 
 // #define ohci_to_usb(ohci)	((ohci)->usb)
@@ -626,6 +626,7 @@ dev_alloc (struct ohci *hc, int mem_flag
 	dev = pci_pool_alloc (hc->dev_cache, mem_flags, &dma);
 	if (dev) {
 		memset (dev, 0, sizeof (*dev));
+		init_waitqueue_head (&dev->wait);
 		dev->dma = dma;
 		offset = ((char *)&dev->ed) - ((char *)dev);
 		for (i = 0; i < NUM_EDS; i++, offset += sizeof dev->ed [0])
