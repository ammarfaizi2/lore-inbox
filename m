Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVIXKo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVIXKo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 06:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbVIXKo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 06:44:29 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33772 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932164AbVIXKo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 06:44:28 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Simon Evans <spse@secret.org.uk>, Vojtech Pavlik <vojtech@suse.cz>
Subject: New inventions in rounding up in catc.c?
Date: Sat, 24 Sep 2005 13:43:42 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_e3SNDa2LoXaEDuh"
Message-Id: <200509241343.42464.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_e3SNDa2LoXaEDuh
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

# grep '>> 6' -C5 catc.c
                catc->stats.rx_bytes += pkt_len;

                /* F5U011 only does one packet per RX */
                if (catc->is_f5u011)
                        break;
                pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;

        } while (pkt_start - (u8 *) urb->transfer_buffer < urb->actual_length);

        catc->netdev->last_rx = jiffies;

--
        unsigned long flags;
        char *tx_buf;

        spin_lock_irqsave(&catc->tx_lock, flags);

        catc->tx_ptr = (((catc->tx_ptr - 1) >> 6) + 1) << 6;
        tx_buf = catc->tx_buf[catc->tx_idx] + catc->tx_ptr;
        *((u16*)tx_buf) = (catc->is_f5u011) ? cpu_to_be16((u16)skb->len) : cpu_to_le16((u16)skb->len);
        memcpy(tx_buf + 2, skb->data, skb->len);
        catc->tx_ptr += skb->len + 2;

I case I do not miss something, second one rounds tx_ptr up to 64 byte
boundary. It can be done in 2 operations instead of 4.

First one may be the same, but do you really meant pkt_len + 1, not pkt_len - 1?

Patch is below, and also attached (KMail may mangle inline patches).
--
vda

--- linux-2.6.13.org/drivers/usb/net/catc.c.org	Mon Aug 29 02:41:01 2005
+++ linux-2.6.13.org/drivers/usb/net/catc.c	Sat Sep 24 13:35:42 2005
@@ -268,7 +268,7 @@ static void catc_rx_done(struct urb *urb
 		/* F5U011 only does one packet per RX */
 		if (catc->is_f5u011)
 			break;
-		pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;
+		pkt_start += ((pkt_len + 2) + 63) & ~63;
 
 	} while (pkt_start - (u8 *) urb->transfer_buffer < urb->actual_length);
 
@@ -417,7 +417,7 @@ static int catc_hard_start_xmit(struct s
 
 	spin_lock_irqsave(&catc->tx_lock, flags);
 
-	catc->tx_ptr = (((catc->tx_ptr - 1) >> 6) + 1) << 6;
+	catc->tx_ptr = (catc->tx_ptr + 63) & ~63;
 	tx_buf = catc->tx_buf[catc->tx_idx] + catc->tx_ptr;
 	*((u16*)tx_buf) = (catc->is_f5u011) ? cpu_to_be16((u16)skb->len) : cpu_to_le16((u16)skb->len);
 	memcpy(tx_buf + 2, skb->data, skb->len);

--Boundary-00=_e3SNDa2LoXaEDuh
Content-Type: text/x-diff;
  charset="us-ascii";
  name="catc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="catc.patch"

--- linux-2.6.13.org/drivers/usb/net/catc.c.org	Mon Aug 29 02:41:01 2005
+++ linux-2.6.13.org/drivers/usb/net/catc.c	Sat Sep 24 13:35:42 2005
@@ -268,7 +268,7 @@ static void catc_rx_done(struct urb *urb
 		/* F5U011 only does one packet per RX */
 		if (catc->is_f5u011)
 			break;
-		pkt_start += (((pkt_len + 1) >> 6) + 1) << 6;
+		pkt_start += ((pkt_len + 2) + 63) & ~63;
 
 	} while (pkt_start - (u8 *) urb->transfer_buffer < urb->actual_length);
 
@@ -417,7 +417,7 @@ static int catc_hard_start_xmit(struct s
 
 	spin_lock_irqsave(&catc->tx_lock, flags);
 
-	catc->tx_ptr = (((catc->tx_ptr - 1) >> 6) + 1) << 6;
+	catc->tx_ptr = (catc->tx_ptr + 63) & ~63;
 	tx_buf = catc->tx_buf[catc->tx_idx] + catc->tx_ptr;
 	*((u16*)tx_buf) = (catc->is_f5u011) ? cpu_to_be16((u16)skb->len) : cpu_to_le16((u16)skb->len);
 	memcpy(tx_buf + 2, skb->data, skb->len);

--Boundary-00=_e3SNDa2LoXaEDuh--
