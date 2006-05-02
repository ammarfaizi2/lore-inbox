Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWEBTNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWEBTNW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWEBTNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:13:22 -0400
Received: from xproxy.gmail.com ([66.249.82.199]:6622 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750734AbWEBTNV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:13:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fHV2mfNyZQVBzRyim+0aUdhj7YVLLgmkk8JTlqYtUXgPvtKalRdcfmGNZPwdWEY4w5NchoVcfrQEKOzatOxdmG4yA7KBk3dvLW99ebxAvfCiOnyqRQJiYT8zKQn05wg2dE+R2FO5x35Km3RBNSDsgkmfuVlmT6j9npmKe4XfoQc=
Message-ID: <df47b87a0605021213i7b3de7bck1162ef519a654579@mail.gmail.com>
Date: Tue, 2 May 2006 15:13:21 -0400
From: "Ioan Ionita" <opslynx@gmail.com>
To: "Michael Helmling" <supermihi@web.de>
Subject: Re: New, yet unsupported USB-Ethernet adaptor
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <200605022002.15845.supermihi@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200605022002.15845.supermihi@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/2/06, Michael Helmling <supermihi@web.de> wrote:

> I bought an USB-Ethernet adaptor from delock (www.delock.de) and found it was
> not supported by linux from the vendor. So I played a little with lsusb and
> found it uses a MCS7830 chip from MosChip semiconductor (moschip.com). On
> their homepage I found a driver but it only was a precompiled Fedora4 module.
> So I wrote them an email and they sent me the whole source code for the
> module . Unfortunately it doesn't compile on my machine with a 2.6.16 kernel,
> but in does on a friend's one who uses 2.6.12, so I assume something has
> changed in the kernel interface (I get errors with sk_buff_head not
> containing "list").
> I have no idea of how to correct this but maybe someone else can. I attached
> the sourcecode wich is licensed under the GPL.

Great. below is an UNTESTED patch which should get it to build fine
with more recent kernels. (Builds on 2.6.17-rc3). Give it a try if you
can and let us know.

Signed-off-by: Ioan Ionita <opslynx@yahoo.com>
--

--- old/mcs7830.c	2006-05-02 11:01:22.000000000 -0400
+++ new/mcs7830.c	2006-05-02 11:01:12.000000000 -0400
@@ -1309,9 +1309,9 @@
  * completion callbacks.  2.5 should have fixed those bugs...
  */

-static void defer_bh (struct usbnet *dev, struct sk_buff *skb)
+static void defer_bh (struct usbnet *dev, struct sk_buff *skb, struct
sk_buff_head *list)
 {
-	struct sk_buff_head	*list = skb->list;
+	
 	unsigned long		flags;

 	spin_lock_irqsave (&list->lock, flags);
@@ -1370,7 +1370,7 @@

 	usb_fill_bulk_urb (urb, dev->udev, dev->in,
 		skb->data, size, rx_complete, skb);
-	urb->transfer_flags |= URB_ASYNC_UNLINK;
+	

 	spin_lock_irqsave (&dev->rxq.lock, lockflags);

@@ -1503,7 +1503,7 @@
 		break;
 	}

-	defer_bh (dev, skb);
+	defer_bh (dev, skb, &dev->txq);

 	if (urb) {
 		if (netif_running (dev->net)
@@ -1935,7 +1935,7 @@

 	urb->dev = NULL;
 	entry->state = tx_done;
-	defer_bh (dev, skb);
+	defer_bh (dev, skb, &dev->txq);
 }

 /*-------------------------------------------------------------------------*/
@@ -1997,7 +1997,7 @@

 	usb_fill_bulk_urb (urb, dev->udev, dev->out,
 			skb->data, skb->len, tx_complete, skb);
-	urb->transfer_flags |= URB_ASYNC_UNLINK;
+

 	/* don't assume the hardware handles USB_ZERO_PACKET
 	 * NOTE:  strictly conforming cdc-ether devices should expect
@@ -2044,7 +2044,7 @@
 		}
 		usb_fill_bulk_urb (Zerourb, dev->udev, dev->out,\
 				skb->data, 0, Zero_complete, NULL);
-		Zerourb->transfer_flags |= URB_ASYNC_UNLINK;
+		
 		retval2 = usb_submit_urb (urb, GFP_ATOMIC);
 		if(retval2 !=0)
 		printk("Error sending Zero Length packet in transmission\n");
@@ -2404,8 +2404,10 @@
 MODULE_DEVICE_TABLE (usb, products);

 static struct usb_driver usbnet_driver = {
-	.owner =	THIS_MODULE,
-	.name =		driver_name,
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		driver_name,
+	 },
 	.id_table =	products,
 	.probe =	usbnet_probe,
 	.disconnect =	usbnet_disconnect,
