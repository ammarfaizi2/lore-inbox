Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264726AbUFGO5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264726AbUFGO5K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUFGO5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:57:10 -0400
Received: from fw.osdl.org ([65.172.181.6]:6027 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264726AbUFGO5G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:57:06 -0400
Date: Mon, 7 Jun 2004 07:56:48 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Paul Mackerras <paulus@samba.org>
cc: linuxppc64-dev@lists.linuxppc.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>, anton@samba.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: PREEMPT for ppc64
In-Reply-To: <16580.7953.94871.281986@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.58.0406070737240.1730@ppc970.osdl.org>
References: <16580.7953.94871.281986@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 7 Jun 2004, Paul Mackerras wrote:
>
> Here is a patch that implements CONFIG_PREEMPT for ppc64.  Aside from
> the entry.S changes to check the _TIF_NEED_RESCHED bit when returning
> from an exception, most of the changes are to add preempt/{dis,en}able
> in various places.  Undoubtedly I have missed some though.

I would really suggest you push these into the "enable_kernel_fp()" thing, 
for example, rather than open-coding them. Also, code like

	+     preempt_disable();
	      if (regs->msr & MSR_VEC)
	              giveup_altivec(current);
	+     preempt_enable();

doesn't seem to make much sense, since "regs->msr" certainly isn't 
changing, so clearly the above is equivalent to just pushing the whole 
preempt disable into "giveup_altivec()".

The most _common_ bug (and the one I don't see any code for at all in your
patch) is stuff that knows which CPU it is on, or that reads actual
special CPU registers and acts on them. The other thing to look out for is
anything that gets the CPU number: use "get_cpu() + put_cpu()" rather than
"smp_processor_id()".

		Linus
