Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750932AbWEWQxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750932AbWEWQxw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 12:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWEWQxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 12:53:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15847 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750902AbWEWQxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 12:53:50 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0603021405540.22647@g5.osdl.org> 
References: <Pine.LNX.4.64.0603021405540.22647@g5.osdl.org>  <20060302213356.7282.26463.stgit@warthog.cambridge.redhat.com> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, akpm@osdl.org,
       trond.myklebust@fys.uio.no, aviro@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org,
       Miklos Szeredi <miklos@szeredi.hu>, nathans@sgi.com
Subject: Re: [PATCH 0/5] Permit NFS superblock sharing [try #3] 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Tue, 23 May 2006 17:53:10 +0100
Message-ID: <19085.1148403190@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> > Following discussion with Al Viro, the following changes [try #2] have been
> > made to the previous attempt at this set of patches:
> 
> Btw, I'd like Al to ack/nack the VFS-specific part, but if he does so, I 
> can apply those early in the post.2.6.16-season, so that then the NFS 
> specific parts can be decided on independently..

Any thoughts on whether you can reassert this commitment on the new set of
patches, at least for the getsb and statfs patches which touch every
filesystem.  Those two would make life easier for Andrew:-)

Al: Could you at least ACK or NAK the concepts of those two patches, even if
you don't do a complete review of them?:

 (*) getsb patch

     The attached patch extends the get_sb() filesystem operation to take an
     extra argument that permits the VFS to pass in the target vfsmount that
     defines the mountpoint.

     The filesystem is then required to manually set the superblock and root
     dentry pointers. For most filesystems, this should be done with
     simple_set_mnt() which will set the superblock pointer and then set the
     root dentry to the superblock's s_root (as per the old default
     behaviour).

 (*) statfs patch

     The attached patch gives the statfs superblock operation a dentry pointer
     rather than a superblock pointer.

     This complements the get_sb() patch.  That reduced the significance of
     sb->s_root, allowing NFS to place a fake root there.  However, NFS does
     require a dentry to use as a target for the statfs operation.  This
     permits the root in the vfsmount to be used instead.

The latter patch would also benefit Miklos Szeredi for FUSE:

	http://www.ussg.iu.edu/hypermail/linux/kernel/0510.3/0234.html

And Nathan Scott for XFS.

These two patches can then be used by the NFS filesystem to share superblocks
(which is now done on a remote filesystem level as delineated by the FSID
presented by the NFS server rather than on a server level).

David
