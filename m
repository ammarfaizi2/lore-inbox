Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTDMWYF (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTDMWYF (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:24:05 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:44183
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S262609AbTDMWX4 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:23:56 -0400
Message-ID: <3E99E620.7060907@redhat.com>
Date: Sun, 13 Apr 2003 15:35:12 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030412
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: unwinding for vsyscall code
References: <3E98E01C.3070103@redhat.com> <20030413141028.A3683@twiddle.net>
In-Reply-To: <20030413141028.A3683@twiddle.net>
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA8962D3E27C54893810C19EC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA8962D3E27C54893810C19EC
Content-Type: multipart/mixed;
 boundary="------------030209020106000607070707"

This is a multi-part message in MIME format.
--------------030209020106000607070707
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Richard Henderson wrote:

> So you also need a
> 
> 	0x85 0x04			DW_CFA_offset %ebp -16
> [...]

Updated patch attached.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------030209020106000607070707
Content-Type: text/plain;
 name="d-kernel-eh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-kernel-eh"

--- linux-2.5/arch/i386/kernel/sysenter.c-eh	2003-04-13 15:32:51.000000000 -0700
+++ linux-2.5/arch/i386/kernel/sysenter.c	2003-04-13 15:30:22.000000000 -0700
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/gfp.h>
 #include <linux/string.h>
+#include <linux/elf.h>
 
 #include <asm/cpufeature.h>
 #include <asm/msr.h>
@@ -52,11 +53,47 @@ void enable_sep_cpu(void *info)
 
 static int __init sysenter_setup(void)
 {
-	static const char int80[] = {
+	static const char __initdata int80[] = {
 		0xcd, 0x80,		/* int $0x80 */
 		0xc3			/* ret */
 	};
-	static const char sysent[] = {
+	/* Unwind information for the int80 code.  Keep track of
+	   where the return address is stored.  */
+	static const char __initdata int80_eh_frame[] = {
+	/* First the Common Information Entry (CIE):  */
+		0x14, 0x00, 0x00, 0x00,	/* Length of the CIE */
+		0x00, 0x00, 0x00, 0x00,	/* CIE Identifier Tag */
+		0x01,			/* CIE Version */
+		'z', 'R', 0x00,		/* CIE Augmentation */
+		0x01,			/* CIE Code Alignment Factor */
+		0x7c,			/* CIE Data Alignment Factor */
+		0x08,			/* CIE RA Column */
+		0x01,			/* Augmentation size */
+		0x1b,			/* FDE Encoding (pcrel sdata4) */
+		0x0c,			/* DW_CFA_def_cfa */
+		0x04,
+		0x04,
+		0x88,			/* DW_CFA_offset, column 0x8 */
+		0x01,
+		0x00,			/* padding */
+		0x00,
+	/* Now the FDE which contains the instructions for the frame.  */
+		0x0a, 0x00, 0x00, 0x00,	/* FDE Length */
+		0x1c, 0x00, 0x00, 0x00,	/* FDE CIE offset */
+	/* The PC-relative offset to the beginning of the code this
+	   FDE covers.  The computation below assumes that the offset
+	   can be represented in one byte.  Change if this is not true
+	   anymore.  The offset from the beginning of the .eh_frame
+	   is represented by EH_FRAME_OFFSET.  The word with the offset
+	   starts at byte 0x20 of the .eh_frame.  */
+		0x100 - (EH_FRAME_OFFSET + 0x20),
+		0xff, 0xff, 0xff,	/* FDE initial location */
+		3,			/* FDE address range */
+		0x00			/* Augmentation size */
+	/* The code does not change the stack pointer.  We need not
+	   record any operations.  */
+	};
+	static const char __initdata sysent[] = {
 		0x51,			/* push %ecx */
 		0x52,			/* push %edx */
 		0x55,			/* push %ebp */
@@ -76,13 +113,71 @@ static int __init sysenter_setup(void)
 		0x59,			/* pop %ecx */
 		0xc3			/* ret */
 	};
-	static const char sigreturn[] = {
+	/* Unwind information for the sysenter code.  Keep track of
+	   where the return address is stored.  */
+	static const char __initdata sysent_eh_frame[] = {
+	/* First the Common Information Entry (CIE):  */
+		0x14, 0x00, 0x00, 0x00,	/* Length of the CIE */
+		0x00, 0x00, 0x00, 0x00,	/* CIE Identifier Tag */
+		0x01,			/* CIE Version */
+		'z', 'R', 0x00,		/* CIE Augmentation */
+		0x01,			/* CIE Code Alignment Factor */
+		0x7c,			/* CIE Data Alignment Factor */
+		0x08,			/* CIE RA Column */
+		0x01,			/* Augmentation size */
+		0x1b,			/* FDE Encoding (pcrel sdata4) */
+		0x0c,			/* DW_CFA_def_cfa */
+		0x04,
+		0x04,
+		0x88,			/* DW_CFA_offset, column 0x8 */
+		0x01,
+		0x00,			/* padding */
+		0x00,
+	/* Now the FDE which contains the instructions for the frame.  */
+		0x22, 0x00, 0x00, 0x00,	/* FDE Length */
+		0x1c, 0x00, 0x00, 0x00,	/* FDE CIE offset */
+	/* The PC-relative offset to the beginning of the code this
+	   FDE covers.  The computation below assumes that the offset
+	   can be represented in one byte.  Change if this is not true
+	   anymore.  The offset from the beginning of the .eh_frame
+	   is represented by EH_FRAME_OFFSET.  The word with the offset
+	   starts at byte 0x20 of the .eh_frame.  */
+		0x100 - (EH_FRAME_OFFSET + 0x20),
+		0xff, 0xff, 0xff,	/* FDE initial location */
+		0x14, 0x00, 0x00, 0x00,	/* FDE address range */
+		0x00,			/* Augmentation size */
+	/* What follows are the instructions for the table generation.
+	   We have to record all changes of the stack pointer and
+	   callee-saved registers.  */
+		0x41,			/* DW_CFA_advance_loc+1, push %ecx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x08,			/* RA at offset 8 now */
+		0x41,			/* DW_CFA_advance_loc+1, push %edx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x0c,			/* RA at offset 12 now */
+		0x41,			/* DW_CFA_advance_loc+1, push %ebp */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x10,			/* RA at offset 16 now */
+		0x85, 0x04,		/* DW_CFA_offset %ebp -16 */
+	/* Finally the epilogue.  */
+		0x4e,			/* DW_CFA_advance_loc+14, pop %ebx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x12,			/* RA at offset 12 now */
+		0xc5,			/* DW_CFA_restore %ebp */
+		0x41,			/* DW_CFA_advance_loc+1, pop %edx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x08,			/* RA at offset 8 now */
+		0x41,			/* DW_CFA_advance_loc+1, pop %ecx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x04			/* RA at offset 4 now */
+	};
+	static const char __initdata sigreturn[] = {
 	/* 32: sigreturn point */
 		0x58,				/* popl %eax */
 		0xb8, __NR_sigreturn, 0, 0, 0,	/* movl $__NR_sigreturn, %eax */
 		0xcd, 0x80,			/* int $0x80 */
 	};
-	static const char rt_sigreturn[] = {
+	static const char __initdata rt_sigreturn[] = {
 	/* 64: rt_sigreturn point */
 		0xb8, __NR_rt_sigreturn, 0, 0, 0,	/* movl $__NR_rt_sigreturn, %eax */
 		0xcd, 0x80,			/* int $0x80 */
@@ -93,10 +188,14 @@ static int __init sysenter_setup(void)
 	memcpy((void *) page, int80, sizeof(int80));
 	memcpy((void *)(page + 32), sigreturn, sizeof(sigreturn));
 	memcpy((void *)(page + 64), rt_sigreturn, sizeof(rt_sigreturn));
+	memcpy((void *)(page + EH_FRAME_OFFSET), int80_eh_frame,
+	       sizeof(int80_eh_frame));
 	if (!boot_cpu_has(X86_FEATURE_SEP))
 		return 0;
 
 	memcpy((void *) page, sysent, sizeof(sysent));
+	memcpy((void *)(page + EH_FRAME_OFFSET), sysent_eh_frame,
+	       sizeof(sysent_eh_frame));
 	on_each_cpu(enable_sep_cpu, NULL, 1, 1);
 	return 0;
 }
--- linux-2.5/include/asm-i386/elf.h-eh	2003-04-13 15:31:35.000000000 -0700
+++ linux-2.5/include/asm-i386/elf.h	2003-04-13 14:47:04.000000000 -0700
@@ -100,7 +100,8 @@ typedef struct user_fxsr_struct elf_fpxr
  * Architecture-neutral AT_ values in 0-17, leave some room
  * for more of them, start the x86-specific ones at 32.
  */
-#define AT_SYSINFO	32
+#define AT_SYSINFO		32
+#define AT_SYSINFO_EH_FRAME	33
 
 #ifdef __KERNEL__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
@@ -118,9 +119,15 @@ extern void dump_smp_unlazy_fpu(void);
 #define ELF_CORE_SYNC dump_smp_unlazy_fpu
 #endif
 
-#define ARCH_DLINFO					\
-do {							\
-		NEW_AUX_ENT(AT_SYSINFO, 0xffffe000);	\
+/* Offset from the beginning of the page where the .eh_frame information
+   for the code in the vsyscall page starts.  */
+#define EH_FRAME_OFFSET 96
+
+#define ARCH_DLINFO						\
+do {								\
+		NEW_AUX_ENT(AT_SYSINFO, 0xffffe000);		\
+		NEW_AUX_ENT(AT_SYSINFO_EH_FRAME,		\
+			    0xffffe000 + EH_FRAME_OFFSET);	\
 } while (0)
 
 #endif

--------------030209020106000607070707--

--------------enigA8962D3E27C54893810C19EC
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+meYg2ijCOnn/RHQRAoKtAJ0akt1i+i+CAPMEpmr2hJUd/TklfQCgj95S
5JCH9MZqZY1kXqyaOJwXVjU=
=dvtz
-----END PGP SIGNATURE-----

--------------enigA8962D3E27C54893810C19EC--

