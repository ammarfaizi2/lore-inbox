Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263165AbTDMDpz (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:45:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbTDMDpz (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:45:55 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:61586
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263165AbTDMDps (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 23:45:48 -0400
Message-ID: <3E98E01C.3070103@redhat.com>
Date: Sat, 12 Apr 2003 20:57:16 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030412
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: unwinding for vsyscall code
X-Enigmail-Version: 0.74.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEAD71804BEDC750E1A3BE98F"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEAD71804BEDC750E1A3BE98F
Content-Type: multipart/mixed;
 boundary="------------050605060207040103090603"

This is a multi-part message in MIME format.
--------------050605060207040103090603
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Now that the kernel provides code user programs are executing directly
(I mean the vsyscall code on x86) it is necessary to add unwind
information for that code as well.  The unwind information is used not
only in C++ code.  The new thread code also uses it for the cancellation
handling.  If we have no such information available we would have to
resort to using int $0x80 for all syscalls which are also cancellation
points (read, write, ...).

Providing the information from outside the kernel is problematic.
First, we would have to recognize when a process starts which code is
actually used and install the appropriate unwind table.  Second, we
would always have to keep libc and kernel in sync.  There might be new
code sequences in future and once the kernel is changed you'd need a new
libc.  Not good at all.

Instead the best way I've found is to provide the info in the kernel.
Fortunately this is associated with almost no cost.  The unwind table is
just a block of static data which is copied at system boot time into the
vsyscall page just like the normal vsyscall code.

To advertise the existence and location of the unwind table I've added
one more AT_* constant.  It might in theory be possible to reuse
AT_SYSINFO and add a fixed offset but I'd rather not do this.  If/When
more code is added to the vsyscall page the unwind table gets larger and
you want to have the liberty to move it out of the way.

This also brings up an important point: even if more entry points into
the vsyscall page are defined, there will always have to be only one
unwind table.  It is not necessary to add more and more AT_* values to
advertise more tables.

The attached patch just adds the AT_* value, makes sure the AT_* value
is passed to applications, define the static data for the unwind blocks
(two, one for int80 and the other for sysenter), and finally code to
copy the data in place.  Very simple and unintrusive.  The patch is
verified to work nicely and unwind now works even when I use vsyscall.

I've added documentation of all the unwind info but it might still be
not easy to generate new data if the code sequences are changed or new
sequences are added.  If you want, you can add a comment somewhere which
instructs people to contact me to make the changes.


The patch also includes a bonus: so far all the tables in the
sysenter_setup() function will stay behing even if the function gets
removed after startup.  They are not marked appropriately.  I've added
__initdata marker, but actually it should be __initrodata if this would
exist.  Not that it makes much of a difference, the data is gone right
away after booting.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

--------------050605060207040103090603
Content-Type: text/plain;
 name="d-kernel-eh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="d-kernel-eh"

--- linux-2.5/arch/i386/kernel/sysenter.c-eh	2003-04-12 12:33:14.000000000 -0700
+++ linux-2.5/arch/i386/kernel/sysenter.c	2003-04-12 20:35:26.000000000 -0700
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
@@ -76,13 +113,74 @@ static int __init sysenter_setup(void)
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
+		0x37, 0x00, 0x00, 0x00,	/* FDE Length */
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
+	   We have to record all changes of the stack pointer.  */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x01, 0x00, 0x00, 0x00,	/* Size of push %ecx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x08,			/* RA at offset 8 now */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x01, 0x00, 0x00, 0x00,	/* Size of push %edx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x0c,			/* RA at offset 12 now */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x01, 0x00, 0x00, 0x00,	/* Size of push %ebp */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x10,			/* RA at offset 16 now */
+	/* Finally the epilogue.  */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x0e, 0x00, 0x00, 0x00,	/* Offset til pop %edx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x12,			/* RA at offset 12 now */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x01, 0x00, 0x00, 0x00,	/* Size of pop %edx */
+		0x0e,			/* DW_CFA_def_cfa_offset */
+		0x08,			/* RA at offset 8 now */
+		0x04,			/* DW_CFA_advance_loc4 */
+		0x01, 0x00, 0x00, 0x00,	/* Size of pop %ecx */
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
@@ -93,10 +191,14 @@ static int __init sysenter_setup(void)
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
--- linux-2.5/include/asm-i386/elf.h-eh	2003-04-12 14:07:33.000000000 -0700
+++ linux-2.5/include/asm-i386/elf.h	2003-04-12 14:14:38.000000000 -0700
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

--------------050605060207040103090603--

--------------enigEAD71804BEDC750E1A3BE98F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+mOAc2ijCOnn/RHQRAjZSAKCtA3dnlxrsKK0cyGp9fBOScIwu3wCgrxg/
DlRxjVPdpsc7lew0EPIjlh4=
=7Cz7
-----END PGP SIGNATURE-----

--------------enigEAD71804BEDC750E1A3BE98F--

