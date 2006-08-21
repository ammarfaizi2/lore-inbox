Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbWHUStk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWHUStk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750778AbWHUStT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:49:19 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13757 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750756AbWHUStN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:49:13 -0400
Date: Mon, 21 Aug 2006 11:47:38 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 16/20] Fix ipv4 routing locking bug
Message-ID: <20060821184738.GQ21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-ipv4-routing-locking-bug.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>

[IPV4]: severe locking bug in fib_semantics.c

Found in 2.4 by Yixin Pan <yxpan@hotmail.com>.

> When I read fib_semantics.c of Linux-2.4.32, write_lock(&fib_info_lock) =
> is used in fib_release_info() instead of write_lock_bh(&fib_info_lock).  =
> Is the following case possible: a BH interrupts fib_release_info() while =
> holding the write lock, and calls ip_check_fib_default() which calls =
> read_lock(&fib_info_lock), and spin forever.

Signed-off-by: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/fib_semantics.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.17.9.orig/net/ipv4/fib_semantics.c
+++ linux-2.6.17.9/net/ipv4/fib_semantics.c
@@ -160,7 +160,7 @@ void free_fib_info(struct fib_info *fi)
 
 void fib_release_info(struct fib_info *fi)
 {
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	if (fi && --fi->fib_treeref == 0) {
 		hlist_del(&fi->fib_hash);
 		if (fi->fib_prefsrc)
@@ -173,7 +173,7 @@ void fib_release_info(struct fib_info *f
 		fi->fib_dead = 1;
 		fib_info_put(fi);
 	}
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 }
 
 static __inline__ int nh_comp(const struct fib_info *fi, const struct fib_info *ofi)
@@ -599,7 +599,7 @@ static void fib_hash_move(struct hlist_h
 	unsigned int old_size = fib_hash_size;
 	unsigned int i, bytes;
 
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	old_info_hash = fib_info_hash;
 	old_laddrhash = fib_info_laddrhash;
 	fib_hash_size = new_size;
@@ -640,7 +640,7 @@ static void fib_hash_move(struct hlist_h
 	}
 	fib_info_laddrhash = new_laddrhash;
 
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 
 	bytes = old_size * sizeof(struct hlist_head *);
 	fib_hash_free(old_info_hash, bytes);
@@ -822,7 +822,7 @@ link_it:
 
 	fi->fib_treeref++;
 	atomic_inc(&fi->fib_clntref);
-	write_lock(&fib_info_lock);
+	write_lock_bh(&fib_info_lock);
 	hlist_add_head(&fi->fib_hash,
 		       &fib_info_hash[fib_info_hashfn(fi)]);
 	if (fi->fib_prefsrc) {
@@ -841,7 +841,7 @@ link_it:
 		head = &fib_info_devhash[hash];
 		hlist_add_head(&nh->nh_hash, head);
 	} endfor_nexthops(fi)
-	write_unlock(&fib_info_lock);
+	write_unlock_bh(&fib_info_lock);
 	return fi;
 
 err_inval:

--
