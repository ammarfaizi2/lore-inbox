Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263054AbTCLAiZ>; Tue, 11 Mar 2003 19:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263053AbTCLAiP>; Tue, 11 Mar 2003 19:38:15 -0500
Received: from mail.zmailer.org ([62.240.94.4]:48356 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S263047AbTCLAhz>;
	Tue, 11 Mar 2003 19:37:55 -0500
Date: Wed, 12 Mar 2003 02:48:36 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Runaway cron task on 2.5.63/4 bk?
Message-ID: <20030312004836.GE1073@mea-ext.zmailer.org>
References: <20030311144448.4d9ee416.akpm@digeo.com> <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303111458390.1709-100000@home.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 03:02:31PM -0800, Linus Torvalds wrote:
> On Tue, 11 Mar 2003, Andrew Morton wrote:
> > gcc will generate 64bit * 64bit multiplies without resorting to
> > any library code
> 
> However, gcc is unable to do-the-right-thing and generate 32x32->64 
> multiplies, or 32x64->64 multiplies, even though those are both a _lot_ 
> faster than the full 64x64->64 case.
> 
> And in quite a _lot_ of cases, that's actually what you want. It might 
> actually make sense to add a "do_mul()" thing to allow architectures to do 
> these cases right, since gcc doesn't.

Some architectures have a bit stricter limitations -- S390 limits divisor
to 2^31-1, for example.

A number of systems simply flaunt the task, and instead implement
mere 32/32 division in  do_div().
(arm, cris, m68knommu, sh (?), sparc(32), v850)


The original pure C code to do 64/32 division to 64/32 results is
very much gone in favour of architecture specific assembly codes
(where system isn't 64 bit one already..)
Ah, include/asm-parisc/div64.h  still has it in 2.5.64 sources..


> > and you can probably do the division with do_div().

If you need arbitrary divisions at all.  Filesystems for example
can (in most cases) do with power-of-two divisions, e.g.:  LL >> count
You may, perhaps, need to pre-calculate a number of those shift-counts
when mounting a filesystem.

> Yes. This is the same issue - gcc will always promote a 64-bit divide to
> be _fully_ 64-bit, even if the mixed-size 64/32 -> [64,32] case is much
> faster and simpler. Which is why do_div() exists in the first place.

Originally it was  lib/vsprintf.c's  internal (and very portable)
divide numerator by small base, produce changed numerator, and
remainder...  The innermost element in arbitrary base number printing.

In 2.5 there is some odd:   #define sector_div(a, b) do_div(a, b)
(only with  CONFIG_LDB), and usage in jiffie-to-clock conversion...
... and all over the code in various odd nooks, XFS filesystem included...

> 		Linus

/Matti Aarnio
