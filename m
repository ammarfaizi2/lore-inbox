Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRHFHZ4>; Mon, 6 Aug 2001 03:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267268AbRHFHZq>; Mon, 6 Aug 2001 03:25:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53122 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S267196AbRHFHZ1>;
	Mon, 6 Aug 2001 03:25:27 -0400
Date: Mon, 6 Aug 2001 03:25:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Gergely Madarasz <gorgo@sztaki.hu>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.8-pre4 drivers/net/wan/comx.c unresolved symbol
In-Reply-To: <Pine.GS4.4.33.0108060912240.5076-100000@lutra.sztaki.hu>
Message-ID: <Pine.GSO.4.21.0108060315490.13716-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 6 Aug 2001, Gergely Madarasz wrote:

> Ok. I was just maintaining that code, I didn't write it, and it was
> accepted into 2.2 with no mention of these problems. And btw it at
> least seemed to be working...

Ask Alan - he had accepted that code in 2.2...

Seriously, it's badly broken. I'm quite interested in getting the
filesystem side fixed (and ready to help with that), but amount of
other bugs is _very_ large. Several I can remember right now:
	* kmalloc(..., GFP_KERNEL) may block and lead to IO. What do you
expect to happen if it gets called when interrupts are disabled?
	* ->hw_init() can block before it bumps module reference count
(e.g. mixcom calls kmalloc()). rmmod while we are sleeping and you've
got a nice oops.
	* return value of ->stop() is ignored. Returning -EBUSY
will not prevent shutting the interface down.
	* remove_proc_entry() won't terminate ->read() in progress (obviously)
and it doesn't wait for completion of said ->read() (nothing to wait on).
open a file and do rmdir(). See what happens if somebody's reading from
the file right now...

