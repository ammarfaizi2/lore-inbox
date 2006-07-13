Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWGMC7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWGMC7l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 22:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932329AbWGMC7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 22:59:40 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:44508 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932095AbWGMC7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 22:59:40 -0400
Subject: Re: [SYSFS] Kernel Null pointer dereference in sysfs_readdir()
From: Steven Rostedt <rostedt@goodmis.org>
To: maneesh@in.ibm.com
Cc: "Duetsch, Thomas  LDE1" <thomas.duetsch@siemens.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>
In-Reply-To: <20060712203935.GA25484@in.ibm.com>
References: <5B0042046ADE774687F32BF3652F5BB9021C92CA@kher9eaa.ww007.siemens.net>
	 <1152713179.8309.35.camel@localhost.localdomain>
	 <20060712195700.GA1743@in.ibm.com>
	 <1152736118.13382.6.camel@localhost.localdomain>
	 <20060712203935.GA25484@in.ibm.com>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 22:59:12 -0400
Message-Id: <1152759552.13382.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ removed Patrick, added Greg KH since I ignorantly looked at the file
for maintainer instead of the MAINTAINERS file.  Well, I actually did
look at MAINTAINERS but I stupidly did a case sensitive search for
"sysfs" instead of SYSFS ]

On Thu, 2006-07-13 at 02:09 +0530, Maneesh Soni wrote:
> On Wed, Jul 12, 2006 at 04:28:38PM -0400, Steven Rostedt wrote:
> > On Thu, 2006-07-13 at 01:27 +0530, Maneesh Soni wrote:
> > 
> > > 
> > > sysfs_attach_attr() is called from sysfs_lookup() only, and which in turn
> > > is called under parent inode's i_mutex from VFS layer.
> > 
> > Ah, I didn't see the parent mutex lock.
> > 
> > Does sysfs support hard links?  Where an inode may belong to two
> > different dentrys?
> > 
> No, only symbolic links are supported.
> 
> > > 
> > > But you did help in spotting a bug which could happen like this
> > > 
> > > i_mutext held
> > > sysfs_lookup()
> > > -->sysfs_attach_attr()
> > >    --> sysfs_create() fails
> > >    --> sd->s_dentry has a NULL d_inode
> > >    --> sysfs_put() frees the sysfs_dirent 
> > >    --> error returned to lookup
> > > i_mutex released
> > > 
> > > But the sysfs_dirent with NULL d_inode is never unlinked from 
> > > the parent sysfs_dirent. And later on this happens
> > 
> > But doesn't this only happen in case of no memory?
> > 
> Right, but this is a bug anyway.
> 
> > Thomas, is the system running low on memory?
> > 
> > > 
> > > vfs_readdir()
> > > i_mutex held
> > > -->sysfs_readdir()
> > >    --> trips on the freed sysfs_dirent with NULL inode.
> > > 
> > > I am not sure if it is possible for other thread to see the freed 
> > > sysfs_dirent and trip at sd->s_dentry->d_inode but the sysfs_dirent
> > > should have been unlinked from the parent sysfs_dirent's s_children list.
> > > 
> > > > Now the question is, is it safe to add the test for s_dentry->d_inode too.
> > > > I ask this because the s_dentry is in the process of being filled, and 
> > > > I don't know what effect this will have on what readdir wants.  I guess
> > > > it may be safe, so I'm giving this patch:
> > > > 
> > > > -- Steve
> > > > 
> > > > 
> > > > Description:
> > > > 
> > > > In the process of creating a sysfs attribute, we can have a state
> > > > where the sysfs descriptor can have a dentry with a NULL inode.
> > > > 
> > > > Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> > > > 
> > > > Index: linux-2.6.18-rc1/fs/sysfs/dir.c
> > > > ===================================================================
> > > > --- linux-2.6.18-rc1.orig/fs/sysfs/dir.c	2006-07-12 09:43:10.000000000 -0400
> > > > +++ linux-2.6.18-rc1/fs/sysfs/dir.c	2006-07-12 10:01:18.000000000 -0400
> > > > @@ -445,7 +445,7 @@ static int sysfs_readdir(struct file * f
> > > >  
> > > >  				name = sysfs_get_name(next);
> > > >  				len = strlen(name);
> > > > -				if (next->s_dentry)
> > > > +				if (next->s_dentry && next->s_dentry->d_inode)
> > > >  					ino = next->s_dentry->d_inode->i_ino;
> > > >  				else
> > > >  					ino = iunique(sysfs_sb, 2);
> > > > 
> > > 
> > > I think this patch only fixes the sympton. I have tried to keep the
> > > assumption of no negative dentries (dentries with NULL d_inode) valid 
> > > in sysfs. So, this does indicate a bug. 
> > 
> > Something else that might help is knowing what the other tasks where
> > doing at the time.  Thomas, do you also have the task dump?  You can
> > send that to me offline if you like.
> > 
> 
> yup... please cc me also.

Thomas, perhaps CC Greg KH on this too, since he _is_ the maintainer for
sysfs.

-- Steve


