Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265286AbSJaRUZ>; Thu, 31 Oct 2002 12:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265287AbSJaRUR>; Thu, 31 Oct 2002 12:20:17 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62877 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265286AbSJaRTt>;
	Thu, 31 Oct 2002 12:19:49 -0500
Date: Thu, 31 Oct 2002 12:26:14 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Nikita Danilov <Nikita@Namesys.COM>
cc: Linus Torvalds <Torvalds@Transmeta.COM>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>
Subject: Re: [PATCH]: reiser4 [8/8] reiser4 code
In-Reply-To: <15809.25023.211776.529580@laputa.namesys.com>
Message-ID: <Pine.GSO.4.21.0210311203300.16688-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Oct 2002, Nikita Danilov wrote:

> generic_shutdown_super() calls fsync_super(sb) (which will call
> ->writepage() on each dirty page) and then invalidate_inodes().
> 
> Reiser4 has commit out-standing transactions -between- these two points:
> after ->writepage() has been called on all dirty pages, but before
> inodes were destroyed. Thus, we cannot use
> kill_block_super()/generic_shutdown_super().

Why don't you do that from within fsync_super()?  That would be much
more natural point for such stuff...

I hadn't looked into akpm's stuff in fs-writeback.c for a while, but
if one can't stick such flush point in there I'd argue that this is
a bug that needs to be fixed - either there or by providing explicit
callback from fsync_super().

Note that sync(2) doesn't get anywhere near your ->kill_sb() code,
so you want fsync_super() do the right thing anyway - regardless of the
umount(2) situation.

