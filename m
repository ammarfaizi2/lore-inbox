Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129939AbQLTOAB>; Wed, 20 Dec 2000 09:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130142AbQLTN7w>; Wed, 20 Dec 2000 08:59:52 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:10090 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129939AbQLTN7m>; Wed, 20 Dec 2000 08:59:42 -0500
Date: Wed, 20 Dec 2000 14:28:58 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre2
Message-ID: <20001220142858.A7381@athlon.random>
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E147MkJ-00036t-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Dec 16, 2000 at 07:11:47PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2000 at 07:11:47PM +0000, Alan Cox wrote:
> o	E820 memory detect backport from 2.4		(Michael Chen)

It's broken, it will crash machines:

       for (i = 0; i < e820.nr_map; i++) {
               unsigned long start, end;
               /* RAM? */
               if (e820.map[i].type != E820_RAM)
                       continue;
               start = PFN_UP(e820.map[i].addr);
               end = PFN_DOWN(e820.map[i].addr + e820.map[i].size);
               if (start >= end)
                       continue;
               if (end > max_pfn)
                       max_pfn = end;
       }
       memory_end = (max_pfn << PAGE_SHIFT);

this will threat non-RAM holes as RAM. On 2.4.x we do a different things, that
is we collect the max_pfn but then we don't assume that there are no holes
between 1M and max_pfn ;), we instead fill the bootmem allocator _only_ with
E820_RAM segments.

I was in the process of fixing this (I also just backported the thinkpad
%edx clobber fix), but if somebody is going to work on this please let
me know so we stay in sync.

> o	wake_one semantics for accept()			(Andrew Morton)

I dislike the implementation. I stick with my faster and nicer implementation
that was just included in aa kernels for some time (2.2.18aa2 included it for
example). Andrew, I guess you didn't noticed I just implemented the wakeone for
accept. (I just ported it on top of 2.2.19pre2 after backing out the wakeone in
pre2)

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
