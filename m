Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265045AbUADDG6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 22:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265100AbUADDG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 22:06:58 -0500
Received: from [193.138.115.2] ([193.138.115.2]:10504 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265045AbUADDGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 22:06:52 -0500
Date: Sun, 4 Jan 2004 04:04:12 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Re: Suspected bug in fs/ufs/inode.c and other filesystems - test
 for < 0 on unsigned sector_t - [2.6.1-rc1-mm1]
In-Reply-To: <Pine.LNX.4.56.0401032326050.4664@jju_lnx.backbone.dif.dk>
Message-ID: <Pine.LNX.4.56.0401040344490.4664@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0401032326050.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, the exact same thing as below seems to be going on in

fs/adfs/inode.c		- line 30
fs/befs/linuxvfs.c	- line 135
fs/bfs/file.c		- line 67 (this one's a little different, but the sector_t < 0 check is involved
fs/reiserfs/inode.c	- line 577

should I be worried?  Is this worth digging into any further?
I don't mind doing some intensive fs code studying, but before I commit a
lot of time to this it would be nice with a confirmation from someone who
already knows this stuff that it's worth spending time on... I don't yet
know enough to judge that..


/Jesper Juhl


On Sat, 3 Jan 2004, Jesper Juhl wrote:

>
> Hi,
>
> I think I may have found a bug in fs/ufs/inode.c
>
> lines 334 & 335 have this code (in function ufs_getfrag_block) :
>
> 	if (fragment < 0)
> 		goto abort_negative;
>
> fragment is an argument to ufs_getfrag_block of type sector_t
> digging a little in include/linux and include/asm reveals sector_t to be
> an an unsigned type in all archs (at least as far as I've been able to
> determine).
>
> include/linux/types.h defines sector_t as
>
> typedef unsigned long sector_t;
>
> and in include/asm* sector_t is defined as :
>
> asm-sh/types.h:typedef u64 sector_t;
> asm-x86_64/types.h:typedef u64 sector_t;
> asm-h8300/types.h:typedef u64 sector_t;
> asm-i386/types.h:typedef u64 sector_t;
> asm-mips/types.h:typedef u64 sector_t;
> asm-s390/types.h:typedef u64 sector_t;
> asm-ppc/types.h:typedef u64 sector_t;
>
> all unsigned types.
>
> So, since sector_t is unsigned it can never be less than zero, hence the
> branch on line 334 will never be taken and the assiciated label
> "abort_negative" will never be reached (and it's not referenced anywhere
> else).
>
> I don't know enough about UFS to be able to tell if this is actually a
> problem or not, but I suspect that it might be.. If it's not a problem,
> then the code that tests for (fragment < 0) and the associated code
> in abort_negative might as well be removed.
>
> Is this analysis correct?  If it is, can the code simply be removed?
>
>
> Kind regards,
>
> Jesper Juhl
