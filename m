Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262348AbVCPKqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbVCPKqv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 05:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVCPKqv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 05:46:51 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:19041
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S262356AbVCPKqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 05:46:21 -0500
Date: Wed, 16 Mar 2005 11:46:18 +0100
From: Andrea Arcangeli <andrea@cpushare.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [-mm patch] seccomp: don't say it was more or less mandatory
Message-ID: <20050316104618.GB11192@opteron.random>
References: <20050301003247.GY4021@stusta.de> <20050301004449.GV8880@opteron.random> <20050303145147.GX4608@stusta.de> <20050303135556.5fae2317.akpm@osdl.org> <20050315100903.GA32198@elte.hu> <20050315112712.GA3497@elte.hu> <20050315130046.GK7699@opteron.random> <20050315150526.GA14744@elte.hu> <20050315164420.GT7699@opteron.random> <20050316082851.GB10260@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316082851.GB10260@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 09:28:51AM +0100, Ingo Molnar wrote:
> in fact, we had bugs on x86 where if userspace set up a specific value
> for %ebx the kernel would crash, because the irq entry code was
> incorrect. (this might even have been exploitable) So yes, if seccomp
> would be backported to that kernel, seccomp would be vulnerable too.

You said "might have been", so you should as well say "might be
vulnerable" too. Either you go check and you prove it exploitable or you
cannot say it would be vulnerable.

I've never heard of this %ebx bug that could be exploitable from my part.

I'm aware of several DoS but they're not really a problem since they can
even be autodetected.

> 'provable' here means provable mathematically, as done in computer
> science. Not 'provable via good track record'. So what i said was in
> fact a compliment towards seccomp: i believe that as long as we assume
> certain external mechanisms (the whole hardware environment, and all
> irq/rest-of-kernel and read/write mechanisms) to be secure, the basic
> seccomp code itself (those 100-200 lines of code), _may_ be provably
> secure, mathematically. That would be a nice thing to have.

The hardware is not provable mathematically anyway, javascript is not
provable mathematically anyway, JVM security for java applets is not
provable mathematically anyway, jpeg decompression is not provable
methematically anyway, gzip decompression is not provable mathematically
anyway, a mail client decoding mime attachments is not provable
mathematically anyway, the ip_conntrack code of the firewall is not
provable anwyay, the ipsec stack is not math provable anyway, the
compiler that compiled the source is not provale mathematically anyway,
the tcp/ip stack is not provable mathematically anyway, I can go on
forever.

The thing I care about is that seccomp is much more provable than the
above and more provable than ptrace as well. Go ahead and disagree with
this bold statement if you can.

> obviously the irq and sys_read/sys_write code is way too complex to be
> mathematically provable in the near future.

Math provable is irrelevant with real software world since nobody has
enough resources to demonstrate math correctness.

The only places where they truly do the math-provable thing is for the
software avoding airplane mid air collisions or problems with a very
limited scope, where it's simple enough that it's actually possible to
prove it (i.e. obviously no real OS like linux, no paging and perhaps
simpler compiler as well).

> sorry, but if an attacker can cause arbitrary signals to be sent to your
> secure application (and the signals pass the security checks!) then you
> have much bigger problems!

It's not the attacker that sends the signal! It's a buggy application
coming from the CDs, like a videogame hitting a bug.

Like kill(-1, SIGCONT) because the fork failed and for some reason the
pid was set to -1.

> this is what i feel is unfair: you are (unintentionally, i presume)
> mixing the security of the 'totality of ptrace APIs' with the security
> model that 'untrusted bytecode' is in.

What I want is a model that guarantees me that nothing from userland can
ever un-release the bytecode so that it becomes free to execute in the
system.

After I enable seccomp on the bytecode there's nothing that the user can
do to un-seccomp the task (unless it changes the right bit in /dev/mem,
but that can't be an accident unlike the kill(-1, SIGCONT)!).

This is not possible to achieve with ptrace.

> but, i dont mind your code being in the kernel, for the reasons i
> stated, as long as the anti-ptrace fallacy is clearly understood. So you
> might have partly succeeded in social engineering your security feature
> into the kernel (feel the irony?), but i'm trying to counter what i
> believe to be false premises. Ptrace has its fundamental security
> problems, but PTRACE_TRACE is not nearly as bad and should not be
> confused with the kernel holes caused by other, security-independent
> ptrace debug mechanisms.

You're the one that wants to prove mathematically the code. So you
should be aware that the more code that is involved, the harder it is to
prove it mathematically safe. In real life math provable won't be doable
in our lifetime, but still the auditing of the code will be more
reliable the shorter the code is. All I did with seccomp is to reduce
the amount of code that you want to prove mathematically. Spending any
time to prove mathematically ptrace (or more realistically audit it)
when somebody can change it at anytime would not be a good idea (for the
other parts like read/write/pipe I can't avoid to re-audit, but ptrace
I can definitely avoid to re-audit thanks to seccomp). Plus as shown,
the API is an order of magnitude simpler to use and it's arch
indipendent unlike ptrace, so perhaps I won't be the only one using it,
and non-kernel developers may actually be able to use it too to do
decompression and similar stuff.

If you can't see any benefit for my project in using in seccomp instead
ptrace that's your problem because there are several tangible benefits
that I already mentioned several times. So I'm not answering further
emails to avoid repeating the same things over and over again.
