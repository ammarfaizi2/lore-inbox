Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030297AbWFBV0b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbWFBV0b (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWFBV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:26:31 -0400
Received: from mx2.netapp.com ([216.240.18.37]:61249 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030297AbWFBV0a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:26:30 -0400
X-IronPort-AV: i="4.05,205,1146466800"; 
   d="scan'208"; a="384438971:sNHT17606728"
Subject: Re: lock_kernel called under spinlock in NFS
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mingo@elte.hu
In-Reply-To: <20060602134346.73019624.akpm@osdl.org>
References: <20060601195535.GA28188@tsunami.ccur.com>
	 <1149192820.3549.43.camel@lade.trondhjem.org>
	 <20060602202436.GA4783@tsunami.ccur.com>
	 <1149280078.5621.63.camel@lade.trondhjem.org>
	 <20060602134346.73019624.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Fri, 02 Jun 2006 17:26:26 -0400
Message-Id: <1149283586.23580.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
X-OriginalArrivalTime: 02 Jun 2006 21:26:27.0815 (UTC) FILETIME=[35391F70:01C6868B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-02 at 13:43 -0700, Andrew Morton wrote:
> Trond Myklebust <Trond.Myklebust@netapp.com> wrote:
> >
> > On Fri, 2006-06-02 at 16:24 -0400, Joe Korty wrote:
> > > On Thu, Jun 01, 2006 at 04:13:39PM -0400, Trond Myklebust wrote:
> > > > On Thu, 2006-06-01 at 15:55 -0400, Joe Korty wrote:
> > > >> Tree 5fdccf2354269702f71beb8e0a2942e4167fd992
> > > >> 
> > > >>         [PATCH] vfs: *at functions: core
> > > >> 
> > > >> introduced a bug where lock_kernel() can be called from
> > > >> under a spinlock.  To trigger the bug one must have
> > > >> CONFIG_PREEMPT_BKL=y and be using NFS heavily.  It is
> > > >> somewhat rare and, so far, haven't traced down the userland
> > > >> sequence that causes the fatal path to be taken.
> > > >> 
> > > >> The bug was caused by the insertion into do_path_lookup()
> > > >> of a call to file_permission().  do_path_lookup()
> > > >> read-locks current->fs->lock for most of its operation.
> > > >> file_permission() calls permission() which calls
> > > >> nfs_permission(), which has one path through it
> > > >> that uses lock_kernel().
> > > 
> > > > Nowhere should anyone be calling file_permission() under a spinlock.
> > > > 
> > > > Why would you need to read-protect current->fs in the case where you are
> > > > starting from a file? The correct thing to do there would appear to be
> > > > to read_protect only the cases where (*name=='/') and (dfd == AT_FDCWD).
> > > > 
> > > > Something like the attached patch...
> > > 
> > > 
> > > Hi Trond,
> > > I've been running with the patch for the last few hours, on an nfs-rooted
> > > system, and it has been working fine.  Any plans to submit this for 2.6.17?
> > 
> > It probably ought to be, given the nature of the sin. Andrew?
> > 
> 
> OK.
> 
> Just to confirm, this is final?

Yes. That is the patch that Joe has tested.

Cheers,
  Trond


> From: Trond Myklebust <Trond.Myklebust@netapp.com>
> 
> We're presently running lock_kernel() under fs_lock via nfs's ->permission
> handler.  That's a ranking bug and sometimes a sleep-in-spinlock bug.  This
> problem was introduced in the openat() patchset.
> 
> We should not need to hold the current->fs->lock for a codepath that doesn't
> use current->fs.
> 
> Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> Cc: Al Viro <viro@ftp.linux.org.uk>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  fs/namei.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff -puN fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path fs/namei.c
> --- 25/fs/namei.c~fs-nameic-call-to-file_permission-under-a-spinlock-in-do_lookup_path	Fri Jun  2 13:39:52 2006
> +++ 25-akpm/fs/namei.c	Fri Jun  2 13:39:52 2006
> @@ -1080,8 +1080,8 @@ static int fastcall do_path_lookup(int d
>  	nd->flags = flags;
>  	nd->depth = 0;
>  
> -	read_lock(&current->fs->lock);
>  	if (*name=='/') {
> +		read_lock(&current->fs->lock);
>  		if (current->fs->altroot && !(nd->flags & LOOKUP_NOALT)) {
>  			nd->mnt = mntget(current->fs->altrootmnt);
>  			nd->dentry = dget(current->fs->altroot);
> @@ -1092,9 +1092,12 @@ static int fastcall do_path_lookup(int d
>  		}
>  		nd->mnt = mntget(current->fs->rootmnt);
>  		nd->dentry = dget(current->fs->root);
> +		read_unlock(&current->fs->lock);
>  	} else if (dfd == AT_FDCWD) {
> +		read_lock(&current->fs->lock);
>  		nd->mnt = mntget(current->fs->pwdmnt);
>  		nd->dentry = dget(current->fs->pwd);
> +		read_unlock(&current->fs->lock);
>  	} else {
>  		struct dentry *dentry;
>  
> @@ -1118,7 +1121,6 @@ static int fastcall do_path_lookup(int d
>  
>  		fput_light(file, fput_needed);
>  	}
> -	read_unlock(&current->fs->lock);
>  	current->total_link_count = 0;
>  	retval = link_path_walk(name, nd);
>  out:
> _
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
