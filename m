Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129511AbRAITyS>; Tue, 9 Jan 2001 14:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130231AbRAITyH>; Tue, 9 Jan 2001 14:54:07 -0500
Received: from dfmail.f-secure.com ([194.252.6.39]:43527 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S129511AbRAITxz>; Tue, 9 Jan 2001 14:53:55 -0500
Date: Tue, 9 Jan 2001 22:06:51 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: Wayne Whitney <whitney@math.berkeley.edu>
cc: LKML <linux-kernel@vger.kernel.org>,
        "William A. Stein" <was@math.harvard.edu>, Dan Maas <dmaas@dcine.com>
Subject: Re: Subtle MM bug (really 830MB barrier question)
In-Reply-To: <Pine.LNX.4.30.0101081819540.19272-100000@mf1.private>
Message-ID: <Pine.LNX.4.30.0101092109580.1092-100000@fs129-124.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Jan 2001, Dan Maas wrote:

> OK it's fairly obvious what's happening here. Your program is using
> its own allocator, which relies solely on brk() to obtain more
> memory.
[... good explanation here ...]
> Here's your short answer: ask the authors of your program to either
> 1) replace their custom allocator with regular malloc() or 2) enhance
> their custom allocator to use mmap. (or, buy some 64-bit hardware =)...)

3) ask kernel developers to get rid of this "brk hits the fixed start
address of mmapped areas" or the other way around complaints "mmapped
area should start at lower address" limitation. E.g. Solaris does
growing up heap, growing down mmap and fixed size stack at the top.

Wayne, the patch below should fix your barrier problem [1 GB physical
memory configuration], I used only with 2.2 kernels. Your app should
complain about out of memory around 2.7 GB (0xb0000000-0x08??????),
but note that only 256 MB (0xc0000000-0xb0000000) left for shared
libraries, mmapped areas.

Good luck,

	Szaka

--- linux-2.2.18/include/asm-i386/processor.h  Thu Dec 14 08:20:17 2000
+++ linux/include/asm-i386/processor.h	Tue Jan  9 17:50:49 2001
@@ -166,7 +166,7 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
-#define TASK_UNMAPPED_BASE	(TASK_SIZE / 3)
+#define TASK_UNMAPPED_BASE	0xb0000000

 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
