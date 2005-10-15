Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbVJOSML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbVJOSML (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Oct 2005 14:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbVJOSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Oct 2005 14:12:11 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:24244 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751189AbVJOSMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Oct 2005 14:12:10 -0400
Subject: PATCH: Better fixup for the orinoco driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 15 Oct 2005 19:41:20 +0100
Message-Id: <1129401680.17923.3.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest kernel added a pretty ugly fix for the orinoco etherleak bug
which contains bogus skb->len checks already done by the caller and
causes copies of all odd sized frames (which are quite common)

While the skb->len check should be ripped out the other fix is harder to
do properly so I'm proposing for this the -mm tree only until next 2.6.x
so that it gets tested.

Instead of copying buffers around blindly this code implements a padding
aware version of the hermes buffer writing function which does padding
as the buffer is loaded and thus more cleanly and without bogus 1.5K
copies.

Patch v current -mm so before the bogus skb->len/skb=skb_padto change
went in.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/hermes.c linux-2.6.14-rc2-mm1/drivers/net/wireless/hermes.c
--- linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/hermes.c	2005-09-22 15:21:45.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/net/wireless/hermes.c	2005-10-13 13:18:46.000000000 +0100
@@ -451,6 +451,43 @@
 	return err;
 }
 
+/* Write a block of data to the chip's buffer with padding if
+ * neccessary, via the BAP. Synchronization/serialization is the
+ * caller's problem. len must be even.
+ *
+ * Returns: < 0 on internal failure (errno), 0 on success, > 0 on error from firmware
+ */
+int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, unsigned data_len, unsigned len, 
+		      u16 id, u16 offset)
+{
+	int dreg = bap ? HERMES_DATA1 : HERMES_DATA0;
+	int err = 0;
+
+	if (len < 0 || len % 2 || data_len > len)
+		return -EINVAL;
+
+	err = hermes_bap_seek(hw, bap, id, offset);
+	if (err)
+		goto out;
+	
+	/* Transfer all the complete words of data */
+	hermes_write_words(hw, dreg, buf, data_len/2);
+	/* If there is an odd byte left over pad and transfer it */
+	if(data_len & 1) {
+		u8 end[2];
+		end[1] = 0;
+		end[0] = ((unsigned char *)buf)[data_len - 1];
+		hermes_write_words(hw, dreg, end, 1);
+		data_len ++;
+	}
+	/* Now send zeros for the padding */
+	if(data_len < len)
+		hermes_clear_words(hw, dreg, (len - data_len) / 2);
+	/* Complete */
+ out:	
+	return err;
+}
+
 /* Read a Length-Type-Value record from the card.
  *
  * If length is NULL, we ignore the length read from the card, and
@@ -538,6 +575,7 @@
 
 EXPORT_SYMBOL(hermes_bap_pread);
 EXPORT_SYMBOL(hermes_bap_pwrite);
+EXPORT_SYMBOL(hermes_bap_pwrite_pad);
 EXPORT_SYMBOL(hermes_read_ltv);
 EXPORT_SYMBOL(hermes_write_ltv);
 
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/hermes.h linux-2.6.14-rc2-mm1/drivers/net/wireless/hermes.h
--- linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/hermes.h	2005-09-22 15:21:45.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/net/wireless/hermes.h	2005-10-13 13:08:48.000000000 +0100
@@ -377,6 +377,8 @@
 		       u16 id, u16 offset);
 int hermes_bap_pwrite(hermes_t *hw, int bap, const void *buf, unsigned len,
 			u16 id, u16 offset);
+int hermes_bap_pwrite_pad(hermes_t *hw, int bap, const void *buf, 
+			unsigned data_len, unsigned len, u16 id, u16 offset);
 int hermes_read_ltv(hermes_t *hw, int bap, u16 rid, unsigned buflen,
 		    u16 *length, void *buf);
 int hermes_write_ltv(hermes_t *hw, int bap, u16 rid,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/orinoco.c linux-2.6.14-rc2-mm1/drivers/net/wireless/orinoco.c
--- linux.vanilla-2.6.14-rc2-mm1/drivers/net/wireless/orinoco.c	2005-09-22 15:22:54.000000000 +0100
+++ linux-2.6.14-rc2-mm1/drivers/net/wireless/orinoco.c	2005-10-13 13:17:19.000000000 +0100
@@ -502,8 +502,7 @@
 	}
 
 	/* Length of the packet body */
-	/* FIXME: what if the skb is smaller than this? */
-	len = max_t(int,skb->len - ETH_HLEN, ETH_ZLEN - ETH_HLEN);
+	len = max_t(int,skb->len, ETH_ZLEN) - ETH_HLEN;
 
 	eh = (struct ethhdr *)skb->data;
 
@@ -549,14 +548,21 @@
 			stats->tx_errors++;
 			goto fail;
 		}
+		/* Actual xfer length - allow for padding */
+		len = ALIGN(data_len, 2);
+		if(len < ETH_ZLEN - ETH_HLEN)
+			len = ETH_ZLEN - ETH_HLEN;
 	} else { /* IEEE 802.3 frame */
 		data_len = len + ETH_HLEN;
 		data_off = HERMES_802_3_OFFSET;
 		p = skb->data;
+		/* Actual xfer length - round up for odd length packets */
+		len = ALIGN(data_len, 2);
+		if(len < ETH_ZLEN)
+			len = ETH_ZLEN;
 	}
 
-	/* Round up for odd length packets */
-	err = hermes_bap_pwrite(hw, USER_BAP, p, ALIGN(data_len, 2),
+	err = hermes_bap_pwrite_pad(hw, USER_BAP, p, data_len, len,
 				txfid, data_off);
 	if (err) {
 		printk(KERN_ERR "%s: Error %d writing packet to BAP\n",


