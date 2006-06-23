Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWFWKJf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWFWKJf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 06:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751269AbWFWKJf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 06:09:35 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:12722 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750865AbWFWKJe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 06:09:34 -0400
Date: Fri, 23 Jun 2006 12:04:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [patch 50/61] lock validator: special locking: hrtimer.c
Message-ID: <20060623100439.GI4889@elte.hu>
References: <20060529212109.GA2058@elte.hu> <20060529212709.GX3155@elte.hu> <20060529183556.602b1570.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060529183556.602b1570.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  	for (i = 0; i < MAX_HRTIMER_BASES; i++, base++)
> > -		spin_lock_init(&base->lock);
> > +		spin_lock_init_static(&base->lock);
> >  }
> >  
> 
> Perhaps the validator core's implementation of spin_lock_init() could 
> look at the address and work out if it's within the static storage 
> sections.

yeah, but there are two cases: places where we want to 'unify' array 
locks into a single type, and places where we want to treat them 
separately. The case where we 'unify' is the more common one: locks 
embedded into hash-tables for example. So i went for annotating the ones 
that are rarer. There are 2 right now: scheduler, hrtimers, with the 
hrtimers one going away in the high-res-timers implementation. (we 
unified the hrtimers locks into a per-CPU lock) (there's also a kgdb 
annotation for -mm)

perhaps the naming should be clearer? I had it named 
spin_lock_init_standalone() originally, then cleaned it up to be 
spin_lock_init_static(). Maybe the original name is better?

	Ingo
