Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWDVVOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWDVVOz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDVVOz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:14:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:9691 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751213AbWDVVOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:14:54 -0400
Date: Fri, 21 Apr 2006 19:06:23 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Albert Cahalan <acahalan@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: gcc stack problem
In-Reply-To: <787b0d920604211807l2b08dd31h8bcc36bdea1e4379@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0604211823160.3701@g5.osdl.org>
References: <787b0d920604211807l2b08dd31h8bcc36bdea1e4379@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Apr 2006, Albert Cahalan wrote:
>
> I reported that problem involving asmlinkage and prevent_tail_call.

It's been discussed before, although I cannot for the life of me come up 
with the right magic query for google to find it ;(

Btw, the "prevent_tail_call()" thing is really badly named. It does 
exactly what it says, but the problem isn't even really fundamentally 
tailcalls, that just is the deail that happens to trigger the problem (but 
I could imagine other situations triggering it _too_, which is why the 
naming is bad).

We don't actually care about tailcalls (they're absolutely _fine_, if the 
tailcall arguments are all in registers, not overwriting the caller 
stack-frame), so "prevent_tail_call()" really talks about the wrong thing. 

In other words, it's too tightly coupled to an implementation issue, not 
to the more fundamental _conceptual_ issue, which is that the caller owns 
the stackframe at that point.

> I hope I got the details right. Here it is:
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=27234
> 
> Note comment #3, suggesting that following the ABI would
> be a better way to write the assembly.

Sure, we could just do a slower system call entry. We always knew that. 

Suggesting that as the solution is pretty stupid, though. That's _the_ 
most timing-critical part in the whole kernel on many loads. We've 
literally spent time trying to remove single cycles there, and it matters. 

I'd much rather have an officially sanctioned way to do what Linux wants 
to do, but in the meantime, we can (and are forced to) rely on hacks like 
"prevent_tail_call()". They are hacks, and we _know_ they are hacks, but 
as long as gcc maintainers don't want to help us, we don't have much 
choice (although we could perhaps make the hacks a bit nicer ;).

The fact is, the "official ABI" simply isn't appropriate. In fact, we 
don't use the "official ABI" _anywhere_ in the kernel any more, since we 
actually end up using other gcc calling conventions (ie regparm=3).

Btw, this is not even unusual. A lot of embedded platforms have support 
for magic exception/interrupt calling conventions. Gcc even supports them: 
things like "__attribute__((interrupt))". This is also exactly analogous 
to stdcall/cdecl/regparm/longcall/naked/sp_switch/trap_exit etc 
attributes.

So gcc already has support for the fact that people sometimes need special 
calling conventions. We've historically worked around it by hand instead, 
since our calling convention is very _close_ to the standard one

In fact, the calling convention we want there is _so_ close to the 
standard one, that I'm not even convinced the i386 ABI really says that 
the callee owns the parameter space - it may well be a local gcc decision 
rather than any "official i386 ABI" issue.

Btw, we don't even need a real attribute. That would be the cleanest and 
easiest way by far, but the hack mostly works, and I'd be more than 
happy to just perhaps clean up the hacky "do it by hand" thing a bit.

For example, I've considered replacing the ugly "prevent_tail_call()" with 
a slightly different macro that talks less about tailcalls, and talks 
more about the ABI we want:

	static inline long system_call_ret(long retval, void *arg)
	{
		asm("":
			"=r" (retval),
			"+m" (*(struct pt_regs *)arg)
			:"0" (retval));
		return retval;
	}

	#ifdef __x86__
	#define sys_return(x, arg1) \
		return system_call_ret((x), &(arg1))
	#else
	define sys_return(x, arg1) \
		return (x)
	#endif

where we'd make it extra clear that on x86 we're still _using_ the memory 
pointed to by "arg1" when we return (so that any other strange gcc 
optimization would also be kept from touching the call frame, not just 
tailcalls).

That said, I'd much rather have a real gcc attribute. I don't _like_ 
having horrible hacks like the above to make gcc do what I want it to do. 
And I know the gcc developers don't like it either when I force gcc to be 
my biatch. It would be much better for everybody if gcc helped a bit.

		Linus
