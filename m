Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263493AbTFKBdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 21:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263837AbTFKBdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 21:33:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55999 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263493AbTFKBdf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 21:33:35 -0400
Date: Wed, 11 Jun 2003 02:47:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank Cusack <fcusack@fcusack.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611014717.GB6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com> <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk> <20030610182824.A18280@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030610182824.A18280@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 10, 2003 at 06:28:24PM -0700, Frank Cusack wrote:
> On Wed, Jun 11, 2003 at 01:54:25AM +0100, viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Mon, Jun 09, 2003 at 06:51:41AM -0700, Frank Cusack wrote:
> >  
> > > When foo is unlinked, nfs_unlink() does a sillyrename, this puts the
> > > dentry on nfs_delete_queue, and (in the VFS) unhashes it from the dcache.
> > > This causes a problem, because dentry->d_parent->d_inode is now guaranteed
> > > to remain stale.  (OK, I'm not really sure about this last part.)
> > 
> > ????
> > 
> > What does hashed state have to ->d_parent?
> 
> Because now d_parent can be d_deleted (no children) and then go away.

Why?  It still has our dentry refering to it and contributing into its
->d_count.

> Then won't dentry->d_parent be wrong?  What happens if d_parent becomes
> a negative d_entry v. disappearing entirely.

->d_parent will not become negative.

> It is if d_count goes to 0 on one of them and the inode is then unlinked.
> But the other dentry remains and again tries to unlink when its d_count
> goes to 0.  Over NFS the fh includes the generation and so you can't
> accidentally delete what only looks like the same file, but what happens
> in the local fs?

Please, take a look at the way normal links work.
 
> Also, the real problem is that something goes wrong with d_parent and

Now, _that_ is interesting.  What are you actually seeing there?
Note that unhashing doesn't change _any_ ->d_count - hash chains
are not counted in it and ->d_parent is not changed.

> NFS tries to refresh an inode that it should really know doesn't exist
> anymore.  That's why my #2 patch only executes during a rmdir.
