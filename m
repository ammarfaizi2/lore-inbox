Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWBTNj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWBTNj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030223AbWBTNj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:39:59 -0500
Received: from mail.renesas.com ([202.234.163.13]:13530 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1030217AbWBTNj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:39:58 -0500
Date: Mon, 20 Feb 2006 22:39:52 +0900 (JST)
Message-Id: <20060220.223952.1025207799.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Al Viro <viro@ftp.linux.org.uk>,
       takata@linux-m32r.org
Subject: [PATCH 2.6.16-rc3] m32r: update sys_tas() routine
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

This patch updates and fixes sys_tas() routine for m32r.

In the previous implementation, a lockup rarely caused at sys_tas()
routine in SMP environment.

> > The problem is that touching *addr will generate an oops if that page isn't
> > paged in.  If we convert it to use get_user() then that's an improvement,
> > but we must not run get_user() under spinlock or local_irq_disable().

I rewrote sys_tas() routine by using "lock -> unlock" instructions,
and utilizing the m32r's interrupt handling characteristics;
the m32r processor can accept interrupts only at the 32-bit instruction
boundary. So, the "unlock" instruction can be executed continuously
after the "lock" instruction execution without any interruptions.

In addition, to solve such a page_fault problem, I use a fixup code
like get_user().

And, as for the kernel lockup problem, we found that a calling 
do_page_fault() routine with disabling interrupts might cause
a lockup at flush_tlb_others(), because we checked a completion
of IPI handler's operations in a spin-locked critical section.

Therefore, by using "lock -> unlock" code, we can implement 
the sys_tas() rouitine without disabling interrupts explicitly,
then no lockups would happen at flush_tlb_others(), I hope.

Compile check and some working test in SMP environment have done.

-- Takata


From: Hirokazu Takata <takata@linux-m32r.org>
Subject: Re: [WTF?] sys_tas() on m32r
Date: Tue, 27 Dec 2005 14:27:39 +0900 (JST)
> Hi,
> 
> From: Andrew Morton <akpm@osdl.org>
> Date: Fri, 23 Dec 2005 05:55:26 -0800
> > Al Viro <viro@ftp.linux.org.uk> wrote:
> > >
> > > asmlinkage int sys_tas(int *addr)
> > > {
> > >         int oldval;
> > >         unsigned long flags;
> > > 
> > >         if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
> > >                 return -EFAULT;
> > >         local_irq_save(flags);
> > >         oldval = *addr;
> > >         if (!oldval)
> > >                 *addr = 1;
> > >         local_irq_restore(flags);
> > >         return oldval;
> > > }
> > > in arch/m32r/kernel/sys_m32r.c.  Trivial oops *AND* ability to trigger
> > > IO with interrupts disabled.
> > 
> > Yeah.  I pointed this out to Takata in October last year and then promptly
> > forgot about it. It's rather amazing that this code (which appears to be in
> > live use in linuxthreads) hasn't generated oopses.
> 
> Yes, I remember it.
> 
> > The problem is that touching *addr will generate an oops if that page isn't
> > paged in.  If we convert it to use get_user() then that's an improvement,
> > but we must not run get_user() under spinlock or local_irq_disable().
> 
> Exactly. 
> This problem has been bothering me, but I cannot find a good solusion...


Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/sys_m32r.c |   61 ++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

Index: linux-2.6.16-rc1/arch/m32r/kernel/sys_m32r.c
===================================================================
--- linux-2.6.16-rc1.orig/arch/m32r/kernel/sys_m32r.c	2006-01-31 21:47:06.918951364 +0900
+++ linux-2.6.16-rc1/arch/m32r/kernel/sys_m32r.c	2006-01-31 21:58:21.733388614 +0900
@@ -29,28 +29,7 @@
 
 /*
  * sys_tas() - test-and-set
- * linuxthreads testing version
  */
-#ifndef CONFIG_SMP
-asmlinkage int sys_tas(int *addr)
-{
-	int oldval;
-	unsigned long flags;
-
-	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
-		return -EFAULT;
-	local_irq_save(flags);
-	oldval = *addr;
-	if (!oldval)
-		*addr = 1;
-	local_irq_restore(flags);
-	return oldval;
-}
-#else /* CONFIG_SMP */
-#include <linux/spinlock.h>
-
-static DEFINE_SPINLOCK(tas_lock);
-
 asmlinkage int sys_tas(int *addr)
 {
 	int oldval;
@@ -58,15 +37,43 @@ asmlinkage int sys_tas(int *addr)
 	if (!access_ok(VERIFY_WRITE, addr, sizeof (int)))
 		return -EFAULT;
 
-	_raw_spin_lock(&tas_lock);
-	oldval = *addr;
-	if (!oldval)
-		*addr = 1;
-	_raw_spin_unlock(&tas_lock);
+	/* atomic operation:
+	 *   oldval = *addr; *addr = 1;
+	 */
+	__asm__ __volatile__ (
+		DCACHE_CLEAR("%0", "r4", "%1")
+		"	.fillinsn\n"
+		"1:\n"
+		"	lock	%0, @%1	    ->	unlock	%2, @%1\n"
+		"2:\n"
+		/* NOTE:
+		 *   The m32r processor can accept interrupts only
+		 *   at the 32-bit instruction boundary.
+		 *   So, in the above code, the "unlock" instruction
+		 *   can be executed continuously after the "lock"
+		 *   instruction execution without any interruptions.
+		 */
+		".section .fixup,\"ax\"\n"
+		"	.balign 4\n"
+		"3:	ldi	%0, #%3\n"
+		"	seth	r14, #high(2b)\n"
+		"	or3	r14, r14, #low(2b)\n"
+		"	jmp	r14\n"
+		".previous\n"
+		".section __ex_table,\"a\"\n"
+		"	.balign 4\n"
+		"	.long 1b,3b\n"
+		".previous\n"
+		: "=&r" (oldval)
+		: "r" (addr), "r" (1), "i"(-EFAULT)
+		: "r14", "memory"
+#ifdef CONFIG_CHIP_M32700_TS1
+		  , "r4"
+#endif /* CONFIG_CHIP_M32700_TS1 */
+	);
 
 	return oldval;
 }
-#endif /* CONFIG_SMP */
 
 /*
  * sys_pipe() is the normal C calling standard for creating

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/

