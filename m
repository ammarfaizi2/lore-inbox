Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbWIKIJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWIKIJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 04:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWIKIJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 04:09:28 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:6285 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751243AbWIKIJ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 04:09:26 -0400
Date: Mon, 11 Sep 2006 10:01:15 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: 2.6.18-rc6-mm1: GPF loop on early boot
Message-ID: <20060911080115.GB5328@elte.hu>
References: <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911051028.GA10084@elte.hu> <450510E0.8080906@goop.org> <20060911072959.GA2322@elte.hu> <45051330.5050205@goop.org> <20060911073649.GA3188@elte.hu> <4505176B.6030803@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505176B.6030803@goop.org>
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
> >yes - but loading a null selector is a special-case: you dont have to 
> >invalidate/reload the shadow, you just have to turn access off. This 
> >might or might not make a difference on modern CPUs (it makes a 
> >difference with older CPUs) - but it's worth a try nevertheless. You 
> >measured a 9 cycles degradation with the %gs method, we could recover 
> >some of that.
> >  
> 
> It's a worthwhile experiment.  The gain would be the NULL selector 
> load, but the loss would be an additional segment reload on context 
> switch and TLS ABI incompatibility (which is more difficult to 
> quantify).

the ratio between the number of syscalls vs. the number of context 
switches is 1-2 orders of magnitude. So a loss of 9 cycles in the 
syscall path is roughly equal to a loss of 90-900 cycles in switch_to() 
costs ...

the TLS ABI is just a gcc stupidity. Why did they pick the _second_ 
extra selector, instead of the first one ...? Anyway, perhaps this could 
be solved by extending gcc with a switch to also generate __thread code 
off %fs. Probably not worth the pain though ...

	Ingo
