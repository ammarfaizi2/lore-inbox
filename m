Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263623AbUEWVea@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263623AbUEWVea (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 17:34:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbUEWVe3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 17:34:29 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:21151 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263623AbUEWVeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 17:34:18 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <1YAd2-6Th-13@gated-at.bofh.it> <1YPF4-2hJ-11@gated-at.bofh.it>
	<1YPOI-2nq-1@gated-at.bofh.it> <1YRdQ-3pu-5@gated-at.bofh.it>
	<m3r7tbtlrk.fsf@averell.firstfloor.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 May 2004 15:32:48 -0600
In-Reply-To: <m3r7tbtlrk.fsf@averell.firstfloor.org>
Message-ID: <m11xlarfr3.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > Currently I know of a safe version that will work on x86 on processors
> > with sse support.   And I how to generate 64bit I/O cycles with using
> > mmx or x87 registers,  but don't know if I can write code that touches
> > the FPU registers that is interrupt safe.
> 
> As long as you save/restore cr0 and the FPU registers and do clts
> interrupts are not a problem.  In fact interrupts are even easier that
> process context, where you need preempt_disable().

The saving and restoring is where things are looking icky.

It does not look like that kernel_fpu_begin() will work safely in
an interrupt context.

The generic x86 variant is to do:

fild
fistp

Which works for 64bit values because the floating point registers
have a 64bit mantissa.

I suppose I could unconditionally save the x87 floating point registers
to a local variable, but that sounds like a terribly expensive operation.
At least with kernel_fpu_begin() the floating point save only
needs to happen once, per context switch.

With SSE it is easy to save just a single register.  For the x87 I don't
see how to do that.  Beyond the stack based nature of the x87 there is
the question if the registers are in mmx mode or not.

I guess a conservative always correct version would be a place to start.

Eric
