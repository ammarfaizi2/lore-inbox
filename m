Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264308AbUEDKXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUEDKXh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 06:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUEDKXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 06:23:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:11573 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S264308AbUEDKWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 06:22:39 -0400
Message-ID: <40976EA1.928BAB65@melbourne.sgi.com>
Date: Tue, 04 May 2004 20:21:21 +1000
From: Greg Banks <gnb@melbourne.sgi.com>
Organization: SGI Australian Software Group
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18-6mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dipankar Sarma <dipankar@in.ibm.com>
CC: viro@parcelfarce.linux.theplanet.co.uk, Neil Brown <neilb@cse.unsw.edu.au>,
       Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
References: <16521.5104.489490.617269@laputa.namesys.com> <16529.56343.764629.37296@cse.unsw.edu.au> <409634B9.8D9484DA@melbourne.sgi.com> <16534.54704.792101.617408@cse.unsw.edu.au> <40973F7F.A9FA4F1@melbourne.sgi.com> <20040504094642.GL17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G'day Dipankar,

I don't know if you've been following this thread on lkml, but Al Viro
wants an RCU expert's opinion on the following dcache patch.

Greg Banks wrote:
> 
> > > *   Dentry_stat.nr_unused can be be spuriously decremented when dput()
> > >     races with __dget_unlocked().  Eventual result is nr_unused<0
> > >     and kswapd loops.  This is the problem I mentioned earlier.  Note
> > >     that this is not an NFS-specific problem.  Fix is:
> > > [...first attempt elided...]
> Ok, how about this...it's portable, and not racy, but may perturb the
> logic slightly by also taking dentries off the unused list in the case
> where they already had d_count>=1.  I'm not sure how significant that is.
> In any case this also passes my tests.
> 
> --- linux.orig/fs/dcache.c      Mon May  3 21:46:30 2004
> +++ linux/fs/dcache.c   Tue May  4 14:34:44 2004
> @@ -256,7 +256,7 @@
>  static inline struct dentry * __dget_locked(struct dentry *dentry)
>  {
>         atomic_inc(&dentry->d_count);
> -       if (atomic_read(&dentry->d_count) == 1) {
> +       if (!list_empty(&dentry->d_lru)) {
>                 dentry_stat.nr_unused--;
>                 list_del_init(&dentry->d_lru);
>         }
> @@ -663,6 +663,7 @@
>                 if (gfp_mask & __GFP_FS)
>                         prune_dcache(nr);
>         }
> +       BUG_ON(dentry_stat.nr_unused < 0);
>         return dentry_stat.nr_unused;
>  }
> 

viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> a) ask RCU folks to review - the current logics in dcache.c is extremely
> brittle as it is.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.
