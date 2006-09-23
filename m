Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIWEgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIWEgG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 00:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbWIWEgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 00:36:06 -0400
Received: from ozlabs.org ([203.10.76.45]:49035 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750808AbWIWEgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 00:36:04 -0400
Subject: Re: [PATCH 2/7]
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andi Kleen <ak@muc.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
In-Reply-To: <451462B0.8000709@goop.org>
References: <1158925861.26261.3.camel@localhost.localdomain>
	 <1158925997.26261.6.camel@localhost.localdomain>
	 <1158926106.26261.8.camel@localhost.localdomain>
	 <451462B0.8000709@goop.org>
Content-Type: text/plain
Date: Sat, 23 Sep 2006 14:36:01 +1000
Message-Id: <1158986162.26261.66.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-22 at 15:24 -0700, Jeremy Fitzhardinge wrote:
> Rusty Russell wrote:
> > This patch implements save/restore of %gs in the kernel, so it can be
> > used for per-cpu data.  This is not cheap, and we do it for UP as well
> > as SMP, which is stupid.  Benchmarks, anyone?
> >   
> I measured the cost as adding 9 cycles to a null syscall on my Core Duo 
> machine.  I have not explicitly measured it on other machines, but I run 
> a number of other segment save/load tests on a wide range of machines, 
> and didn't find much variability.

Oh, OK!  I had a belief that segment loading was expensive, perhaps I'm
off-base here.

> I think saving/restoring %gs will still be necessary. There are a number 
> of places in the kernel which expect to find the usermode %gs on the 
> kernel stack frame, including context switch, ptrace, vm86, signal 
> context, and maybe something else.  If you don't save it on the stack, 
> then you need to have UP variations of %gs handling in all those other 
> places, which is pretty messy.  Also, unless you want to have two 
> definitions of struct_pt regs (which would add even more mess into 
> ptrace), you'd still need to sub/add %esp in entry.S to skip over the 
> %gs hole.  I don't think this UP microoptimisation would be worth enough 
> to justify the mess it would cause elsewhere.
> 
> How does this version of the patch differ from mine?  Is it just my 
> patch+Ingo's fix, or are there other changes?  I couldn't see anything 
> from a quick read-over.

Yep, no substative changes.  s/__KERNEL_PDA/__KERNEL_PERCPU/, plus your
version had a "write_pda(pcurrent, next_p)" inserted in process.c's
__switch_to which belonged in a successor patch...

Thanks!
Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

