Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUIPGo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUIPGo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267538AbUIPGo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:44:56 -0400
Received: from cantor.suse.de ([195.135.220.2]:27275 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267519AbUIPGoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:44:32 -0400
Date: Thu, 16 Sep 2004 08:44:28 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916064428.GD12915@wotan.suse.de>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916062759.GA10527@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 08:27:59AM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > Known problem. Interrupts don't save regs->rbp, but the new profile_pc
> > that was introduced recently uses it.
> > 
> > One quick fix is to just use SAVE_ALL in the interrupt entry code, but
> > I don't like this because it will affect interrupt latency.
> > 
> > The real fix is to fix profile_pc to not reference it.
> 
> it would be nice if we could profile the callers of the spinlock
> functions instead of the opaque spinlock functions.
> 
> the ebp trick is nice, but forcing a formal stack frame for every
> function has global performance implications. Couldnt we define some

I don't think that is needed anyways.  It would seem to 
be overkill to me to make a relatively fast path slower
just for the profiler interrupt.

I think the idea was that the spinlock functions should be small 
enough that they don't have any stack local variables. In this case 
for the standard non FP build you can just use *regs->rsp. The only problem
was with CONFIG_FRAME_POINTER, because then the compiler puts
an additional word onto the stack. I think the right way 
is to just correct for this word and still use rsp.

Here's an untested patch to implement this. Does this fix the problem for 
you?

-Andi


Index: linux/arch/x86_64/kernel/time.c
===================================================================
--- linux.orig/arch/x86_64/kernel/time.c	2004-09-13 22:19:22.%N +0200
+++ linux/arch/x86_64/kernel/time.c	2004-09-16 08:43:06.%N +0200
@@ -184,9 +184,11 @@
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
-
+	/* [0] is the frame pointer, [1] is the return address.
+	   This assumes that the spinlock function is small enough
+	   to not have any stack variables. */	
 	if (in_lock_functions(pc))
-		return *(unsigned long *)regs->rbp;
+		return ((unsigned long *)regs->rsp)[1];
 	return pc;
 }
 EXPORT_SYMBOL(profile_pc);

