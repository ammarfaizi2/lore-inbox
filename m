Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751343AbWC3KZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbWC3KZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWC3KZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:25:38 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:9992 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751344AbWC3KZh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:25:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hRlKEO5kEJHs5X/XH4YJ25EuMsOhGKWLCdcqPgY2iEvIxxl/SpzwLMrPNzVGGnqD9PyEHwzFNMsblrX7Aa/RsX/dOiXFtV0Z817J97LjMY6xb7VECq9Y0DADOTYnPzCHdeCBvgSpjoseT+Rttz/w2GUACYXFegERLaL+s8OWpS0=
Message-ID: <2cf1ee820603300225x3c5a6f98qe8bdda1023f0d74f@mail.gmail.com>
Date: Thu, 30 Mar 2006 13:25:35 +0300
From: "emin ak" <eminak71@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.16-rt10 crash on ppc
Cc: "Kumar Gala" <galak@kernel.crashing.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20060330072339.GB3941@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cf1ee820603270656w6697778ai83935217ea5ab3a5@mail.gmail.com>
	 <2cf1ee820603271231l69187925j3150098097c7ca15@mail.gmail.com>
	 <44288FB3.5030208@yahoo.com.au> <20060329150815.GA24741@elte.hu>
	 <442B4890.6000905@yahoo.com.au> <20060330071322.GA3137@elte.hu>
	 <F86880BD-2EE9-4078-AB28-F769EF507C3B@kernel.crashing.org>
	 <20060330072339.GB3941@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soryy fot the late answer. I have change the driver to use
SA_INTERRUPT, OOM messages disappeared but the ethernet
throughput decreased significantly as Kumar said before(90MBit for
1518Byte packet, and throughput without the patch is
about 900Bits) and the system can't manage load
balancing between to interfaces,the system acts like
the priorty of tsec0 (eth0) is higher then tsec1 because of
this, under heavy load on tsec0 blocks packet receiving
on tsec1 (eth1). And also I have tried Nick solution, increased
/proc/sys/vm/min_free_kbytes to 10MB, the result did'nt changed, OOM
messages was repeated again.
I'll try Ingo patch immediately and and report you the results.
Thanks.
Emin


2006/3/30, Ingo Molnar <mingo@elte.hu>:
>
> * Kumar Gala <galak@kernel.crashing.org> wrote:
>
> > The issue me actually be a driver interrupt locking bug.  The driver
> > supports three distinct interrupts for TX, RX, Error.  I asked Emin to
> > try changing the driver to use SA_INTERRUPT in the request_irq() to
> > see what happens.  I believe that when he did that it worked but hurts
> > performance.
>
> this is the -rt kernel, with PREEMPT_RT enabled, so SA_INTERRUPT should
> make no difference. All interrupts are executed by their interrupt
> thread, and are fully preemptible:
>
> fastcall int handle_IRQ_event(unsigned int irq, struct pt_regs *regs,
>                                struct irqaction *action)
> {
>        int ret, retval = 0, status = 0;
>
>        /*
>         * Unconditionally enable interrupts for threaded
>         * IRQ handlers:
>         */
>        if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
>                local_irq_enable();
>
> i.e. SA_INTERRUPT should have no effect.
>
>        Ingo
>
