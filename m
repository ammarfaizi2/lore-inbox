Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261751AbULNXFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261751AbULNXFN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 18:05:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbULNXDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 18:03:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:43928 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261739AbULNXBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 18:01:40 -0500
Date: Tue, 14 Dec 2004 15:00:56 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Lee Revell <rlrevell@joe-job.com>, Andrea Arcangeli <andrea@suse.de>,
       Manfred Spraul <manfred@colorfullife.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       George Anzinger <george@mvista.com>, dipankar@in.ibm.com,
       ganzinger@mvista.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Subject: Re: [patch, 2.6.10-rc3] safe_hlt() & NMIs
In-Reply-To: <20041214222307.GB22043@elte.hu>
Message-ID: <Pine.LNX.4.58.0412141450430.3279@ppc970.osdl.org>
References: <41BA698E.8000603@mvista.com> <Pine.LNX.4.61.0412110751020.5214@montezuma.fsmlabs.com>
 <41BB2108.70606@colorfullife.com> <41BB25B2.90303@mvista.com>
 <Pine.LNX.4.61.0412111947280.7847@montezuma.fsmlabs.com>
 <41BC0854.4010503@colorfullife.com> <20041212093714.GL16322@dualathlon.random>
 <41BC1BF9.70701@colorfullife.com> <20041212121546.GM16322@dualathlon.random>
 <1103060437.14699.27.camel@krustophenia.net> <20041214222307.GB22043@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 14 Dec 2004, Ingo Molnar wrote:
> 
> indeed, there could be a connection, and it's certainly a fun race. The
> proper fix is Manfred's suggestion: check whether the EIP is a kernel
> text address, and if yes, whether it's a HLT instruction - and if yes
> then increase EIP by 1.

You do it the wrong way, though. This is not safe:

	if (__kernel_text_address(regs->eip) && *(char *)regs->eip == 0xf4)

does _entirely_ the wrong thing if CS is not the kernel CS. 

It can trigger with a regular use CS if you were to run the 4G:4G patches, 
but more realistically, I think you can make ii trigger even with a 
standard kernel by creating a local code segment in your LDT, and then 
trying to confuse the kernel that way.

Now, as long as the _only_ thing it does is increment the eip, the worst 
that can happen is that it screws over the user program that must have 
worked at this a bit, but the basic point is that you shouldn't do this. 
In _theory_ you could confuse a real program that wasn't doing anything 
bad.

Checking for kernel CS also requires checking that it's not vm86 mode, 
btw. So that's not just a "regs->xcs & 0xffff == __KERNEL_CS" either.

But something like

	static inline int kernel_mode(struct pt_regs *regs)
	{
		return !((regs->eflags & VM_MASK) | (regs->xcs & 3));
	}

should DTRT.

Can you pls double-check my thinking, and test?

			Linus
