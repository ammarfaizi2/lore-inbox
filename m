Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264153AbUECX3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264153AbUECX3W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 19:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264154AbUECX3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 19:29:22 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:40587 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S264153AbUECX3N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 19:29:13 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Greg Banks <gnb@melbourne.sgi.com>
Date: Tue, 4 May 2004 09:28:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16534.54704.792101.617408@cse.unsw.edu.au>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       alexander viro <viro@parcelfarce.linux.theplanet.co.uk>,
       trond myklebust <trondmy@trondhjem.org>
Subject: Re: d_splice_alias() problem.
In-Reply-To: message from Greg Banks on Monday May 3
References: <16521.5104.489490.617269@laputa.namesys.com>
	<16529.56343.764629.37296@cse.unsw.edu.au>
	<409634B9.8D9484DA@melbourne.sgi.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday May 3, gnb@melbourne.sgi.com wrote:
> Neil Brown wrote:
> > 
> > This problem can be resolved by making sure that an inode never has
> > both a connected and a disconnected dentry.
> > 
> > This is already the case for directories (as they must only have one
> > dentry), but it is not the case for non-directories.
> > 
> > The following patch tries to address this.  It is a "technology
> > preview" in that the only testing I have done is that it compiles OK.
> > 
> > Please consider reviewing it to see if it makes sense.
> 
> It does, and it fixes one of the dcache bugs that was tripping my debug
> code.  Here are a couple more.
> 
> *   Logic bug in d_splice_alias() forgets to clear the DCACHE_DISCONNECTED
>     flag when a lookup connects a disconnected dentry.  Fix is (relative
>     to Neil's patch):

I seem to recall that this was intentional.  When I first wrote the
code I wanted to leave the splicing code to just splice things, and
when the code that cared about disconnected-ness (in knfsd) discovered
that something really was connected, it would clear the bit
(find_exported_dentry does this). 
However if we want to ensure that there is at-most one disconnected
dentry for an inode, we do need to set the bit more aggressively.
I'll try and review the code with that in mind.  Thanks.

> 
> 
> *   Dentry_stat.nr_unused can be be spuriously decremented when dput()
>     races with __dget_unlocked().  Eventual result is nr_unused<0
>     and kswapd loops.  This is the problem I mentioned earlier.  Note
>     that this is not an NFS-specific problem.  Fix is:
> 
> --- linux.orig/fs/dcache.c	Mon May  3 21:46:30 2004
> +++ linux/fs/dcache.c	Mon May  3 21:49:07 2004
> @@ -255,8 +255,8 @@
>  
>  static inline struct dentry * __dget_locked(struct dentry *dentry)
>  {
> -	atomic_inc(&dentry->d_count);
> -	if (atomic_read(&dentry->d_count) == 1) {
> +	if (atomic_inc(&dentry->d_count) == 1) {

One problem with this is that (in include/asm-i386/atomic.h at least):
  static __inline__ void atomic_inc(atomic_t *v)

atomic_inc returns "void".

NeilBrown
