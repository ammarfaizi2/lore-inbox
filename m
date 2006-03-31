Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWCaSpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWCaSpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 13:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWCaSpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 13:45:08 -0500
Received: from pat.uio.no ([129.240.10.6]:53220 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751256AbWCaSpG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 13:45:06 -0500
Subject: Re: [PATCH 2/4] locks: don't unnecessarily fail posix lock
	operations
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: akpm@osdl.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1143829641.8085.7.camel@lade.trondhjem.org>
References: <E1FPNOD-0005Tg-00@dorka.pomaz.szeredi.hu>
	 <E1FPNSB-0005VK-00@dorka.pomaz.szeredi.hu>
	 <1143829641.8085.7.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Fri, 31 Mar 2006 13:44:53 -0500
Message-Id: <1143830693.8085.19.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.573, required 12,
	autolearn=disabled, AWL 1.43, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-31 at 13:27 -0500, Trond Myklebust wrote:
> On Fri, 2006-03-31 at 19:30 +0200, Miklos Szeredi wrote:
> > posix_lock_file() was too cautious, failing operations on OOM, even if
> > they didn't actually require an allocation.
> > 
> > This has the disadvantage, that a failing unlock on process exit could
> > lead to a memory leak.  There are two possibilites for this:
> > 
> > - filesystem implements .lock() and calls back to posix_lock_file().
> > On cleanup of files_struct locks_remove_posix() is called which should
> > remove all locks belonging to files_struct.  However if filesystem
> > calls posix_lock_file() which fails, then those locks will never be
> > freed.
> > 
> > - if a file is closed while a lock is blocked, then after acquiring
> > fcntl_setlk() will undo the lock.  But this unlock itself might fail
> > on OOM, again possibly leaking the lock.
> > 
> > The solution is to move the checking of the allocations until after it
> > is sure that they will be needed.  This will solve the above problem
> > since unlock will always succeed unless it splits an existing region.
> > 
> > Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>
> > 
> > Index: linux/fs/locks.c
> > ===================================================================
> > --- linux.orig/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
> > +++ linux/fs/locks.c	2006-03-31 18:55:33.000000000 +0200
> > @@ -835,14 +835,7 @@ int __posix_lock_file(struct inode *inod
> >  	if (request->fl_flags & FL_ACCESS)
> >  		goto out;
> >  
> > -	error = -ENOLCK; /* "no luck" */
> > -	if (!(new_fl && new_fl2))
> > -		goto out;
> > -
> >  	/*
> > -	 * We've allocated the new locks in advance, so there are no
> > -	 * errors possible (and no blocking operations) from here on.
> > -	 * 
> >  	 * Find the first old lock with the same owner as the new lock.
> >  	 */
> >  	
> > @@ -939,6 +932,18 @@ int __posix_lock_file(struct inode *inod
> >  		before = &fl->fl_next;
> >  	}
> >  
> > +	/*
> > +	 * The above code only modifies existing locks in case of
> > +	 * merging or replacing.  If new lock(s) need to be inserted
> > +	 * all modifications are done bellow this, so it's safe yet to
> > +	 * bail out.
> > +	 */
> > +	error = -ENOLCK; /* "no luck" */
> > +	if (!added && request->fl_type != F_UNLCK && !new_fl)
> > +		goto out;
> > +	if (right && left == right && !new_fl2)
> > +		goto out;
> > +
> >  	error = 0;
> >  	if (!added) {
> >  		if (request->fl_type == F_UNLCK)
> 
> NACK.
> 
> This changes the behaviour of F_UNLCK. Currently, if the allocation
> fails, the inode locking state remains unchanged. With your change, an
> unlock request may end up unlocking part of the inode, but not the rest.
> 
> Furthermore, AFAICS you are now able to Oops if (!added && !new_fl).

Sorry: the Oops turned out to be a mirage.

However you are also changing the behaviour of F_SETLK for the case
where the user is trying to up/downgrade a set of existing READ/WRITE
locks. Again you may end up with a situation where some of the existing
locks get up/downgraded, and yet the lock request fails.

Cheers,
  Trond

