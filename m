Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULPP51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULPP51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbULPP50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:57:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:62110 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261450AbULPPzH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:55:07 -0500
Date: Thu, 16 Dec 2004 07:54:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041216145159.GA3204@elte.hu>
Message-ID: <Pine.LNX.4.58.0412160742080.22750@ppc970.osdl.org>
References: <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
 <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
 <20041214224706.GA26853@elte.hu> <Pine.LNX.4.58.0412141501250.3279@ppc970.osdl.org>
 <1103157476.3585.33.camel@localhost.localdomain> <Pine.LNX.4.58.0412151756550.3279@ppc970.osdl.org>
 <20041216145159.GA3204@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Dec 2004, Ingo Molnar wrote:
> 
> i also played a bit with the %ss instructions, and combined them with
> the cli/sti instructions and other instructions in various ways, and
> with a bit of experimenting found the following, somewhat surprising
> results:
>
> [ snip ]
> 
> it shows a number of interesting effects:
> 
> - "mov %eax,%ss" followed by the _same_ instruction cancels the 
>   black-hole. This i suspect is done to prevent the lockup in vm86
>   mode.

I don't think it's the "same instruction". Looking at the pattern, I think
that a "mov->ss" always checks interrupts _before_ it executes, and never 
checks interrupts _after_ it executes.

So I think the pattern is (for your athlon64):

 - regular instructions check interrupts before they execute, _except_ if 
   the "dontcheck" flag was set. They clear "dontcheck" after execution.
 - "mov->ss" always checks interrupts before it executes, regardless of
   "dontcheck". It always sets "dontcheck".
 - "sti" sets "dontcheck" if interrupts were disabled before.

So you can get two-instruction holes by doing the sequence

	/* interrupts disabled */
	mov->ss
	sti
	/* any instruction except cli/mov->ss */

but no other combination (series of "mov->ss" will always check _before_
each "mov->ss", and series of "sti" will obviously only have interrupts 
disabled for the _first_ sti).

And I suspect this is very much micro-architecture-dependent, although the 
Athlon64 rules seem very simple and straightforward.

		Linus
