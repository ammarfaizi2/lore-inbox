Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030343AbWHDFpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030343AbWHDFpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030319AbWHDFo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:44:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:2992 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030339AbWHDFoh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:44:37 -0400
Date: Thu, 3 Aug 2006 22:39:56 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, nfs@lists.sourceforge.net,
       Neil Brown <neilb@suse.de>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 14/23] Fix race related problem when adding items to and svcrpc auth cache.
Message-ID: <20060804053956.GO769@kroah.com>
References: <20060804053258.391158155@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-race-related-problem-when-adding-items-to-and-svcrpc-auth-cache.patch"
In-Reply-To: <20060804053807.GA769@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Neil Brown <neilb@suse.de>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


---
 net/sunrpc/cache.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.17.7.orig/net/sunrpc/cache.c
+++ linux-2.6.17.7/net/sunrpc/cache.c
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

--
