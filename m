Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263756AbUEXAEp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUEXAEp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:04:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUEXAEp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:04:45 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55711 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263756AbUEXAEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:04:43 -0400
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm5
References: <1YAd2-6Th-13@gated-at.bofh.it> <1YPF4-2hJ-11@gated-at.bofh.it>
	<1YPOI-2nq-1@gated-at.bofh.it> <1YRdQ-3pu-5@gated-at.bofh.it>
	<m3r7tbtlrk.fsf@averell.firstfloor.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 May 2004 18:02:50 -0600
In-Reply-To: <m3r7tbtlrk.fsf@averell.firstfloor.org>
Message-ID: <m1wu32n13p.fsf@ebiederm.dsl.xmission.com>
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

Thinking about this some more, I would need to transform every
preempt_disable() into a local_irq_disable() if I wanted to save
the FP registers to their home in struct task.

It looks to me like the only way to handle all of the x87 and mmx 
subtleties is to call fsave which takes 108 bytes.  That is a lot of
stack bytes to eat in irq context, and I suspect it is time consuming,
as well.

So I suspect it makes most sense just submit a patch for a sse version
of writeq on x86, and let the drivers that care use that.   It does
mean that the drivers that care can't build for pre PentiumIII
hardware or must use a work around in generic kernels.  So far the
cure for that looks much worse than the disease.

Eric
