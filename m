Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261736AbVANATy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261736AbVANATy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 19:19:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVANAQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 19:16:28 -0500
Received: from ponzo.noc.sonic.net ([64.142.18.11]:53678 "HELO ponzo.sonic.net")
	by vger.kernel.org with SMTP id S261713AbVAMWBE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:01:04 -0500
Date: Thu, 13 Jan 2005 14:01:00 -0800
From: Scott Doty <scott@sonic.net>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: 2.4.28(+?): Strange ARP problem
Message-ID: <20050113220100.GC25475@sonic.net>
References: <20050113145029.GA22622@sonic.net> <20050113120900.GA5681@logos.cnet> <20050113210142.GA27481@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <20050113210142.GA27481@gondor.apana.org.au>
User-Agent: Mutt/1.4.1i
X-PGP-Key: http://sonic.net/~scott/gpgkey.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 14, 2005 at 08:01:42AM +1100, Herbert Xu wrote:
> On Thu, Jan 13, 2005 at 10:09:00AM -0200, Marcelo Tosatti wrote:
> > 
> > Maybe you can try earlier v2.4.28's (-rc1 for one) to check where 
> > the problem starts to happen?
> 
> The symptom sounds like the bug in the 2.4 backport of the neighbour
> hash updates.  In neigh_create, hash_val needs to be computed inside
> the lock (and after the growing), not outside.
> 
> Someone even posted a patch for it.  I'll dig it up tonight if it
> doesn't show up by then.

I just built a patch from your description -- it's attached.

 -Scott

--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-arp

--- linux-2.4.29-rc2/net/core/neighbour.c	2005/01/13 21:55:06	1.1
+++ linux-2.4.29-rc2/net/core/neighbour.c	2005/01/13 21:56:32
@@ -427,11 +427,12 @@
 
 	n->confirmed = jiffies - (n->parms->base_reachable_time<<1);
 
-	hash_val = tbl->hash(pkey, dev) & tbl->hash_mask;
-
 	write_lock_bh(&tbl->lock);
 	if (atomic_read(&tbl->entries) > (tbl->hash_mask + 1))
 		neigh_hash_grow(tbl, (tbl->hash_mask + 1) << 1);
+
+	hash_val = tbl->hash(pkey, dev) & tbl->hash_mask;
+
 	for (n1 = tbl->hash_buckets[hash_val]; n1; n1 = n1->next) {
 		if (dev == n1->dev &&
 		    memcmp(n1->primary_key, pkey, key_len) == 0) {

--BXVAT5kNtrzKuDFl--
