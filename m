Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUIEBiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUIEBiv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 21:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUIEBiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 21:38:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:27840 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265161AbUIEBis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 21:38:48 -0400
Date: Sat, 4 Sep 2004 18:38:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Jackson <pj@sgi.com>
cc: ak@muc.de, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix argument checking in sched_setaffinity
In-Reply-To: <20040904180548.2dcdd488.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0409041827280.2331@ppc970.osdl.org>
References: <m3zn4bidlx.fsf@averell.firstfloor.org> <20040831183655.58d784a3.pj@sgi.com>
 <20040904133701.GE33964@muc.de> <20040904171417.67649169.pj@sgi.com>
 <Pine.LNX.4.58.0409041717230.4735@ppc970.osdl.org> <20040904180548.2dcdd488.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 4 Sep 2004, Paul Jackson wrote:
> 
> My understanding of "asking for it" requires at present a user code
> loop, to probe for the size that works.

Yeah, or just make a frigging big area, and asking the kernel for it ;)

Something like

	/* We just assume that 8k CPU's aren't going to happen */
	#define MAX_CPUMASK_BYTES (1024)

	void *cpumask = malloc(MAX_CPUMASK_BYTES);
	int real_size = sched_getaffinity(0, cpumask, MAX_CPUMASK_BYTES);

and no loop needed.

>				  But my user code already does
> that, and the first thing for which I audit any changes to this kernel
> code is not breaking my sizing loop code in user space.

I don't think you can reasonably use the "setaffinity()" call for sizing, 
since that historically just refused to use anything but the exact size. 
Sure, you could loop over every byte value known to man, but it's just a 
lot easier to do the "getaffinity" thing - if it fails, you can double the 
size of your buffer and try again. O(log(n)) rather than O(n) ;)

(And the "just start high enough" approach means that you can basically 
make it O(1) if you don't care about the theoretical possibility of a 
8k-CPU monster machine).

> I'd mildly prefer adding a kernel/user API for explicitly providing the
> two values:
> 
> 	sizeof(cpumask_t)
> 	sizeof(nodemask_t)
> 
> This might help reduce the unending confusions in the user and library
> code sitting on top of us.

I don't know how to sanely expose the damn things. Maybe in the vsyscall 
page or something. Adding YAEAE (yet another ELF aux entry) could be done, 
of course.

> We could two phase this:
>  1) add an obvious way to size these masks, and then
>  2) six months later, require sizes to match in all these calls.

Well, historically we _have_ required sizes to match. You can pass in 
larger sizes to the "get" functions (and they'll tell you how much you 
got), but the "set" functions required the user to know exactly what the 
size was. Which is easy, see above.

		Linus
