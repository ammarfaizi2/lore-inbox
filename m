Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261893AbUKPFus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbUKPFus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 00:50:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbUKPFus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 00:50:48 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:57523 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261893AbUKPFuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 00:50:40 -0500
Date: Tue, 16 Nov 2004 05:50:18 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tmpfs symlink corrupts mempolicy
In-Reply-To: <20041116021405.GJ4758@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0411160513400.3422-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Nov 2004, Andrea Arcangeli wrote:
> 
> I was wrong about it crashing, but it will not crash only for shmfs,
> if you want to export that to MAP_SHARED on other fs, you won't be

I've not yet studied the patches which apply NUMA memory policy to
general page cache, but that's something different.  (I'd like to
think they could extend and replace the shmem special case mpol,
but API commitment may turn out to prevent that.)

Of course they won't be able to rely on tmpfs peculiarities, but
they will surely integrate the mpol with generic inode/mapping,
not the tmpfs-specfic inode.  I don't know whether they would free
up the mpol in destroy_inode, or near the truncate_inode_pages.

> allowed anymore to depending on this shmfs speciaility of delete_inode
> being recalled only during unlink. I don't see how depending on this
> subtle detail to free the mpol could ever be an improvement instead of
> doing in destroy_inode where it belongs to.

But we're talking about tmpfs (shmfs) for now: which has this space-
saving but nasty oddity that it keeps the short symlinks overwriting
its filesystem-specific inode structure, but the long symlinks in a
page allocated according to NUMA memory policy.  By the time you get
to shmem_destroy_inode, you don't know which was which.  No, I'm
wrong on that, you can test inode->i_op->truncate to decide
(I'd have to check whether inode->i_op might be NULL).

Your code is relying on the fact that actually the mpol for a long
symlink is always the default, and the default doesn't need any memory
to be freed .  That may well remain the case forever, but Brent has a
patch to set tmpfs default memory policy by mount option.  That patch
may go nowhere, or we might override the default for symlinks anyway,
but potentially it could need mpol freed even in long symlink case.

The place where tmpfs currently deals with regular files and long
symlinks (those which may allocate pages) versus the rest is in
shmem_delete_inode, hence I moved the mpol freeing there.  Perhaps
that whole bank of code could be moved into shmem_destroy_inode,
but I rather doubt it - shmem_destroy_inode is there to free what
shmem_alloc_inode allocated, and that doesn't involve mpol at all.

Hugh

