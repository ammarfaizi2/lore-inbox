Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130207AbRAIXl6>; Tue, 9 Jan 2001 18:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131509AbRAIXlj>; Tue, 9 Jan 2001 18:41:39 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:50956 "EHLO
	mf1.private") by vger.kernel.org with ESMTP id <S131181AbRAIXlb>;
	Tue, 9 Jan 2001 18:41:31 -0500
Date: Tue, 9 Jan 2001 15:45:31 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: LKML <linux-kernel@vger.kernel.org>,
        "William A. Stein" <was@math.harvard.edu>, Dan Maas <dmaas@dcine.com>
Subject: Re: Subtle MM bug (really 830MB barrier question)
In-Reply-To: <Pine.LNX.4.30.0101092109580.1092-100000@fs129-124.f-secure.com>
Message-ID: <Pine.LNX.4.30.0101091535460.13548-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Szabolcs Szakacsits wrote:

> Wayne, the patch below should fix your barrier problem [1 GB physical
> memory configuration].

First, I just wanted to thank you and everyone else (Linus, Andrea, Dan
Maas, Rik and others) who has responded to my emails.  You guys are
wonderful!

On Tue, 9 Jan 2001, Dan Maas wrote:

> OK it's fairly obvious what's happening here. Your program is using
> its own allocator, which relies solely on brk() to obtain more memory.

OK, the statically linked binary I have produces a simpler /proc/pid/maps,
here it is (before I actually try to create any big objects in memory):

08048000-08afb000 r-xp 00000000 03:07 64318      /usr/local/magma-2.7/magma.exe
08afb000-08c3e000 rw-p 00ab2000 03:07 64318      /usr/local/magma-2.7/magma.exe
08c3e000-0bc54000 rwxp 00000000 00:00 0
40000000-40001000 rw-p 00000000 00:00 0
bfffd000-c0000000 rwxp ffffe000 00:00 0

If I understand correctly, the first two lines are the executable
(although I don't know why it shows up twice), the third line is the heap
for this program, the fourth line is where mmap stuff starts and the fifth
line is the boundary between the process address space and the kernel
address space.

First question:  for this statically linked binary, nothing is really
being mmap'ed, is there any way that I can arrange, for this process only,
to get rid of the fourth line?  This would be the ideal solution.

Szabolcs's suggestion (and Mark Hahn's privately, as well) of modifying
TASK_UNMAPPED_BASE does work for me.  Unfortunately, on the same machine
I'd like to both run programs that use brk() allocation and that use
mmap() allocation, so the best I can do is change TASK_UNMAPPED_BASE to
1.5GB from 1GB, this allows a bit under 1.5GB for brk() and 1.5GB() for
mmap().

Second question:  if I understand correctly, the start of the kernel
process space is controlled by PAGE_OFFSET, and under CONFIG_NOHIGHMEM,
the kernel maps all the physical RAM into its address space.  I guess
128MB of this space is used for the 2.4.0 kernel itself, so that the
maximum physical RAM under 2.4.0 with PAGE_OFFSET set to 3GB is 896MB.
One of my machines has 1024MB of RAM, so can I just decrease PAGE_OFFEST
by 128MB to be able to use all of it?

Thanks again,
Wayne





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
