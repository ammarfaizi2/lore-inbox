Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264512AbUEJEvm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264512AbUEJEvm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 00:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264506AbUEJEvm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 00:51:42 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:56552 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264505AbUEJEvj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 00:51:39 -0400
Message-ID: <409F09FD.778D4231@melbourne.sgi.com>
Date: Mon, 10 May 2004 14:50:05 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com>
		<16529.56343.764629.37296@cse.unsw.edu.au>
		<409634B9.8D9484DA@melbourne.sgi.com>
		<16534.54704.792101.617408@cse.unsw.edu.au>
		<40973F7F.A9FA4F1@melbourne.sgi.com> <16542.61686.49097.41973@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> On Tuesday May 4, gnb@melbourne.sgi.com wrote:
> > > >
> > Ok, how about this...it's portable, and not racy, but may perturb the
> > logic slightly by also taking dentries off the unused list in the case
> > where they already had d_count>=1.  I'm not sure how significant that is.
> > In any case this also passes my tests.
> 
> I think this patch is good and needed.
> 
> I think the race can happen if:
>        dentry->d_count == 1, not on list
> 
>    thread 1                       thread 2
>    enter __dget_locked            enter dput
>    atomic_inc(d_count) (now 2)
>                                   atomic_dec_and_lock(d_count...) (now 1)
>    if(atomic_read(d_count)==1 ....
>          remove from list
> 
> This will remove it from the unused list when it isn't
> on, and will decrement nr_unused which, as you say, is bad.

This is precisely the race that my tracing indicated was happening
during my tests.

> [...]  Possibly that patch should update the
> d_lookup comment to add __dget_locked to the set of functions that
> clean up after it.

Ok, updated patch below.


--- linux.orig/fs/dcache.c	2004-05-10 13:38:09.000000000 +1000
+++ linux/fs/dcache.c	2004-05-10 14:45:44.000000000 +1000
@@ -257,7 +257,7 @@
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (!list_empty(&dentry->d_lru)) {
 		dentry_stat.nr_unused--;
 		list_del_init(&dentry->d_lru);
 	}
@@ -940,8 +942,9 @@
  * lookup is going on.
  *
  * dentry_unused list is not updated even if lookup finds the required dentry
- * in there. It is updated in places such as prune_dcache, shrink_dcache_sb and
- * select_parent. This laziness saves lookup from dcache_lock acquisition.
+ * in there. It is updated in places such as prune_dcache, shrink_dcache_sb,
+ * select_parent and __dget_locked. This laziness saves lookup from dcache_lock
+ * acquisition.
  *
  * d_lookup() is protected against the concurrent renames in some unrelated
  * directory using the seqlockt_t rename_lock.


Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
