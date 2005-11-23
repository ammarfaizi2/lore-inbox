Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932524AbVKWExY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932524AbVKWExY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:53:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbVKWExY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:53:24 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:49861 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932524AbVKWExX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:53:23 -0500
Date: Wed, 23 Nov 2005 10:20:49 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: What protection does sysfs_readdir have with SMP/Preemption?
Message-ID: <20051123045049.GA22714@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <1132695202.13395.15.camel@localhost.localdomain> <20051122213947.GB8575@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051122213947.GB8575@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2005 at 01:39:47PM -0800, Greg KH wrote:
> On Tue, Nov 22, 2005 at 04:33:22PM -0500, Steven Rostedt wrote:
> > Hi,
> > 
> > I'm developing a custom kernel on top of Ingo's -rt patch. My kernel
> > makes race conditions in the vanilla kernel show up very well :-)
> > 
> > I just hit a bug, actually a page fault in fs/sysfs/dir.c in
> > sysfs_readdir:
> > 
> > 
> > 
> > 			for (p=q->next; p!= &parent_sd->s_children; p=p->next) {
> > 				struct sysfs_dirent *next;
> > 				const char * name;
> > 				int len;
> > 
> > 				next = list_entry(p, struct sysfs_dirent,
> > 						   s_sibling);
> > 				if (!next->s_element)
> > 					continue;
> > 
> > 				name = sysfs_get_name(next);
> > 				len = strlen(name);
> > 				if (next->s_dentry)
> > 					ino = next->s_dentry->d_inode->i_ino;
> > 
> > ^^^^
> > This is where I had a bad pointer reference.
> > 
> > 				else
> > 					ino = iunique(sysfs_sb, 2);
> > 
> > 				if (filldir(dirent, name, len, filp->f_pos, ino,
> > 						 dt_type(next)) < 0)
> > 					return 0;
> > 
> > 
> > Looking at this code, I don't see anything protecting the s_dentry. For
> > example, couldn't the following happen:
> > 
> > sysfs_create_dir is called, which calls create_dir.  Now we create a
> > dentry with no d_inode. In sysfs_make_dirent which calls
> > sysfs_new_dirent which adds to the parents s_children. Then
> > sysfs_make_dirent sets s_dentry = dentry (the one that was just made
> > with no d_inode assigned yet).  Then create_dir calls sysfs_create which
> > finally assigns the d_inode.
> > 
> > So, either there is some hidden protection and my modification to the
> > kernel has caused this to bug, or we have just been lucky the whole time
> > in the vanilla kernel.
> 
> I think we've been lucky :(
> 
> Maneesh, any ideas?
> 

The dir operation sysfs_readdir() is called under directory inode's i_sem
taken in vfs_readdir() and create_dir() also takes parent directory inode's 
i_sem. So in this case I think following are the relevant steps happening
which look safe to me.

cpu 0
vfs_readdir()
  down(dir inode i_sem)
    sysfs_readdir(dir)
      parse through dir->s_dirent s_children list
  up(dir inode i_sem)
   

cpu 1
sysfs_create_dir()
  create_dir()
   down(parent dir inode i_sem)
   lookup_one_len (allocates & makes the new directory dentry visible)
   sysfs_make_diret()
     sysfs_new_dirent()
       attach the new directory s_dirent to parent's s_children list)
   up(parent dir inode i_sem)


Basically, sysfs_readdir for a directory is protected against any 
addition/deletion in the directory by directory inode's i_sem.

But the bad pointer reference seen in sysfs_readdir() has to be debugged.
Assumption here is that if there is a dentry attached to s_dirent, there
has to be a inode associated becuase negative dentries are not created
in sysfs. Is it possible to get some more information about the recreation
scenario. Could you enable DEBUG printks for lib/kobject.c and 
drivers/base/class.c to see the events happening.


Thanks
Maneesh
   
-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
