Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271189AbTHLWK4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 18:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271194AbTHLWK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 18:10:56 -0400
Received: from ip144-173-busy.ott.istop.com ([66.11.173.144]:30220 "EHLO
	worf.vpn") by vger.kernel.org with ESMTP id S271189AbTHLWKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 18:10:50 -0400
Date: Tue, 12 Aug 2003 18:10:48 -0400
From: Christian Mautner <linux@mautner.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4: Allocation of >1GB in one chunk - Solution
Message-ID: <20030812221048.GA17552@mautner.ca>
References: <20030811174934.GA7569@mautner.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030811174934.GA7569@mautner.ca>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(since I hate googling for answers and always finding people with the
same questions, but never with answers, I post the whole story:)

This was my problem:

On Mon, Aug 11, 2003 at 01:49:34PM -0400, Christian Mautner wrote:
> 
> I am running various kinds of EDA software on 32-bit Linux, and they
> need substantial amounts of memory. I am running 2.4.21 with with
> PAGE_OFFSET at 0xc0000000, so I can run processes just over 3GB. The
> machine (a dual Xeon) has 4GB memory and 4GB swap.

This was a typo, I meant 0xe0000000

> But this one needs less than 3GB. But what it does need (I strace'ed
> this), is 1.3GB in one whole chunk.

Matthew Wilcox and Geert Uytterhoeven pointed me to the /proc/*/maps
file, which looked like this (last column trimmed):

08048000-08049000 r-xp 00000000 00:0b 1516708 foo 
08049000-0804a000 rw-p 00000000 00:0b 1516708 foo 
0804a000-2ed4a000 rwxp 00000000 00:00 0 
42000000-42126000 r-xp 00000000 08:06 144004 libc-2.2.93.so 
42126000-4212b000 rw-p 00126000 08:06 144004 libc-2.2.93.so 
4212b000-4212f000 rw-p 00000000 00:00 0 
4aaab000-4aabd000 r-xp 00000000 08:06 16004  ld-2.2.93.so 
4aabd000-4aabe000 rw-p 00012000 08:06 16004  ld-2.2.93.so 
4aac9000-dff15000 rw-p 00000000 00:00 0 
dfffc000-e0000000 rwxp ffffd000 00:00 0 

This shows that the memory space is split into two fragments, at
around 0x40000000 (=1GB) I learned that the virtual memory space is
usually laid out like this[1]:

0GB-1GB  User space   - Used for executable and brk/sbrk allocations 
                        (malloc uses brk for small chunks). 
1GB-2GB  User space   - Used for mmaps (shared memory), shared 
                        libraries and malloc uses mmap (malloc uses 
                        mmap for large chunks). 
2GB-3GB  User space   - Used for stack. 
3GB-4GB  Kernel Space - Used for the kernel itself. 

I have moved the start of the kernel already up to 3.5GB by setting
PAGE_OFFSET. To move the start of the mmap space, I set
TASK_UNMAPPED_BASE in include/asm-i386/processor.h to 0x20000000
(=512MB).

But, to my surprise, this is, for example, a maps file with the new
kernel: 

08048000-0804c000 r-xp 00000000 08:06 112076 /bin/cat
0804c000-0804d000 rw-p 00003000 08:06 112076 /bin/cat
0804d000-0804e000 rwxp 00000000 00:00 0
20000000-20012000 r-xp 00000000 08:06 16004  /lib/ld-2.2.93.so
20012000-20013000 rw-p 00012000 08:06 16004  /lib/ld-2.2.93.so
2001e000-2001f000 rw-p 00000000 00:00 0
42000000-42126000 r-xp 00000000 08:06 144004 /lib/i686/libc-2.2.93.so
42126000-4212b000 rw-p 00126000 08:06 144004 /lib/i686/libc-2.2.93.so
4212b000-4212f000 rw-p 00000000 00:00 0
dfffe000-e0000000 rwxp fffff000 00:00 0

The program I had problems with now works fine, because the smaller
chunks that are allocated first, fit in the hole between 0x20000000
and 0x42000000, leaving the big space for the 1.3GB chunk.

But why is the libc at 0x42000000, making my de-fragmentation efforts
almost worthless? Turns out [2], "On RedHat 7.3 and 8.0 the C library
is compiled for a fixed address rather than a dynamic address."

Great. The only solution is to get the libc RPM and recompile and
re-package it. I might do this at a later point.

I had one more problem, that grub apparently cannot load the initial
RAM disk if the PAGE_OFFSET is not 0xc0000000, but this does not
belong here.

thanks everyone,
chm.

[1] http://www.puschitz.com/TuningLinuxForOracle.shtml
[2] http://www.daimi.au.dk/~kasperd/comp.os.linux.development.faq.html 

PS: I did not choose RedHat voluntarily, but try running commercial
(EDA) software on Linux that is not RedHat 7.3!

-- 
christian mautner -- chm bei istop punkt com -- ottawa, canada
