Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUILFLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUILFLN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268448AbUILFLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:11:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:26541 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268453AbUILFK3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:10:29 -0400
Date: Sat, 11 Sep 2004 22:10:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Yielding processor resources during lock contention
In-Reply-To: <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0409112200060.13491@ppc970.osdl.org>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409090751230.5912@ppc970.osdl.org>
 <Pine.LNX.4.58.0409090754270.5912@ppc970.osdl.org>
 <Pine.LNX.4.53.0409091107450.15087@montezuma.fsmlabs.com>
 <Pine.LNX.4.53.0409120009510.2297@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 12 Sep 2004, Zwane Mwaikambo wrote:
> 
> On i386 processors with PNI this is achieved by using the 
> monitor/mwait opcodes to halt the processor until a write to the lock is 
> done. 

I'd seriously suggest you ask Intel for an official opinion on this. Last
I heard (and that was, I believe, before monitor/mwait had been officially
announced, so it's certainly a bit dated now) it wasn't architecturally
clear that it's a good idea using it for things like spinlocks.

In particular, if the CPU idly waits for a cacheline to be dirtied, it is 
entirely possible that the other CPU that owns the lock and releases it 
won't actually _tell_ the world that the lock has been released for quite 
some time. After all, why should it - if it is the exclusive owner, and it 
sees no memory traffic on the bus, it may have no reason to push out the 
fact that it just released the lock. Just keep it dirty in its caches.

In other words: monitor/mwait on purpose obviously causes fewer bus
cycles. But that very fact may well mean (at least in theory) that you get
very high latencies. It could make spinlock contention very very unfair
(the original CPU keeps getting the lock over and over again, while the
monitor/mwait one never gets to play), and it might also make ping-pong
locking latency be extremely high.

Also, it's entirely possible that monitor/mwait ends up shutting down the
CPU to the point that getting out of a lower-power mode might have a
latency of microseconds or even milliseconds. External (or even internal)
voltage regulators and frequency changes are not instantaneous by any
means..

In other words, I would strongly suggest you _not_ really consider this a
serious thing (feel free to play around with it and try to get some
numbers) with this without getting an answer from Intel about what the
_architected_ behaviour of monitor/mwait is, from a latency standpoint.

Because otherwise you might find that even if it performs like you want it
to on some existing machine, next year it would suck so badly that it's
not even funny.

			Linus
