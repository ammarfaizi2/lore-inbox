Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161179AbWKEG5f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161179AbWKEG5f (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:57:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161173AbWKEG5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:57:35 -0500
Received: from ns2.suse.de ([195.135.220.15]:15756 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161184AbWKEG5e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:57:34 -0500
From: Andi Kleen <ak@suse.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs =?iso-8859-15?q?for=09paravirtualizing_critical?= operations
Date: Sun, 5 Nov 2006 07:57:21 +0100
User-Agent: KMail/1.9.5
Cc: Zachary Amsden <zach@vmware.com>, Chris Wright <chrisw@sous-sol.org>,
       virtualization@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <20061029024504.760769000@sous-sol.org> <200611050646.15334.ak@suse.de> <1162707685.29777.53.camel@localhost.localdomain>
In-Reply-To: <1162707685.29777.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611050757.21709.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> If Andrew says we have to get those patches into mainline through you,

Well I'm mainline in this case.


> then I'll spend all that time re-spinning the patches for you from the
> -mm tree until they go in.  

I got it to compile now with this patch (+ one additional patch
that is folded in). It then goes through kernel initialization
and then init gets killed with "Inconsistency detected by rtld.c:1250:
Assertation ph_vaddr == _rtld_local.dl_sysinfo_vdso failed"

It looks like some of the ifdefs were placed completely wrong
and in addition you were missing a patch to include asm/offset.h
everywhere as assembly (I patched around that). And two macros
were apparently never compiled in their current form.

But it seems it is dependent on even more -mm* magic than just
that. If you can identify the missing patches that make init's
rtld work again that would be useful.

-Andi

Get paravirt ops to compile

TBD should be folded into the original patches

Unfortunately still doesn't boot.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/include/asm-i386/desc.h
===================================================================
--- linux.orig/include/asm-i386/desc.h
+++ linux/include/asm-i386/desc.h
@@ -92,6 +92,9 @@ static inline void write_dt_entry(void *
 #define write_gdt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
 #define write_idt_entry(dt, entry, a, b) write_dt_entry(dt, entry, a, b)
 
+#define set_ldt native_set_ldt
+#endif /* CONFIG_PARAVIRT */
+
 static inline void _set_gate(int gate, unsigned int type, void *addr, unsigned short seg)
 {
 	__u32 a, b;
@@ -108,9 +111,6 @@ static inline void __set_tss_desc(unsign
 	write_gdt_entry(get_cpu_gdt_table(cpu), entry, a, b);
 }
 
-#define set_ldt native_set_ldt
-#endif /* CONFIG_PARAVIRT */
-
 static inline fastcall void native_set_ldt(const void *addr,
 					   unsigned int entries)
 {
Index: linux/include/asm-i386/paravirt.h
===================================================================
--- linux.orig/include/asm-i386/paravirt.h
+++ linux/include/asm-i386/paravirt.h
@@ -454,16 +454,20 @@ static inline unsigned long __raw_local_
 	return f;
 }
 
-#define CLI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
-		     "call *paravirt_ops+PARAVIRT_irq_disable;"		\
-		     "popl %edx; popl %ecx",				\
+#define CLI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+		     "call *paravirt_ops+%c[irq_disable];"		\
+		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_DISABLE, CLBR_EAX)
 
-#define STI_STRING paravirt_alt("pushl %ecx; pushl %edx;"		\
-		     "call *paravirt_ops+PARAVIRT_irq_enable;"		\
-		     "popl %edx; popl %ecx",				\
+#define STI_STRING paravirt_alt("pushl %%ecx; pushl %%edx;"		\
+		     "call *paravirt_ops+%c[irq_enable];"		\
+		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
 #define CLI_STI_CLOBBERS , "%eax"
+#define CLI_STI_INPUT_ARGS \
+	,								\
+	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
+	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
 
 #else  /* __ASSEMBLY__ */
 
Index: linux/include/asm-i386/spinlock.h
===================================================================
--- linux.orig/include/asm-i386/spinlock.h
+++ linux/include/asm-i386/spinlock.h
@@ -13,6 +13,7 @@
 #define CLI_STRING	"cli"
 #define STI_STRING	"sti"
 #define CLI_STI_CLOBBERS
+#define CLI_STI_INPUT_ARGS
 #endif /* CONFIG_PARAVIRT */
 
 /*
@@ -58,26 +59,27 @@ static inline void __raw_spin_lock_flags
 {
 	asm volatile(
 		"\n1:\t"
-		LOCK_PREFIX " ; decb %0\n\t"
+		LOCK_PREFIX " ; decb %[slock]\n\t"
 		"jns 5f\n"
 		"2:\t"
-		"testl $0x200, %1\n\t"
+		"testl $0x200, %[flags]\n\t"
 		"jz 4f\n\t"
 		STI_STRING "\n"
 		"3:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %0\n\t"
+		"cmpb $0, %[slock]\n\t"
 		"jle 3b\n\t"
 		CLI_STRING "\n\t"
 		"jmp 1b\n"
 		"4:\t"
 		"rep;nop\n\t"
-		"cmpb $0, %0\n\t"
+		"cmpb $0, %[slock]\n\t"
 		"jg 1b\n\t"
 		"jmp 4b\n"
 		"5:\n\t"
-		: "+m" (lock->slock)
-		: "r" (flags)
+		: [slock] "+m" (lock->slock)
+		: [flags] "r" (flags) 
+	 	  CLI_STI_INPUT_ARGS
 		: "memory" CLI_STI_CLOBBERS);
 }
 #endif
Index: linux/include/asm-i386/processor.h
===================================================================
--- linux.orig/include/asm-i386/processor.h
+++ linux/include/asm-i386/processor.h
@@ -511,6 +511,7 @@ static inline void load_esp0(struct tss_
 		wrmsr(MSR_IA32_SYSENTER_CS, thread->sysenter_cs, 0);
 	}
 }
+#endif
 
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs": :"r" (0));			\
@@ -524,6 +525,7 @@ static inline void load_esp0(struct tss_
 	regs->esp = new_esp;					\
 } while (0)
 
+#ifndef CONFIG_PARAVIRT
 /*
  * These special macros can be used to get or set a debugging register
  */
