Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbTEADzR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 23:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262225AbTEADzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 23:55:17 -0400
Received: from franka.aracnet.com ([216.99.193.44]:22492 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S262222AbTEADzQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 23:55:16 -0400
Date: Wed, 30 Apr 2003 21:07:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, Keith Mannthey <kmannth@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] clustered apic irq affinity fix for i386
Message-ID: <8940000.1051762026@[10.10.2.4]>
In-Reply-To: <20030430192205.13491d61.akpm@digeo.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
 <20030430163637.04f06ba6.akpm@digeo.com>
 <1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com>
 <20030430192205.13491d61.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This should be better. Thanks for the comments. 
> 
> Remind me again what the patch actually does?  It seems to be purely
> adding debug checks?
> 
> Won't it just go BUG if someone boots the kernel and then tries to
> manually set affinity?

Just ignoring the idiot caller would seem better, IMHO. BUG is a little
extreme ;-) Personally I'm happy for clustered apic mode machines with
irqbalance *disabled* to just fail the call. With it enabled, they can just
fraggle the affinity for irqbalance, and be happy.

> Seems a bit racy too. setup_ioapic_dest() does:
> 
>                         pending_irq_balance_apicid[irq] = mask;
>         ==> window here
>                         set_ioapic_affinity(irq, mask);
> 
> ioapic_lock is not held, so there is a window where
> pending_irq_balance_apicid[irq] can be set to some other value and
> io_apic_write_affinity() will accidentally go BUG.
> 
> 
> Is it not possible to fix set_ioapic_affinity() for real for clustered
> APIC mode?  What is involved in that?

The hardware doesn't support arbitrary cpumasks. However, as long as
we're running irqbalance, it doesn't matter  - we only do one cpu at a time
anyway.

The existing code in the mainline kernel is wrong for platforms other than
clustered apic mode too. irqbalance is happily rotating us one cpu at a
time, and then we go along and put our big masky foot in the thing, and
splat it across multiple CPUs. If irqbalance is on, all we need to do is
set up the irqbalance mask, then force a rebalance immediately.

M.

