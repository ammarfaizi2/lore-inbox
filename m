Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUIJAim@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUIJAim (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266244AbUIJAil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:38:41 -0400
Received: from ozlabs.org ([203.10.76.45]:62410 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262329AbUIJAik (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:38:40 -0400
Date: Fri, 10 Sep 2004 10:35:05 +1000
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Paul Mackerras <paulus@samba.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
Message-ID: <20040910003505.GG11358@krispykreme>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <16703.60725.153052.169532@cargo.ozlabs.ibm.com> <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com> <20040909154259.GE11358@krispykreme> <20040909171954.GW3106@holomorphy.com> <16704.52551.846184.630652@cargo.ozlabs.ibm.com> <20040909220040.GM3106@holomorphy.com> <16704.59668.899674.868174@cargo.ozlabs.ibm.com> <20040910000903.GS3106@holomorphy.com> <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0409091712270.5912@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Hi,

> Why do we care about profile_pc() here? It should do the right thing 
> as-is.

With preempt off profile_pc works as expected, timer ticks in spinlocks
are apportioned to the calling function. Turn preempt on and you end up
with one big bucket called __preempt_spin_lock where most of the
spinlock ticks end up.

> What you care about is wchan, and stack unwiding _over_ the spinlocks. 
> Since a spinlock can never be part of the wchan callchain, I vote we just 
> change "in_sched_functions()" to claim that anything in the spinlock 
> section is also a scheduler function as far as it's concerned.
> 
> That makes wchan happy, and profile_pc() really never should care.

At the moment profile_pc is simple and only looks at the timer interrupt
pt_regs. With 2 levels of locks (_spin_lock -> __preempt_spin_lock) we
now have to walk the stack. Obviously fixable, it just a bit more work
in profile_pc. We would also need to move __preempt_spin_lock into the 
lock section which should be fine if we change wchan backtracing to do
as you suggest.

Anton
