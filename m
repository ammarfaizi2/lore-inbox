Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTA3BnH>; Wed, 29 Jan 2003 20:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267300AbTA3BnH>; Wed, 29 Jan 2003 20:43:07 -0500
Received: from [195.223.140.107] ([195.223.140.107]:641 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267292AbTA3BnE>;
	Wed, 29 Jan 2003 20:43:04 -0500
Date: Thu, 30 Jan 2003 02:52:19 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@digeo.com>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: frlock and barrier discussion
Message-ID: <20030130015219.GT1237@dualathlon.random>
References: <1043797341.10150.300.camel@dell_ss3.pdx.osdl.net> <20030128230639.A17385@twiddle.net> <1043889355.10153.571.camel@dell_ss3.pdx.osdl.net> <20030129174133.A19912@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030129174133.A19912@twiddle.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2003 at 05:41:33PM -0800, Richard Henderson wrote:
> 	//begin
> 	t1 = rw->pre_sequence
> 	t1 += 1
> 	rw->pre_sequence = t1
> 	wmb()
> 
> 	//stuff
> 	xtimensec = xtime.tv_nsec
> 
> 	//end
> 	wmb()
> 	t2 = rw->post_sequence
> 	t2 += 1
> 	rw->post_sequence = t2
> 
> is
> 
> 	t1 = rw->pre_sequence
> 	t2 = rw->post_sequence
> 	xtimensec = xtime.tv_nsec
> 	t1 += 1;
> 	t2 += 2;
> 	rw->pre_sequence = t1
> 	wmb()
> 	wmb()
> 	rw->post_sequence = t2

No it's:


 	t1 = rw->pre_sequence
 	t2 = rw->post_sequence
 	t1 += 1;
 	t2 += 2;
 	rw->pre_sequence = t1
 	wmb()
 	xtimensec = xtime.tv_nsec
 	wmb()
 	rw->post_sequence = t2

you're missing xtimensec is a write.

or this if you prefer:

	spin_lock() / now xtime can't change under us

 	t1 = rw->pre_sequence
 	t2 = rw->post_sequence
	t3 = xtime.tv_nsec
 	t1 += 1;
 	t2 += 2;
 	rw->pre_sequence = t1
 	wmb()
 	xtimensec = t3
 	wmb()
 	rw->post_sequence = t2

	spin_unlock() / now xtime can change again


and the above is the optimal implementation of the write-side. We
definitely don't want to forbid those reoderings. if gcc or cpu thinks
it's worthwhile they must be allowed to optimize it since it's legal.


I believe wmb() is correct, and mb() is overkill.

Andrea
