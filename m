Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbWARGhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbWARGhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 01:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWARGhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 01:37:36 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33495 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751353AbWARGhf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 01:37:35 -0500
Date: Wed, 18 Jan 2006 07:37:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Michael Ellerman <michael@ellerman.id.au>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linuxppc64-dev@ozlabs.org, paulus@au1.ibm.com, anton@au1.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm4 failure on power5
Message-ID: <20060118063732.GA21003@elte.hu>
References: <20060116063530.GB23399@sergelap.austin.ibm.com> <200601180032.46867.michael@ellerman.id.au> <20060117140050.GA13188@elte.hu> <200601181119.39872.michael@ellerman.id.au> <20060118033239.GA621@cs.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118033239.GA621@cs.umn.edu>
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


* Dave C Boutcher <sleddog@us.ibm.com> wrote:

> On Wed, Jan 18, 2006 at 11:19:36AM +1100, Michael Ellerman wrote:
> > It booted fine _with_ the patch applied, with DEBUG_MUTEXES=y and n.
> > 
> > Boutcher, to be clear, you can't boot with kernel-kernel-cpuc-to-mutexes.patch 
> > applied and DEBUG_MUTEXES=y ?
> > 
> > But if you revert kernel-kernel-cpuc-to-mutexes.patch it boots ok?
> > 
> > This is looking quite similar to another hang we're seeing on Power4 iSeries 
> > on mainline git:
> > http://ozlabs.org/pipermail/linuxppc64-dev/2006-January/007679.html
> 
> Correct...I die in exactly the same place every time with 
> DEBUG_MUTEXES=Y.  I posted a backtrace that points into the _lock_cpu 
> code, but I haven't really dug into the issue yet.  I believe this is 
> very timing related (Serge was dying slightly differently).

so my question still is: _without_ the workaround patch, i.e. with 
vanilla -mm4, and DEBUG_MUTEXES=n, do you get a hang?

the reason for my question is that DEBUG_MUTEXES=y will e.g. enable 
interrupts - so buggy early bootup code which relies on interrupts being 
off might be surprised by it. The fact that you observed that it's 
somehow related to the timer interrupt seems to strengthen this 
suspicion. DEBUG_MUTEXES=n on the other hand should have no such 
interrupt-enabling effects.

[ if this indeed is the case then i'll add irqs_off() checks to
  DEBUG_MUTEXES=y, to ensure that the mutex APIs are never called with 
  interrupts disabled. ]

	Ingo
