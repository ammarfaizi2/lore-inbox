Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWCNInT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWCNInT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 03:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752028AbWCNInS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 03:43:18 -0500
Received: from fsmlabs.com ([168.103.115.128]:62369 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S1751854AbWCNInS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 03:43:18 -0500
X-ASG-Debug-ID: 1142325794-8974-71-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 14 Mar 2006 00:47:32 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Zachary Amsden <zach@vmware.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: VMI Interface Proposal Documentation for I386, Part 5
Subject: Re: VMI Interface Proposal Documentation for I386, Part 5
In-Reply-To: <44167E03.3060807@vmware.com>
Message-ID: <Pine.LNX.4.64.0603140040230.11606@montezuma.fsmlabs.com>
References: <4415CE76.9030006@vmware.com> <Pine.LNX.4.64.0603132328270.11606@montezuma.fsmlabs.com>
 <44167E03.3060807@vmware.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.9729
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zach,

On Tue, 14 Mar 2006, Zachary Amsden wrote:

> It could be possible to change the semantics of the interrupt masking
> interface in Linux, such that enable_interrupts() did just that - but did not
> yet deliver pending IRQs.  As did restore_interrupt_mask().  This would
> require inspection of many drivers to ensure that they don't rely on those
> actions causing immediate interrupt delivery.  And if they did, they would
> require a call, say, deliver_pending_irqs() to accomplish that.

I think we can break these down into low level and higher level interrupt 
enabling. Lower level tends to be call sites like exception entry, in that 
particular case drivers aren't aware of the interrupt enable/disable 
semantics so it's safe to enable without dispatch. Higher up is where 
dispatch makes sense and we can closer mimick hardware.

> Is this a nice interface for Linux?  Probably not.  In fact, requiring source
> inspection of all drivers just for this would be a gargantuan task, as well as
> being difficult to maintain.  Perhaps, it may have some benefit - one ideology
> is that drivers should not in general require the ability to enable and
> receive interrupts immediately.  Otherwise, they are dependent on hardware
> responses to continue operation, which means they are probably not fault
> tolerant / recoverable.  But many drivers have been written this way.

The aforementioned should allow us not to have to do a driver audit.

> The motivation here is entirely selfish.  Emulating the CPU by unquestioning
> delivery of interrupts is a fine course of action - but it does impose a
> slight overhead.  You first have to determine if there are any interrupts /
> callbacks / upcalls to be serviced.  This is not something you can do in one
> instruction, and moreover, you may have to deal with race conditions in
> determining whether or not any actions are pending.  So there is a measurable
> benefit, when running in a virtual machine, to separate the required delivery
> or interrupts with the enabling of them.
> 
> That is why I think it warrants discussion on the principles, although I am
> not sure that it is practical.

I believe it certainly is worth seperating and would help in the iret, in 
that you could enable interrupts without recursing again.

Thanks,
	Zwane

