Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262367AbTFKAlE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 20:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbTFKAlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 20:41:04 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19645 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262367AbTFKAkr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 20:40:47 -0400
Date: Wed, 11 Jun 2003 01:54:25 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank Cusack <fcusack@fcusack.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>, torvalds@transmeta.com,
       marcelo@conectiva.com.br, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race (was: nfs_refresh_inode: inode number mismatch)
Message-ID: <20030611005425.GA6754@parcelfarce.linux.theplanet.co.uk>
References: <20030603165438.A24791@google.com> <shswug2sz5x.fsf@charged.uio.no> <20030604142047.C24603@google.com> <16094.25720.895263.4398@charged.uio.no> <20030603165438.A24791@google.com> <20030609065141.A9781@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030609065141.A9781@google.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 09, 2003 at 06:51:41AM -0700, Frank Cusack wrote:
 
> When foo is unlinked, nfs_unlink() does a sillyrename, this puts the
> dentry on nfs_delete_queue, and (in the VFS) unhashes it from the dcache.
> This causes a problem, because dentry->d_parent->d_inode is now guaranteed
> to remain stale.  (OK, I'm not really sure about this last part.)

????

What does hashed state have to ->d_parent?
 
> Then readdir() returns the new .nfs file, this creates a NEW dentry
> (we just moved the first one to nfs_delete_queue and did not create a
> negative dentry) which now has d_count==1 so instead of sillyrename we
> just remove it (but note, we actually have this file open).  Then rmdir
> succeeeds.
> 
> Now, we have a dentry on nfs_delete_queue which a) has already been
> unlinked and b) whose dentry->d_parent DNE and dentry->d_parent->d_inode
> DNE.  Of course this will cause confusion later!

b) is bogus.  Unhashing does nothing to ->d_parent.

> Note that if a process does a drive by on the .nfs file (another round
> of unlinked-but-open) before we unlink it, we would sillyrename it again.
> We'd now have two different dentry's on the delete queue for the same
> file.  (One of them would just leak, I think--possible local DoS?)

Two different dentries for the same file is obviously not a problem...

> 1) Don't unhash the dentry after silly-renaming.  In 2.2, each fs is
>    responsible for doing a d_delete(), in 2.4 it happens in the VFS and
>    I think it was just an oversight that the 2.4 VFS doesn't consider
>    sillyrename (considering the code and comments that are cruft).
> 
>    This preserves the unlinked-but-open semantic, but breaks rmdir.  So
>    it's not a clear winner from a semantics POV.  dentry->d_count is
>    always correct, which sounds like a plus.
> 
>    The patch to make this work is utterly simple, which is a big plus.

... and AFAICS it opens a huge can of worms with races in NFS unlink/rename.

Sigh...  I'll look through that code and try to reconstruct the analysis.
It used to be a very big mess and there was fairly subtle logics around
unhashing/checks for d_count/etc. involved in fixing ;-/  And there was
a lot of changes since then.  Oh, well...
