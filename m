Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbTEARih (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTEARih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:38:37 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:27538 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261775AbTEARif (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:38:35 -0400
Subject: Re: [RFC] clustered apic irq affinity fix for i386
From: Keith Mannthey <kmannth@us.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030430192205.13491d61.akpm@digeo.com>
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com>
	<20030430163637.04f06ba6.akpm@digeo.com>
	<1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com> 
	<20030430192205.13491d61.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 May 2003 10:51:12 -0700
Message-Id: <1051811474.16886.159.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Remind me again what the patch actually does?  It seems to be purely adding
> debug checks?



> Won't it just go BUG if someone boots the kernel and then tries to manually
> set affinity?

  I would assume if someone was setting the affinity from /proc they
would have disabled the kernel irqbalancer and the flag
irqbalance_disabled would be set.
  What I am trying to avoid is a branching for both kirqd and user space
setting affinity.  I see though I hadn't fully thought out user trying
to set affinity and have for following idea.  This would also make
Martin happy :)  

--- ../linux-2.5.68/arch/i386/kernel/irq.c	Sat Apr 19 19:48:50 2003
+++ arch/i386/kernel/irq.c	Fri May  2 14:01:12 2003
@@ -871,8 +871,11 @@
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
-	irq_desc[irq].handler->set_affinity(irq, new_value);
-
+	if (irqbalance_disabled) {
+		irq_desc[irq].handler->set_affinity(irq, new_value);
+	} else {
+		do_irq_balance();
+	}	
 	return full_count;
 }
 

 This would make the /proc call tie into kirqd in cases where the
irq_balance has not been disabled. 

 
> Seems a bit racy too. setup_ioapic_dest() does:
> 
>                         pending_irq_balance_apicid[irq] = mask;
>         ==> window here
>                         set_ioapic_affinity(irq, mask);
> 
> ioapic_lock is not held, so there is a window where
> pending_irq_balance_apicid[irq] can be set to some other value and
> io_apic_write_affinity() will accidentally go BUG.
  
  It don't think it is the ioapic_lock we would need to hold it would be
the desc->lock.  This is also early in the boot sequence, but I could
grab the lock anyway.  

> Is it not possible to fix set_ioapic_affinity() for real for clustered APIC
> mode?  What is involved in that?
 
   The real issue is in clustered apic mode not all possible masks are
possible.  If flat mode you have 8 bits (00000000) where each bit
represents a cpu.  In clusterd mode you have 8 bits (0000-node id
0000-cpu id) also.  If the cpu mask you want to write has cpus on
different nodes it impossible (except in special cases) to write that
value the ioapic.  
  In clustered apic mode I can only mask an irq to a single cpu, cpus on
the same node, all cpus, or I beleive the Nth cpu on every node.  It
can't do everything flat apic mode can.  This makes it difficult to
decide what a real fix should be.  


Keith 

