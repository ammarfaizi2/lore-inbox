Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754305AbWKNEW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754305AbWKNEW0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 23:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755237AbWKNEW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 23:22:26 -0500
Received: from twinlark.arctic.org ([207.7.145.18]:9954 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id S1754305AbWKNEWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 23:22:25 -0500
Date: Mon, 13 Nov 2006 20:22:25 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Andi Kleen <ak@suse.de>
cc: Suleiman Souhlal <ssouhlal@freebsd.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>, vojtech@suse.cz,
       Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH 1/2] Make the TSC safe to be used by gettimeofday().
In-Reply-To: <Pine.LNX.4.64.0611131908060.28562@twinlark.arctic.org>
Message-ID: <Pine.LNX.4.64.0611132015240.28562@twinlark.arctic.org>
References: <455916A5.2030402@FreeBSD.org> <200611140305.00383.ak@suse.de>
 <45592929.2000606@FreeBSD.org> <200611140344.00407.ak@suse.de>
 <Pine.LNX.4.64.0611131908060.28562@twinlark.arctic.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2006, dean gaudet wrote:

> next an implementation which relies on the kernel restarting the computation when
> necessary.  this would be achieved by testing to see when the task to be restarted
> is on the vsyscall page and backtracking the task to the vsyscall entry point.
> 
> this is challenging when the vsyscall is implemented in C -- because of potential
> stack usage.  there are ways to get this to work though, even without resorting to
> assembly.  i'm presenting this only as a best case scenario should such an effort
> be undertaken.  (i have a crazy idea involving the direction flag which i need to
> mock up.)

nevermind the crazy idea using DF... i was hoping to use DF as a generic 
"restart a vsyscall" indicator -- switch_to() would note the task is on 
the vsyscall page and unilaterally clear DF before restoring eflags.

then a vsyscall critical section could be surrounded like so:

	unsigned long tmp;
	do {
		asm volatile("std");

		critical section

		asm volatile(
			"\n	pushf"
			"\n	pop %0"
			"\n	cld"
			: "=r" (tmp));
	} while ((tmp & 0x400) == 0);

it works great on k8 ... but DF manipulation hurts way too much on core2 and p4.

i even tried reading DF using a string instruction:

	long tmp;
	do {
		asm volatile("std");

		critical section

		asm volatile(
			"\n	mov %%rsp,%%rsi"
			"\n	lodsl"
			"\n	sub %%rsp,%%rsi"
			"\n	cld"
			: "=S" (tmp));
	} while (tmp > 0);

it's no better.

i've also tried similar tricks setting the EFLAGS.ID bit... but the popf
hurts in that case.

i think a general vsyscall restart mechanism would be useful (for more
than just the time functions), but still haven't found one which is
cheap enough.

-dean
