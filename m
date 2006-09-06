Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965073AbWIFXFy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965073AbWIFXFy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:05:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965271AbWIFXFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:05:52 -0400
Received: from mail.kroah.org ([69.55.234.183]:30925 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965079AbWIFXDI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:08 -0400
Date: Wed, 6 Sep 2006 15:57:59 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Jeff Garzik <jgarzik@pobox.com>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       Stephen Hemminger <shemminger@osdl.org>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 34/37] sky2: use dev_alloc_skb for receive buffers
Message-ID: <20060906225759.GI15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sky2-dev-alloc.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

Several code paths assume an additional 16 bytes of header padding
on the receive path. Use dev_alloc_skb to get that padding.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/net/sky2.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/drivers/net/sky2.c
+++ linux-2.6.17.11/drivers/net/sky2.c
@@ -949,14 +949,14 @@ static void sky2_vlan_rx_kill_vid(struct
 /*
  * It appears the hardware has a bug in the FIFO logic that
  * cause it to hang if the FIFO gets overrun and the receive buffer
- * is not aligned. ALso alloc_skb() won't align properly if slab
+ * is not aligned. Also dev_alloc_skb() won't align properly if slab
  * debugging is enabled.
  */
 static inline struct sk_buff *sky2_alloc_skb(unsigned int size, gfp_t gfp_mask)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(size + RX_SKB_ALIGN, gfp_mask);
+	skb = __dev_alloc_skb(size + RX_SKB_ALIGN, gfp_mask);
 	if (likely(skb)) {
 		unsigned long p	= (unsigned long) skb->data;
 		skb_reserve(skb, ALIGN(p, RX_SKB_ALIGN) - p);
@@ -1855,7 +1855,7 @@ static struct sk_buff *sky2_receive(stru
 		goto oversize;
 
 	if (length < copybreak) {
-		skb = alloc_skb(length + 2, GFP_ATOMIC);
+		skb = dev_alloc_skb(length + 2);
 		if (!skb)
 			goto resubmit;
 

--
