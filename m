Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWGSBPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWGSBPp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 21:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbWGSBPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 21:15:44 -0400
Received: from student.uhasselt.be ([193.190.2.1]:9733 "EHLO
	student.uhasselt.be") by vger.kernel.org with ESMTP id S932437AbWGSBPn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 21:15:43 -0400
Date: Wed, 19 Jul 2006 03:15:40 +0200
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, nico@cam.org, patrick@tykepenguin.com,
       linville@tuxdriver.com, davem@davemloft.net
Subject: [PATCH] Conversions from kmalloc+memset to k(z|c)alloc.
Message-ID: <20060719011540.GD30823@lumumba.uhasselt.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: takis@lumumba.uhasselt.be (Panagiotis Issaris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Panagiotis Issaris <takis@issaris.org>

Conversions from kmalloc+memset to k(z|c)alloc.  The original memsets
did not clear out the entire allocated structure. To my unexperienced
eye, that seemed a bit fishy (or at least a bit weird and inconsistent).

Signed-off-by: Panagiotis Issaris <takis@issaris.org>
---
Applies to current GIT or 2.6.18-rc2. Compile-tested with 
make allyesconfig.

 drivers/video/pxafb.c        |    3 +--
 drivers/video/sa1100fb.c     |    3 +--
 net/decnet/dn_table.c        |    4 +---
 net/ieee80211/ieee80211_tx.c |    3 +--
 net/ipv6/ip6_flowlabel.c     |    3 +--
 net/sched/sch_atm.c          |    3 +--
 6 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
index bbb0710..57931cf 100644
--- a/drivers/video/pxafb.c
+++ b/drivers/video/pxafb.c
@@ -1051,11 +1051,10 @@ static struct pxafb_info * __init pxafb_
 	struct pxafb_mach_info *inf = dev->platform_data;
 
 	/* Alloc the pxafb_info and pseudo_palette in one step */
-	fbi = kmalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
+	fbi = kzalloc(sizeof(struct pxafb_info) + sizeof(u32) * 16, GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct pxafb_info));
 	fbi->dev = dev;
 
 	strcpy(fbi->fb.fix.id, PXA_NAME);
diff --git a/drivers/video/sa1100fb.c b/drivers/video/sa1100fb.c
index a2e6e72..fdcc617 100644
--- a/drivers/video/sa1100fb.c
+++ b/drivers/video/sa1100fb.c
@@ -1373,12 +1373,11 @@ static struct sa1100fb_info * __init sa1
 	struct sa1100fb_mach_info *inf;
 	struct sa1100fb_info *fbi;
 
-	fbi = kmalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
+	fbi = kzalloc(sizeof(struct sa1100fb_info) + sizeof(u32) * 16,
 		      GFP_KERNEL);
 	if (!fbi)
 		return NULL;
 
-	memset(fbi, 0, sizeof(struct sa1100fb_info));
 	fbi->dev = dev;
 
 	strcpy(fbi->fb.fix.id, SA1100_NAME);
diff --git a/net/decnet/dn_table.c b/net/decnet/dn_table.c
index e926c95..b104d52 100644
--- a/net/decnet/dn_table.c
+++ b/net/decnet/dn_table.c
@@ -759,11 +759,9 @@ struct dn_fib_table *dn_fib_get_table(in
                 printk(KERN_DEBUG "DECnet: BUG! Attempt to create routing table from interrupt\n"); 
                 return NULL;
         }
-        if ((t = kmalloc(sizeof(struct dn_fib_table) + sizeof(struct dn_hash), GFP_KERNEL)) == NULL)
+        if ((t = kzalloc(sizeof(struct dn_fib_table) + sizeof(struct dn_hash), GFP_KERNEL)) == NULL)
                 return NULL;
 
-        memset(t, 0, sizeof(struct dn_fib_table));
-
         t->n = n;
         t->insert = dn_fib_table_insert;
         t->delete = dn_fib_table_delete;
diff --git a/net/ieee80211/ieee80211_tx.c b/net/ieee80211/ieee80211_tx.c
index bf04213..732d13f 100644
--- a/net/ieee80211/ieee80211_tx.c
+++ b/net/ieee80211/ieee80211_tx.c
@@ -192,12 +192,11 @@ static struct ieee80211_txb *ieee80211_a
 {
 	struct ieee80211_txb *txb;
 	int i;
-	txb = kmalloc(sizeof(struct ieee80211_txb) + (sizeof(u8 *) * nr_frags),
+	txb = kzalloc(sizeof(struct ieee80211_txb) + (sizeof(u8 *) * nr_frags),
 		      gfp_mask);
 	if (!txb)
 		return NULL;
 
-	memset(txb, 0, sizeof(struct ieee80211_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = txb_size;
 
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 1d672b0..782c33c 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -297,11 +297,10 @@ fl_create(struct in6_flowlabel_req *freq
 		int junk;
 
 		err = -ENOMEM;
-		fl->opt = kmalloc(sizeof(*fl->opt) + olen, GFP_KERNEL);
+		fl->opt = kzalloc(sizeof(*fl->opt) + olen, GFP_KERNEL);
 		if (fl->opt == NULL)
 			goto done;
 
-		memset(fl->opt, 0, sizeof(*fl->opt));
 		fl->opt->tot_len = sizeof(*fl->opt) + olen;
 		err = -EFAULT;
 		if (copy_from_user(fl->opt+1, optval+CMSG_ALIGN(sizeof(*freq)), olen))
diff --git a/net/sched/sch_atm.c b/net/sched/sch_atm.c
index dbf44da..75398bb 100644
--- a/net/sched/sch_atm.c
+++ b/net/sched/sch_atm.c
@@ -308,13 +308,12 @@ static int atm_tc_change(struct Qdisc *s
 		}
 	}
 	DPRINTK("atm_tc_change: new id %x\n",classid);
-	flow = kmalloc(sizeof(struct atm_flow_data)+hdr_len,GFP_KERNEL);
+	flow = kzalloc(sizeof(struct atm_flow_data)+hdr_len,GFP_KERNEL);
 	DPRINTK("atm_tc_change: flow %p\n",flow);
 	if (!flow) {
 		error = -ENOBUFS;
 		goto err_out;
 	}
-	memset(flow,0,sizeof(*flow));
 	flow->filter_list = NULL;
 	if (!(flow->q = qdisc_create_dflt(sch->dev,&pfifo_qdisc_ops)))
 		flow->q = &noop_qdisc;
-- 
1.4.1.gd3ba6

-- 
OpenPGP key: http://lumumba.luc.ac.be/takis/takis_public_key.txt
fingerprint: 6571 13A3 33D9 3726 F728  AA98 F643 B12E ECF3 E029
