Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267276AbTA3Bc1>; Wed, 29 Jan 2003 20:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267281AbTA3Bc1>; Wed, 29 Jan 2003 20:32:27 -0500
Received: from are.twiddle.net ([64.81.246.98]:27526 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267276AbTA3Bc0>;
	Wed, 29 Jan 2003 20:32:26 -0500
Date: Wed, 29 Jan 2003 17:41:33 -0800
From: Richard Henderson <rth@twiddle.net>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
Message-ID: <20030129174133.A19912@twiddle.net>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
	Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net> <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net>; from shemminger@osdl.org on Wed, Jan 29, 2003 at 05:15:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 05:15:55PM -0800, Stephen Hemminger wrote:
> First, write_begin/end can only be safely used when there is separate
> writer synchronization such as a spin_lock or semaphore.  
> As far as I know, semaphore or spin_lock guarantees a barrier.
> So xtime or anything else can not be read before the spin_lock.
> 
> Using mb() is more paranoid than necessary. 

If you want stuff to happen *between* the write_begin/end, or
indeed for the begin/end not to be interleaved, then mb() is
absolutely necessary.  The most likely dynamic reordering of

	//begin
	t1 = rw->pre_sequence
	t1 += 1
	rw->pre_sequence = t1
	wmb()

	//stuff
	xtimensec = xtime.tv_nsec

	//end
	wmb()
	t2 = rw->post_sequence
	t2 += 1
	rw->post_sequence = t2

is

	t1 = rw->pre_sequence
	t2 = rw->post_sequence
	xtimensec = xtime.tv_nsec
	t1 += 1;
	t2 += 2;
	rw->pre_sequence = t1
	wmb()
	wmb()
	rw->post_sequence = t2

Why?  Because pre_sequence and post_sequence are in the same
cache line, and both reads could be satisfied in the same 
cycle by the same line fill from main memory.

If you don't care about stuff happening in between the
write_begin/end, then why are you using them at all?


r~
