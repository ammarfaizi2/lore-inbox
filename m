Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWFUQ6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWFUQ6V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 12:58:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750860AbWFUQ6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 12:58:21 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4276 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750814AbWFUQ6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 12:58:20 -0400
Subject: Memory corruption in 8390.c ? (was Re: Possible leaks in network
	drivers)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
In-Reply-To: <1150907317.8320.0.camel@alice>
References: <1150907317.8320.0.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jun 2006 18:13:02 +0100
Message-Id: <1150909982.15275.100.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-06-21 am 18:28 +0200, ysgrifennodd Eric Sesterhenn:
> of the driver. Where we call skb=skb_padto(skb, ETH_ZLEN),
> and dont free the skb later when something goes wrong.

skb_padto() returns either a new buffer or the existing one depending
upon the space situation. If it returns a new buffer then it frees the
old one.

The sequence is

dev_queue_xmit(skb)
	->hard_start_xmit(dev, skb)
	if (0)
		free skb
	return

Which I think means that the error path for a short packet would double
free the skb buffer and leak nskb.


So these drivers should indeed be checking their status before they
clone the buffer. At the point they do an skb_padto they must not fail
if the skb_padto succeeds.

In the case of 8390.c this was broken in 2.6.9 when the efficient 8390
padding code was replaced by something slower and it turns out broken -
although nobody realised that last bit until the checker came along.

See: http://linux.derkeiler.com/Mailing-Lists/Kernel/2005-02/4480.html

Although reverting the change was proposed it was not actually done.


The following should do the trick:

Signed-off-by: Alan Cox <alan@redhat.com>

--- drivers/net/8390.c~	2006-06-21 17:41:12.006145536 +0100
+++ drivers/net/8390.c	2006-06-21 17:41:12.007145384 +0100
@@ -275,12 +275,14 @@
 	struct ei_device *ei_local = (struct ei_device *) netdev_priv(dev);
 	int send_length = skb->len, output_page;
 	unsigned long flags;
+	char buf[64];
+	char *data = skb->data;
 
 	if (skb->len < ETH_ZLEN) {
-		skb = skb_padto(skb, ETH_ZLEN);
-		if (skb == NULL)
-			return 0;
+		memset(buf, 0, ETH_ZLEN);	/* more efficient than doing just the needed bits */
+		memcpy(buf, data, ETH_ZLEN);
 		send_length = ETH_ZLEN;
+		data = buf;
 	}
 
 	/* Mask interrupts from the ethercard. 
@@ -347,7 +349,7 @@
 	 * trigger the send later, upon receiving a Tx done interrupt.
 	 */
 	 
-	ei_block_output(dev, send_length, skb->data, output_page);
+	ei_block_output(dev, send_length, data, output_page);
 		
 	if (! ei_local->txing) 
 	{



