Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263352AbUCTKte (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 05:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263351AbUCTKtX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 05:49:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:9871 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S263363AbUCTKtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 05:49:05 -0500
Date: Sat, 20 Mar 2004 10:48:18 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Robert Love <rml@ximian.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       mjy@geizhals.at, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_PREEMPT and server workloads
Message-ID: <20040320104818.GC10398@mail.shareable.org>
References: <40591EC1.1060204@geizhals.at> <20040318060358.GC29530@dualathlon.random> <20040318015004.227fddfb.akpm@osdl.org> <20040318145129.GA2246@dualathlon.random> <1079632130.6043.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1079632130.6043.6.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> This is because of work Dave Miller and Ingo did - irq count, softirq
> count, and lock count (when PREEMPT=y) are unified into preempt_count. 

(x86 only) Have you considerd unifying the "interrupts disabled" bit
into it as well, for spin_lock_irqsave/spin_unlock_irqrestore?

The principle is to use a memory bit or counter instead of "cli" and
"sti", because it is cheaper or even free when it's unified in
preempt_count.

The very first instructions of the interrupt handlers check
preempt_count, and if interrupts are logically disabled they modify
preempt_count to indicate that an irq is pending, save the interrupt
vector number, and return keeping interrupts disabled at the CPU level
(i.e. not using "iret").  Only one vector can be pending in this way,
because we keep CPU interrupts disabled after the first one.

In spin_unlock_irqrestore, it checks preempt_count (as it already
does), and in the slow path if there's an irq pending, calls the
handler for that irq as if it were invoked by the CPU.

That should effectively eliminate the "cli" and "sti" isnructions
from spin_lock_irqsave and spin_unlock_irqrestore, saving a few cycles.

-- Jamie
