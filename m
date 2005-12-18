Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932673AbVLRCf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932673AbVLRCf0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 21:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932672AbVLRCf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 21:35:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17635 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932670AbVLRCfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 21:35:25 -0500
Date: Sat, 17 Dec 2005 18:34:46 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nicolas Pitre <nico@cam.org>
cc: David Howells <dhowells@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
       linux-arch@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
       mingo@redhat.com, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/12]: MUTEX: Implement mutexes
In-Reply-To: <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0512171803580.3698@g5.osdl.org>
References: <Pine.LNX.4.64.0512162334440.3698@g5.osdl.org>
 <dhowells1134774786@warthog.cambridge.redhat.com>
 <200512162313.jBGND7g4019623@warthog.cambridge.redhat.com>
 <1134791914.13138.167.camel@localhost.localdomain>
 <14917.1134847311@warthog.cambridge.redhat.com> <Pine.LNX.4.64.0512171201200.3698@g5.osdl.org>
 <Pine.LNX.4.64.0512172018410.26663@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 17 Dec 2005, Nicolas Pitre wrote:
> 
> Well, if you really want to be honest, you have to consider that the 
> ldrex/strex instructions are available only on ARM architecture level 6 
> and above, or in other words with only about 1% of all ARM deployments 
> out there.  The other 99% of actual ARM processors in the field only 
> have the atomic swap (swp) instruction which is insufficient for 
> implementing a counting semaphore (we therefore have to disable 
> interrupts, do the semaphore update and enable interrupts again which is 
> much slower than a swp-based mutex).

Ehh.. Have you seen any SMP arm machines with the old ones?

Yes, there are some shared-memory things out there. I thought they were 
basically never used in SMP configs, but just with two independent CPU's 
that just happened to share (at least part of) memory.

In fact, I thought it was more common that you had one ARM core, and then 
a specialized comm chip or something?

As far as I can tell from the Linux arm assembly (which I admittedly don't 
read very well at all), the non-ARMv6 semaphore code just disables 
interrupts and does the semaphore without any atomic instructions at all. 
Which is fine for UP (in fact, I'm not even convinced you need to disable 
interrupts, since any interrupts - even if they do a "trylock+up" - should 
always leave the counter in the same state it was before).

So afaik, Linux simply doesn't support pre-ARMv6 in SMP configurations, 
and never has (and I'd assume never will).

Or am I missing something?

		Linus
