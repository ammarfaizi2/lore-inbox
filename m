Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261778AbULOAS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261778AbULOAS7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 19:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbULOARc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 19:17:32 -0500
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:8115 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S261786AbULNXmu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:42:50 -0500
Date: Wed, 15 Dec 2004 00:41:56 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
Message-ID: <20041214234156.GS16322@dualathlon.random>
References: <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com> <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com> <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random> <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random> <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu> <20041214224706.GA26853@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041214224706.GA26853@elte.hu>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 11:47:06PM +0100, Ingo Molnar wrote:
> find the correct patch below. I've tested it with an NMI watchdog
> frequency artificially increased to 10 KHz, and i've instrumented the

Nice test, it'd be nice to trigger it in real life.

on the lines of the 64k movl ss, I wonder if we could create an huge
piece of memory like this:

new_htl:
cli
sti
htl
cli
sti
htl
[..]
jmp original_hlt


and to call new_htl from original_hlt instead of sti;hlt. A dozen megs
of the above should boost the probability of getting interrupted in
"hlt" quite a bit.

However even if the nmi can execute on top of the "hlt" instruction, it
doesn't necessairly mean the next pending irq will execute before
executing 'hlt' too, so it'd need a bit more of instrumentation to as
well track down the race as happening (it's not enough to see the branch
in the nmi handler to be taken). The additional instrumentation should
be quite easy though, just copying the same nmi code to the irq handler
should do the trick.
