Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263244AbTLOGJS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 01:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTLOGI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 01:08:57 -0500
Received: from dp.samba.org ([66.70.73.150]:58812 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263290AbTLOGIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 01:08:39 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>, Rob Love <rml@tech9.net>
Subject: Re: [DOCUMENTATION] Revised Unreliable Kernel Locking Guide 
In-reply-to: Your message of "Fri, 12 Dec 2003 15:44:01 -0000."
             <20031212154401.GA10584@redhat.com> 
Date: Mon, 15 Dec 2003 13:28:39 +1100
Message-Id: <20031215060838.B7C952C232@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20031212154401.GA10584@redhat.com> you write:
> On Fri, Dec 12, 2003 at 04:24:18PM +1100, Rusty Russell wrote:
>  > OK, I've put the html version up for your reading pleasure: the diff
>  > is quite extensive and hard to read.
>  > 
>  > http://www.kernel.org/pub/linux/kernel/people/rusty/kernel-locking/
>  > 
>  > Feedback welcome,
> 
> Hi Rusty,
>  Might be worth mentioning in the Per-CPU data section that code doing
> operations on CPU registers (MSRs and the like) needs to be protected
> by an explicit preempt_disable() / preempt_enable() pair if it's doing
> operations that it expects to run on a specific CPU.
> 
> For examples, see arch/i386/kernel/msr.c & cpuid.c

I don't think it belongs in per-cpu data, that's a bit disingenous.
It's a separate section by itself, I think.  But it's also fairly
rare.

The smp_call_function() case is more subtle, but in fact, there are
only two calls to smp_call_function in non-arch-specific code, and
both are wrong:

mm/slab.c: smp_call_function_all_cpus() should just be on_each_cpu.

net/core/flow.c: This should also be on_each_cpu: I actually have a
		 patch for this, too.

The aim of this document is to give the reader an overview core
techniques, not describe every possible variant.  IMHO a more likely
candidate for a section would be atomic_dec_and_lock(), which there is
no real concept of an "owner" of an object, but the destroy is
implicit (and atomic) by the last user.

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
