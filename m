Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbULMLsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbULMLsS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 06:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbULMLsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 06:48:17 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:10424 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S262229AbULMLrr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 06:47:47 -0500
Date: Mon, 13 Dec 2004 12:47:37 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: kernel@kolivas.org, pavel@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: dynamic-hz
Message-ID: <20041213114737.GV16322@dualathlon.random>
References: <20041211142317.GF16322@dualathlon.random> <20041212163547.GB6286@elf.ucw.cz> <20041212222312.GN16322@dualathlon.random> <41BCD5F3.80401@kolivas.org> <20041213030237.5b6f6178.akpm@osdl.org> <20041213111741.GR16322@dualathlon.random> <20041213032521.702efe2f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213032521.702efe2f.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 03:25:21AM -0800, Andrew Morton wrote:
> We still have 1000-odd places which do things like
> 
> 	schedule_timeout(HZ/10);
> 
> which will now involve a runtime divide.  The propagation of msleep() and
> ssleep() will reduce that a bit, but not much.

The above is by far the least cpu-hungry piece, it's going to sleep for
100msec, so any order-of-nanoseconds computation in such path will be by
defininition not measurable.

msleep and ssleep as well will obviously be non measurable for the same
reason (their only point is to wait and "waste" cpu). I mean,
msleep/ssleep are the only places in the kernel that we don't really
need to optimize ;). 

Most other fast paths can't execute the division or multiplication at
compile time anyway, so they'd only save 1 cacheline (at the expense of
a bit larger icache).

> It's so simple to turn all those into compile-time divides that we may as
> well do it.

I'm not against leaving a compile time option, it's absolutely trivial
to add it, but I just don't think it'll provide any measurable benefit
in practice, while the ability to switch HZ provides tantible benefits
(even to be able to set HZ to higher frequencies than 1khz, so that
people can post a nanosleep call that will return in 0.1msec instead of
1msec).

Perhaps __HZ could hurt a bit on a NUMA box where the icache may be
spread on the local nodes and the __HZ not, but then the __HZ could be
made a __per_cpu variable conditionally to NUMA and they would get
dynamic settable hz too, which I believe is significant for a numa box
since if they're doing just userspace computing they don't need a fast
HZ and they can get back 1% of their cpu power from every cpu in the
system (on a 512-way system that's quite a lot more than what you will
ever get back from HZ set at compile time ;). 
