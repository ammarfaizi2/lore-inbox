Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267013AbSLQTws>; Tue, 17 Dec 2002 14:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbSLQTws>; Tue, 17 Dec 2002 14:52:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2569 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267013AbSLQTwH>; Tue, 17 Dec 2002 14:52:07 -0500
Date: Tue, 17 Dec 2002 12:01:06 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>
cc: Matti Aarnio <matti.aarnio@zmailer.org>, Hugh Dickins <hugh@veritas.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       <linux-kernel@vger.kernel.org>, <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3DFF80BC.2020709@redhat.com>
Message-ID: <Pine.LNX.4.44.0212171159440.1095-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


How about this diff? It does both the 6-parameter thing _and_ the
AT_SYSINFO addition. Untested, since I have to run off and watch my kids
do their winter program ;)

		Linus

-----
===== arch/i386/kernel/entry.S 1.42 vs edited =====
--- 1.42/arch/i386/kernel/entry.S	Mon Dec 16 21:39:04 2002
+++ edited/arch/i386/kernel/entry.S	Tue Dec 17 11:59:13 2002
@@ -232,7 +232,7 @@
 #endif

 /* Points to after the "sysenter" instruction in the vsyscall page */
-#define SYSENTER_RETURN 0xfffff007
+#define SYSENTER_RETURN 0xffffe007

 	# sysenter call handler stub
 	ALIGN
@@ -243,6 +243,21 @@
 	pushfl
 	pushl $(__USER_CS)
 	pushl $SYSENTER_RETURN
+
+/*
+ * Load the potential sixth argument from user stack.
+ * Careful about security.
+ */
+	cmpl $0xc0000000,%ebp
+	jae syscall_badsys
+1:	movl (%ebp),%ebp
+.section .fixup,"ax"
+2:	xorl %ebp,%ebp
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,2b
+.previous

 	pushl %eax
 	SAVE_ALL
===== arch/i386/kernel/sysenter.c 1.1 vs edited =====
--- 1.1/arch/i386/kernel/sysenter.c	Mon Dec 16 21:39:04 2002
+++ edited/arch/i386/kernel/sysenter.c	Tue Dec 17 11:39:39 2002
@@ -48,14 +48,14 @@
 		0xc3			/* ret */
 	};
 	static const char sysent[] = {
-		0x55,			/* push %ebp */
 		0x51,			/* push %ecx */
 		0x52,			/* push %edx */
+		0x55,			/* push %ebp */
 		0x89, 0xe5,		/* movl %esp,%ebp */
 		0x0f, 0x34,		/* sysenter */
+		0x5d,			/* pop %ebp */
 		0x5a,			/* pop %edx */
 		0x59,			/* pop %ecx */
-		0x5d,			/* pop %ebp */
 		0xc3			/* ret */
 	};
 	unsigned long page = get_zeroed_page(GFP_ATOMIC);
===== include/asm-i386/elf.h 1.3 vs edited =====
--- 1.3/include/asm-i386/elf.h	Thu Oct 17 00:48:55 2002
+++ edited/include/asm-i386/elf.h	Tue Dec 17 10:12:58 2002
@@ -100,6 +100,12 @@

 #define ELF_PLATFORM  (system_utsname.machine)

+/*
+ * Architecture-neutral AT_ values in 0-17, leave some room
+ * for more of them, start the x86-specific ones at 32.
+ */
+#define AT_SYSINFO	32
+
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)

@@ -115,6 +121,11 @@
 extern void dump_smp_unlazy_fpu(void);
 #define ELF_CORE_SYNC dump_smp_unlazy_fpu
 #endif
+
+#define ARCH_DLINFO					\
+do {							\
+		NEW_AUX_ENT(AT_SYSINFO, 0xffffe000);	\
+} while (0)

 #endif

===== include/asm-i386/fixmap.h 1.9 vs edited =====
--- 1.9/include/asm-i386/fixmap.h	Mon Dec 16 21:39:04 2002
+++ edited/include/asm-i386/fixmap.h	Tue Dec 17 10:11:31 2002
@@ -42,8 +42,8 @@
  * task switches.
  */
 enum fixed_addresses {
-	FIX_VSYSCALL,
 	FIX_HOLE,
+	FIX_VSYSCALL,
 #ifdef CONFIG_X86_LOCAL_APIC
 	FIX_APIC_BASE,	/* local (CPU) APIC) -- required for SMP or not */
 #endif

