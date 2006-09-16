Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964868AbWIPXim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964868AbWIPXim (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 19:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWIPXim
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 19:38:42 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:53654 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964868AbWIPXim (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 19:38:42 -0400
Date: Sun, 17 Sep 2006 01:30:38 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>,
       Jes Sorensen <jes@sgi.com>, Roman Zippel <zippel@linux-m68k.org>,
       tglx@linutronix.de, karim@opersys.com, Paul Mundt <lethal@linux-sh.org>,
       linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Ingo Molnar <mingo@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>,
       Tom Zanussi <zanussi@us.ibm.com>, ltt-dev@shafik.org,
       Michel Dagenais <michel.dagenais@polymtl.ca>, fche@redhat.com
Subject: Re: [patch] kprobes: optimize branch placement
Message-ID: <20060916233038.GC23132@elte.hu>
References: <20060915202233.GA23318@Krystal> <450BCAF1.2030205@sgi.com> <20060916172419.GA15427@Krystal> <20060916173552.GA7362@elte.hu> <20060916175606.GA2837@Krystal> <20060916191043.GA22558@elte.hu> <20060916193745.GA29022@elte.hu> <20060916202939.GA4520@elte.hu> <20060916204342.GA5208@elte.hu> <20060916155657.a233b54d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060916155657.a233b54d.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> On Sat, 16 Sep 2006 22:43:42 +0200
> Ingo Molnar <mingo@elte.hu> wrote:
> 
> > --- linux.orig/arch/i386/kernel/kprobes.c
> > +++ linux/arch/i386/kernel/kprobes.c
> > @@ -354,9 +354,8 @@ no_kprobe:
> >   */
> >  fastcall void *__kprobes trampoline_handler(struct pt_regs *regs)
> >  {
> > -        struct kretprobe_instance *ri = NULL;
> > -        struct hlist_head *head;
> > -        struct hlist_node *node, *tmp;
> > +        struct kretprobe_instance *ri = NULL, *tmp;
> > +        struct list_head *head;
> >  	unsigned long flags, orig_ret_address = 0;
> >  	unsigned long trampoline_address =(unsigned long)&kretprobe_trampoline;
> 
> Wanna fix the whitespace wreckage while you're there??

will do. If you consider this for -mm then there's some djprobes noise 
in the patch [djprobes isnt upstream yet] - it's not completely 
sanitized yet. (but it should actually work if applied to upstream - 
kprobes and djprobes are disjunct.) Also, i havent tested with 
CONFIG_KPROBES turned off, etc. I'll do a clean queue.

> i386's kprobe_handler() appears to forget to reenable preemption in 
> the if (p->pre_handler && p->pre_handler(p, regs)) case?

that portion seems a bit tricky - i think what happens is that the 
pre_handler() sets stuff up for single-stepping, and then we do this 
recursive single-stepping (during which preemption remains disabled), 
and _then_ do we re-enable preemption.

	Ingo
