Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312769AbSDBEhA>; Mon, 1 Apr 2002 23:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312770AbSDBEgv>; Mon, 1 Apr 2002 23:36:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61194 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312769AbSDBEgh>; Mon, 1 Apr 2002 23:36:37 -0500
Date: Mon, 1 Apr 2002 20:32:42 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Richard Henderson <rth@twiddle.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 7.52 second kernel compile
In-Reply-To: <20020326185356.B19912@twiddle.net>
Message-ID: <Pine.LNX.4.33.0204012013580.32552-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Mar 2002, Richard Henderson wrote:
>
> For the record, Alpha timings:
> 
> pca164 @ 533MHz:
>   72.79: 19
>    1.50: 20
>   21.30: 35
>    1.50: 36
>    1.30: 105

Interesting. There seems to be three peaks: a big 4/1 split at 19-20 vs
35-36 cycles, which is probably just the L1 cache (8 bytes per entry,
32-byte cachelines on the EV5 gives 4 entries per cache load), while the
much smaller peak at 105 cycles might possibly be due to the virtual
lookup miss, causing a double TLB miss and a real walk every 8kB entries
(actually, much more often than that, since there's TLB pressure and the
virtual PTE mappings get thrown out faster than the theoretical numbers
would indicate)

It also shows how pretty studly it is to take a sw TLB miss quite that
quickly. Getting in and out of PAL-mode that fast is rather fast.

> ev6 @ 500MHz:
>    2.43: 78
>   72.13: 84
>    2.55: 89
>    5.87: 90
>    1.38: 105
>    5.94: 108
>    1.36: 112
> 
> I wonder how much of that ev6 slowdown is due to an SRM that's
> has to handle both 3 and 4 level page tables, and how much is
> due to the more expensive syncing of the OOO pipeline...

The multi-level page table shouldn't hurt at all for the common case (ie
the virtual PTE lookup success), so my money would be on the pipeline
flush.

The other profile difference seems to be due to the 64-byte cacheline (ie
a cacheline now holds 8 entries, so 7/8th can be filled that way).

However, I doubt whether that third peak could be a double PTE fault, it
seems too big and too close in cycles to the others. So maybe the third
peak at 108 cycles is something else... As it seems to balance out very
nicely with the second peak, I wonder if there might not be something
making every other cache fill faster - like a 128-byte prefetch or an
external 128-byte line on the L2/L3? (Ie the third peak would be really
just the "other half" of the second peak).

		Linus

