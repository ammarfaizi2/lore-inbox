Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751739AbWCIGx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751739AbWCIGx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 01:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbWCIGxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 01:53:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:49891 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751713AbWCIGxW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 01:53:22 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 9 Mar 2006 17:52:19 +1100
Message-Id: <1060309065219.24647@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 011 of 14] knfsd: An assortment of little fixes to the sunrpc cache code.
References: <20060309174755.24381.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


- in cache_check, h must be non-NULL as it has been de-referenced,
  so don't bother checking for NULL.

- When a cache-item is updated, we need to call cache_revisit_request to see
  if there is a pending request waiting for that item.  We were using
  a transition to CACHE_VALID to see if that was needed, however that is
  wrong as an expired entry will still be marked 'valid' (as the data is valid 
  and will need to be released).  So instead use an off transition for
  CACHE_PENDING which is exactly the right thing to test.

- Add a little bit more debugging info.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/cache.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff ./net/sunrpc/cache.c~current~ ./net/sunrpc/cache.c
--- ./net/sunrpc/cache.c~current~	2006-03-09 17:29:35.000000000 +1100
+++ ./net/sunrpc/cache.c	2006-03-09 17:30:20.000000000 +1100
@@ -208,7 +208,7 @@ int cache_check(struct cache_detail *det
 	if (rv == -EAGAIN)
 		cache_defer_req(rqstp, h);
 
-	if (rv && h)
+	if (rv)
 		detail->cache_put(h, detail);
 	return rv;
 }
@@ -223,8 +223,10 @@ void cache_fresh(struct cache_detail *de
 	head->last_refresh = get_seconds();
 	if (!test_and_set_bit(CACHE_VALID, &head->flags))
 		cache_revisit_request(head);
-	if (test_and_clear_bit(CACHE_PENDING, &head->flags))
+	if (test_and_clear_bit(CACHE_PENDING, &head->flags)) {
+		cache_revisit_request(head);
 		queue_loose(detail, head);
+	}
 }
 
 /*
@@ -551,7 +553,7 @@ static void cache_defer_req(struct cache
 		/* there was one too many */
 		dreq->revisit(dreq, 1);
 	}
-	if (test_bit(CACHE_VALID, &item->flags)) {
+	if (!test_bit(CACHE_PENDING, &item->flags)) {
 		/* must have just been validated... */
 		cache_revisit_request(item);
 	}
@@ -892,7 +894,7 @@ static void queue_loose(struct cache_det
 			if (cr->item != ch)
 				continue;
 			if (cr->readers != 0)
-				break;
+				continue;
 			list_del(&cr->q.list);
 			spin_unlock(&queue_lock);
 			detail->cache_put(cr->item, detail);
@@ -1180,8 +1182,8 @@ static int c_show(struct seq_file *m, vo
 		return cd->cache_show(m, cd, NULL);
 
 	ifdebug(CACHE)
-		seq_printf(m, "# expiry=%ld refcnt=%d\n",
-			   cp->expiry_time, atomic_read(&cp->refcnt));
+		seq_printf(m, "# expiry=%ld refcnt=%d flags=%lx\n",
+			   cp->expiry_time, atomic_read(&cp->refcnt), cp->flags);
 	cache_get(cp);
 	if (cache_check(cd, cp, NULL))
 		/* cache_check does a cache_put on failure */
