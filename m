Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWIKIDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWIKIDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbWIKIDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:03:19 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:23528 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751217AbWIKIDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:03:18 -0400
Date: Mon, 11 Sep 2006 09:55:05 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060911075504.GA5328@elte.hu>
References: <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org> <20060911073809.GB3188@elte.hu> <4505169C.3010507@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505169C.3010507@goop.org>
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


* Jeremy Fitzhardinge <jeremy@goop.org> wrote:

> Ingo Molnar wrote:
> >btw., what's the connection of %gs based PDA to Xen and 
> >paravirtualization in general - %esp based current is just as 
> >Xen-friendly, or am i wrong? I guess there must be some connection, 
> >given that you are working on this ;)
> >  
> 
> Yep.  The goal is to put the Xen VCPU structure into the PDA, so that it 
> can be easily accessed.  At present, masking events (ie, cli), is 
> something along the lines of
> 
>    xen_shared_info->vcpu[smp_processor_id()].mask = 1
> 
> which comes out to something like 20 bytes of code, and is probably too 
> awkward to inline.  If the vcpu is in the PDA, it would come out to:
> 
>    movb $1, %gs:xen_vcpu_mask
> 
> which has the added benefit of not needing a register.

take a look at lockdep: amongst other things it adds the TRACE_IRQFLAGS 
/ irqflags.h infrastructure, which could easily be modified to allow the 
easy replacement of cli/sti/pushf/popf. I wrote it with the side-goal of 
paravirtualization. I.e. instead of the DISABLE_INTERRUPT / 
ENABLE_INTERRUPT duplication you do in -mm currently please just enhance 
irqflags.h to cover the needs of paravirtualization too. (most of which 
should be the moving of cli/sti into the assembly callbacks)

into that the PDA would plug in a natural way: current->hardirqs_enabled 
is basically just an alias for 
!xen_shared_info->vcpu[smp_processor_id()].mask.

	Ingo
