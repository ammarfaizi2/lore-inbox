Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932894AbWF2LZu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932894AbWF2LZu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932895AbWF2LZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:25:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:63410 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932894AbWF2LZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:25:49 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, kaos@sgi.com
Subject: Re: i386 IPI handlers running with hardirq_count == 0
References: <26704.1151571677@kao2.melbourne.sgi.com>
	<20060629021800.9a1e16f4.akpm@osdl.org>
From: Andi Kleen <ak@suse.de>
Date: 29 Jun 2006 13:25:38 +0200
In-Reply-To: <20060629021800.9a1e16f4.akpm@osdl.org>
Message-ID: <p73wtb0w6dp.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> On Thu, 29 Jun 2006 19:01:17 +1000
> Keith Owens <kaos@ocs.com.au> wrote:
> 
> > Macro arch/i386/kernel/entry.S::BUILD_INTERRUPT generates the code to
> > handle an IPI and call the corresponding smp_<name> C code.
> > BUILD_INTERRUPT does not update the hardirq_count for the interrupted
> > task, that is left to the C code.  Some of the C IPI handlers do not
> > call irq_enter(), so they are running in IRQ context but the
> > hardirq_count field does not reflect this.  For example,
> > smp_invalidate_interrupt does not set the hardirq count.
> > 
> > What is the best fix, change BUILD_INTERRUPT to adjust the hardirq
> > count or audit all the C handlers to ensure that they call irq_enter()?
> > 
> 
> The IPI handlers run with IRQs disabled.  Do we need a fix?

They have to because if there was another interrupt it would execute
IRET and then clear the NMI flag in the hardware and allow nested NMIs 
which would cause all sorts of problems.

The only reason to change it would be complex callbacks in the
current handlers using notifier chains. Maybe if they're that complex they 
should become simpler? 

-Andi
