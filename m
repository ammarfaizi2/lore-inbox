Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264308AbUACWsi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 17:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264313AbUACWsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 17:48:38 -0500
Received: from [193.138.115.2] ([193.138.115.2]:30217 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S264308AbUACWsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 17:48:36 -0500
Date: Sat, 3 Jan 2004 23:45:56 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Subject: Suspected bug in fs/ufs/inode.c - test for < 0 on unsigned sector_t
 - [2.6.1-rc1-mm1]
Message-ID: <Pine.LNX.4.56.0401032326050.4664@jju_lnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I think I may have found a bug in fs/ufs/inode.c

lines 334 & 335 have this code (in function ufs_getfrag_block) :

	if (fragment < 0)
		goto abort_negative;

fragment is an argument to ufs_getfrag_block of type sector_t
digging a little in include/linux and include/asm reveals sector_t to be
an an unsigned type in all archs (at least as far as I've been able to
determine).

include/linux/types.h defines sector_t as

typedef unsigned long sector_t;

and in include/asm* sector_t is defined as :

asm-sh/types.h:typedef u64 sector_t;
asm-x86_64/types.h:typedef u64 sector_t;
asm-h8300/types.h:typedef u64 sector_t;
asm-i386/types.h:typedef u64 sector_t;
asm-mips/types.h:typedef u64 sector_t;
asm-s390/types.h:typedef u64 sector_t;
asm-ppc/types.h:typedef u64 sector_t;

all unsigned types.

So, since sector_t is unsigned it can never be less than zero, hence the
branch on line 334 will never be taken and the assiciated label
"abort_negative" will never be reached (and it's not referenced anywhere
else).

I don't know enough about UFS to be able to tell if this is actually a
problem or not, but I suspect that it might be.. If it's not a problem,
then the code that tests for (fragment < 0) and the associated code
in abort_negative might as well be removed.

Is this analysis correct?  If it is, can the code simply be removed?


Kind regards,

Jesper Juhl
