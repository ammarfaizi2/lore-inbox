Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWIWIz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWIWIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWIWIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:55:58 -0400
Received: from ozlabs.org ([203.10.76.45]:37016 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751256AbWIWIz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:55:57 -0400
Subject: Re: [PATCH 5/7] Use %gs for per-cpu sections in kernel
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>
In-Reply-To: <20060923081755.GB10534@muc.de>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <1158926215.26261.11.camel@localhost.localdomain>
	 <1158926308.26261.14.camel@localhost.localdomain>
	 <1158926386.26261.17.camel@localhost.localdomain>
	 <20060922123215.GA98728@muc.de>
	 <1158987075.26261.79.camel@localhost.localdomain>
	 <20060923081755.GB10534@muc.de>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 18:55:54 +1000
Message-Id: <1159001755.30003.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-09-23 at 10:17 +0200, Andi Kleen wrote:
> > Mainly that it makes more sense to use the existing per-cpu concept than
> > introduce another kind of per-cpu var within a special structure, but
> > it's also more efficient (see other post).  Hopefully it will spark
> 
> What post exactly?  AFAIK it is the same code for common code.
> 
> The advantage of the PDA split is that the important variables which are 
> in the PDA can be accessed with a single reference, while generic portable
> per CPU data is the same as it was before. With your scheme even
> the PDA accesses are at least two instructions, right? (I don't
> think gcc/ld can resolve the per cpu section offset into a constant,
> so it has to load them into a register first) 

No, now normal per-cpu accesses are 2 insn, per-cpu accesses using
arch-specific macros are 1 insn.  ie. it's as if every per-cpu variable
were in the "pda".

Here's the reply to Jeremy's query:

Jeremy says:
> Or is the only percpu benefit you're getting from %gs is a slightly 
> quicker way of getting the percpu_offset?  Does that help much?

In generic code, that's true (the arch-specific accessors can do it in 1
insn, not two).  But it's still a help.  This is __raw_get_cpu_var(x)
before:

   3:   89 e0                   mov    %esp,%eax
   5:   25 00 e0 ff ff          and    $0xffffe000,%eax
   a:   8b 40 08                mov    0x8(%eax),%eax
   d:   8b 04 85 00 00 00 00    mov    0x0(,%eax,4),%eax
                        10: R_386_32    __per_cpu_offset
  14:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
                        16: R_386_32    per_cpu__x

And this is after:

  1f:   65 a1 00 00 00 00       mov    %gs:0x0,%eax
                        21: R_386_32    per_cpu__this_cpu_off
  25:   8b 80 00 00 00 00       mov    0x0(%eax),%eax
                        27: R_386_32    per_cpu__x

So we go from 5 instructions, 23 bytes, 3 memory references, to 2
instructions, 12 bytes, 2 memory references (although the extra mem ref
will almost certainly have been in cache).

> > interest in making dynamic-percpu pointers use the same offset scheme,
> > now x86 will experience the benefits.
> > 
> > And we might even get a third user of local_t!
> 
> I'm not holding my breath. I guess it was a nice idea before preemption
> became popular ...

Well, since Xen doesn't support preemption, perhaps we'll convince
distros to turn it off again? 8)

Sorry for the confusion,
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

