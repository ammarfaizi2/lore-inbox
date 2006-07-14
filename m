Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161266AbWGNQr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161266AbWGNQr6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jul 2006 12:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWGNQr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jul 2006 12:47:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23224 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161266AbWGNQrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jul 2006 12:47:55 -0400
Date: Fri, 14 Jul 2006 09:47:30 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chase Venters <chase.venters@clientec.com>
cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove volatile from nmi.c
In-Reply-To: <Pine.LNX.4.64.0607141131390.27161@turbotaz.ourhouse>
Message-ID: <Pine.LNX.4.64.0607140941170.5623@g5.osdl.org>
References: <1152882288.1883.30.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607140757080.5623@g5.osdl.org> <Pine.LNX.4.64.0607141131390.27161@turbotaz.ourhouse>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jul 2006, Chase Venters wrote:
> > 
> > static int __init check_nmi_watchdog(void)
> > {
> > -	volatile int endflag = 0;
> > +	static int endflag = 0;
> 
> Now that this is static, isn't this a candidate for __initdata?

Yes, that would be good.

Somebody want to test that it actually still _works_, and go through all 
the logic?

On a similar vein: Steven, looking at the cmos version of the patch, I 
have a hard time knowing whether the added barriers are needed, because I 
didn't spend any time on looking at the context of the patch. But I 
suspect that generally you do _not_ want to add barriers when you remove 
volatiles.

Basically, "volatile" is not a sign that a barrier is needed per se. In 
many cases, the _only_ thing that "volatile" implies is that the original 
programmer was confused and/or lazy.

So replacing volatiles with accesses with barriers is usually the _wrong_ 
thing to do. The right thing to do is generally to just _remove_ the 
volatile entirely, and then think hard about whether there was some _real_ 
reason why it existed in the first place.

Note that the only thing a volatile can do is a _compiler_ barrier, so if 
you add a real memory barrier or make it use a "set_wmb()" or similar, 
you're literally changing code that has been tested to work, and you're 
in the process also removing the hint that the code may actually have 
fundamental problems.

So I'd argue that it's actually _worse_ to do a "mindless" conversion away 
from volatile, than it is to just remove them outright. Removing them 
outright may show a bug that the volatile hid (and at that point, people 
may see what the _deeper_ problem was), but at least it won't add a memory 
barrier that isn't necessary and will potentially just confuse people.

			Linus
