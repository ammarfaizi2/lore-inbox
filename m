Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVA1BGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVA1BGt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 20:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbVA1BGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 20:06:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:40634 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261348AbVA1BGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 20:06:46 -0500
Date: Thu, 27 Jan 2005 17:06:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: mingo@elte.hu, pwil3058@bigpond.net.au, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [patch, 2.6.10-rc2] sched: fix ->nr_uninterruptible handling
 bugs
In-Reply-To: <20050127165330.6f388054.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0501271658460.2362@ppc970.osdl.org>
References: <20041116113209.GA1890@elte.hu> <419A7D09.4080001@bigpond.net.au>
 <20041116232827.GA842@elte.hu> <Pine.LNX.4.58.0411161509190.2222@ppc970.osdl.org>
 <20050127165330.6f388054.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Jan 2005, Paul Jackson wrote:
>
> A long time ago, Linus wrote:
> > An atomic op is pretty much as expensive as a spinlock/unlock pair on x86.  
> > Not _quite_, but it's pretty close.
> 
> Are both read and modify atomic ops relatively expensive on some CPUs,
> or is it just modify atomic ops?

Linux pretty much assumes that any naturally aligned read or write of the
basic word-size (actually "int"/"long"/pointer) are always atomic.  
That's true on all architectures that do SMP today. In fact, it's hard
seeing it ever be not true, although specialized architectures with
out-of-band locking bits might have different assumptions (and return
"invalid" for a memory location that is "in flux").

So if you just do a regular read or write, that's basically always cheap.

HOWEVER. In the absense of locking, you usually can't just do a regular
read or write. You'd have memory barriers etc, which quite easily bring
the cost up to similar as locking (modulo cacheline bounces, which would
happen on the actual access, not the barrier).

Also, "bigger" accesses are not atomic, ie a 64-bit read on a 32-bit 
platform usually requires a lock (or equivalent data structures, like 
sequence numbers with memory barriers).

The _real_ cost of not locking also often ends up being the inevitable 
bugs. Doing clever things with memory barriers is almost always a bug 
waiting to happen. It's just _really_ hard to wrap your head around all 
the things that can happen on ten different architectures with different
memory ordering, and a single missing barrier.

		Linus
