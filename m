Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263770AbUEXA1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263770AbUEXA1x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 20:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUEXA1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 20:27:53 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:64143 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263770AbUEXA1w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 20:27:52 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 23 May 2004 17:27:17 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: scheduler: IRQs disabled over context switches
In-Reply-To: <20040524003308.B4818@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0405231635300.512@bigblue.dev.mdolabs.com>
References: <20040523174359.A21153@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0405231125420.512@bigblue.dev.mdolabs.com>
 <20040523203814.C21153@flint.arm.linux.org.uk>
 <Pine.LNX.4.58.0405231241450.512@bigblue.dev.mdolabs.com>
 <20040524003308.B4818@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Russell King wrote:

> On Sun, May 23, 2004 at 04:04:39PM -0700, Davide Libenzi wrote:
> > On Sun, 23 May 2004, Russell King wrote:
> > > Not quite - look harder.  They use spin_unlock_irq in finish_arch_switch
> > > rather than prepare_arch_switch.
> > 
> > Hmm, they do indeed. Hmm, if we release the rq lock before the ctx switch, 
> > "prev" (the real one) will result not running since we already set 
> > "rq->curr" to "next" (and we do not hold "prev->switch_lock").
> 
> We do hold prev->switch_lock - we hold it all the time that the thread
> is running.  Consider what prepare_arch_switch() is doing - it's taking
> the next threads switch_lock.  It only gets released _after_ we've
> switched away from that thread.

It is flawed indeed :) (/me looking at it after ages). Even looking at the 
scheduler tick code, it does not play with mm fields, so it should be fine 
after the rq lock (and IRQ) release. Preempt is fine due to the preempt_disable()
(plus switch_lock held), tasks result running (due switch_lock held) so 
remote CPUs won't touch them, and scheduler_tick() looking innocuous with 
respect to the fields that matters for switch. Is it blowing up on ARM?



- Davide

