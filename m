Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUEJDDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUEJDDr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 23:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEJDDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 23:03:47 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:52708 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264479AbUEJDDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 23:03:42 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg Banks <gnb@melbourne.sgi.com>
Date: Mon, 10 May 2004 13:03:18 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16542.61686.49097.41973@cse.unsw.edu.au>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Greg Banks on Tuesday May 4
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<409634B9.8D9484DA@melbourne.sgi.com>
	<16534.54704.792101.617408@cse.unsw.edu.au>
	<40973F7F.A9FA4F1@melbourne.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday May 4, gnb@melbourne.sgi.com wrote:
> > >
> > > --- linux.orig/fs/dcache.c    Mon May  3 21:46:30 2004
> > > +++ linux/fs/dcache.c Mon May  3 21:49:07 2004
> > > @@ -255,8 +255,8 @@
> > >
> > >  static inline struct dentry * __dget_locked(struct dentry *dentry)
> > >  {
> > > -     atomic_inc(&dentry->d_count);
> > > -     if (atomic_read(&dentry->d_count) == 1) {
> > > +     if (atomic_inc(&dentry->d_count) == 1) {
> > 
> > One problem with this is that (in include/asm-i386/atomic.h at least):
> >   static __inline__ void atomic_inc(atomic_t *v)
> 
> Ok, how about this...it's portable, and not racy, but may perturb the
> logic slightly by also taking dentries off the unused list in the case
> where they already had d_count>=1.  I'm not sure how significant that is.
> In any case this also passes my tests.

I think this patch is good and needed.

I think the race can happen if:
       dentry->d_count == 1, not on list

   thread 1                       thread 2
   enter __dget_locked            enter dput
   atomic_inc(d_count) (now 2)
                                  atomic_dec_and_lock(d_count...) (now 1)
   if(atomic_read(d_count)==1 ....
         remove from list


This will remove it from the unused list when it isn't
on, and will decrement nr_unused which, as you say, is bad.

I don't think there can be any problem with taking dentries with a
non-zero d_count off the unused_list randomly (providing dcache_lock
is held of course).

The comment at the top of d_lookup says that it doesn't take dentries
off the unused_list, but instead leaves that task to assorted other
code.

prune_dcache and shrink_dcache_sb and select_parent will all quietly
remove such dentries from the unused list and there is no reason that
__dget_locked shouldn't aswell.  Possibly that patch should update the 
d_lookup comment to add __dget_locked to the set of functions that
clean up after it.

NeilBrown

> 
> 
> --- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
> +++ linux/fs/dcache.c	Tue May  4 14:34:44 2004
> @@ -256,7 +256,7 @@
>  static inline struct dentry * __dget_locked(struct dentry *dentry)
>  {
>  	atomic_inc(&dentry->d_count);
> -	if (atomic_read(&dentry->d_count) == 1) {
> +	if (!list_empty(&dentry->d_lru)) {
>  		dentry_stat.nr_unused--;
>  		list_del_init(&dentry->d_lru);
>  	}
> @@ -663,6 +663,7 @@
>  		if (gfp_mask & __GFP_FS)
>  			prune_dcache(nr);
>  	}
> +	BUG_ON(dentry_stat.nr_unused < 0);
>  	return dentry_stat.nr_unused;
>  }
>  
> 
> 
> Greg.
> -- 
> Greg Banks, R&D Software Engineer, SGI Australian Software Group.
> I don't speak for SGI.
