Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264253AbUEDHB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264253AbUEDHB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 03:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264255AbUEDHB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 03:01:26 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:62699 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264253AbUEDHBX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 03:01:23 -0400
Message-ID: <40973F7F.A9FA4F1@melbourne.sgi.com>
Date: Tue, 04 May 2004 17:00:15 +1000
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
References: <16521.5104.489490.617269@laputa.namesys.com>
		<16529.56343.764629.37296@cse.unsw.edu.au>
		<409634B9.8D9484DA@melbourne.sgi.com> <16534.54704.792101.617408@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> 
> > *   Dentry_stat.nr_unused can be be spuriously decremented when dput()
> >     races with __dget_unlocked().  Eventual result is nr_unused<0
> >     and kswapd loops.  This is the problem I mentioned earlier.  Note
> >     that this is not an NFS-specific problem.  Fix is:
> >
> > --- linux.orig/fs/dcache.c    Mon May  3 21:46:30 2004
> > +++ linux/fs/dcache.c Mon May  3 21:49:07 2004
> > @@ -255,8 +255,8 @@
> >
> >  static inline struct dentry * __dget_locked(struct dentry *dentry)
> >  {
> > -     atomic_inc(&dentry->d_count);
> > -     if (atomic_read(&dentry->d_count) == 1) {
> > +     if (atomic_inc(&dentry->d_count) == 1) {
> 
> One problem with this is that (in include/asm-i386/atomic.h at least):
>   static __inline__ void atomic_inc(atomic_t *v)

Ok, how about this...it's portable, and not racy, but may perturb the
logic slightly by also taking dentries off the unused list in the case
where they already had d_count>=1.  I'm not sure how significant that is.
In any case this also passes my tests.


--- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
+++ linux/fs/dcache.c	Tue May  4 14:34:44 2004
@@ -256,7 +256,7 @@
 static inline struct dentry * __dget_locked(struct dentry *dentry)
 {
 	atomic_inc(&dentry->d_count);
-	if (atomic_read(&dentry->d_count) == 1) {
+	if (!list_empty(&dentry->d_lru)) {
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
