Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265393AbSJXLYv>; Thu, 24 Oct 2002 07:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265395AbSJXLYv>; Thu, 24 Oct 2002 07:24:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:31600 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265393AbSJXLYu>; Thu, 24 Oct 2002 07:24:50 -0400
Date: Thu, 24 Oct 2002 13:31:06 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: chrisl@vmware.com, linux-kernel@vger.kernel.org
Subject: Re: writepage return value check in vmscan.c
Message-ID: <20021024113106.GE3354@dualathlon.random>
References: <20021024082505.GB1471@vmware.com> <3DB7B11B.9E552CFF@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB7B11B.9E552CFF@digeo.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2002 at 01:36:43AM -0700, Andrew Morton wrote:
> prod.  We should do something about that.

you need to preallocate the file, then to mmap it. If you do, the kernel
won't throw the data away. So the fix for vmware is to preallocate the
file and later to mmap it. This way you will be notified by -ENOSPC if
you run out of disk/shmfs space.  Other than this I'm not so against the
MAP_SHARED like Andrew, the reason the API is not so clean is that we
cannot have an API at all inside a page fault to notify userspace that
the ram modifications cannot be written to disk. the page fault must be
transparent, there's no retvalue, so if you run out of disk space during
the page fault, the page fault cannot easily tell userspace. As said the
fix is very easy and consists in preallocating the space on disk (I
understand that on shmfs it may not be extremely desiderable since you
may prefer to defer allocation lazily to when you will need the memory
but assuming your allocations are worthwhile it won't make difference
after a few minutes/hours of usage and this way you will trap the -ENOSPC).

As for the task being able to reference a deleted file in memory, that's
true for many other scenarios (the user could leak space by keeping the
fd open and unlinking the file and at the same time to alloc lots of ram
with malloc, the result would be similar), and that's why root will have
to kill these malicious tasks in order to reclaim ram and disk space.

Andrea
