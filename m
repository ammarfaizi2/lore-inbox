Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030737AbWKORq3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030737AbWKORq3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030745AbWKORq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:46:29 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:8100 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1030737AbWKORq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:46:28 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Wed, 15 Nov 2006 18:46:30 +0100
User-Agent: KMail/1.9.5
Cc: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org,
       Arjan van de Ven <arjan@infradead.org>,
       Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <20061115172003.GA20403@elte.hu> <200611151824.36198.ak@suse.de>
In-Reply-To: <200611151824.36198.ak@suse.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_3J1WF+BWSp4NCve"
Message-Id: <200611151846.31109.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_3J1WF+BWSp4NCve
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 15 November 2006 18:24, Andi Kleen wrote:
> On Wednesday 15 November 2006 18:20, Ingo Molnar wrote:
> > * Andi Kleen <ak@suse.de> wrote:
> > > On Wednesday 15 November 2006 12:27, Eric Dumazet wrote:
> > > > Seeing %gs prefixes used now by i386 port, I recalled seeing strange
> > > > oprofile results on Opteron machines.
> > > >
> > > > I really think %gs prefixes can be expensive in some (most ?) cases,
> > > > even if the Intel/AMD docs say they are free.
> > >
> > > They aren't free, just very cheap.
> >
> > Eric's test shows a 5% slowdown. That's far from cheap.
>
> I have my doubts about the accuracy of his test results. That is why I
> asked him to double check.

Fair enough :)

I plan doing *lot* of tests as soon as possible (not possible during daytime 
unfortunately, I miss a dev machine)

By the way, I tried this patch to avoid reload %gs at syscall start. Since %gs 
is not anymore used inside kernel (after i386-pda UP optimization is 
applied) : We can let in %gs the User Program %gs value. (I still force a 
reload of %gs before syscall exit of course)

Machine boots but freeze when init starts. Any idea ?

Thank you
Eric

--Boundary-00=_3J1WF+BWSp4NCve
Content-Type: text/plain;
  charset="iso-8859-1";
  name="entry.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="entry.patch"

--- linux-2.6.19-rc5-mm2/arch/i386/kernel/entry.S	2006-11-15 11:21:25.000000000 +0100
+++ linux-2.6.19-rc5-mm2-ed/arch/i386/kernel/entry.S	2006-11-15 18:40:53.000000000 +0100
@@ -97,6 +97,16 @@
 #define resume_userspace_sig	resume_userspace
 #endif
 
+/*
+ * On UP, we dont need to change %gs since PDA accesses dont use %gs
+ */
+#if defined(CONFIG_SMP)
+#define LOAD_KERNEL_GS(reg)	movl $(__KERNEL_PDA), reg; \
+	movl reg, %gs
+#else
+#define LOAD_KERNEL_GS(reg)
+#endif
+
 #define SAVE_ALL \
 	cld; \
 	pushl %gs; \
@@ -132,8 +142,7 @@
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
-	movl $(__KERNEL_PDA), %edx; \
-	movl %edx, %gs
+	LOAD_KERNEL_GS(%edx);
 
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
@@ -544,9 +553,15 @@
 	jmp resume_userspace
 	CFI_ENDPROC
 
+#ifdef CONFIG_SMP
+# define GET_CPU_NUM(reg) movl %gs:PDA_cpu, reg;
+#else
+# define GET_CPU_NUM(reg)
+#endif
+
 #define FIXUP_ESPFIX_STACK \
 	/* since we are on a wrong stack, we cant make it a C code :( */ \
-	movl %gs:PDA_cpu, %ebx; \
+	GET_CPU_NUM(%ebx) \
 	PER_CPU(cpu_gdt_descr, %ebx); \
 	movl GDS_address(%ebx), %ebx; \
 	GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah); \
@@ -660,8 +675,7 @@
 	pushl %gs
 	CFI_ADJUST_CFA_OFFSET 4
 	/*CFI_REL_OFFSET gs, 0*/
-	movl $(__KERNEL_PDA), %ecx
-	movl %ecx, %gs
+	LOAD_KERNEL_GS(%ecx)
 	UNWIND_ESPFIX_STACK
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4

--Boundary-00=_3J1WF+BWSp4NCve--
