Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWGGVtD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWGGVtD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 17:49:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWGGVtB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 17:49:01 -0400
Received: from relay00.pair.com ([209.68.5.9]:45580 "HELO relay00.pair.com")
	by vger.kernel.org with SMTP id S1751267AbWGGVtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 17:49:00 -0400
X-pair-Authenticated: 71.197.50.189
Date: Fri, 7 Jul 2006 16:48:56 -0500 (CDT)
From: Chase Venters <chase.venters@clientec.com>
X-X-Sender: root@turbotaz.ourhouse
To: "linux-os \\\\(Dick Johnson\\\\)" <linux-os@analogic.com>
cc: Linus Torvalds <torvalds@osdl.org>, Krzysztof Halasa <khc@pm.waw.pl>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
In-Reply-To: <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
Message-ID: <Pine.LNX.4.64.0607071635130.23767@turbotaz.ourhouse>
References: <20060705114630.GA3134@elte.hu><20060705101059.66a762bf.akpm@osdl.org><20060705193551.GA13070@elte.hu><20060705131824.52fa20ec.akpm@osdl.org><Pine.LNX.4.64.0607051332430.12404@g5.osdl.org><20060705204727.GA16615@elte.hu><Pine.LNX.4.64.0607051411460.12404@g5.osdl.org><20060705214502.GA27597@elte.hu><Pine.LNX.4.64.0607051458200.12404@g5.osdl.org><Pine.LNX.4.64.0607051555140.12404@g5.osdl.org><20060706081639.GA24179@elte.hu><Pine.LNX.4.61.0607060756050.8312@chaos.analogic.com><Pine.LNX.4.64.0607060856080.12404@g5.osdl.org><Pine.LNX.4.64.0607060911530.12404@g5.osdl.org><Pine.LNX.4.61.0607061333450.11071@chaos.analogic.com>
 <m34pxt8emn.fsf@defiant.localdomain> <Pine.LNX.4.61.0607071535020.13007@chaos.analogic.com>
 <Pine.LNX.4.64.0607071318570.3869@g5.osdl.org> <Pine.LNX.4.61.0607071657580.15580@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, linux-os \(Dick Johnson\) wrote:

> Again, I didn't propose to do that. In fact, your spin-lock
> code already inserts "rep nops" and I never implied that they
> should be removed. I said only that "volatile" still needs to
> be used, not some macro that tells the compiler that everything
> in memory probably got trashed. Read what I said, not what you
> think some idiot might have said.
>

Dude, are you even paying attention? "volatile" very much does not need to 
be used (and as Linus points out, it is _wrong_). Since we're using GCC's 
inline asm syntax _already_, it is perfectly sufficient to use the same 
syntax to tell GCC that memory should be considered invalid.

Locks are supposed to be syncronization points, which is why they ALREADY 
HAVE "memory" on the clobber list! "memory" IS NECESSARY. The fact 
that "=m" is changing to "+m" in Linus's patches is because "=m" is in 
fact insufficient, because it would let the compiler believe we're just 
going to over-write the value. "volatile" merely hides that bug -- once 
that bug is _fixed_ (by going to "+m"), "volatile" is no longer useful. 
(It wasn't useful before, it just _papered over_ a problem).

If "volatile" is in use elsewhere (other than locks), it's still 
probably wrong. In these cases, you can use a barrier, a volatile cast, or 
an inline asm with a specific clobber.

Thanks,
Chase
