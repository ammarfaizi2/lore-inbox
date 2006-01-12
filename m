Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030359AbWALKsf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030359AbWALKsf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 05:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030362AbWALKsf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 05:48:35 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:1036 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030359AbWALKsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 05:48:33 -0500
Date: Thu, 12 Jan 2006 11:48:33 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, "Ed L. Cashin" <ecashin@coraid.com>,
       Greg K-H <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] drivers/block/aoe/aoecmd.c: make aoecmd_cfg_pkts() static
Message-ID: <20060112104833.GS29663@stusta.de>
References: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 04:21:35AM -0800, Andrew Morton wrote:
>...
> Changes since 2.6.15-mm2:
>...
> +gregkh-driver-aoe-support-dynamic-resizing-of-aoe-devices.patch
>...
>  driver tree updates
>...

aoecmd_cfg_pkts() can be static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/block/aoe/aoe.h    |    1 
 drivers/block/aoe/aoecmd.c |   94 ++++++++++++++++++-------------------
 2 files changed, 47 insertions(+), 48 deletions(-)

--- linux-2.6.15-mm3-full/drivers/block/aoe/aoe.h.old	2006-01-12 00:56:33.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/block/aoe/aoe.h	2006-01-12 00:56:38.000000000 +0100
@@ -154,7 +154,6 @@
 
 void aoecmd_work(struct aoedev *d);
 void aoecmd_cfg(ushort aoemajor, unsigned char aoeminor);
-struct sk_buff *aoecmd_cfg_pkts(ushort, unsigned char, struct sk_buff **);
 void aoecmd_ata_rsp(struct sk_buff *);
 void aoecmd_cfg_rsp(struct sk_buff *);
 void aoecmd_sleepwork(void *vp);
--- linux-2.6.15-mm3-full/drivers/block/aoe/aoecmd.c.old	2006-01-12 00:56:47.000000000 +0100
+++ linux-2.6.15-mm3-full/drivers/block/aoe/aoecmd.c	2006-01-12 00:57:29.000000000 +0100
@@ -190,6 +190,53 @@
 	}
 }
 
+/* some callers cannot sleep, and they can call this function,
+ * transmitting the packets later, when interrupts are on
+ */
+static struct sk_buff *
+aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff **tail)
+{
+	struct aoe_hdr *h;
+	struct aoe_cfghdr *ch;
+	struct sk_buff *skb, *sl, *sl_tail;
+	struct net_device *ifp;
+
+	sl = sl_tail = NULL;
+
+	read_lock(&dev_base_lock);
+	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
+		dev_hold(ifp);
+		if (!is_aoe_netif(ifp))
+			continue;
+
+		skb = new_skb(ifp, sizeof *h + sizeof *ch);
+		if (skb == NULL) {
+			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
+			continue;
+		}
+		if (sl_tail == NULL)
+			sl_tail = skb;
+		h = (struct aoe_hdr *) skb->mac.raw;
+		memset(h, 0, sizeof *h + sizeof *ch);
+
+		memset(h->dst, 0xff, sizeof h->dst);
+		memcpy(h->src, ifp->dev_addr, sizeof h->src);
+		h->type = __constant_cpu_to_be16(ETH_P_AOE);
+		h->verfl = AOE_HVER;
+		h->major = cpu_to_be16(aoemajor);
+		h->minor = aoeminor;
+		h->cmd = AOECMD_CFG;
+
+		skb->next = sl;
+		sl = skb;
+	}
+	read_unlock(&dev_base_lock);
+
+	if (tail != NULL)
+		*tail = sl_tail;
+	return sl;
+}
+
 /* enters with d->lock held */
 void
 aoecmd_work(struct aoedev *d)
@@ -543,53 +590,6 @@
 	aoenet_xmit(sl);
 }
 
-/* some callers cannot sleep, and they can call this function,
- * transmitting the packets later, when interrupts are on
- */
-struct sk_buff *
-aoecmd_cfg_pkts(ushort aoemajor, unsigned char aoeminor, struct sk_buff **tail)
-{
-	struct aoe_hdr *h;
-	struct aoe_cfghdr *ch;
-	struct sk_buff *skb, *sl, *sl_tail;
-	struct net_device *ifp;
-
-	sl = sl_tail = NULL;
-
-	read_lock(&dev_base_lock);
-	for (ifp = dev_base; ifp; dev_put(ifp), ifp = ifp->next) {
-		dev_hold(ifp);
-		if (!is_aoe_netif(ifp))
-			continue;
-
-		skb = new_skb(ifp, sizeof *h + sizeof *ch);
-		if (skb == NULL) {
-			printk(KERN_INFO "aoe: aoecmd_cfg: skb alloc failure\n");
-			continue;
-		}
-		if (sl_tail == NULL)
-			sl_tail = skb;
-		h = (struct aoe_hdr *) skb->mac.raw;
-		memset(h, 0, sizeof *h + sizeof *ch);
-
-		memset(h->dst, 0xff, sizeof h->dst);
-		memcpy(h->src, ifp->dev_addr, sizeof h->src);
-		h->type = __constant_cpu_to_be16(ETH_P_AOE);
-		h->verfl = AOE_HVER;
-		h->major = cpu_to_be16(aoemajor);
-		h->minor = aoeminor;
-		h->cmd = AOECMD_CFG;
-
-		skb->next = sl;
-		sl = skb;
-	}
-	read_unlock(&dev_base_lock);
-
-	if (tail != NULL)
-		*tail = sl_tail;
-	return sl;
-}
-
 void
 aoecmd_cfg(ushort aoemajor, unsigned char aoeminor)
 {

