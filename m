Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265936AbTL3T7d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 14:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265937AbTL3T7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 14:59:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:60876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265936AbTL3T7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 14:59:30 -0500
Date: Tue, 30 Dec 2003 11:59:27 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: James Bourne <jbourne@hardrock.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-uv3 patch set released
In-Reply-To: <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
Message-ID: <Pine.LNX.4.58.0312301130430.2065@home.osdl.org>
References: <Pine.LNX.4.51.0312290052470.1599@cafe.hardrock.org>
 <Pine.LNX.4.58L.0312300935040.22101@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Dec 2003, Marcelo Tosatti wrote:
> 
> On Mon, 29 Dec 2003, James Bourne wrote:
> 
> > linux-2.4.23-ide-busy-race-fix.patch: Daniel Lux: Fix IDE busy-wait race
> 
> I screwed up the merge of this patch, you also want to apply "Fix IDE
> busywait merge" (its the next changeset after this one).

I really think that the patch is wrong - it's just insane to "test one 
more time in case we got an interrupt", when the code around it plays with 
the interrupt flag all the time. Especially when it is supposed to wait 
for several timer interrupts while doing this. It appears that the timeout 
itself is just too damn borderline.

I suspect that anything in IDE that uses that idiotic "local_irq_set()"  
macro is just broken, and should be rewritten to explicitly enable 
interrupts. As it is, the code is just incredibly _strange_, and it 
actually enables interrupts at all the wrong places.

Anyway, in ide_wait_stat(), the "timeout" value is always either 
"WAIT_DRQ" (5*HZ/100) or it is "WAIT_READY" (3*HZ/100). And look at 
WAIT_READY a bit more: 

	#if defined(CONFIG_APM) || defined(CONFIG_APM_MODULE)
	#define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very slow */
	#else
	#define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous */
	#endif /* CONFIG_APM || CONFIG_APM_MODULE */

I bet that the _real_ problem is this. That "3*HZ/100" value is just too 
damn short. It has already been increased to 5*HZ for anything that has 
APM enabled, but anybody who doesn't use APM gets a _really_ short 
timeout.

My suggestion: change the non-APM timeout to something much larger. Make
it ten times bigger, rather than leaving it at a value that us so small
that a single interrupt could make a difference..

In fact, right now a single timer interrupt on 2.4.x is the difference
between waiting 20ms and 30ms. That's a _big_ relative difference.

Andrew - unless you disagree, I'd just be inlined to change both the DRQ
and READY timeouts to be a bit larger. On working hardware it shouldn't
matter, so how about just making them both be something like 100 msec (and
leave that strange really big APM value alone).

On 2.6.x, the higher timer frequency should make the time keeping more 
exact anyway (29-30ms rather than 20-30ms), but that's a small random 
detail..

			Linus
