Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131682AbRCUQyP>; Wed, 21 Mar 2001 11:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRCUQx4>; Wed, 21 Mar 2001 11:53:56 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:14857 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131682AbRCUQxe>; Wed, 21 Mar 2001 11:53:34 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: spinlock usage - ext2_get_block, lru_list_lock
Date: 21 Mar 2001 08:52:37 -0800
Organization: Transmeta Corporation
Message-ID: <99am8l$8mk$1@penguin.transmeta.com>
In-Reply-To: <20010321180607.A11941@linuxcare.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010321180607.A11941@linuxcare.com>,
Anton Blanchard  <anton@linuxcare.com.au> wrote:
>
>It was not surprising the BKL was one of the main offenders. Looking at the
>stats ext2_get_block was the bad guy (UTIL is % of time lock was busy for,
>WAIT is time spent waiting for lock):

Actually, I find the BKL fairly surprising - we've whittled down all the
major non-lowlevel-FS offenders, and I didn't realize that it's still
there in do_exit().

And the do_exit() case should be _trivial_ to fix: almost none of the
code protected by the kernel lock in the exit path actually needs the
lock. I suspect you could cut down the kernel lock there to much
smaller.

The big case seems to be ext2_get_block(), we'll fix that early in
2.5.x. I think Al already has patches for it.

As to lseek, that one should probably get the inode semaphore, not the
kernel lock. 

		Linus
