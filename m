Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSGGVI5>; Sun, 7 Jul 2002 17:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSGGVI4>; Sun, 7 Jul 2002 17:08:56 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:13285 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S316578AbSGGVIz>; Sun, 7 Jul 2002 17:08:55 -0400
Date: Sun, 7 Jul 2002 22:09:34 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Werner Almesberger <wa@almesberger.net>
Cc: Bill Davidsen <davidsen@tmr.com>, Keith Owens <kaos@ocs.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [OKS] Module removal
Message-ID: <20020707220933.B11999@kushida.apsleyroad.org>
References: <20020702133658.I2295@almesberger.net> <Pine.LNX.3.96.1020704000434.2248F-100000@gatekeeper.tmr.com> <20020704032929.N2295@almesberger.net> <20020704035012.O2295@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020704035012.O2295@almesberger.net>; from wa@almesberger.net on Thu, Jul 04, 2002 at 03:50:12AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> Okay, here's an almost correct example (except for the usual
> return-after-removal, plus an unlikely data race described
> below). foo_1 runs first:

This can be fixed if we assume a way to ask "is any CPU still executing
module code?".

To do this, have the `free_module' function use `smp_call_function' to
ask every CPU "are you executing code for module XXX?".  The question is
answered by a routine which walks the stack, checking the instruction
pointer at each place on the stack to see whether it's inside the module
of interest.

Yes this is complex, but it's not that complex -- provided you can rely
on stack walking to find the module.  (It wouldn't work if x86 used
-fomit-frame-pointer, for example).

So module removal works like this:

	int free_module(...)
	{
		/* ...stuff... */
		if (module->uc.usecount != 0)
			return -EAGAIN;
		if (smp_call_function (check_if_in_module, module, 1, 1))
			return -EGAIN;

		/* remove module. */
	}

Admittedly, this _only_ deals with this particular class of race
conditions.

Another possibility would be the RCU thing: execute the module's exit
function, but keep the module's memory allocated until some safe
scheduling point later, when you are sure that no CPU can possibly be
running the module.

These don't help at all with races against parallel opens -- food for
thought, though.

-- Jamie
