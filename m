Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261530AbSKNSye>; Thu, 14 Nov 2002 13:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSKNSye>; Thu, 14 Nov 2002 13:54:34 -0500
Received: from [195.223.140.107] ([195.223.140.107]:34961 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S261530AbSKNSyd>;
	Thu, 14 Nov 2002 13:54:33 -0500
Date: Thu, 14 Nov 2002 20:00:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Leif Sawyer <lsawyer@gci.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: FW: i386 Linux kernel DoS
Message-ID: <20021114190014.GQ31697@dualathlon.random>
References: <20021114030541.GU31697@dualathlon.random> <Pine.LNX.4.44.0211140956480.1340-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211140956480.1340-100000@home.transmeta.com>
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2002 at 10:12:53AM -0800, Linus Torvalds wrote:
> 
> Ok, the reason for this one is that we don't really emulate a
> trap/interrupt gate correctly when taking a lcall. We _do_ set up the 
> stack to be identical, but a real trap/interrupt will also clear TF and NT 

actually TF should cleared implicitly in the do_debug or it could get
the single step trap before you can clear TF explicitly in the entry.S.
but it's certainly zerocost to clear it explicitly there too just to
remeber it's one of the bits not cleared implicitly in hardware when
entering via lcall.  However in 2.5 it seems the clear_TF in do_debug is
still missing.

basically you need to add this check in do_debug too:

--- x/arch/i386/kernel/traps.c.~1~	Fri Aug  9 14:52:06 2002
+++ x/arch/i386/kernel/traps.c	Thu Nov 14 19:57:42 2002
@@ -514,10 +514,14 @@ asmlinkage void do_debug(struct pt_regs 
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
+	unsigned long eip = regs->eip;
 	siginfo_t info;
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
+	if ((eip >=PAGE_OFFSET) && (regs->eflags & TF_MASK))
+		goto clear_TF;
+
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])


or maybe I'm missing something and 2.5 fixes it in another way that I
didn't notice.

> in EFLAGS on entry to the kernel (_after_ having saved the value off), and 
> our emulation code didn't do that.
> 
> So when we returned with an "iret", we had NT set in EFLAGS, causing the
> iret to do all the wrong things.

Yep.

Andrea
