Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129449AbQKCCZ1>; Thu, 2 Nov 2000 21:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129848AbQKCCZS>; Thu, 2 Nov 2000 21:25:18 -0500
Received: from ha2.rdc2.mi.home.com ([24.2.68.69]:15608 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129449AbQKCCZI>; Thu, 2 Nov 2000 21:25:08 -0500
Message-ID: <3A02212F.8B1BA2DC@didntduck.org>
Date: Thu, 02 Nov 2000 21:21:35 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 boot time check for cpu features
Content-Type: multipart/mixed;
 boundary="------------982758D8B6905F00759C7FA7"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------982758D8B6905F00759C7FA7
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

This patch allows the real mode setup code to check for required
features (such as cmov, pae, etc.) that would normally just cause the
boot process to silently hang.  Tested with a K6-2 (no cmov) and an
Athlon (has cmov), needs testing on a CPU without cpuid.

-- 

						Brian Gerst
--------------982758D8B6905F00759C7FA7
Content-Type: text/plain; charset=us-ascii;
 name="reqdflags.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reqdflags.diff"

diff -ur linux-2.4.0t10/arch/i386/boot/setup.S linux/arch/i386/boot/setup.S
--- linux-2.4.0t10/arch/i386/boot/setup.S	Tue Oct 31 17:06:34 2000
+++ linux/arch/i386/boot/setup.S	Thu Nov  2 21:04:01 2000
@@ -364,6 +364,55 @@
 	xorw	%bx, %bx
 	int	$0x16
 
+/* This is butt ugly, but it works. */
+#ifdef CONFIG_X86_CMOV
+# define REQD_CMOV	0x00008000
+#else
+# define REQD_CMOV	0
+#endif
+#ifdef CONFIG_X86_PAE
+# define REQD_PAE	0x00000040
+#else
+# define REQD_PAE	0
+#endif
+#define REQD_FLAGS REQD_CMOV|REQD_PAE
+
+#if REQD_FLAGS
+/*
+ * We must check this here while we can still get a message to the console
+ * because instructions for newer processors (ie. cmovcc) may be present
+ * in C code.
+ */
+	pushfl
+	popl	%eax
+	xorl	$0x200000, %eax			# check ID flag
+	pushl	%eax
+	popfl
+	pushfl
+	popl	%edx
+	xorl	%edx, %eax
+	testl	$0x200000, %eax
+	jnz	cpuid_fail
+	xorl	%eax, %eax
+	cpuid
+	cmpl 	$1, %eax
+	jb	cpuid_fail
+	movl	$1, %eax
+	cpuid
+	andl	$REQD_FLAGS, %edx
+	cmpl	$REQD_FLAGS, %edx
+	je	cpuid_pass
+cpuid_fail:
+	pushw	%cs
+	popw	%ds
+	lea	cpuid_fail_msg, %si
+	call	prtstr
+1:	jmp	1b
+cpuid_fail_msg:
+	.string	"Required CPU features are not present - compile kernel for the proper CPU type."
+cpuid_pass:
+#endif
+	
 # Check for video adapter and its parameters and allow the
 # user to browse video modes.
 	call	video				# NOTE: we need %ds pointing
diff -ur linux-2.4.0t10/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.4.0t10/arch/i386/config.in	Tue Oct 31 17:06:34 2000
+++ linux/arch/i386/config.in	Thu Nov  2 18:53:59 2000
@@ -82,6 +82,7 @@
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_CMOV y
 fi
 if [ "$CONFIG_M686FXSR" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -91,6 +92,7 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_FXSR y
    define_bool CONFIG_X86_XMM y
+   define_bool CONFIG_X86_CMOV y
 fi
 if [ "$CONFIG_MK6" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -105,6 +107,7 @@
    define_bool CONFIG_X86_USE_3DNOW y
    define_bool CONFIG_X86_PGE y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_CMOV y
 fi
 if [ "$CONFIG_MCRUSOE" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5

--------------982758D8B6905F00759C7FA7--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
