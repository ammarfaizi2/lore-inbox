Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932382AbVLVFu3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVLVFu3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 00:50:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVLVFu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 00:50:28 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:53912 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932382AbVLVFu2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 00:50:28 -0500
Date: Thu, 22 Dec 2005 11:17:43 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Neil Brown <neilb@suse.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH - 2.6.15-rc5-mm3] Allow sysfs attribute files to be pollable.
Message-ID: <20051222054742.GA3711@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <17320.36949.269788.520946@cse.unsw.edu.au> <20051221134901.GA19746@in.ibm.com> <17322.8400.727405.522183@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17322.8400.727405.522183@cse.unsw.edu.au>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2005 at 02:43:12PM +1100, Neil Brown wrote:
> On Wednesday December 21, maneesh@in.ibm.com wrote:
> > > 
> > > It works like this:
> > >   Open the file
> > >   Read all the contents.
> > >   Call poll requesting POLLERR or POLLPRI (so select/exceptfds works)
> > >   When poll returns, close the file, and go to top of loop.
> > > 
> > 
> > I am no "poll/select" expert, but is reading the contents always a
> > requirement for "poll"? If not then probably it is not a good idea to 
> > put such rules.
> 
> You don't have to read the contents unless you want to know what is in
> the file.  You could just open the file and call 'poll' and wait for
> it to tell you something has happened.  However this isn't likely to
> be really useful.
> It isn't the 'something has happened' event that is particularly
> interesting.  It is the 'the state is now X' information that is
> interesting. 
> So you read the file to find out what the state is.  If that isn't the
> state you were looking for (or if you have finished responding to that
> state), you poll/select, and then try again.
> 

ok.. that makes sense. But in this case [open() and then poll()], should
buffer->event() be initialized in sysfs_open()-->check_perm(), instead
of fill_read_buffer() ? I think this scheme should work for [open(), read()
and then poll()] also. 

But how about the other rule, ie once woken-up the user has to close,
re-open and re-read the file. Can this also be avoided, as probably this is also
not poll semantics?

> > 
> > > Events are signaled by an object manager calling
> > >    sysfs_notify(kobj, dir, attr);
> > > 
> > > If the dir is non-NULL, it is used to find a subdirectory which
> > > contains the attribute (presumably created by sysfs_create_group).
> > > 
> > > This has a cost of one int  per attribute, one wait_queuehead per kobject,
> > > one int per open file.
> > > 
> > So, all the attribute files for a given kobject will use the same
> > wait queue? What happens if there are multiple attribute files 
> > polled for the same kobject.
> 
> wait_queues are sharable.  Having one wait queue for a number of
> events can work quite well.
> 
> Suppose a kobject has two (or more) attributes, and two processes poll on
> those attributes, one each.
>  When either attribute gets changed and sysfs_notify is called, both
>  of the processes will be woken up.  They will check if their
>  attribute of interest has changed.  If it has, the poll syscall will
>  return to userspace.  If it hasn't the process will just go to sleep
>  again.
> 
> So, if a kobject has many attributes, and there are many concurrent
> processes listening on different attributes, then sharing a wait_queue
> may cause a lot of needly wakeup/return-to-sleep events.  But it is
> fairly unlikely.
> wait_queues are not tiny, and having one per kobject is more
> economical than one per attribute.
> 
> I hope that helps.
> 
> > > diff ./fs/sysfs/inode.c~current~ ./fs/sysfs/inode.c
> > > --- ./fs/sysfs/inode.c~current~	2005-12-21 09:43:51.000000000 +1100
> > > +++ ./fs/sysfs/inode.c	2005-12-21 09:43:52.000000000 +1100
> > > @@ -247,3 +247,23 @@ void sysfs_hash_and_remove(struct dentry
> > >  }
> > >  
> > >  
> > > +struct sysfs_dirent *sysfs_find(struct sysfs_dirent *dir, const char * name)
> > > +{
> > > +	struct sysfs_dirent * sd, * rv = NULL;
> > > +
> > > +	if (dir->s_dentry == NULL ||
> > > +	    dir->s_dentry->d_inode == NULL)
> > > +		return NULL;
> > > +
> > > +	down(&dir->s_dentry->d_inode->i_sem);
> > > +	list_for_each_entry(sd, &dir->s_children, s_sibling) {
> > > +		if (!sd->s_element)
> > > +			continue;
> > > +		if (!strcmp(sysfs_get_name(sd), name)) {
> > > +			rv = sd;
> > > +			break;
> > > +		}
> > > +	}
> > > +	up(&dir->s_dentry->d_inode->i_sem);
> > > +	return rv;
> > > +}
> > 
> > I think there might be some issues here, if some other thread wants to
> > remove the kobject, while this thread is trying to notify. Testing
> > with some parallel add/delete operations should tell.
> 
> My idea - which I thought I had stuck in a comment, but apparently not
> - is that the owner of the kobject should have it's own locking to
> ensure that it doesn't go away while the sysfs_notify is being
> called (md does in the places where it calls sysfs_notify).
> I guess it makes sense to make sysfs_notify safe against object owners
> doing silly things, but it wasn't clear to me either how, or that it
> was necessary.
> > 

That's right, some times these kobjects do strange things like the
kobject is alive but it decides to get rid of attribute files. So, I think
if the VFS/dentry locking is used, it would be safer.

> > In this case IMO, the better option is to do just lookup_one_len(), get
> > the dentry and then get the sysfs_dirent as dentry->d_fsdata. And once
> > done, do dput() which will release the references taken.
> 
> You may well be right.  I'll try and see what happens.
> 

Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
