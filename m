Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbTL1Mn2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 07:43:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbTL1Mn2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 07:43:28 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:17163 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S261188AbTL1MnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 07:43:25 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       maneesh@in.ibm.com, mgorse@mgorse.dhs.org, linux-kernel@vger.kernel.org
Subject: Re: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
Date: Sun, 28 Dec 2003 15:38:42 +0300
User-Agent: KMail/1.5.3
Cc: Patrick Mochel <mochel@digitalimplant.org>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com> <20031208224810.GB31134@kroah.com>
In-Reply-To: <20031208224810.GB31134@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312281538.42309.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 01:48, Greg KH wrote:
> Ok, I'm ccing lkml and everyone else who has been in on this thread at
> different times.  This is based on a patch from Andrey that was/is in
> the -mm tree for a while.
>

what about second part in sysfs/dir.c? How relevant is it?

-andrey

>
> > > - after this oops has been fixed I got next one now in sysfs.  The
> > >   problem is sysfs_remove_dir would unlink all children including
> > >   directories for subordinate kobjects.  Resulting in dget/dput
> > > mismatch. I usually got oops due to the fact that d_delete in
> > > remove_dir would free inode and then simple_rmdir would try to access
> > > it.
> > >
> > >   The patch avoids calling extra d_delete/unlink on already-deleted
> > >   dentry.  I hate this patch but anything better apparently requires
> > >   complete redesign of sysfs implementation.  Unlinking busy directory
> > > is otherwise impossible and I am afraid it will show itself somewhere
> > > else.
> > >
> > >
> > >
> > >  25-akpm/fs/sysfs/dir.c |   12 ++++++++++--
> > >  25-akpm/lib/kobject.c  |    4 ++--
> > >  2 files changed, 12 insertions(+), 4 deletions(-)
> > >
> > > diff -puN fs/sysfs/dir.c~kobject-oops-fixes fs/sysfs/dir.c
> > > --- 25/fs/sysfs/dir.c~kobject-oops-fixes	Thu Oct  9 01:46:51 2003
> > > +++ 25-akpm/fs/sysfs/dir.c	Thu Oct  9 01:46:51 2003
> > > @@ -82,8 +82,16 @@ static void remove_dir(struct dentry * d
> > >  {
> > >  	struct dentry * parent = dget(d->d_parent);
> > >  	down(&parent->d_inode->i_sem);
> > > -	d_delete(d);
> > > -	simple_rmdir(parent->d_inode,d);
> > > +	/*
> > > +	 * It is possible that parent has already been removed, in which
> > > +	 * case directory is already unhashed and dput.
> > > +	 * Note that this won't update parent->d_inode->i_nlink; OTOH
> > > +	 * parent should already be dead
> > > +	 */
> > > +	if (!d_unhashed(d)) {
> > > +		d_delete(d);
> > > +		simple_rmdir(parent->d_inode,d);
> > > +	}
> > >
> > >  	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
> > >  		 atomic_read(&d->d_count));

