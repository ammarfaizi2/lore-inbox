Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTJ0PUf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 10:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263285AbTJ0PUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 10:20:35 -0500
Received: from [212.97.163.22] ([212.97.163.22]:33004 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S263281AbTJ0PUW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 10:20:22 -0500
Date: Mon, 27 Oct 2003 16:20:01 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: FEATURE REQUEST: Specific Processor Optimizations on x86 Architecture
Message-ID: <20031027152001.GC27333@werewolf.able.es>
References: <200310221855.15925.theman@josephdwagner.info> <20031023230542.GC2084@werewolf.able.es> <200310241301.41230.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200310241301.41230.ioe-lkml@rameria.de> (from ioe-lkml@rameria.de on Fri, Oct 24, 2003 at 13:01:41 +0200)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10.24, Ingo Oeser wrote:
> Hi James,
> 
> On Friday 24 October 2003 01:05, J.A. Magallon wrote:
> > There are some other specific code that could be used in the kernel,
> > for example mb() and so on can be implemented with {m,s,l}fence in p3/p4
> > processors, instead of the old 'lock; insn' (attached also).
> 
> The sfence part might be ok (modulo errata not known to me), but
> replacing "This Barrier not needed on x86" with an instruction means,
> that either these instructions are NOPs or we have a real BUG there.
> 
> Not using these mfence and lfence insn would mean less instructions,
> which is a good kernel optimization anyway ;-)
> 
> Puzzled
> 

Patch inlined. Credits should go to Zwane Mwaikambo <zwane@linux.realnet.co.sz>.
It adds the corresponding flags for PII) and P4, and in case thei are defined,
the *fence insn are used.

Included is also one other patch by Zwane, which states that smp_call_function
needs mb() instead of wmb().

I use them regularly, so they look safe. Are they really better ? At least they
do not touch any register, like the trick used till now.

22-x86-mb:

--- linux-2.4.21-pre5-jam1/arch/i386/config.in.orig	2003-03-07 03:50:19.000000000 +0100
+++ linux-2.4.21-pre5-jam1/arch/i386/config.in	2003-03-07 03:50:47.000000000 +0100
@@ -113,6 +113,7 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_SFENCE y
 fi
 if [ "$CONFIG_MPENTIUM4" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 7
@@ -121,6 +122,9 @@
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_F00F_WORKS_OK y
+   define_bool CONFIG_X86_SFENCE y
+   define_bool CONFIG_X86_LFENCE y
+   define_bool CONFIG_X86_MFENCE y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
--- linux-2.4.21-pre5-jam1/include/asm-i386/system.h.orig	2003-03-07 03:51:31.000000000 +0100
+++ linux-2.4.21-pre5-jam1/include/asm-i386/system.h	2003-03-07 03:51:40.000000000 +0100
@@ -290,16 +290,33 @@
  *
  * Some non intel clones support out of order store. wmb() ceases to be a
  * nop for these.
+ *
+ * Pentium III introduced the SFENCE instruction for serialising all store
+ * operations, Pentium IV further introduced LFENCE and MFENCE for load and
+ * memory barriers respecively.
  */
- 
+
+#ifdef CONFIG_X86_MFENCE
+#define mb()	__asm__ __volatile__ ("mfence": : :"memory")
+#else
 #define mb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
+#endif
+
+#ifdef CONFIG_X86_LFENCE
+#define rmb()	__asm__ __volatile__ ("lfence": : :"memory")
+#else
 #define rmb()	mb()
+#endif
 
+#ifdef CONFIG_X86_SFENCE
+#define wmb()	__asm__ __volatile__ ("sfence": : :"memory")
+#else
 #ifdef CONFIG_X86_OOSTORE
 #define wmb() 	__asm__ __volatile__ ("lock; addl $0,0(%%esp)": : :"memory")
 #else
 #define wmb()	__asm__ __volatile__ ("": : :"memory")
 #endif
+#endif /* CONFIG_X86_SFENCE */
 
 #ifdef CONFIG_SMP
 #define smp_mb()	mb()

009-smp-call-mb:

diff -u -p -B -r1.2 smp.c
--- linux-2.4.20/arch/i386/kernel/smp.c	11 Apr 2003 13:44:11 -0000	1.2
+++ linux-2.4.20/arch/i386/kernel/smp.c	11 Apr 2003 13:44:27 -0000
@@ -553,7 +553,7 @@ int smp_call_function (void (*func) (voi
 
 	spin_lock(&call_lock);
 	call_data = &data;
-	wmb();
+	mb();
 	/* Send a message to all other CPUs and wait for them to respond */
 	send_IPI_allbutself(CALL_FUNCTION_VECTOR);
 

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre8-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
