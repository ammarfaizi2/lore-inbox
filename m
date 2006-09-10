Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWIJMFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWIJMFK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 08:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750871AbWIJMFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 08:05:10 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:54664 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750734AbWIJMFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 08:05:08 -0400
Date: Sun, 10 Sep 2006 13:57:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060910115722.GA15356@elte.hu>
References: <20060908011317.6cb0495a.akpm@osdl.org> <4503DC64.9070007@free.fr> <200609101032.17429.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609101032.17429.ak@suse.de>
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

> > This kernel won't boot here: it starts a GPFs loop on
> > early boot. I attached a screenshot of the first GPF
> > (pause_on_oops=120 helped).
> 
> It's lockdep's fault. This patch should fix it:

Well, it's also x86_64's fault: why does it call into a generic C 
function (x86_64_start_kernel()) without having a full CPU state up and 
running? i686 doesnt do it, never did.

We had frequent breakages due to this property of the x86_64 arch code 
(many more than this single incident with lockdep), tracing and all 
sorts of other instrumentation (including earlier versions of lockdep) 
was hit by it again and again.

Basically, non-atomic setup of basic architecture state _is_ going to be 
a nightmare, lockdep or not, especially if it uses common infrastructure 
like 'current', spin_lock() or even something as simple as C functions. 
(for example the stack-footprint tracer was once hit by this weakness of 
the x86_64 code)

> Hackish patch to fix lockdep with PDA current

hm, this is ugly beyond words. Do you have a config i could try which 
exhibits this problem? I'm sure there is a better solution.

	Ingo
