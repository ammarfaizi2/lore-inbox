Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263644AbUECMDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263644AbUECMDD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 08:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbUECMDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 08:03:03 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:32961 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263641AbUECMC6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 08:02:58 -0400
Message-ID: <409634B9.8D9484DA@melbourne.sgi.com>
Date: Mon, 03 May 2004 22:02:01 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com> <16529.56343.764629.37296@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> This problem can be resolved by making sure that an inode never has
> both a connected and a disconnected dentry.
> 
> This is already the case for directories (as they must only have one
> dentry), but it is not the case for non-directories.
> 
> The following patch tries to address this.  It is a "technology
> preview" in that the only testing I have done is that it compiles OK.
> 
> Please consider reviewing it to see if it makes sense.

It does, and it fixes one of the dcache bugs that was tripping my debug
code.  Here are a couple more.

*   Logic bug in d_splice_alias() forgets to clear the DCACHE_DISCONNECTED
    flag when a lookup connects a disconnected dentry.  Fix is (relative
    to Neil's patch):

--- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
+++ linux/fs/dcache.c	Mon May  3 21:49:07 2004
@@ -894,6 +895,7 @@
 		new = __d_find_alias(inode, 1);
 		if (new) {
 			BUG_ON(!(new->d_flags & DCACHE_DISCONNECTED));
+			new->d_flags &= ~DCACHE_DISCONNECTED;
 			spin_unlock(&dcache_lock);
 			security_d_instantiate(new, inode);
 			d_rehash(dentry);


*   Dentry_stat.nr_unused can be be spuriously decremented when dput()
    races with __dget_unlocked().  Eventual result is nr_unused<0
    and kswapd loops.  This is the problem I mentioned earlier.  Note
    that this is not an NFS-specific problem.  Fix is:

--- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
+++ linux/fs/dcache.c	Mon May  3 21:49:07 2004
@@ -255,8 +255,8 @@
 
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
-	atomic_inc(&dentry->d_count);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (atomic_inc(&dentry->d_count) == 1) {
+	    	BUG_ON(list_empty(&dentry->d_lru));
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
 	}
@@ -663,6 +663,7 @@
 		if (gfp_mask & __GFP_FS)
 			prune_dcache(nr);
 	}
+	BUG_ON(dentry_stat.nr_unused < 0);
 	return dentry_stat.nr_unused;
 }
 

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
