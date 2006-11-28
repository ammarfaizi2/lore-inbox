Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755650AbWK1XK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755650AbWK1XK7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 18:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627AbWK1XK7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 18:10:59 -0500
Received: from gw.goop.org ([64.81.55.164]:46231 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1755314AbWK1XK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 18:10:58 -0500
Message-ID: <456CC25C.6070005@goop.org>
Date: Tue, 28 Nov 2006 15:12:28 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Eric Dumazet <dada1@cosmosbay.com>
CC: akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>, ak@suse.de,
       mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386-pda UP optimization
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <4506665D.2090001@goop.org> <1158047806.2992.7.camel@laptopd505.fenrus.org> <200611151227.04777.dada1@cosmosbay.com>
In-Reply-To: <200611151227.04777.dada1@cosmosbay.com>
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Dumazet wrote:
> Seeing %gs prefixes used now by i386 port, I recalled seeing strange oprofile 
> results on Opteron machines.

Hi Eric,

Could you try this patch out and see if it makes much performance
difference for you.  You should apply this on top of the %fs patch I
posted earlier (and use the %fs patch as the baseline for your comparisons).

Thanks,
    J

Don't bother with segment references for UP PDA

When compiled for UP, don't bother prefixing PDA references with a
segment override.  Also doesn't bother reloading the PDA segment
register (though it still gets saved and restored, because the value
is used elsewhere in the kernel, and the restore is necessary for
correct context switches).

I'm not very keen on the extra #ifdefs this adds, though I've tried to
keep them minimal.  Eric Dumazet reports small performance gains from
similar patch however.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <andi@muc.de>
Cc: Eric Dumazet <dada1@cosmosbay.com>

diff -r 022c29ea754e arch/i386/kernel/cpu/common.c
--- a/arch/i386/kernel/cpu/common.c	Tue Nov 21 18:54:56 2006 -0800
+++ b/arch/i386/kernel/cpu/common.c	Wed Nov 22 01:54:02 2006 -0800
@@ -628,7 +628,11 @@ static __cpuinit int alloc_gdt(int cpu)
 		BUG_ON(gdt != NULL || pda != NULL);
 
 		gdt = alloc_bootmem_pages(PAGE_SIZE);
+#ifdef CONFIG_SMP
+		pda = &boot_pda;
+#else
 		pda = alloc_bootmem(sizeof(*pda));
+#endif
 		/* alloc_bootmem(_pages) panics on failure, so no check */
 
 		memset(gdt, 0, PAGE_SIZE);
@@ -661,6 +665,10 @@ struct i386_pda boot_pda = {
 	.cpu_number = 0,
 	.pcurrent = &init_task,
 };
+#ifndef CONFIG_SMP
+/* boot_pda is used for all PDA access in UP */
+EXPORT_SYMBOL(boot_pda);
+#endif
 
 static inline void set_kernel_fs(void)
 {
diff -r 022c29ea754e arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Tue Nov 21 18:54:56 2006 -0800
+++ b/arch/i386/kernel/entry.S	Wed Nov 22 13:38:56 2006 -0800
@@ -97,6 +97,16 @@ 1:
 #define resume_userspace_sig	resume_userspace
 #endif
 
+#ifdef CONFIG_SMP
+#define LOAD_PDA_SEG(reg)	\
+	movl $(__KERNEL_PDA), reg; \
+	movl reg, %fs
+#define CUR_CPU(reg)	movl %fs:PDA_cpu, reg
+#else
+#define LOAD_PDA_SEG(reg)
+#define CUR_CPU(reg)	movl boot_pda+PDA_cpu, reg
+#endif
+	
 #define SAVE_ALL \
 	cld; \
 	pushl %fs; \
@@ -132,8 +142,7 @@ 1:
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
-	movl $(__KERNEL_PDA), %edx; \
-	movl %edx, %fs
+	LOAD_PDA_SEG(%edx)
 
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
@@ -546,7 +555,7 @@ syscall_badsys:
 
 #define FIXUP_ESPFIX_STACK \
 	/* since we are on a wrong stack, we cant make it a C code :( */ \
-	movl %fs:PDA_cpu, %ebx; \
+	CUR_CPU(%ebx); \
 	PER_CPU(cpu_gdt_descr, %ebx); \
 	movl GDS_address(%ebx), %ebx; \
 	GET_DESC_BASE(GDT_ENTRY_ESPFIX_SS, %ebx, %eax, %ax, %al, %ah); \
diff -r 022c29ea754e include/asm-i386/pda.h
--- a/include/asm-i386/pda.h	Tue Nov 21 18:54:56 2006 -0800
+++ b/include/asm-i386/pda.h	Wed Nov 22 02:35:24 2006 -0800
@@ -22,6 +22,16 @@ extern struct i386_pda *_cpu_pda[];
 
 #define cpu_pda(i)	(_cpu_pda[i])
 
+/* Use boot-time PDA for UP.  For SMP we still need to declare it, but
+   it isn't used. */
+extern struct i386_pda boot_pda;
+
+#ifdef CONFIG_SMP
+#define PDA_REF		"%%fs:%c[off]"
+#else
+#define PDA_REF		"%[mem]"
+#endif
+
 #define pda_offset(field) offsetof(struct i386_pda, field)
 
 extern void __bad_pda_field(void);
@@ -33,28 +43,31 @@ extern void __bad_pda_field(void);
    clobbers, so gcc can readily analyse them. */
 extern struct i386_pda _proxy_pda;
 
-#define pda_to_op(op,field,val)						\
+#define pda_to_op(op,field,_val)					\
 	do {								\
 		typedef typeof(_proxy_pda.field) T__;			\
-		if (0) { T__ tmp__; tmp__ = (val); }			\
+		if (0) { T__ tmp__; tmp__ = (_val); }			\
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
-			asm(op "b %1,%%fs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
-			    :"ri" ((T__)val),				\
-			     "i"(pda_offset(field)));			\
+			asm(op "b %[val]," PDA_REF			\
+			    : "+m" (_proxy_pda.field),			\
+			      [mem] "+m" (boot_pda.field)		\
+			    : [val] "ri" ((T__)_val),			\
+			      [off] "i" (pda_offset(field)));		\
 			break;						\
 		case 2:							\
-			asm(op "w %1,%%fs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
-			    :"ri" ((T__)val),				\
-			     "i"(pda_offset(field)));			\
+			asm(op "w %[val]," PDA_REF			\
+			    : "+m" (_proxy_pda.field),			\
+			      [mem] "+m" (boot_pda.field)		\
+			    : [val] "ri" ((T__)_val),			\
+			      [off] "i" (pda_offset(field)));		\
 			break;						\
 		case 4:							\
-			asm(op "l %1,%%fs:%c2"				\
-			    : "+m" (_proxy_pda.field)			\
-			    :"ri" ((T__)val),				\
-			     "i"(pda_offset(field)));			\
+			asm(op "l %[val]," PDA_REF			\
+			    : "+m" (_proxy_pda.field),			\
+			      [mem] "+m" (boot_pda.field)		\
+			    : [val] "ri" ((T__)_val),			\
+			      [off] "i" (pda_offset(field)));		\
 			break;						\
 		default: __bad_pda_field();				\
 		}							\
@@ -65,22 +78,25 @@ extern struct i386_pda _proxy_pda;
 		typeof(_proxy_pda.field) ret__;				\
 		switch (sizeof(_proxy_pda.field)) {			\
 		case 1:							\
-			asm(op "b %%fs:%c1,%0"				\
-			    : "=r" (ret__)				\
-			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			asm(op "b " PDA_REF ",%[ret]"			\
+			    : [ret] "=r" (ret__)			\
+			    : [off] "i" (pda_offset(field)),		\
+			      "m" (_proxy_pda.field),			\
+			      [mem] "m" (boot_pda.field));		\
 			break;						\
 		case 2:							\
-			asm(op "w %%fs:%c1,%0"				\
-			    : "=r" (ret__)				\
-			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			asm(op "w " PDA_REF ",%[ret]"			\
+			    : [ret] "=r" (ret__)			\
+			    : [off] "i" (pda_offset(field)),		\
+			      "m" (_proxy_pda.field),			\
+			      [mem] "m" (boot_pda.field));		\
 			break;						\
 		case 4:							\
-			asm(op "l %%fs:%c1,%0"				\
-			    : "=r" (ret__)				\
-			    : "i" (pda_offset(field)),			\
-			      "m" (_proxy_pda.field));			\
+			asm(op "l " PDA_REF ",%[ret]"			\
+			    : [ret] "=r" (ret__)			\
+			    : [off] "i" (pda_offset(field)),		\
+			      "m" (_proxy_pda.field),			\
+			      [mem] "m" (boot_pda.field));		\
 			break;						\
 		default: __bad_pda_field();				\
 		}							\


