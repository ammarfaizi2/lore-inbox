Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbRGLCaz>; Wed, 11 Jul 2001 22:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267420AbRGLCaq>; Wed, 11 Jul 2001 22:30:46 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:22291 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267417AbRGLCaf>; Wed, 11 Jul 2001 22:30:35 -0400
Date: Thu, 12 Jul 2001 04:30:46 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lance Larsh <llarsh@oracle.com>
Cc: Brian Strand <bstrand@switchmanagement.com>, linux-kernel@vger.kernel.org,
        lvm-devel@sistina.com
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
Message-ID: <20010712043046.R3496@athlon.random>
In-Reply-To: <3B4C8263.6000407@switchmanagement.com> <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0107111530170.2342-100000@llarsh-pc3.us.oracle.com>; from llarsh@oracle.com on Wed, Jul 11, 2001 at 04:03:09PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2001 at 04:03:09PM -0700, Lance Larsh wrote:
> some of our servers experienced as much as 10-15x slowdown after we moved
[..]
> also tried reiserfs without lvm, which was 5-6x slower than ext2 without

Hmm, so lvm introduced a significant slowdown too.

The only thing I'm scared about lvm are the down() in the ll_rw_block
fast paths and sumbit_bh which should *obviously* be converted to rwsem
(the write lock is needed only while moving PV around or while taking
COW in a snapshotted device). This way the fast paths common cases will
never wait for a lock. We inherit those non rw semaphores from the
latest lvm release (more recent than beta7 there's only the head CVS).

The down() of beta7 fixes race conditions present in previous releases
so they weren't pointless, but it was obviously a suboptimal fix. When I
seen them I was just scared but it was hard to tell if they could hurt
in real life and since 'till today nobody said anything bad about lvm
performance I assumed it wasn't a problem, but now something has
changed thanks to your feedback.

I will soon somehow make those changes in the lvm (based on beta7) in my
tree and it will be interesting to see if this will make a difference. I
will also have a look to see if I can improve a little more the lvm_map
but other than those non rw semaphores there should be not a significant
overhead to remove in the lvm fast path.

Andrea

PS. hint: if the down() were the problem you should also see an higher
    context switching rate with lvm+ext2 than with plain ext2.
