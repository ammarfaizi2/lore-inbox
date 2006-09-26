Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751871AbWIZBCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbWIZBCP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 21:02:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751874AbWIZBCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 21:02:14 -0400
Received: from gw.goop.org ([64.81.55.164]:56996 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751871AbWIZBCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 21:02:13 -0400
Message-ID: <45187C0E.1080601@goop.org>
Date: Mon, 25 Sep 2006 18:02:06 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Mathieu Desnoyers <compudj@krystal.dyndns.org>
CC: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
       Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, prasanna@in.ibm.com,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Paul Mundt <lethal@linux-sh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Tom Zanussi <zanussi@us.ibm.com>,
       Richard J Moore <richardj_moore@uk.ibm.com>,
       Michel Dagenais <michel.dagenais@polymtl.ca>,
       Christoph Hellwig <hch@infradead.org>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Thomas Gleixner <tglx@linutronix.de>, William Cohen <wcohen@redhat.com>,
       ltt-dev@shafik.org, systemtap@sources.redhat.com,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Karim Yaghmour <karim@opersys.com>,
       Pavel Machek <pavel@suse.cz>, Joe Perches <joe@perches.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>,
       "Jose R. Santos" <jrs@us.ibm.com>
Subject: Re: [PATCH] Linux Kernel Markers 0.13 for 2.6.17
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal>
In-Reply-To: <20060926004535.GA2978@Krystal>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers wrote:
> To protect code from being preempted, the macros preempt_disable and
> preempt_enable must normally be used. Logically, this macro must make sure gcc
> doesn't interleave preemptible code and non-preemptible code.
>   

No, it only needs to prevent globally visible side-effects from being 
moved into/out of preemptable blocks.  In practice that means memory 
updates (including the implicit ones that calls to external functions 
are assumed to make).

> Which makes me think that if I put barriers around my asm, call, asm trio, no
> other code will be interleaved. Is it right ?
>   

No global side effects, but code with local side effects could be moved 
around without changing the meaning of preempt.

For example:

	int foo;
	extern int global;

	foo = some_function();

	foo += 42;

	preempt_disable();
	// stuff
	preempt_enable();

	global = foo;
	foo += other_thing();

Assume here that some_function and other_function are extern, and so gcc 
has no insight into their behaviour and therefore conservatively assumes 
they have global side-effects.

The memory barriers in preempt_disable/enable will prevent gcc from 
moving any of the function calls into the non-preemptable region. But 
because "foo" is local and isn't visible to any other code, there's no 
reason why the "foo += 42" couldn't move into the preempt region.  
Likewise, the assignment to "global" can't move out of the range between 
the preempt_enable and the call to other_thing().

So in your case, if your equivalent of the non-preemptable block is the 
call to the marker function, then there's a good chance that the 
compiler might decide to move some other code in there.

Now it might be possible to take the addresses of labels to inhibit code 
motion into a particular range:

	{
		__label__ before, after;
		asm volatile("" : : "m" (*&&before), "m" (*&&after));	// gcc can't know what we're doing with the labels

	before:	;
		// stuff
	after:	;
	}

but that might be risky for several reasons: I don't know of any 
particular promises gcc makes in this circumstance; I suspect taking the 
address of a label will have a pretty severe inhibition on what 
optimisations gcc's is willing to use (it may prevent inlining 
altogether); and this looks pretty unusual, so there could be bugs.

    J
