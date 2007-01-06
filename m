Return-Path: <linux-kernel-owner+w=401wt.eu-S1751121AbXAFCaa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbXAFCaa (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbXAFCaM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:30:12 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36523 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751108AbXAFC3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:29:42 -0500
Message-Id: <20070106023300.998429000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:15 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, greg@kroah.com, boddingt@optusnet.com.au,
       ecashin@coraid.com
Subject: [patch 22/50] fix aoe without scatter-gather [Bug 7662]
Content-Disposition: inline; filename=fix-aoe-without-scatter-gather.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Ed L Cashin <ecashin@coraid.com>

Fix a bug that only appears when AoE goes over a network card that does not
support scatter-gather.  The headers in the linear part of the skb appeared
to be larger than they really were, resulting in data that was offset by 24
bytes.

This patch eliminates the offset data on cards that don't support
scatter-gather or have had scatter-gather turned off.  There remains an
unrelated issue that I'll address in a separate email.

Fixes bugzilla #7662

Signed-off-by: "Ed L. Cashin" <ecashin@coraid.com>
Cc: <stable@kernel.org>
Cc: Greg KH <greg@kroah.com>
Cc: <boddingt@optusnet.com.au>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 drivers/block/aoe/aoecmd.c |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.19.1.orig/drivers/block/aoe/aoecmd.c
+++ linux-2.6.19.1/drivers/block/aoe/aoecmd.c
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
