Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965205AbWIRNwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965205AbWIRNwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 09:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965213AbWIRNwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 09:52:30 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:64711 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S965205AbWIRNw3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 09:52:29 -0400
Date: Mon, 18 Sep 2006 19:22:08 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>,
       Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-ID: <20060918135208.GA6662@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu> <20060916204342.GA5208@elte.hu> <20060916155657.a233b54d.akpm@osdl.org> <20060916233038.GC23132@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916233038.GC23132@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 17, 2006 at 01:30:38AM +0200, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > On Sat, 16 Sep 2006 22:43:42 +0200
> > Ingo Molnar <mingo@elte.hu> wrote:
> > 
> > > --- linux.orig/arch/i386/kernel/kprobes.c
> > > +++ linux/arch/i386/kernel/kprobes.c
> > > @@ -354,9 +354,8 @@ no_kprobe:
> > >   */
> > >  fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
> > >  {
> > > -        struct kretprobe_instance *ri = NULL;
> > > -        struct hlist_head *head;
> > > -        struct hlist_node *node, *tmp;
> > > +        struct kretprobe_instance *ri = NULL, *tmp;
> > > +        struct list_head *head;
> > >  	unsigned long flags, orig_ret_address = 0;
> > >  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> > 
> > Wanna fix the whitespace wreckage while you're there??
>
> will do. If you consider this for -mm then there's some djprobes noise 
> in the patch [djprobes isnt upstream yet] - it's not completely 
> sanitized yet. (but it should actually work if applied to upstream - 
> kprobes and djprobes are disjunct.) Also, i havent tested with 
> CONFIG_KPROBES turned off, etc. I'll do a clean queue.

Also, the hlist->list changes need to be taken care of for the other
archs too.

> > i386's kprobe_handler() appears to forget to reenable preemption in 
> > the if (p->pre_handler && p->pre_handler(p, regs)) case?
> 
> that portion seems a bit tricky - i think what happens is that the 
> pre_handler() sets stuff up for single-stepping, and then we do this 
> recursive single-stepping (during which preemption remains disabled), 
> and _then_ do we re-enable preemption.

Well, that is the jprobes and return probes case. In the case of normal
kprobes, p->pre_handler() should always return 0.

In the case of a jprobe, the setjmp_pre_handler() resets the instruction
pointer to the instrumented routine (same signature as the routine being
jprobed), which later does a jprobe_return(), a placeholder for the
arch-specific trap instruction. We re-enter the kprobe_handler here and
then re-enable preemption via the longjmp_break_handler. As for the
return probe case, since the underlying instruction originally was a nop
(kretprobe_trampoline), we don't need to single-step.

Yes, its a bit convoluted, but we are currently covered for all cases.

Ananth
