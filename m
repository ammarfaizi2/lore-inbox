Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265171AbSLQSPz>; Tue, 17 Dec 2002 13:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265230AbSLQSPz>; Tue, 17 Dec 2002 13:15:55 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50192 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265171AbSLQSPx>; Tue, 17 Dec 2002 13:15:53 -0500
Date: Tue, 17 Dec 2002 10:24:44 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>
cc: Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <hpa@transmeta.com>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212170948380.2702-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212171017590.2702-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Dec 2002, Linus Torvalds wrote:
>
> Uli, how about I just add one ne warchitecture-specific ELF AT flag, which
> is the "base of sysinfo page". Right now that page is all zeroes except
> for the system call trampoline at the beginning, but we might want to add
> other system information to the page in the future (it is readable, after
> all).

Here's the suggested (totally untested as of yet) patch:

 - it moves the system call page to 0xffffe000 instead, leaving an
   unmapped page at the very top of the address space. So trying to
   dereference -1 will cause a SIGSEGV.

 - it adds the AT_SYSINFO elf entry on x86 that points to the system page.

Thus glibc startup should be able to just do

	ptr = default_int80_syscall;
	if (AT_SYSINFO entry found)
		ptr = value(AT_SYSINFO)

and then you can just do a

	call *ptr

to do a system call regardless of kernel version. This also allows the
kernel to later move the page around as it sees fit.

The advantage of using an AT_SYSINFO entry is that

 - no new system call needed to figure anything out
 - backwards compatibility (ie old kernels automatically detected)
 - I think glibc already parses the AT entries at startup anyway

so it _looks_ like a perfect way to do this.

		Linus

----
===== arch/i386/kernel/entry.S 1.42 vs edited =====
--- 1.42/arch/i386/kernel/entry.S	Mon Dec 16 21:39:04 2002
+++ edited/arch/i386/kernel/entry.S	Tue Dec 17 10:13:16 2002
@@ -232,7 +232,7 @@
 #endif

 /* Points to after the "sysenter" instruction in the vsyscall page */
-#define SYSENTER_RETURN 0xfffff007
+#define SYSENTER_RETURN 0xffffe007

 	# sysenter call handler stub
 	ALIGN
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

