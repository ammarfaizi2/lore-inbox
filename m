Return-Path: <linux-kernel-owner+w=401wt.eu-S1751075AbXACTLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbXACTLu (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 14:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751076AbXACTLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 14:11:50 -0500
Received: from server99.tchmachines.com ([72.9.230.178]:54001 "EHLO
	server99.tchmachines.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058AbXACTLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 14:11:49 -0500
Date: Wed, 3 Jan 2007 11:11:30 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       pravin b shelar <pravin.shelar@calsoftinc.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [rfc] [patch 1/2] spin_lock_irq: Enable interrupts while spinning -- preperatory patch
Message-ID: <20070103191130.GA4075@localhost.localdomain>
References: <20070103075923.GA3789@localhost.localdomain> <20070103001635.ecbd74e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070103001635.ecbd74e5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server99.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 03, 2007 at 12:16:35AM -0800, Andrew Morton wrote:
> On Tue, 2 Jan 2007 23:59:23 -0800
> Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> 
> > The following patches do just that. The first patch is preparatory in nature
> > and the second one changes the  x86_64 implementation of spin_lock_irq.
> > Patch passed overnight runs of kernbench and dbench on 4 way x86_64 smp.
> 
> The end result of this is, I think, that i386 enables irqs while spinning
> in spin_lock_irqsave() but not while spinning in spin_lock_irq().  And
> x86_64 does the opposite.

No, right now we have on mainline (non PREEMPT case);

			i386				x86_64
-----------------------------------------------------------------------------
spin_lock_irq		cli when spin			cli when spin
spin_lock_irqsave	spin with intr enabled		spin with intr enabled

The posted patchset changed this to:

			i386				x86_64
-----------------------------------------------------------------------------
spin_lock_irq		cli when spin			spin with intr enabled
spin_lock_irqsave	spin with intr enabled		spin with intr enabled

> 
> Odd, isn't it?

Well we just implemented the x86_64 part.  Here goes the i386 part as well for 
spin_lock_irq.

i386: Enable interrupts while spinning for a lock with spin_lock_irq

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>

Index: linux-2.6.20-rc1/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6.20-rc1.orig/include/asm-i386/spinlock.h	2006-12-28 17:18:32.142775000 -0800
+++ linux-2.6.20-rc1/include/asm-i386/spinlock.h	2007-01-03 10:18:32.243662000 -0800
@@ -82,7 +82,22 @@ static inline void __raw_spin_lock_flags
 	 	  CLI_STI_INPUT_ARGS
 		: "memory" CLI_STI_CLOBBERS);
 }
-# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
+
+static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
+{
+	asm volatile("\n1:\t"
+		     LOCK_PREFIX " ; decb %0\n\t"
+		     "jns 3f\n"
+		     STI_STRING "\n"
+		     "2:\t"
+		     "rep;nop\n\t"
+		     "cmpb $0,%0\n\t"
+		     "jle 2b\n\t"
+		     CLI_STRING "\n"
+		     "jmp 1b\n"
+		     "3:\n\t"
+		     : "+m" (lock->slock) : : "memory");
+}
 #endif
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
