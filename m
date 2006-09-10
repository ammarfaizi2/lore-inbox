Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWIJNe2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWIJNe2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 09:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWIJNe2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 09:34:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:16281 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932142AbWIJNe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 09:34:27 -0400
Date: Sun, 10 Sep 2006 15:26:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060910132614.GA29423@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609101334.34867.ak@suse.de>
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


* Andi Kleen <ak@suse.de> wrote:

> > Basically, non-atomic setup of basic architecture state _is_ going to be
> > a nightmare, lockdep or not, especially if it uses common infrastructure
> > like 'current', spin_lock() or even something as simple as C functions.
> > (for example the stack-footprint tracer was once hit by this weakness of
> > the x86_64 code)
> 
> I disagree with that.  The nightmare is putting stuff that needs so 
> much infrastructure into the most basic operations.

ugh, "having a working current" is "so much infrastructure" ?? Lockdep 
uses a very low amount of infrastructure, considering its complexity: it 
has its own allocator, uses raw spinlocks, raw irq flags ops, it 
basically implements its own infrastructure for everything. Being able 
to access a per-task data area (current) is a quite fundamental thing 
for kernel code.

the i686 PDA patches introduce tons of early_current() uses. While i 
like the new PDA code, its bootstrap (like x86_64's PDA bootstrap) is 
too fragile in my opinion, and it will regularly hit instrumenting 
patches.

Perhaps the early setup code (if we really want to do it all in C) 
should be moved into 32-bit early boot userspace code (like 
compressed/misc.c) and it will thus not depend on any kernel 
infrastructure.

	Ingo
