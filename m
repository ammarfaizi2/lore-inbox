Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264406AbUEIW2T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbUEIW2T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264404AbUEIW2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:28:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:3213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264406AbUEIW2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:28:15 -0400
Date: Sun, 9 May 2004 15:27:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: dipankar@in.ibm.com, manfred@colorfullife.com, torvalds@osdl.org,
       davej@redhat.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       maneesh@in.ibm.com
Subject: Re: dentry bloat.
Message-Id: <20040509152720.039f759a.akpm@osdl.org>
In-Reply-To: <20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk>
References: <20040508012357.3559fb6e.akpm@osdl.org>
	<20040508022304.17779635.akpm@osdl.org>
	<20040508031159.782d6a46.akpm@osdl.org>
	<Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org>
	<20040508120148.1be96d66.akpm@osdl.org>
	<Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org>
	<Pine.LNX.4.58.0405081216510.3271@ppc970.osdl.org>
	<20040508204239.GB6383@in.ibm.com>
	<409DDDAE.3090700@colorfullife.com>
	<20040509153316.GE4007@in.ibm.com>
	<20040509221712.GA17014@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:
>
> On Sun, May 09, 2004 at 09:03:16PM +0530, Dipankar Sarma wrote:
>  
> > Actually, what may happen is that since the dentries are added
> > in the front, a double move like that would result in hash chain
> > traversal looping. Timing dependent and unlikely, but d_move_count
> > avoided that theoritical possibility. It is not about skipping
> > dentries which is safe because a miss would result in a real_lookup()
> 
> Not really.  A miss could result in getting another dentry allocated
> for the same e.g. directory, which is *NOT* harmless at all.

The d_bucket logic does look a bit odd.

		dentry = hlist_entry(node, struct dentry, d_hash);

		/* if lookup ends up in a different bucket 
		 * due to concurrent rename, fail it
		 */
		if (unlikely(dentry->d_bucket != head))
			break;

		/*
		 * We must take a snapshot of d_move_count followed by
		 * read memory barrier before any search key comparison 
		 */
		move_count = dentry->d_move_count;

There is a window between the d_bucket test and sampling of d_move_count. 
What happens if the dentry gets moved around in there?

Anyway, regardless of that, it is more efficient to test d_bucket _after_
performing the hash comparison.  And it seems saner to perform the d_bucket
check when things are pinned down by d_lock.



 25-akpm/fs/dcache.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff -puN fs/dcache.c~dentry-d_bucket-fix fs/dcache.c
--- 25/fs/dcache.c~dentry-d_bucket-fix	2004-05-09 14:06:51.816554824 -0700
+++ 25-akpm/fs/dcache.c	2004-05-09 14:07:41.932935976 -0700
@@ -975,12 +975,6 @@ struct dentry * __d_lookup(struct dentry
 		smp_read_barrier_depends();
 		dentry = hlist_entry(node, struct dentry, d_hash);
 
-		/* if lookup ends up in a different bucket 
-		 * due to concurrent rename, fail it
-		 */
-		if (unlikely(dentry->d_bucket != head))
-			break;
-
 		smp_rmb();
 
 		if (dentry->d_name.hash != hash)
@@ -991,6 +985,13 @@ struct dentry * __d_lookup(struct dentry
 		spin_lock(&dentry->d_lock);
 
 		/*
+		 * If lookup ends up in a different bucket due to concurrent
+		 * rename, fail it
+		 */
+		if (unlikely(dentry->d_bucket != head))
+			goto terminate;
+
+		/*
 		 * Recheck the dentry after taking the lock - d_move may have
 		 * changed things.  Don't bother checking the hash because we're
 		 * about to compare the whole name anyway.
@@ -1014,6 +1015,7 @@ struct dentry * __d_lookup(struct dentry
 			atomic_inc(&dentry->d_count);
 			found = dentry;
 		}
+terminate:
 		spin_unlock(&dentry->d_lock);
 		break;
 next:

_

