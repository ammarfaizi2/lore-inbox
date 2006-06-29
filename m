Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750936AbWF2Qkt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbWF2Qkt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 12:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750939AbWF2Qkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 12:40:49 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:27947 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750931AbWF2Qks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 12:40:48 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: i386 IPI handlers running with hardirq_count == 0 
In-reply-to: Your message of "Thu, 29 Jun 2006 02:18:00 MST."
             <20060629021800.9a1e16f4.akpm@osdl.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 30 Jun 2006 02:40:38 +1000
Message-ID: <8750.1151599238@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton (on Thu, 29 Jun 2006 02:18:00 -0700) wrote:
>On Thu, 29 Jun 2006 19:01:17 +1000
>Keith Owens <kaos@ocs.com.au> wrote:
>
>> Macro arch/i386/kernel/entry.S::BUILD_INTERRUPT generates the code to
>> handle an IPI and call the corresponding smp_<name> C code.
>> BUILD_INTERRUPT does not update the hardirq_count for the interrupted
>> task, that is left to the C code.  Some of the C IPI handlers do not
>> call irq_enter(), so they are running in IRQ context but the
>> hardirq_count field does not reflect this.  For example,
>> smp_invalidate_interrupt does not set the hardirq count.
>> 
>> What is the best fix, change BUILD_INTERRUPT to adjust the hardirq
>> count or audit all the C handlers to ensure that they call irq_enter()?
>> 
>
>The IPI handlers run with IRQs disabled.  Do we need a fix?

Some IPI handlers issue irq_enter() to bump hard_irq_count, some IPI
handlers do not.  It is inconsistent, with no obvious reason for doing
it either way.  All the external irqs go via do_IRQ which does issue
irq_enter().  I guess that my real question is why are some IPIs not
using irq_enter()?  The lack of consistency concerns me.

