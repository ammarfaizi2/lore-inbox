Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751297AbWCKUiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751297AbWCKUiS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 15:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWCKUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 15:38:18 -0500
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:42182 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751297AbWCKUiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 15:38:17 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "YOSHIFUJI Hideaki / =?utf-8?q?=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?=" 
	<yoshfuji@linux-ipv6.org>
Subject: [PATCH] Nearly complete kzalloc cleanup for net/ipv6
Date: Sat, 11 Mar 2006 21:36:42 +0100
User-Agent: KMail/1.9.1
Cc: "David Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603112136.43553.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ingo Oeser <ioe-lkml@rameria.de>

Stupidly use kzalloc() instead of kmalloc()/memset() 
everywhere where this is possible in net/ipv6/*.c . 

Signed-off-by: Ingo Oeser <ioe-lkml@rameria.de>
---
Hi,

I'm going to refactor some of the simple cases to reduce code
duplication which will depend on this patch.

net/ipv6/reassambly.c will get a separate patch,
since I refactored it a little bit.

The netfilter part is NOT included, because Harald should see these, too.

Patch is against net-2.6.17


Regards

Ingo Oeser

diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 8ff7147..b876a10 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -354,12 +354,10 @@ static int ah6_init_state(struct xfrm_st
 	if (x->encap)
 		goto error;
 
-	ahp = kmalloc(sizeof(*ahp), GFP_KERNEL);
+	ahp = kzalloc(sizeof(*ahp), GFP_KERNEL);
 	if (ahp == NULL)
 		return -ENOMEM;
 
-	memset(ahp, 0, sizeof(*ahp));
-
 	ahp->key = x->aalg->alg_key;
 	ahp->key_len = (x->aalg->alg_key_len+7)/8;
 	ahp->tfm = crypto_alloc_tfm(x->aalg->alg_name, 0);
diff --git a/net/ipv6/anycast.c b/net/ipv6/anycast.c
index 840a33d..39ec528 100644
--- a/net/ipv6/anycast.c
+++ b/net/ipv6/anycast.c
@@ -308,7 +308,7 @@ int ipv6_dev_ac_inc(struct net_device *d
 	 *	not found: create a new one.
 	 */
 
-	aca = kmalloc(sizeof(struct ifacaddr6), GFP_ATOMIC);
+	aca = kzalloc(sizeof(struct ifacaddr6), GFP_ATOMIC);
 
 	if (aca == NULL) {
 		err = -ENOMEM;
@@ -322,8 +322,6 @@ int ipv6_dev_ac_inc(struct net_device *d
 		goto out;
 	}
 
-	memset(aca, 0, sizeof(struct ifacaddr6));
-
 	ipv6_addr_copy(&aca->aca_addr, addr);
 	aca->aca_idev = idev;
 	aca->aca_rt = rt;
@@ -550,7 +548,7 @@ static int ac6_seq_open(struct inode *in
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct ac6_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct ac6_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -561,7 +559,6 @@ static int ac6_seq_open(struct inode *in
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index aa7f100..3dcaac7 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -305,12 +305,10 @@ static int esp6_init_state(struct xfrm_s
 	if (x->encap)
 		goto error;
 
-	esp = kmalloc(sizeof(*esp), GFP_KERNEL);
+	esp = kzalloc(sizeof(*esp), GFP_KERNEL);
 	if (esp == NULL)
 		return -ENOMEM;
 
-	memset(esp, 0, sizeof(*esp));
-
 	if (x->aalg) {
 		struct xfrm_algo_desc *aalg_desc;
 
diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 69cbe8a..f9ca639 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -287,10 +287,9 @@ fl_create(struct in6_flowlabel_req *freq
 	int err;
 
 	err = -ENOMEM;
-	fl = kmalloc(sizeof(*fl), GFP_KERNEL);
+	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (fl == NULL)
 		goto done;
-	memset(fl, 0, sizeof(*fl));
 
 	olen = optlen - CMSG_ALIGN(sizeof(*freq));
 	if (olen > 0) {
@@ -663,7 +662,7 @@ static int ip6fl_seq_open(struct inode *
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct ip6fl_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct ip6fl_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -674,7 +673,6 @@ static int ip6fl_seq_open(struct inode *
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv6/ipcomp6.c b/net/ipv6/ipcomp6.c
index 3c7b324..028b636 100644
--- a/net/ipv6/ipcomp6.c
+++ b/net/ipv6/ipcomp6.c
@@ -428,11 +428,10 @@ static int ipcomp6_init_state(struct xfr
 		goto out;
 
 	err = -ENOMEM;
-	ipcd = kmalloc(sizeof(*ipcd), GFP_KERNEL);
+	ipcd = kzalloc(sizeof(*ipcd), GFP_KERNEL);
 	if (!ipcd)
 		goto out;
 
-	memset(ipcd, 0, sizeof(*ipcd));
 	x->props.header_len = 0;
 	if (x->props.mode)
 		x->props.header_len += sizeof(struct ipv6hdr);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 807c021..6e871af 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -767,10 +767,10 @@ static void mld_add_delrec(struct inet6_
 	 * for deleted items allows change reports to use common code with
 	 * non-deleted or query-response MCA's.
 	 */
-	pmc = kmalloc(sizeof(*pmc), GFP_ATOMIC);
+	pmc = kzalloc(sizeof(*pmc), GFP_ATOMIC);
 	if (!pmc)
 		return;
-	memset(pmc, 0, sizeof(*pmc));
+
 	spin_lock_bh(&im->mca_lock);
 	spin_lock_init(&pmc->mca_lock);
 	pmc->idev = im->idev;
@@ -893,7 +893,7 @@ int ipv6_dev_mc_inc(struct net_device *d
 	 *	not found: create a new one.
 	 */
 
-	mc = kmalloc(sizeof(struct ifmcaddr6), GFP_ATOMIC);
+	mc = kzalloc(sizeof(struct ifmcaddr6), GFP_ATOMIC);
 
 	if (mc == NULL) {
 		write_unlock_bh(&idev->lock);
@@ -901,7 +901,6 @@ int ipv6_dev_mc_inc(struct net_device *d
 		return -ENOMEM;
 	}
 
-	memset(mc, 0, sizeof(struct ifmcaddr6));
 	init_timer(&mc->mca_timer);
 	mc->mca_timer.function = igmp6_timer_handler;
 	mc->mca_timer.data = (unsigned long) mc;
@@ -1934,10 +1933,10 @@ static int ip6_mc_add1_src(struct ifmcad
 		psf_prev = psf;
 	}
 	if (!psf) {
-		psf = kmalloc(sizeof(*psf), GFP_ATOMIC);
+		psf = kzalloc(sizeof(*psf), GFP_ATOMIC);
 		if (!psf)
 			return -ENOBUFS;
-		memset(psf, 0, sizeof(*psf));
+
 		psf->sf_addr = *psfsrc;
 		if (psf_prev) {
 			psf_prev->sf_next = psf;
@@ -2431,7 +2430,7 @@ static int igmp6_mc_seq_open(struct inod
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct igmp6_mc_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct igmp6_mc_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 
 	if (!s)
 		goto out;
@@ -2442,7 +2441,6 @@ static int igmp6_mc_seq_open(struct inod
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
@@ -2606,7 +2604,7 @@ static int igmp6_mcf_seq_open(struct ino
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct igmp6_mcf_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct igmp6_mcf_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 	
 	if (!s)
 		goto out;
@@ -2617,7 +2615,6 @@ static int igmp6_mcf_seq_open(struct ino
 
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index 0f63078..fa1ce0a 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -1198,7 +1198,7 @@ static int raw6_seq_open(struct inode *i
 {
 	struct seq_file *seq;
 	int rc = -ENOMEM;
-	struct raw6_iter_state *s = kmalloc(sizeof(*s), GFP_KERNEL);
+	struct raw6_iter_state *s = kzalloc(sizeof(*s), GFP_KERNEL);
 	if (!s)
 		goto out;
 	rc = seq_open(file, &raw6_seq_ops);
@@ -1206,7 +1206,6 @@ static int raw6_seq_open(struct inode *i
 		goto out_kfree;
 	seq = file->private_data;
 	seq->private = s;
-	memset(s, 0, sizeof(*s));
 out:
 	return rc;
 out_kfree:
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 074c49f..abcc7b2 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1877,11 +1877,10 @@ int inet6_dump_fib(struct sk_buff *skb, 
 		/*
 		 * 2. allocate and initialize walker.
 		 */
-		w = kmalloc(sizeof(*w), GFP_ATOMIC);
+		w = kzalloc(sizeof(*w), GFP_ATOMIC);
 		if (w == NULL)
 			return -ENOMEM;
 		RT6_TRACE("dump<%p", w);
-		memset(w, 0, sizeof(*w));
 		w->root = &ip6_routing_table;
 		w->func = fib6_dump_node;
 		w->args = &arg;
