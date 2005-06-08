Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbVFHKMB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbVFHKMB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 06:12:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVFHKMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 06:12:00 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:64973 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261210AbVFHKLN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 06:11:13 -0400
Message-ID: <42A6C6B3.2000303@ru.mvista.com>
Date: Wed, 08 Jun 2005 14:21:39 +0400
From: "Eugeny S. Mints" <emints@ru.mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       David Brownell <david-b@pacbell.net>
Subject: race in usbnet.c in full RT 
Content-Type: multipart/mixed;
 boundary="------------090101070604010105080602"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090101070604010105080602
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

seems there is a race in drivers/net/usbnet.c in full RT mode. To be 
honest I haven't hardly checked this on the latest kernel and latest RT 
patch but just took a look at usbnet.c and latest RT patch and haven't 
observed any related changes.

The  usbnet_start_xmit() contains the following code:

	...
	spin_lock_irqsave (&dev->txq.lock, flags);

#ifdef	CONFIG_USB_NET1080
	if (info->flags & FLAG_FRAMING_NC) {
		header->packet_id = cpu_to_le16 ((u16)dev->dev_packet_id++);
		put_unaligned (header->packet_id, &trailer->packet_id);
#if 0
		devdbg (dev, "frame >tx h %d p %d id %d",
			header->hdr_len, header->packet_len,
			header->packet_id);
#endif
	}
#endif	/* CONFIG_USB_NET1080 */

	switch ((retval = usb_submit_urb (urb, GFP_ATOMIC))) {
	case -EPIPE:
		netif_stop_queue (net);
		defer_kevent (dev, EVENT_TX_HALT);
		break;
	default:
		devdbg (dev, "tx: submit urb err %d", retval);
		break;
	case 0:
		net->trans_start = jiffies;
		__skb_queue_tail (&dev->txq, skb);
		if (dev->txq.qlen >= TX_QLEN (dev))
			netif_stop_queue (net);
	}
	spin_unlock_irqrestore (&dev->txq.lock, flags);
	...

THe race in full RT is between tx_complete() routine and 
__skb_queue_tail (&dev->txq, skb): skb->list gets initialized in 
__skb_queue_tail() but may be dereferenced before initialization at 
defer_bh() called from tx_complete() (since tx_complete() and 
usbnet_start_xmit() are completely asynchronous routines).

in non-RT case spin_lock_irqsave (&dev->txq.lock, flags) disables 
interrupts and thus code from usb_submit_urb() call upto 
__skb_queue_tail (&dev->txq, skb) executes atomically. But in RT case 
interrupts are not disabled and usb_submit_urb() triggers an interrupt 
which may cause tx_complete() execution before __skb_queue_tail () call. 
And since skb->list gets initialized just at __skb_queue_tail(), call to 
tx_complete() (via defer_bh() which thus executes before 
__skb_queue_tail) dereferences NULL (skb->list) pointer.

Thus looks tx_complete() and usbnet_start_xmit() require a 
serialization. Please find proposed fix attached though not sure the 
patch will apply cleanly to the latest kernel.

	Eugeny

--------------090101070604010105080602
Content-Type: text/plain;
 name="usbnet.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="usbnet.c.patch"

--- a/drivers/usb/net/usbnet.c	2004-12-25 00:34:58.000000000 +0300
+++ b/drivers/usb/net/usbnet.c	2005-05-26 21:02:58.000000000 +0400
@@ -2820,6 +2820,8 @@
 
 	urb->dev = NULL;
 	entry->state = tx_done;
+	spin_lock_rt (&dev->txq.lock);
+	spin_unlock_rt(&dev->txq.lock);
 	defer_bh (dev, skb);
 }
 

--------------090101070604010105080602--

