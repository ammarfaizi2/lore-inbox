Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSHKJVA>; Sun, 11 Aug 2002 05:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318260AbSHKJVA>; Sun, 11 Aug 2002 05:21:00 -0400
Received: from dsl-213-023-020-163.arcor-ip.net ([213.23.20.163]:20891 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318258AbSHKJU6>;
	Sun, 11 Aug 2002 05:20:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch 21/21] writeback correctness and peformance fixes
Date: Sun, 11 Aug 2002 11:26:08 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>
References: <3D5614E6.460814A5@zip.com.au>
In-Reply-To: <3D5614E6.460814A5@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17dozA-0001fA-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 August 2002 09:40, Andrew Morton wrote:
> Incidentally, the occurrence of a locked-and-dirty buffer in
> block_write_full_page() is fairly rare: normally the collision avoidance
> happens at the address_space level, via PageWriteback.  But some
> mappings (blockdevs, ext3 files, etc) have their dirty buffers written
> out via submit_bh().  It is these buffers which can stall
> block_write_full_page().
> 
> This wart will be pretty intrusive to fix.  ext3 needs to become fully
> page-based (ugh.  It's a block-based journalling filesystem, and pages
> are unnatural).

Ah, so you have finally seen the light.  This is the answer to the question: 
"why do we need soft page size, with subpages?"  At least it's one of the 
answers, other answers include: "finally getting rid of buffers", "cleaning 
up the page+buffer state mess" and "eliminating the locking madness when 
blocks are smaller than pages".

> blockdev mappings are still written out by buffers
> because that's how filesystems use them.  Putting _all_ metadata
> (indirects, inodes, superblocks, etc) into standalone address_spaces
> would fix that up.

You'll like that idea until you try it.  Think about what happens when you 
need to lock more than one subpage block at the same time, with page locks.

At the rate things are going I can see actually doing the subpage thing in 
2.7, and yes, you're right to be skeptical until you see working code.

-- 
Daniel
