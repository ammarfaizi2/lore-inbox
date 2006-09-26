Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWIZDEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWIZDEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 23:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWIZDEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 23:04:41 -0400
Received: from tomts43.bellnexxia.net ([209.226.175.110]:18658 "EHLO
	tomts43-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S1750736AbWIZDEj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 23:04:39 -0400
Date: Mon, 25 Sep 2006 22:59:24 -0400
From: Mathieu Desnoyers <compudj@krystal.dyndns.org>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Martin Bligh <mbligh@google.com>, "Frank Ch. Eigler" <fche@redhat.com>,
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
Message-ID: <20060926025924.GA27366@Krystal>
References: <20060925233349.GA2352@Krystal> <20060925235617.GA3147@Krystal> <45187146.8040302@goop.org> <20060926002551.GA18276@Krystal> <20060926004535.GA2978@Krystal> <45187C0E.1080601@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <45187C0E.1080601@goop.org>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:47:46 up 33 days, 23:56,  1 user,  load average: 0.36, 0.20, 0.12
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First of all, yes, gcc seems not to allow a programmer to jump between asm
labels without painfully verifying everything, as stated in 
http://developer.apple.com/documentation/DeveloperTools/gcc-4.0.1/gcc/Extended-Asm.html
"Speaking of labels, jumps from one asm to another are not supported. The
compiler's optimizers do not know about these jumps, and therefore they
cannot take account of them when deciding how to optimize."

however... (see below)

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Mathieu Desnoyers wrote:
> >To protect code from being preempted, the macros preempt_disable and
> >preempt_enable must normally be used. Logically, this macro must make sure 
> >gcc
> >doesn't interleave preemptible code and non-preemptible code.
> >  
> 
> No, it only needs to prevent globally visible side-effects from being 
> moved into/out of preemptable blocks.  In practice that means memory 
> updates (including the implicit ones that calls to external functions 
> are assumed to make).
> 
> >Which makes me think that if I put barriers around my asm, call, asm trio, 
> >no
> >other code will be interleaved. Is it right ?
> >  
> 
> No global side effects, but code with local side effects could be moved 
> around without changing the meaning of preempt.
> 
> For example:
> 
> 	int foo;
> 	extern int global;
> 
> 	foo = some_function();
> 
> 	foo += 42;
> 
> 	preempt_disable();
> 	// stuff
> 	preempt_enable();
> 
> 	global = foo;
> 	foo += other_thing();
> 
> Assume here that some_function and other_function are extern, and so gcc 
> has no insight into their behaviour and therefore conservatively assumes 
> they have global side-effects.
> 
> The memory barriers in preempt_disable/enable will prevent gcc from 
> moving any of the function calls into the non-preemptable region. But 
> because "foo" is local and isn't visible to any other code, there's no 
> reason why the "foo += 42" couldn't move into the preempt region.  

I am not sure about this last statement. The same reference :
http://developer.apple.com/documentation/DeveloperTools/gcc-4.0.1/gcc/Extended-Asm.html

States :
"If your assembler instructions access memory in an unpredictable fashion,
add memory to the list of clobbered registers. This will cause GCC to not
keep memory values cached in registers across the assembler instruction
and not optimize stores or loads to that memory. You will also want to
add the volatile keyword if the memory affected is not listed in the
inputs or outputs of the asm, as the memory clobber does not count as
a side-effect of the asm. If you know how large the accessed memory is,
you can add it as input or output but if this is not known, you should
add memory.  As an example, if you access ten bytes of a string, you can
use a memory input like:

  {"m"( ({ struct { char x[10]; } *p = (void *)ptr ; *p; }) )} "


I am just wondering how gcc can assume that I will not modify variables on the
stack from within a function with a memory clobber. If I would like to do some
nasty things in my assembly code, like accessing directly to a local variable by
using an offset from the stack pointer, I would expect gcc not to relocate this
local variable around my asm volatile memory clobbered statement, as it falls
under the category "access memory in an unpredictable fashion".

Mathieu

OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
