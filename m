Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbTLHWvC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 17:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTLHWvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 17:51:02 -0500
Received: from mail.kroah.org ([65.200.24.183]:57483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261893AbTLHWu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 17:50:57 -0500
Date: Mon, 8 Dec 2003 14:48:10 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>, maneesh@in.ibm.com, mgorse@mgorse.dhs.org,
       linux-kernel@vger.kernel.org
Cc: Andrey Borzenkov <arvidjaar@mail.ru>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: oopses in kobjects in 2.6.0-test11 (was Re: kobject patch)
Message-ID: <20031208224810.GB31134@kroah.com>
References: <20031009014837.4ff71634.akpm@osdl.org> <20031208222526.GA31134@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208222526.GA31134@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'm ccing lkml and everyone else who has been in on this thread at
different times.  This is based on a patch from Andrey that was/is in
the -mm tree for a while.

On Mon, Dec 08, 2003 at 02:25:26PM -0800, Greg KH wrote:
> On Thu, Oct 09, 2003 at 01:48:37AM -0700, Andrew Morton wrote:
> > 
> > I've had this in -mm for a while.  What to do with it?
> 
> Heh, nothing like digging up something from the past that I insisted was
> not needed, but...
> 
> > It is possible that parent is removed before child when child is in use. 
> > Trivial example is mounted USB storage when you unplug it. The kobject for 
> > USB device is removed but subordinate SCSI device remains. Then kernel oopses 
> > on attempt to release child e.g. umount removed USB storage. This patch fixes 
> > two problems:
> 
> Yes, I now think this patch needs to be applied.  I can easily cause a
> parent device in sysfs to go away, with the child still present:
> 	- plug in a usb-serial device
> 	- run 'cat /dev/ttyUSB0'
> 	- yank the device out.
> Now if you cancel the 'cat' program, lovely oopses...
> 
> So, Andrew, very sorry about this, but this patch should be sent to
> Linus.  I think Pat agrees with me, but he's on the road for a few days.
> You might want to wait for him.

Hm, wait, Pat objected to the patch to kobject.c (now that I went back
and read the whole thread.)  And I agree with him, but I'm now getting
an oops in get_kobj_path_length if I do the above while loading down the
machine with other tasks when I cancel 'cat'.

So something else bad is happening here...

> > - kset_hotplug.  It oopses in get_kobj_path_length because child->parent
> >   points to nowhere - even if parent has not yet been overwritten, its name
> >   is already freed.
> > 
> >   The patch moves kobject_put for parent from unlink() into
> >   kobject_cleanup for child making sure reference to parents exists for as
> >   long as child is there and may use it.

But you can't do this, as you need that kobject_put() in unlink() for
when it is called from kobject_add().

Hm, wait...  I think we are close...

Ok, here's how a parent can be removed from the system without the child
going away:
	- create parent and register it successfully.
	- create child, call kobject_add() which increments the count of
	  the parent.
	- call kobject_get() on the child.
	- call kobject_del() on the parent.  This will keep the parent
	  around, as the child still has a reference on it.
	- call kobject_del() on the child.  This will decrement the
	  count on the parent due to the call in unlink().  That will
	  free the parent up from memory.  But this child still has a
	  incremented count (rightly, as it is in use).
	  
	- So the child now has a stale parent pointer, causing all sorts
	  of fun...

I'll work on a patch for kobject.c and post it in the next message, and
include the original message and patch below for others to see.

thanks,

greg k-h

> > - after this oops has been fixed I got next one now in sysfs.  The
> >   problem is sysfs_remove_dir would unlink all children including
> >   directories for subordinate kobjects.  Resulting in dget/dput mismatch. 
> >   I usually got oops due to the fact that d_delete in remove_dir would free
> >   inode and then simple_rmdir would try to access it.
> > 
> >   The patch avoids calling extra d_delete/unlink on already-deleted
> >   dentry.  I hate this patch but anything better apparently requires
> >   complete redesign of sysfs implementation.  Unlinking busy directory is
> >   otherwise impossible and I am afraid it will show itself somewhere else.
> > 
> > 
> > 
> >  25-akpm/fs/sysfs/dir.c |   12 ++++++++++--
> >  25-akpm/lib/kobject.c  |    4 ++--
> >  2 files changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff -puN fs/sysfs/dir.c~kobject-oops-fixes fs/sysfs/dir.c
> > --- 25/fs/sysfs/dir.c~kobject-oops-fixes	Thu Oct  9 01:46:51 2003
> > +++ 25-akpm/fs/sysfs/dir.c	Thu Oct  9 01:46:51 2003
> > @@ -82,8 +82,16 @@ static void remove_dir(struct dentry * d
> >  {
> >  	struct dentry * parent = dget(d->d_parent);
> >  	down(&parent->d_inode->i_sem);
> > -	d_delete(d);
> > -	simple_rmdir(parent->d_inode,d);
> > +	/*
> > +	 * It is possible that parent has already been removed, in which
> > +	 * case directory is already unhashed and dput.
> > +	 * Note that this won't update parent->d_inode->i_nlink; OTOH
> > +	 * parent should already be dead
> > +	 */
> > +	if (!d_unhashed(d)) {
> > +		d_delete(d);
> > +		simple_rmdir(parent->d_inode,d);
> > +	}
> >  
> >  	pr_debug(" o %s removing done (%d)\n",d->d_name.name,
> >  		 atomic_read(&d->d_count));
> > diff -puN lib/kobject.c~kobject-oops-fixes lib/kobject.c
> > --- 25/lib/kobject.c~kobject-oops-fixes	Thu Oct  9 01:46:51 2003
> > +++ 25-akpm/lib/kobject.c	Thu Oct  9 01:46:51 2003
> > @@ -236,8 +236,6 @@ static void unlink(struct kobject * kobj
> >  		list_del_init(&kobj->entry);
> >  		up_write(&kobj->kset->subsys->rwsem);
> >  	}
> > -	if (kobj->parent) 
> > -		kobject_put(kobj->parent);
> >  	kobject_put(kobj);
> >  }
> >  
> > @@ -457,6 +455,8 @@ void kobject_cleanup(struct kobject * ko
> >  	if (kobj->k_name != kobj->name)
> >  		kfree(kobj->k_name);
> >  	kobj->k_name = NULL;
> > +	if (kobj->parent)
> > +		kobject_put(kobj->parent);
> >  	if (t && t->release)
> >  		t->release(kobj);
> >  	if (s)
> > 
> > _
