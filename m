Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756063AbWKRAG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756063AbWKRAG3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756073AbWKRAG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:06:28 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:58792 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1753553AbWKRAGY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:24 -0500
Date: Fri, 17 Nov 2006 17:59:53 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [PATCH 20/20] x86_64: Move CPU verification code to common file
Message-ID: <20061117225953.GU15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20061117223432.GA15449@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061117223432.GA15449@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



o This patch moves the code to verify long mode and SSE to a common file.
  This code is not shared by trampoline.S, wakeup.S, boot/setup.S and
  boot/compressed/head.S

o So far we used to do very limited check in trampoline.S, wakeup.S and
  in 32bit entry point. Now all the entry paths are forced to do the
  exhaustive check, including SSE because verify_cpu is shared.

o I am keeping this patch as last in the x86 relocatable series because
  previous patches have got quite some amount of testing done and don't want
  to distrub that. So that if there is problem introduced by this patch, at
  least it can be easily isolated.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
---

 arch/x86_64/boot/compressed/head.S |   19 ++++++
 arch/x86_64/boot/setup.S           |   65 ++--------------------
 arch/x86_64/kernel/acpi/wakeup.S   |   30 +++++-----
 arch/x86_64/kernel/trampoline.S    |   51 +----------------
 arch/x86_64/kernel/verify_cpu.S    |  106 +++++++++++++++++++++++++++++++++++++
 5 files changed, 148 insertions(+), 123 deletions(-)

diff -puN arch/x86_64/boot/compressed/head.S~x86_64-move-cpu-verfication-code-to-common-file arch/x86_64/boot/compressed/head.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/boot/compressed/head.S~x86_64-move-cpu-verfication-code-to-common-file	2006-11-17 00:14:07.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/boot/compressed/head.S	2006-11-17 00:14:07.000000000 -0500
@@ -54,6 +54,15 @@ startup_32:
 1:	popl	%ebp
 	subl	$1b, %ebp
 
+/* setup a stack and make sure cpu supports long mode. */
+	movl	$user_stack_end, %eax
+	addl	%ebp, %eax
+	movl	%eax, %esp
+
+	call	verify_cpu
+	testl	%eax, %eax
+	jnz	no_longmode
+
 /* Compute the delta between where we were compiled to run at
  * and where the code will actually run at.
  */
@@ -150,13 +159,21 @@ startup_32:
 	/* Jump from 32bit compatibility mode into 64bit mode. */
 	lret
 
+no_longmode:
+	/* This isn't an x86-64 CPU so hang */
+1:
+	hlt
+	jmp     1b
+
+#include "../../kernel/verify_cpu.S"
+
 	/* Be careful here startup_64 needs to be at a predictable
 	 * address so I can export it in an ELF header.  Bootloaders
 	 * should look at the ELF header to find this address, as
 	 * it may change in the future.
 	 */
 	.code64
-	.org 0x100
+	.org 0x200
 ENTRY(startup_64)
 	/* We come here either from startup_32 or directly from a
 	 * 64bit bootloader.  If we come here from a bootloader we depend on
diff -puN arch/x86_64/boot/setup.S~x86_64-move-cpu-verfication-code-to-common-file arch/x86_64/boot/setup.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/boot/setup.S~x86_64-move-cpu-verfication-code-to-common-file	2006-11-17 00:14:07.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/boot/setup.S	2006-11-17 00:14:07.000000000 -0500
@@ -295,64 +295,10 @@ loader_ok:
 	movw	%cs,%ax
 	movw	%ax,%ds
 	
-	/* minimum CPUID flags for x86-64 */
-	/* see http://www.x86-64.org/lists/discuss/msg02971.html */		
-#define SSE_MASK ((1<<25)|(1<<26))
-#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
-					   (1<<13)|(1<<15)|(1<<24))
-#define REQUIRED_MASK2 (1<<29)
-
-	pushfl				/* standard way to check for cpuid */
-	popl	%eax
-	movl	%eax,%ebx
-	xorl	$0x200000,%eax
-	pushl	%eax
-	popfl
-	pushfl
-	popl	%eax
-	cmpl	%eax,%ebx
-	jz	no_longmode		/* cpu has no cpuid */
-	movl	$0x0,%eax
-	cpuid
-	cmpl	$0x1,%eax
-	jb	no_longmode		/* no cpuid 1 */
-	xor	%di,%di
-	cmpl	$0x68747541,%ebx	/* AuthenticAMD */
-	jnz	noamd
-	cmpl	$0x69746e65,%edx
-	jnz	noamd
-	cmpl	$0x444d4163,%ecx
-	jnz	noamd
-	mov	$1,%di			/* cpu is from AMD */
-noamd:		
-	movl    $0x1,%eax
-	cpuid
-	andl	$REQUIRED_MASK1,%edx
-	xorl	$REQUIRED_MASK1,%edx
-	jnz	no_longmode
-	movl    $0x80000000,%eax
-	cpuid
-	cmpl    $0x80000001,%eax
-	jb      no_longmode             /* no extended cpuid */
-	movl    $0x80000001,%eax
-	cpuid
-	andl    $REQUIRED_MASK2,%edx
-	xorl    $REQUIRED_MASK2,%edx
-	jnz     no_longmode
-sse_test:		
-	movl	$1,%eax
-	cpuid
-	andl	$SSE_MASK,%edx
-	cmpl	$SSE_MASK,%edx
-	je	sse_ok
-	test	%di,%di
-	jz	no_longmode	/* only try to force SSE on AMD */ 
-	movl	$0xc0010015,%ecx	/* HWCR */
-	rdmsr
-	btr	$15,%eax	/* enable SSE */
-	wrmsr
-	xor	%di,%di		/* don't loop */
-	jmp	sse_test	/* try again */	
+	call verify_cpu
+	testl %eax,%eax
+	jz sse_ok
+
 no_longmode:
 	call	beep
 	lea	long_mode_panic,%si
@@ -362,7 +308,8 @@ no_longmode_loop:		
 long_mode_panic:
 	.string "Your CPU does not support long mode. Use a 32bit distribution."
 	.byte 0
-	
+
+#include "../kernel/verify_cpu.S"
 sse_ok:
 	popw	%ds
 	
diff -puN arch/x86_64/kernel/acpi/wakeup.S~x86_64-move-cpu-verfication-code-to-common-file arch/x86_64/kernel/acpi/wakeup.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/acpi/wakeup.S~x86_64-move-cpu-verfication-code-to-common-file	2006-11-17 00:14:07.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/acpi/wakeup.S	2006-11-17 00:14:07.000000000 -0500
@@ -43,6 +43,11 @@ wakeup_code:
 	cmpl	$0x12345678, %eax
 	jne	bogus_real_magic
 
+  	call	verify_cpu			# Verify the cpu supports long
+						# mode
+	testl	%eax, %eax
+	jnz	no_longmode
+
 	testl	$1, video_flags - wakeup_code
 	jz	1f
 	lcall   $0xc000,$3
@@ -92,18 +97,6 @@ wakeup_32:
 # Running in this code, but at low address; paging is not yet turned on.
 	movb	$0xa5, %al	;  outb %al, $0x80
 
-	/* Check if extended functions are implemented */		
-	movl	$0x80000000, %eax
-	cpuid
-	cmpl	$0x80000000, %eax
-	jbe	bogus_cpu
-	wbinvd
-	mov	$0x80000001, %eax
-	cpuid
-	btl	$29, %edx
-	jnc	bogus_cpu
-	movl	%edx,%edi
-	
 	movl	$__KERNEL_DS, %eax
 	movl	%eax, %ds
 
@@ -123,6 +116,11 @@ wakeup_32:
 	leal    (wakeup_level4_pgt - wakeup_code)(%esi), %eax
 	movl	%eax, %cr3
 
+        /* Check if nx is implemented */
+        movl    $0x80000001, %eax
+        cpuid
+        movl    %edx,%edi
+
 	/* Enable Long Mode */
 	xorl    %eax, %eax
 	btsl	$_EFER_LME, %eax
@@ -243,10 +241,12 @@ bogus_64_magic:
 	movb	$0xb3,%al	;  outb %al,$0x80
 	jmp bogus_64_magic
 
-bogus_cpu:
-	movb	$0xbc,%al	;  outb %al,$0x80
-	jmp bogus_cpu
+.code16
+no_longmode:
+	movb    $0xbc,%al       ;  outb %al,$0x80
+	jmp no_longmode
 
+#include "../verify_cpu.S"
 	
 /* This code uses an extended set of video mode numbers. These include:
  * Aliases for standard modes
diff -puN arch/x86_64/kernel/trampoline.S~x86_64-move-cpu-verfication-code-to-common-file arch/x86_64/kernel/trampoline.S
--- linux-2.6.19-rc6-reloc/arch/x86_64/kernel/trampoline.S~x86_64-move-cpu-verfication-code-to-common-file	2006-11-17 00:14:07.000000000 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/trampoline.S	2006-11-17 00:14:07.000000000 -0500
@@ -54,6 +54,8 @@ r_base = .
 	movw	$(trampoline_stack_end - r_base), %sp
 
 	call	verify_cpu		# Verify the cpu supports long mode
+	testl   %eax, %eax		# Check for return code
+	jnz	no_longmode
 
 	mov	%cs, %ax
 	movzx	%ax, %esi		# Find the 32bit trampoline location
@@ -121,57 +123,10 @@ startup_64:
 	jmp	*%rax
 
 	.code16
-verify_cpu:
-	pushl	$0			# Kill any dangerous flags
-	popfl
-
-	/* minimum CPUID flags for x86-64 */
-	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
-#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
-			   (1<<13)|(1<<15)|(1<<24)|(1<<25)|(1<<26))
-#define REQUIRED_MASK2 (1<<29)
-
-	pushfl				# check for cpuid
-	popl	%eax
-	movl	%eax, %ebx
-	xorl	$0x200000,%eax
-	pushl	%eax
-	popfl
-	pushfl
-	popl	%eax
-	pushl	%ebx
-	popfl
-	cmpl	%eax, %ebx
-	jz	no_longmode
-
-	xorl	%eax, %eax		# See if cpuid 1 is implemented
-	cpuid
-	cmpl	$0x1, %eax
-	jb	no_longmode
-
-	movl	$0x01, %eax		# Does the cpu have what it takes?
-	cpuid
-	andl	$REQUIRED_MASK1, %edx
-	xorl	$REQUIRED_MASK1, %edx
-	jnz	no_longmode
-
-	movl	$0x80000000, %eax	# See if extended cpuid is implemented
-	cpuid
-	cmpl	$0x80000001, %eax
-	jb	no_longmode
-
-	movl	$0x80000001, %eax	# Does the cpu have what it takes?
-	cpuid
-	andl	$REQUIRED_MASK2, %edx
-	xorl	$REQUIRED_MASK2, %edx
-	jnz	no_longmode
-
-	ret				# The cpu supports long mode
-
 no_longmode:
 	hlt
 	jmp no_longmode
-
+#include "verify_cpu.S"
 
 	# Careful these need to be in the same 64K segment as the above;
 tidt:
diff -puN /dev/null arch/x86_64/kernel/verify_cpu.S
--- /dev/null	2006-11-17 00:03:10.168280803 -0500
+++ linux-2.6.19-rc6-reloc-root/arch/x86_64/kernel/verify_cpu.S	2006-11-17 00:14:07.000000000 -0500
@@ -0,0 +1,106 @@
+/*
+ *
+ *	verify_cpu.S - Code for cpu long mode and SSE verification
+ *
+ *	Copyright (c) 2006-2007  Vivek Goyal (vgoyal@in.ibm.com)
+ *
+ * 	This source code is licensed under the GNU General Public License,
+ * 	Version 2.  See the file COPYING for more details.
+ *
+ *	This is a common code for verification whether CPU supports
+ * 	long mode and SSE or not. It is not called directly instead this
+ *	file is included at various places and compiled in that context.
+ * 	Following are the current usage.
+ *
+ * 	This file is included by both 16bit and 32bit code.
+ *
+ *	arch/x86_64/boot/setup.S : Boot cpu verification (16bit)
+ *	arch/x86_64/boot/compressed/head.S: Boot cpu verification (32bit)
+ *	arch/x86_64/kernel/trampoline.S: secondary processor verfication (16bit)
+ *	arch/x86_64/kernel/acpi/wakeup.S:Verfication at resume (16bit)
+ *
+ *	verify_cpu, returns the status of cpu check in register %eax.
+ *		0: Success    1: Failure
+ *
+ * 	The caller needs to check for the error code and take the action
+ * 	appropriately. Either display a message or halt.
+ */
+
+verify_cpu:
+
+	pushfl				# Save caller passed flags
+	pushl	$0			# Kill any dangerous flags
+	popfl
+
+	/* minimum CPUID flags for x86-64 */
+	/* see http://www.x86-64.org/lists/discuss/msg02971.html */
+#define SSE_MASK ((1<<25)|(1<<26))
+#define REQUIRED_MASK1 ((1<<0)|(1<<3)|(1<<4)|(1<<5)|(1<<6)|(1<<8)|\
+					   (1<<13)|(1<<15)|(1<<24))
+#define REQUIRED_MASK2 (1<<29)
+	pushfl				# standard way to check for cpuid
+	popl	%eax
+	movl	%eax,%ebx
+	xorl	$0x200000,%eax
+	pushl	%eax
+	popfl
+	pushfl
+	popl	%eax
+	cmpl	%eax,%ebx
+	jz	verify_cpu_no_longmode	# cpu has no cpuid
+
+	movl	$0x0,%eax		# See if cpuid 1 is implemented
+	cpuid
+	cmpl	$0x1,%eax
+	jb	verify_cpu_no_longmode	# no cpuid 1
+
+	xor	%di,%di
+	cmpl	$0x68747541,%ebx	# AuthenticAMD
+	jnz	verify_cpu_noamd
+	cmpl	$0x69746e65,%edx
+	jnz	verify_cpu_noamd
+	cmpl	$0x444d4163,%ecx
+	jnz	verify_cpu_noamd
+	mov	$1,%di			# cpu is from AMD
+
+verify_cpu_noamd:
+	movl    $0x1,%eax		# Does the cpu have what it takes
+	cpuid
+	andl	$REQUIRED_MASK1,%edx
+	xorl	$REQUIRED_MASK1,%edx
+	jnz	verify_cpu_no_longmode
+
+	movl    $0x80000000,%eax	# See if extended cpuid is implemented
+	cpuid
+	cmpl    $0x80000001,%eax
+	jb      verify_cpu_no_longmode	# no extended cpuid
+
+	movl    $0x80000001,%eax	# Does the cpu have what it takes
+	cpuid
+	andl    $REQUIRED_MASK2,%edx
+	xorl    $REQUIRED_MASK2,%edx
+	jnz     verify_cpu_no_longmode
+
+verify_cpu_sse_test:
+	movl	$1,%eax
+	cpuid
+	andl	$SSE_MASK,%edx
+	cmpl	$SSE_MASK,%edx
+	je	verify_cpu_sse_ok
+	test	%di,%di
+	jz	verify_cpu_no_longmode	# only try to force SSE on AMD
+	movl	$0xc0010015,%ecx	# HWCR
+	rdmsr
+	btr	$15,%eax		# enable SSE
+	wrmsr
+	xor	%di,%di			# don't loop
+	jmp	verify_cpu_sse_test	# try again
+
+verify_cpu_no_longmode:
+	popfl				# Restore caller passed flags
+	movl $1,%eax
+	ret
+verify_cpu_sse_ok:
+	popfl				# Restore caller passed flags
+	xorl %eax, %eax
+	ret
_
