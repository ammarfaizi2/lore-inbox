Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWHCAU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWHCAU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWHCAU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:20:26 -0400
Received: from mail.suse.de ([195.135.220.2]:54213 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750798AbWHCAU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:20:26 -0400
From: Neil Brown <neilb@suse.de>
To: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Date: Thu, 3 Aug 2006 10:20:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17617.16700.274788.869486@cse.unsw.edu.au>
Cc: nfs@lists.sourceforge.net, akpm@osdl.org, stable@kernel.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH for stable] Re: [Fwd: moradin 2006-08-02 11:02 System Events]
In-Reply-To: message from Philipp Matthias Hahn on Wednesday August 2
References: <44D08371.9070607@svs.Informatik.Uni-Oldenburg.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday August 2, pmhahn@svs.Informatik.Uni-Oldenburg.de wrote:
> Hello!
> 
> Rebooting one of our NFS file servers with 2.6.17.7, I just got the
> following OOPS:

Thanks for the report.
The bug was fairly easy to find and fix.
I think this would be appropriate for the next 2.6.17.x stable kernel,
and definitely for 2.6.18. (hence 'akpm' and 'stable' cc:ed).

It is not relevant for earlier kernels (e.g. 2.6.16).

Patch was made against 2.6.18-rc2-mm1, but applies equally to
2.6.17.7.

Thanks again,
NeilBrown


---------------------------------------------
Fix race related problem when adding items to and svcrpc auth cache.

If we don't find the item we are lookng for, we allocate a new one,
and then grab the lock again and search to see if it has been added
while we did the alloc.
If it had been added we need to 'cache_put' the newly created item 
that we are never going to use.  But as it hasn't been initialised
properly, putting it can cause an oops.

So move the ->init call earlier to that it will always be fully
initilised if we have to put it.

Thanks to Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
for reporting the problem.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./net/sunrpc/cache.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff .prev/net/sunrpc/cache.c ./net/sunrpc/cache.c
--- .prev/net/sunrpc/cache.c	2006-08-03 10:07:33.000000000 +1000
+++ ./net/sunrpc/cache.c	2006-08-03 10:08:36.000000000 +1000
@@ -71,7 +71,12 @@ struct cache_head *sunrpc_cache_lookup(s
 	new = detail->alloc();
 	if (!new)
 		return NULL;
+	/* must fully initialise 'new', else
+	 * we might get lose if we need to
+	 * cache_put it soon.
+	 */
 	cache_init(new);
+	detail->init(new, key);
 
 	write_lock(&detail->hash_lock);
 
@@ -85,7 +90,6 @@ struct cache_head *sunrpc_cache_lookup(s
 			return tmp;
 		}
 	}
-	detail->init(new, key);
 	new->next = *head;
 	*head = new;
 	detail->entries++;
