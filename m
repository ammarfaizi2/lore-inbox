Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261727AbUKPA1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261727AbUKPA1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 19:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbUKPA1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 19:27:17 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:26090 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261727AbUKPA00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 19:26:26 -0500
Date: Tue, 16 Nov 2004 00:26:05 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Christoph Rohland <cr@sap.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tmpfs symlink corrupts mempolicy
In-Reply-To: <20041115223430.GF4758@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0411160008500.2835-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2004, Andrea Arcangeli wrote:
> 
> this patch is completely broken, delete_inode isn't going to be called
> when the inode is being shrunk. delete_inode is only good for truncate,

Do you mean "when the inode cache is being shrunk"?
By "truncate" there you mean "unlink"?

> mpol_free_shared_policy has nothing to do with the nlink value.

I didn't think that it would.

> this patch will tend to work until the vm shrink the dcache, then it'll
> crash, sorry.

Sorry, you can see I'm having some trouble understanding your reply.

I think you're forgetting that tmpfs inodes live nowhere but in memory:
if shrinking the inode cache were to remove tmpfs inodes, it would be a
considerably more temporary fs than could ever be useful.  There's an
extra dget that keeps dentry and inode safe from pruning.

mpol_shared_policy_init is appropriate when we might want to allocate
pages to the inode (regular file or long symlink); mpol_free_shared_policy
is appropriate when we've given up the possibility of allocating pages to
such an inode - that's after shmem_delete_inode's shmem_truncate.
Whereas shmem_destroy_inode is the complement of shmem_alloc_inode,
neither of which should get into this mpol stuff.

If you're unconvinced, please suggest a test case which will do the
wrong thing, and I'll check it out tomorrow - thanks.

Hugh

