Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWJEIMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWJEIMF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 04:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbWJEIMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 04:12:05 -0400
Received: from mx10.go2.pl ([193.17.41.74]:33261 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751193AbWJEIMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 04:12:01 -0400
Date: Thu, 5 Oct 2006 10:16:36 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Klaus Knopper <knopper@knopper.net>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: compile error for 2.6.18-git19 with CONFIG_RWSEM_GENERIC_SPINLOCK=y
Message-ID: <20061005081636.GA8208@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	Klaus Knopper <knopper@knopper.net>, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061003192000.GG6710@knopper.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-2006 21:20, Klaus Knopper wrote:
> Hello everyone,
> 
> Since the "reporting bugs" FAQ told me to post here in case I can't
> identify the right person to ask, and have not found any mention of this
> problem on the list and anywhere else yet, I do.
> 
> Problem description: Compiling 2.6.18-git19 (gcc-3.3 and 4.1) fails for
> processor family i386 (when CONFIG_RWSEM_GENERIC_SPINLOCK=y) is set,
> with
> 
> arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_down_read_failed':
> arch/i386/lib/semaphore.S:(.sched.text+0x5f): undefined reference to `rwsem_down_read_failed'
> arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_down_write_failed':
> arch/i386/lib/semaphore.S:(.sched.text+0x6a): undefined reference to `rwsem_down_write_failed'
> arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_wake':
> arch/i386/lib/semaphore.S:(.sched.text+0x76): undefined reference to `rwsem_wake'
> arch/i386/lib/lib.a(semaphore.o): In function `call_rwsem_downgrade_wake':
> arch/i386/lib/semaphore.S:(.sched.text+0x7f): undefined reference to `rwsem_downgrade_wake'
> 
> This option is present in .config when setting processor family to
> plain "i386" in make menuconfig.
> 
> Using CONFIG_RWSEM_XCHGADD_ALGORITHM=y INSTEAD of
> CONFIG_RWSEM_GENERIC_SPINLOCK=y (i486 and up) kind of "fixes" the
> compile error, but I'm not sure if the resulting code would still run on
> a real i386.
> 
> This problem also exists for ealier gits, but I can't tell exactly when
> it started.
> 
> Regards
> -Klaus Knopper
> PS: Please CC any answers to me, since I'm not a subscriber to this list.

It looks there is only one person in the world who remembers i386!

I attach my patch proposal.

Best regards,

Jarek P.


diff -Nurp linux-2.6.18-rc1-/arch/i386/lib/semaphore.S linux-2.6.18-rc1/arch/i386/lib/semaphore.S
--- linux-2.6.18-rc1-/arch/i386/lib/semaphore.S	2006-10-05 09:25:44.000000000 +0200
+++ linux-2.6.18-rc1/arch/i386/lib/semaphore.S	2006-10-05 10:01:01.000000000 +0200
@@ -153,6 +153,7 @@ ENTRY(__read_lock_failed)
 #endif
 
 /* Fix up special calling conventions */
+#ifdef CONFIG_RWSEM_XCHGADD_ALGORITHM
 ENTRY(call_rwsem_down_read_failed)
 	CFI_STARTPROC
 	push %ecx
@@ -214,3 +215,4 @@ ENTRY(call_rwsem_downgrade_wake)
 	CFI_ENDPROC
 	END(call_rwsem_downgrade_wake)
 
+#endif
