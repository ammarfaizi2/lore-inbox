Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261754AbUKPCON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbUKPCON (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 21:14:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbUKPCON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 21:14:13 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:50050 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261754AbUKPCOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 21:14:09 -0500
Date: Tue, 16 Nov 2004 03:14:05 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Christoph Rohland <cr@sap.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs symlink corrupts mempolicy
Message-ID: <20041116021405.GJ4758@dualathlon.random>
References: <20041115223430.GF4758@dualathlon.random> <Pine.LNX.4.44.0411160008500.2835-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0411160008500.2835-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 12:26:05AM +0000, Hugh Dickins wrote:
> On Mon, 15 Nov 2004, Andrea Arcangeli wrote:
> > 
> > this patch is completely broken, delete_inode isn't going to be called
> > when the inode is being shrunk. delete_inode is only good for truncate,
> 
> Do you mean "when the inode cache is being shrunk"?
> By "truncate" there you mean "unlink"?

yes.

> > this patch will tend to work until the vm shrink the dcache, then it'll
> > crash, sorry.
> 
> Sorry, you can see I'm having some trouble understanding your reply.
> 
> I think you're forgetting that tmpfs inodes live nowhere but in memory:
> if shrinking the inode cache were to remove tmpfs inodes, it would be a
> considerably more temporary fs than could ever be useful.  There's an
> extra dget that keeps dentry and inode safe from pruning.

I was wrong about it crashing, but it will not crash only for shmfs,
if you want to export that to MAP_SHARED on other fs, you won't be
allowed anymore to depending on this shmfs speciaility of delete_inode
being recalled only during unlink. I don't see how depending on this
subtle detail to free the mpol could ever be an improvement instead of
doing in destroy_inode where it belongs to.
