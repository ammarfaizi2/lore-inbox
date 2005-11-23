Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVKWM4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKWM4w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVKWM4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:56:52 -0500
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:409 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1750758AbVKWM4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:56:51 -0500
Date: Wed, 23 Nov 2005 07:56:39 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Maneesh Soni <maneesh@in.ibm.com>
cc: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
In-Reply-To: <20051123045049.GA22714@in.ibm.com>
Message-ID: <Pine.LNX.4.58.0511230748000.23751@gandalf.stny.rr.com>
References: <1132695202.13395.15.camel@localhost.localdomain>
 <20051122213947.GB8575@kroah.com> <20051123045049.GA22714@in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Maneesh Soni wrote:
>
> The dir operation sysfs_readdir() is called under directory inode's i_sem
> taken in vfs_readdir() and create_dir() also takes parent directory inode's
> i_sem. So in this case I think following are the relevant steps happening
> which look safe to me.
>
> cpu 0
> vfs_readdir()
>   down(dir inode i_sem)
>     sysfs_readdir(dir)
>       parse through dir->s_dirent s_children list
>   up(dir inode i_sem)
>
>
> cpu 1
> sysfs_create_dir()
>   create_dir()
>    down(parent dir inode i_sem)
>    lookup_one_len (allocates & makes the new directory dentry visible)
>    sysfs_make_diret()
>      sysfs_new_dirent()
>        attach the new directory s_dirent to parent's s_children list)
>    up(parent dir inode i_sem)
>
>
> Basically, sysfs_readdir for a directory is protected against any
> addition/deletion in the directory by directory inode's i_sem.

OK, I missed that, thanks.

>
> But the bad pointer reference seen in sysfs_readdir() has to be debugged.
> Assumption here is that if there is a dentry attached to s_dirent, there
> has to be a inode associated becuase negative dentries are not created
> in sysfs. Is it possible to get some more information about the recreation
> scenario. Could you enable DEBUG printks for lib/kobject.c and
> drivers/base/class.c to see the events happening.

The bug that I've been fighting in my own kernel is a memory leak. So I
started looking into this at what would happen in verious places if an
allocation didn't work.

In create_dir:

		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
// Above is where the entry is added to the parent link list.

		if (!error) {
			error = sysfs_create(*d, mode, init_dir);
// If sysfs_create fails to allocate an inode, when below
// does the element get removed from the parent?
			if (!error) {
				p->d_inode->i_nlink++;
				(*d)->d_op = &sysfs_dentry_ops;
				d_rehash(*d);
			}
		}
		if (error && (error != -EEXIST)) {
			sysfs_put((*d)->d_fsdata);
// sysfs_put only seems to handle the kobject portion

			d_drop(*d);
// d_drop handles the unhash
		}
		dput(*d);

So I'm not sure an error from sysfs_create will remove the object from the
link list.  In fact, it might be worst since now there's an object on the
link list that may no long even be an object.

I'll test this by forcing a failure at sysfs_create.

-- Steve


