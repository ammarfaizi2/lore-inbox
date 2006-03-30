Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbWC3H0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbWC3H0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 02:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWC3H0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 02:26:09 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:20153 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751068AbWC3H0I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 02:26:08 -0500
Date: Thu, 30 Mar 2006 09:23:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, emin ak <eminak71@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rt10 crash on ppc
Message-ID: <20060330072339.GB3941@elte.hu>
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com> <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com> <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu> <442B4890.6000905@yahoo.com.au> <20060330071322.GA3137@elte.hu> <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Kumar Gala <galak@kernel.crashing.org> wrote:

> The issue me actually be a driver interrupt locking bug.  The driver 
> supports three distinct interrupts for TX, RX, Error.  I asked Emin to 
> try changing the driver to use SA_INTERRUPT in the request_irq() to 
> see what happens.  I believe that when he did that it worked but hurts 
> performance.

this is the -rt kernel, with PREEMPT_RT enabled, so SA_INTERRUPT should 
make no difference. All interrupts are executed by their interrupt 
thread, and are fully preemptible:

fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
                                struct irqaction *action)
{
        int ret, retval = 0, status = 0;

        /*
         * Unconditionally enable interrupts for threaded
         * IRQ handlers:
         */
        if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
                local_irq_enable();

i.e. SA_INTERRUPT should have no effect.

	Ingo
