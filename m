Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBXC4E>; Sat, 23 Feb 2002 21:56:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289278AbSBXCz6>; Sat, 23 Feb 2002 21:55:58 -0500
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:17283 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S289255AbSBXCzp>; Sat, 23 Feb 2002 21:55:45 -0500
Date: Sat, 23 Feb 2002 18:55:29 -0800
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Pete Zaitcev <zaitcev@redhat.com>, Keith Owens <kaos@ocs.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] C exceptions in kernel
Message-ID: <20020224025529.GA4585@gnuppy.monkey.org>
In-Reply-To: <20020223235051.GA2412@gnuppy.monkey.org> <Pine.LNX.4.44.0202231708080.1035-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202231708080.1035-100000@blue1.dev.mcafeelabs.com>
User-Agent: Mutt/1.3.27i
From: Bill Huey <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2002 at 05:31:33PM -0800, Davide Libenzi wrote:
> You can't do that w/out an integrated resource allocation/deallocation
> system. This because real code ends up by allocating resources ( or doing
> whatever operation that needs an undo ) during its path and if you do not
> have an automatic resource deallocation you're going to leak resources
> more than Harleys engine oil. So w/out such system you've to catch
> exceptions at every level where you actually own resources with the code
> that is likely->surely to be way worse than the kernel gotos. Where you're

It's a different attitude to doing recoverable systems. I can't fault
nor praise it because I've never used a system like that.

> going to save is in cases where your code does not allocate any resource (
> book's code ) and here you save the cost of multiple unwinding 'return's
> against a single catch link. So, in case that an exception happen ( very

Right, not many systems inside a kernel are the kind that you need a
sophisticated resource allocation/deallocation system except for, maybe,
FSes and possibly long chains of IO operations. I'm not sure what else would
fit in this category, but it's generally counter to the coding attitude
in Unix.

The things that exception would work well for seem to typically be modular
and can function independently from other subsystems in the kernel. Unix, on
the other hand, is pretty tightly interconnected so each subsystem's state is
some what dependent on the others, which can be unwieldly or impossible to
unwind properly.

It's almost the same kind of design style issue as the classic dead lock
problem. Some OSs provide a facility to detect those circular allocation,
but others just bail on that heavy weight idea and make it intrinsic to the
system that dead locks shouldn't exist in the first place. Both solutions have
their advantages, but Unix prefers the latter and it seems to lead to a
much snappier system from my intuition of it.

> low probability compared to the common path ) and in case your code
> underneath the catch point does not own resources, you're going to have a
> 'little' advantage. What is the cost ? You're going to push onto the
> common path the exception code by slowing down the CPU's fast path.

Not sure, memory allocators are typically pretty primitive relative to
modern GCs. I guess you could apply generational techniques to memory
allocation (stack allocation of objects typical) and have it run pretty
fast, but certainly not as fast as the typical hotwired C path.

It's not the only resource that might need to be unwound. Like what do you do
about IO system commits ? I'm not sure here.

Just bored and babbling here. ;-)

bill

