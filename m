Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262458AbVD2H5Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbVD2H5Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 03:57:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbVD2H5Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 03:57:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:50644 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262454AbVD2H5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 03:57:15 -0400
Subject: Re: [PATCH] private mounts
From: Ram <linuxram@us.ibm.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Eric Van Hensbergen <ericvh@gmail.com>, Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20050428220839.GA5183@mail.shareable.org>
References: <E1DPoCg-0000W0-00@localhost>
	 <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk>
	 <20050424213822.GB9304@mail.shareable.org>
	 <20050425152049.GB2508@elf.ucw.cz>
	 <20050425190734.GB28294@mail.shareable.org>
	 <20050426092924.GA4175@elf.ucw.cz>
	 <20050426140715.GA10833@mail.shareable.org>
	 <a4e6962a050428064774e88f4a@mail.gmail.com>
	 <20050428192048.GA2895@mail.shareable.org>
	 <1114717183.4180.718.camel@localhost>
	 <20050428220839.GA5183@mail.shareable.org>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1114761430.4180.1566.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 29 Apr 2005 00:57:10 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-28 at 15:08, Jamie Lokier wrote:
> Ram wrote:
> > > I've looked at the code.  Look in fs/proc/base.c (Linux 2.6.10),
> > > proc_root_link().
> > > 
> > > I don't see anything there to prevent you from traversing to the
> > > mounts in the other namespace.
> > > 
> > > So why is it failing?  Any idea?
> > 
> > Since you are traversing a symlink, you will be traversing the symlink
> > in the context of traversing process's namespace. 
> > 
> > If process 'x' is traversing /proc/y/root , the lookup for the root
> > dentry will happen in the context of process x's  namespace, and not
> > process y's namespace. Hence process 'x' wont really get into
> > the namespace of the process y.
> 
> Lookups don't happen in the context of a namespace.
> 
> They happen in the context of a vfsmnt.  And the switch to a new
> vfsmnt is done by matching against (dentry,parent-vfsmnt) pairs.
> current->namespace is only checked for mount & unmount operations, not
> for path lookups.

Looked deeper into the code, and realized that in procfs, the symlink is
not followed through link_path_walk(). instead it is expected to
return the root vfsmount of the traversed process as you rightly
pointed.

 
> 
> Which means proc_root_link, when it switches to the vfsmnt at the root
> of the other process, should traverse into the tree of vfsmnts which
> make up the other namespace.

Yes. But proc_check_root() in proc_pid_follow_link() is failing the 
traversal, because it is expecting the root vfsmount of the traversed
process to belong to the vfsmount tree of the traversing process.
In other words its expecting them to be both in the same namespace.

The permissions get denied by this code in proc_check_root():

         while (vfsmnt != our_vfsmnt) {
                if (vfsmnt == vfsmnt->mnt_parent)
                        goto out;
                de = vfsmnt->mnt_mountpoint;
                vfsmnt = vfsmnt->mnt_parent;
        }

RP
> -- Jamie

