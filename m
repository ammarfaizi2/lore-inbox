Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264025AbTFKCaV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 22:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264029AbTFKCaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 22:30:21 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:35142 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264025AbTFKCaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 22:30:17 -0400
Date: Tue, 10 Jun 2003 19:43:33 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030610194333.B18623@google.com>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <16102.36078.894833.262461@charged.uio.no> <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030611022754.GC6754@parcelfarce.linux.theplanet.co.uk>; from viro@parcelfarce.linux.theplanet.co.uk on Wed, Jun 11, 2003 at 03:27:54AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 03:27:54AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Jun 11, 2003 at 03:59:10AM +0200, Trond Myklebust wrote:
> > IOW we just want to prevent VFS from unhashing the dentry in the first
> > place: dentry aliasing cannot work together with sillyrename.
> 
> Aliasing could be dealt with.  They would have the same inode, so it's
> easy to detect.

dentry only contains the inode, not the fh.  On the server, the inode
can go away and come back as a new fh, but with the same inode.  Is
that detectable (would comparison hooks have to be added?)?  Although,
I guess the inode is enough; you can do an NFS_I(inode)->fh to get
the fh, but I wouldn't guess you'd want that in the VFS.  Bah, here
I go again ... forgive me if that's nonsense.

>  The real problem is different: what happens if I take
> silly-renamed file and rename it away?  You suddenly get ->dir and ->dentry
> if your nfs_unlinkdata having nothing to do with each other.

You could disallow rename if DCACHE_NFSFS_RENAMED is set.  That would
be easy and makes sense as an "ok" thing to do.  I mean, if you're not
going to allow unlinking of a sillyrenamed file, you may as well disallow
rename as well.

If that's not desirable (again, seems ok to me ... speaking as just a user)
then hey, in rename you just need to check the nfs_delete_queue.

> _If_ we want to be able to work with silly-renamed dentry, we need much
> more careful async unlink.  Your current code assumes that these dentries
> won't go anywhere.   AFAICS, dcache will not get into inconsistent state,
> but it will have very little to do with state of server...

OK, where else besides rename would the dentry change?

/fc
