Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUILFXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUILFXQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268463AbUILFXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:23:16 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25048 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268472AbUILFWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:22:38 -0400
Date: Sun, 12 Sep 2004 01:27:12 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <Pine.LNX.4.58.0409112200060.13491@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.53.0409120118280.2297@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409112200060.13491@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Sep 2004, Linus Torvalds wrote:

> I'd seriously suggest you ask Intel for an official opinion on this. Last
> I heard (and that was, I believe, before monitor/mwait had been officially
> announced, so it's certainly a bit dated now) it wasn't architecturally
> clear that it's a good idea using it for things like spinlocks.

Indeed last i heard, it was unuseable for low latency locking, for this 
case (lock acquisition after relinquish on remote processor) we may be 
able to put up with the higher latency.

> In particular, if the CPU idly waits for a cacheline to be dirtied, it is 
> entirely possible that the other CPU that owns the lock and releases it 
> won't actually _tell_ the world that the lock has been released for quite 
> some time. After all, why should it - if it is the exclusive owner, and it 
> sees no memory traffic on the bus, it may have no reason to push out the 
> fact that it just released the lock. Just keep it dirty in its caches.
> 
> In other words: monitor/mwait on purpose obviously causes fewer bus
> cycles. But that very fact may well mean (at least in theory) that you get
> very high latencies. It could make spinlock contention very very unfair
> (the original CPU keeps getting the lock over and over again, while the
> monitor/mwait one never gets to play), and it might also make ping-pong
> locking latency be extremely high.

Good point, i can see this scenario occuring on current processors.

> Also, it's entirely possible that monitor/mwait ends up shutting down the
> CPU to the point that getting out of a lower-power mode might have a
> latency of microseconds or even milliseconds. External (or even internal)
> voltage regulators and frequency changes are not instantaneous by any
> means..

Yes i noted too, currently it doesn't support any additional options 
to affect how the processor halts during mwait, intel could indeed pull a 
number and make the default ultra high wakeup latency mode. I truly 
hope they don't as it really would make the whole thing useless.

> In other words, I would strongly suggest you _not_ really consider this a
> serious thing (feel free to play around with it and try to get some
> numbers) with this without getting an answer from Intel about what the
> _architected_ behaviour of monitor/mwait is, from a latency standpoint.

Well the i386 and x86_64 versions were purely for testing purposes on my 
part, i'm content with dropping them. The main user was going to be PPC64, 
but i felt compelled to throw in an architecture implementation.

Thanks,
	Zwane
