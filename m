Return-Path: <linux-kernel-owner+w=401wt.eu-S1753771AbWLRSLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753771AbWLRSLx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 13:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753776AbWLRSLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 13:11:53 -0500
Received: from ns1.coraid.com ([65.14.39.133]:13222 "EHLO coraid.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753770AbWLRSLw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 13:11:52 -0500
X-Greylist: delayed 1200 seconds by postgrey-1.27 at vger.kernel.org; Mon, 18 Dec 2006 13:11:51 EST
Date: Mon, 18 Dec 2006 12:53:00 -0500
From: "Ed L. Cashin" <ecashin@coraid.com>
To: linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, boddingt@optusnet.com.au,
       Andrew Morton <akpm@osdl.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
Subject: [PATCH 2.6.19.1] fix aoe without scatter-gather [Bug 7662]
Message-ID: <20061218175300.GM23156@coraid.com>
References: <20061209234305.c65b4e14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061209234305.c65b4e14.akpm@osdl.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a bug that only appears when AoE goes over a
network card that does not support scatter-gather.  The headers in the
linear part of the skb appeared to be larger than they really were,
resulting in data that was offset by 24 bytes.

This patch eliminates the offset data on cards that don't support
scatter-gather or have had scatter-gather turned off.  There remains
an unrelated issue that I'll address in a separate email.

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>

diff -uprN linux-2.6.19.orig/drivers/block/aoe/aoecmd.c linux-2.6.19.mod/drivers/block/aoe/aoecmd.c
--- linux-2.6.19.orig/drivers/block/aoe/aoecmd.c	2006-12-11 18:15:42.322711000 -0500
+++ linux-2.6.19.mod/drivers/block/aoe/aoecmd.c	2006-12-12 17:12:59.307200500 -0500
@@ -30,8 +30,6 @@ new_skb(ulong len)
 		skb->nh.raw = skb->mac.raw = skb->data;
 		skb->protocol = __constant_htons(ETH_P_AOE);
 		skb->priority = 0;
-		skb_put(skb, len);
-		memset(skb->head, 0, len);
 		skb->next = skb->prev = NULL;
 
 		/* tell the network layer not to perform IP checksums
@@ -122,8 +120,8 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	skb->len = sizeof *h + sizeof *ah;
-	memset(h, 0, ETH_ZLEN);
+	skb_put(skb, sizeof *h + sizeof *ah);
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 	f->buf = buf;
@@ -149,7 +147,6 @@ aoecmd_ata_rw(struct aoedev *d, struct f
 		skb->len += bcnt;
 		skb->data_len = bcnt;
 	} else {
-		skb->len = ETH_ZLEN;
 		writebit = 0;
 	}
 
@@ -206,6 +203,7 @@ aoecmd_cfg_pkts(ushort aoemajor, unsigne
 			printk(KERN_INFO "aoe: skb alloc failure\n");
 			continue;
 		}
+		skb_put(skb, sizeof *h + sizeof *ch);
 		skb->dev = ifp;
 		if (sl_tail == NULL)
 			sl_tail = skb;
@@ -243,6 +241,7 @@ freeframe(struct aoedev *d)
 			continue;
 		if (atomic_read(&skb_shinfo(f->skb)->dataref) == 1) {
 			skb_shinfo(f->skb)->nr_frags = f->skb->data_len = 0;
+			skb_trim(f->skb, 0);
 			return f;
 		}
 		n++;
@@ -698,8 +697,8 @@ aoecmd_ata_id(struct aoedev *d)
 	skb = f->skb;
 	h = (struct aoe_hdr *) skb->mac.raw;
 	ah = (struct aoe_atahdr *) (h+1);
-	skb->len = ETH_ZLEN;
-	memset(h, 0, ETH_ZLEN);
+	skb_put(skb, sizeof *h + sizeof *ah);
+	memset(h, 0, skb->len);
 	f->tag = aoehdr_atainit(d, h);
 	f->waited = 0;
 


-- 
  Ed L Cashin <ecashin@coraid.com>
