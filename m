Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWFTM1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWFTM1W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 08:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbWFTM1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 08:27:22 -0400
Received: from souterrain.chygwyn.com ([194.39.143.233]:40918 "EHLO
	souterrain.chygwyn.com") by vger.kernel.org with ESMTP
	id S965056AbWFTM1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 08:27:22 -0400
From: Steven Whitehouse <steve@chygwyn.com>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: Theodore Tso <tytso@thunk.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606201345.45332.arnd.bergmann@de.ibm.com>
References: <20060619152003.830437000@candygram.thunk.org>
	 <20060619153108.418349000@candygram.thunk.org>
	 <1150796596.3856.1333.camel@quoit.chygwyn.com>
	 <200606201345.45332.arnd.bergmann@de.ibm.com>
Organization: ChyGwyn Limited
Date: Tue, 20 Jun 2006 13:34:09 +0100
Message-Id: <1150806849.3856.1370.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with
	inode.i_private
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.0 (built Sat, 04 Sep 2004 19:17:51 +0100)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-06-20 at 13:45 +0200, Arnd Bergmann wrote:
> On Tuesday 20 June 2006 11:43, Steven Whitehouse wrote:
> > As a further suggestion, I wonder do we really need i_private at all?
> > Since we have sb->s_op->alloc_inode and inode->i_sb->s_op->destroy_inode
> > if all filesystems did something along the following lines:
> > 
> > struct myfs_inode {
> >         struct inode i_inode;
> >         ...
> > };
> > 
> > #define MYFS_I(inode) container_of((inode), struct myfs_inode, i_inode)
> > 
> > then it would seem that i_private is redundant. If there is a file
> > system which does genuinely need a pointer here (if indeed such a
> > filesystem does exist, I haven't actually checked that) then a pointer
> > can just be added as the one single other member of (in my example)
> > struct myfs_inode.
> > 
> That would mean that all file systems need to implement ->alloc_inode,
> which in turn need slab caches that eat consume memory even when
> the file system is not mounted.
> 
Yes, although I'm not sure that it would be as significant as the memory
saved by removing the pointer bearing in mind the relative numbers of
the structures that you'd expect to see in a "normal" working system. We
could also try and reduce this by creating a special inode cache which
would be shared by all filesystems which did still need just struct
inode + private pointer for example.

What you do gain though is (on umount of a filesystem) a much greater
likelihood of being able to reclaim the memory which was being used by
the inodes of that particular filesystem (particularly so if you only
have a single mounted filesystem of a particular type). So hopefully
having a separate slab cache per fstype would help reduce memory
fragmentation, and more than compensate for the difference.

In fact a number of filesystems already have slab caches for their own
private part of the inode anyway... I count 10 of those on my current
development box.

> Something as simple as nfsctl or devpts should not need that.
> 
> 	Arnd <><

Steve.


