Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbUKOWer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbUKOWer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 17:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUKOWer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 17:34:47 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:31715 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261482AbUKOWeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 17:34:31 -0500
Date: Mon, 15 Nov 2004 23:34:30 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs symlink corrupts mempolicy
Message-ID: <20041115223430.GF4758@dualathlon.random>
References: <Pine.LNX.4.44.0411152037340.4131-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411152037340.4131-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 08:41:12PM +0000, Hugh Dickins wrote:
> Andrea discovered that short symlinks on tmpfs, stored within the inode
> itself, overwrote the NUMA mempolicy field which shmem_destroy_inode
> expected to find there.  His fix was good, but Hugh changed it around a
> little, to match existing shmem.c practice (now mpol_init in cases which
> might allocate a page, mpol_free in shmem_truncate_inode), and allow for
> possibility that mpol_init for a long symlink might one day do something
> which really needs mpol_free.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> 
> Thanks a lot for working that out, Andrea: is this version okay with you?
> I've not studied the mempolicy.c part of the patch you posted, which
> seemed to be an entirely separate (and less urgent) patch,
> better reviewed by Andi.
> 
> --- 2.6.10-rc2/mm/shmem.c	2004-11-15 16:21:24.000000000 +0000
> +++ linux/mm/shmem.c	2004-11-15 19:08:58.366829456 +0000
> @@ -672,6 +672,7 @@ static void shmem_delete_inode(struct in
>  		shmem_unacct_size(info->flags, inode->i_size);
>  		inode->i_size = 0;
>  		shmem_truncate(inode);
> +		mpol_free_shared_policy(&info->policy);
>  		if (!list_empty(&info->swaplist)) {
>  			spin_lock(&shmem_swaplist_lock);
>  			list_del_init(&info->swaplist);

this patch is completely broken, delete_inode isn't going to be called
when the inode is being shrunk. delete_inode is only good for truncate,
mpol_free_shared_policy has nothing to do with the nlink value.

this patch will tend to work until the vm shrink the dcache, then it'll
crash, sorry.
