Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131888AbRAJFru>; Wed, 10 Jan 2001 00:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132585AbRAJFrl>; Wed, 10 Jan 2001 00:47:41 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:46260 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131888AbRAJFr3>;
	Wed, 10 Jan 2001 00:47:29 -0500
Date: Wed, 10 Jan 2001 00:47:17 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Chris Mason <mason@suse.com>
cc: Marc Lehmann <pcg@goof.com>, reiserfs-list@namesys.com,
        linux-kernel@vger.kernel.org, vs@namesys.botik.ru
Subject: Re: [reiserfs-list] major security bug in reiserfs (may affect SuSE
 Linux)
In-Reply-To: <75150000.979093424@tiny>
Message-ID: <Pine.GSO.4.21.0101092129380.11512-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 Jan 2001, Chris Mason wrote:

> 
> 
> On Wednesday, January 10, 2001 02:32:09 AM +0100 Marc Lehmann <pcg@goof.com> wrote:
> 
> >>> EIP; c013f911 <filldir+20b/221>   <=====
> > Trace; c013f706 <filldir+0/221>
> > Trace; c0136e01 <reiserfs_getblk+2a/16d>
> 
> The buffer reiserfs is sending to filldir is big enough for
> the huge file name, so I think the real fix should be done in VFSland.
 
> But, in the interest of providing a quick, obviously correct fix, this

ITYM "band-aid"

> reiserfs only patch will refuse to create file names larger 
> than 255 chars, and skip over any directory entries larger than 
> 255 chars.

Chris, I seriously suspect that it's not that simple (read: trace is a
BS). 0x20b is just too large for filldir().

However, actual code really looks like the end of filldir(). If that's the
case we are deep in it - argument of filldir() gets screwed. buf, that is.
Since it happens after we've already done dereferencing of buf in filldir()
and we don't trigger them... Fsck knows. copy_to_user() and put_user() should
not be able to screw the kernel stack.

Marc, could you please get larger area before the point of oops + your
fs/readdir.c and send them to me? As much as I hate disassembling, it's
better than guessing the version of compiler you've used and flags you've
built with.

Another useful thing would be printk() of buf prior and post calls of
copy_to_user() and put_user() + value of &dirent before these calls.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
