Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWHJUHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWHJUHH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbWHJUEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:23 -0400
Received: from mail.suse.de ([195.135.220.2]:59280 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932638AbWHJTgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:43 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [84/145] x86_64: annotate arch/x86_64/lib/*.S
Message-Id: <20060810193641.2904013C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:41 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: "Jan Beulich" <jbeulich@novell.com>

Add unwind annotations to arch/x86_64/lib/*.S, and also use the macros
provided by linux/linkage.h where-ever possible.

Some of the alternative instructions handling needed to be adjusted so
that the replacement code would also have valid unwind information.

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/lib/clear_page.S |   47 +++++++++++++++----------
 arch/x86_64/lib/copy_page.S  |   53 +++++++++++++++++++---------
 arch/x86_64/lib/copy_user.S  |   39 +++++++++++++++------
 arch/x86_64/lib/csum-copy.S  |   26 +++++++++++---
 arch/x86_64/lib/getuser.S    |   32 ++++++++++-------
 arch/x86_64/lib/iomap_copy.S |   10 +++--
 arch/x86_64/lib/memcpy.S     |   69 +++++++++++++++++++++----------------
 arch/x86_64/lib/memset.S     |   79 +++++++++++++++++++++++--------------------
 arch/x86_64/lib/putuser.S    |   32 ++++++++++-------
 9 files changed, 244 insertions(+), 143 deletions(-)

Index: linux/arch/x86_64/lib/clear_page.S
===================================================================
--- linux.orig/arch/x86_64/lib/clear_page.S
+++ linux/arch/x86_64/lib/clear_page.S
@@ -1,10 +1,22 @@
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+
 /*
  * Zero a page. 	
  * rdi	page
  */			
-	.globl clear_page
-	.p2align 4
-clear_page:
+	ALIGN
+clear_page_c:
+	CFI_STARTPROC
+	movl $4096/8,%ecx
+	xorl %eax,%eax
+	rep stosq
+	ret
+	CFI_ENDPROC
+ENDPROC(clear_page)
+
+ENTRY(clear_page)
+	CFI_STARTPROC
 	xorl   %eax,%eax
 	movl   $4096/64,%ecx
 	.p2align 4
@@ -23,28 +35,25 @@ clear_page:
 	jnz	.Lloop
 	nop
 	ret
-clear_page_end:
+	CFI_ENDPROC
+.Lclear_page_end:
+ENDPROC(clear_page)
 
 	/* Some CPUs run faster using the string instructions.
 	   It is also a lot simpler. Use this when possible */
 
 #include <asm/cpufeature.h>
 
+	.section .altinstr_replacement,"ax"
+1:	.byte 0xeb					/* jmp <disp8> */
+	.byte (clear_page_c - clear_page) - (2f - 1b)	/* offset */
+2:
+	.previous
 	.section .altinstructions,"a"
 	.align 8
-	.quad  clear_page
-	.quad  clear_page_c
-	.byte  X86_FEATURE_REP_GOOD
-	.byte  clear_page_end-clear_page
-	.byte  clear_page_c_end-clear_page_c
-	.previous
-
-	.section .altinstr_replacement,"ax"
-clear_page_c:
-	movl $4096/8,%ecx
-	xorl %eax,%eax
-	rep 
-	stosq
-	ret
-clear_page_c_end:
+	.quad clear_page
+	.quad 1b
+	.byte X86_FEATURE_REP_GOOD
+	.byte .Lclear_page_end - clear_page
+	.byte 2b - 1b
 	.previous
Index: linux/arch/x86_64/lib/copy_page.S
===================================================================
--- linux.orig/arch/x86_64/lib/copy_page.S
+++ linux/arch/x86_64/lib/copy_page.S
@@ -1,17 +1,33 @@
 /* Written 2003 by Andi Kleen, based on a kernel by Evandro Menezes */
 	
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+
+	ALIGN
+copy_page_c:
+	CFI_STARTPROC
+	movl $4096/8,%ecx
+	rep movsq
+	ret
+	CFI_ENDPROC
+ENDPROC(copy_page_c)
+
 /* Don't use streaming store because it's better when the target
    ends up in cache. */
 	    
 /* Could vary the prefetch distance based on SMP/UP */
 
-	.globl copy_page
-	.p2align 4
-copy_page:
+ENTRY(copy_page)
+	CFI_STARTPROC
 	subq	$3*8,%rsp
+	CFI_ADJUST_CFA_OFFSET 3*8
 	movq	%rbx,(%rsp)
+	CFI_REL_OFFSET rbx, 0
 	movq	%r12,1*8(%rsp)
+	CFI_REL_OFFSET r12, 1*8
 	movq	%r13,2*8(%rsp)
+	CFI_REL_OFFSET r13, 2*8
 
 	movl	$(4096/64)-5,%ecx
 	.p2align 4
@@ -72,30 +88,33 @@ copy_page:
 	jnz	.Loop2
 
 	movq	(%rsp),%rbx
+	CFI_RESTORE rbx
 	movq	1*8(%rsp),%r12
+	CFI_RESTORE r12
 	movq	2*8(%rsp),%r13
+	CFI_RESTORE r13
 	addq	$3*8,%rsp
+	CFI_ADJUST_CFA_OFFSET -3*8
 	ret
+.Lcopy_page_end:
+	CFI_ENDPROC
+ENDPROC(copy_page)
 
 	/* Some CPUs run faster using the string copy instructions.
 	   It is also a lot simpler. Use this when possible */
 
 #include <asm/cpufeature.h>
 
+	.section .altinstr_replacement,"ax"
+1:	.byte 0xeb					/* jmp <disp8> */
+	.byte (copy_page_c - copy_page) - (2f - 1b)	/* offset */
+2:
+	.previous
 	.section .altinstructions,"a"
 	.align 8
-	.quad  copy_page
-	.quad  copy_page_c
-	.byte  X86_FEATURE_REP_GOOD
-	.byte  copy_page_c_end-copy_page_c
-	.byte  copy_page_c_end-copy_page_c
-	.previous
-
-	.section .altinstr_replacement,"ax"
-copy_page_c:
-	movl $4096/8,%ecx
-	rep 
-	movsq 
-	ret
-copy_page_c_end:
+	.quad copy_page
+	.quad 1b
+	.byte X86_FEATURE_REP_GOOD
+	.byte .Lcopy_page_end - copy_page
+	.byte 2b - 1b
 	.previous
Index: linux/arch/x86_64/lib/copy_user.S
===================================================================
--- linux.orig/arch/x86_64/lib/copy_user.S
+++ linux/arch/x86_64/lib/copy_user.S
@@ -4,6 +4,9 @@
  * Functions to copy from and to user space.		
  */		 
 
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+
 #define FIX_ALIGNMENT 1
 
 	#include <asm/current.h>
@@ -12,9 +15,8 @@
 	#include <asm/cpufeature.h>
 
 /* Standard copy_to_user with segment limit checking */		
-	.globl copy_to_user
-	.p2align 4	
-copy_to_user:
+ENTRY(copy_to_user)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%rax)
 	movq %rdi,%rcx
 	addq %rdx,%rcx
@@ -25,9 +27,11 @@ copy_to_user:
 	.byte 0xe9	/* 32bit jump */
 	.long .Lcug-1f
 1:
+	CFI_ENDPROC
+ENDPROC(copy_to_user)
 
 	.section .altinstr_replacement,"ax"
-3:	.byte 0xe9			/* replacement jmp with 8 bit immediate */
+3:	.byte 0xe9			/* replacement jmp with 32 bit immediate */
 	.long copy_user_generic_c-1b	/* offset */
 	.previous
 	.section .altinstructions,"a"
@@ -40,9 +44,8 @@ copy_to_user:
 	.previous
 
 /* Standard copy_from_user with segment limit checking */	
-	.globl copy_from_user
-	.p2align 4	
-copy_from_user:
+ENTRY(copy_from_user)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%rax)
 	movq %rsi,%rcx
 	addq %rdx,%rcx
@@ -50,10 +53,13 @@ copy_from_user:
 	cmpq threadinfo_addr_limit(%rax),%rcx
 	jae  bad_from_user
 	/* FALL THROUGH to copy_user_generic */
+	CFI_ENDPROC
+ENDPROC(copy_from_user)
 	
 	.section .fixup,"ax"
 	/* must zero dest */
 bad_from_user:
+	CFI_STARTPROC
 	movl %edx,%ecx
 	xorl %eax,%eax
 	rep
@@ -61,6 +67,8 @@ bad_from_user:
 bad_to_user:
 	movl	%edx,%eax
 	ret
+	CFI_ENDPROC
+END(bad_from_user)
 	.previous
 	
 		
@@ -75,9 +83,8 @@ bad_to_user:
  * Output:		
  * eax uncopied bytes or 0 if successful.
  */
-	.globl copy_user_generic
-	.p2align 4
-copy_user_generic:
+ENTRY(copy_user_generic)
+	CFI_STARTPROC
 	.byte 0x66,0x66,0x90	/* 5 byte nop for replacement jump */
 	.byte 0x66,0x90
 1:
@@ -95,6 +102,8 @@ copy_user_generic:
 	.previous
 .Lcug:
 	pushq %rbx
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rbx, 0
 	xorl %eax,%eax		/*zero for the exception handler */
 
 #ifdef FIX_ALIGNMENT
@@ -168,9 +177,13 @@ copy_user_generic:
 	decl %ecx
 	jnz .Lloop_1
 
+	CFI_REMEMBER_STATE
 .Lende:
 	popq %rbx
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_RESTORE rbx
 	ret
+	CFI_RESTORE_STATE
 
 #ifdef FIX_ALIGNMENT
 	/* align destination */
@@ -261,6 +274,9 @@ copy_user_generic:
 .Le_zero:
 	movq %rdx,%rax
 	jmp .Lende
+	CFI_ENDPROC
+ENDPROC(copy_user_generic)
+
 
 	/* Some CPUs run faster using the string copy instructions.
 	   This is also a lot simpler. Use them when possible.
@@ -282,6 +298,7 @@ copy_user_generic:
   * this please consider this.
    */
 copy_user_generic_c:
+	CFI_STARTPROC
 	movl %edx,%ecx
 	shrl $3,%ecx
 	andl $7,%edx	
@@ -294,6 +311,8 @@ copy_user_generic_c:
 	ret
 3:	lea (%rdx,%rcx,8),%rax
 	ret
+	CFI_ENDPROC
+END(copy_user_generic_c)
 
 	.section __ex_table,"a"
 	.quad 1b,3b
Index: linux/arch/x86_64/lib/csum-copy.S
===================================================================
--- linux.orig/arch/x86_64/lib/csum-copy.S
+++ linux/arch/x86_64/lib/csum-copy.S
@@ -5,8 +5,9 @@
  * License.  See the file COPYING in the main directory of this archive
  * for more details. No warranty for anything given at all.
  */
- 	#include <linux/linkage.h>
-	#include <asm/errno.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+#include <asm/errno.h>
 
 /*
  * Checksum copy with exception handling.
@@ -53,19 +54,24 @@
 	.endm
 	
 				
-	.globl csum_partial_copy_generic
-	.p2align 4
-csum_partial_copy_generic:
+ENTRY(csum_partial_copy_generic)
+	CFI_STARTPROC
 	cmpl	 $3*64,%edx
 	jle	 .Lignore
 
 .Lignore:		
 	subq  $7*8,%rsp
+	CFI_ADJUST_CFA_OFFSET 7*8
 	movq  %rbx,2*8(%rsp)
+	CFI_REL_OFFSET rbx, 2*8
 	movq  %r12,3*8(%rsp)
+	CFI_REL_OFFSET r12, 3*8
 	movq  %r14,4*8(%rsp)
+	CFI_REL_OFFSET r14, 4*8
 	movq  %r13,5*8(%rsp)
+	CFI_REL_OFFSET r13, 5*8
 	movq  %rbp,6*8(%rsp)
+	CFI_REL_OFFSET rbp, 6*8
 
 	movq  %r8,(%rsp)
 	movq  %r9,1*8(%rsp)
@@ -208,14 +214,22 @@ csum_partial_copy_generic:
 	addl %ebx,%eax
 	adcl %r9d,%eax		/* carry */
 			
+	CFI_REMEMBER_STATE
 .Lende:
 	movq 2*8(%rsp),%rbx
+	CFI_RESTORE rbx
 	movq 3*8(%rsp),%r12
+	CFI_RESTORE r12
 	movq 4*8(%rsp),%r14
+	CFI_RESTORE r14
 	movq 5*8(%rsp),%r13
+	CFI_RESTORE r13
 	movq 6*8(%rsp),%rbp
+	CFI_RESTORE rbp
 	addq $7*8,%rsp
+	CFI_ADJUST_CFA_OFFSET -7*8
 	ret
+	CFI_RESTORE_STATE
 
 	/* Exception handlers. Very simple, zeroing is done in the wrappers */
 .Lbad_source:
@@ -231,3 +245,5 @@ csum_partial_copy_generic:
 	jz   .Lende	
 	movl $-EFAULT,(%rax)
 	jmp .Lende
+	CFI_ENDPROC
+ENDPROC(csum_partial_copy_generic)
Index: linux/arch/x86_64/lib/getuser.S
===================================================================
--- linux.orig/arch/x86_64/lib/getuser.S
+++ linux/arch/x86_64/lib/getuser.S
@@ -27,25 +27,26 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/dwarf2.h>
 #include <asm/page.h>
 #include <asm/errno.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
 	.text
-	.p2align 4
-.globl __get_user_1
-__get_user_1:	
+ENTRY(__get_user_1)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	cmpq threadinfo_addr_limit(%r8),%rcx
 	jae bad_get_user
 1:	movzb (%rcx),%edx
 	xorl %eax,%eax
 	ret
+	CFI_ENDPROC
+ENDPROC(__get_user_1)
 
-	.p2align 4
-.globl __get_user_2
-__get_user_2:
+ENTRY(__get_user_2)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $1,%rcx
 	jc 20f
@@ -57,10 +58,11 @@ __get_user_2:
 	ret
 20:	decq    %rcx
 	jmp	bad_get_user
+	CFI_ENDPROC
+ENDPROC(__get_user_2)
 
-	.p2align 4
-.globl __get_user_4
-__get_user_4:
+ENTRY(__get_user_4)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $3,%rcx
 	jc 30f
@@ -72,10 +74,11 @@ __get_user_4:
 	ret
 30:	subq $3,%rcx
 	jmp bad_get_user
+	CFI_ENDPROC
+ENDPROC(__get_user_4)
 
-	.p2align 4
-.globl __get_user_8
-__get_user_8:
+ENTRY(__get_user_8)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
 	jc 40f
@@ -87,11 +90,16 @@ __get_user_8:
 	ret
 40:	subq $7,%rcx
 	jmp bad_get_user
+	CFI_ENDPROC
+ENDPROC(__get_user_8)
 
 bad_get_user:
+	CFI_STARTPROC
 	xorl %edx,%edx
 	movq $(-EFAULT),%rax
 	ret
+	CFI_ENDPROC
+END(bad_get_user)
 
 .section __ex_table,"a"
 	.quad 1b,bad_get_user
Index: linux/arch/x86_64/lib/iomap_copy.S
===================================================================
--- linux.orig/arch/x86_64/lib/iomap_copy.S
+++ linux/arch/x86_64/lib/iomap_copy.S
@@ -15,12 +15,16 @@
  * Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
  */
 
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+
 /*
  * override generic version in lib/iomap_copy.c
  */
- 	.globl __iowrite32_copy
-	.p2align 4
-__iowrite32_copy:
+ENTRY(__iowrite32_copy)
+	CFI_STARTPROC
 	movl %edx,%ecx
 	rep movsd
 	ret
+	CFI_ENDPROC
+ENDPROC(__iowrite32_copy)
Index: linux/arch/x86_64/lib/memcpy.S
===================================================================
--- linux.orig/arch/x86_64/lib/memcpy.S
+++ linux/arch/x86_64/lib/memcpy.S
@@ -1,6 +1,10 @@
 /* Copyright 2002 Andi Kleen */
 	
-	#include <asm/cpufeature.h>		
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+#include <asm/cpufeature.h>
+
 /*
  * memcpy - Copy a memory block.
  *
@@ -13,12 +17,26 @@
  * rax original destination
  */	
 
- 	.globl __memcpy
-	.globl memcpy
-	.p2align 4
-__memcpy:
-memcpy:		
+	ALIGN
+memcpy_c:
+	CFI_STARTPROC
+	movq %rdi,%rax
+	movl %edx,%ecx
+	shrl $3,%ecx
+	andl $7,%edx
+	rep movsq
+	movl %edx,%ecx
+	rep movsb
+	ret
+	CFI_ENDPROC
+ENDPROC(memcpy_c)
+
+ENTRY(__memcpy)
+ENTRY(memcpy)
+	CFI_STARTPROC
 	pushq %rbx
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rbx, 0
 	movq %rdi,%rax
 
 	movl %edx,%ecx
@@ -86,36 +104,27 @@ memcpy:		
 
 .Lende:
 	popq %rbx
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_RESTORE rbx
 	ret
 .Lfinal:
+	CFI_ENDPROC
+ENDPROC(memcpy)
+ENDPROC(__memcpy)
 
 	/* Some CPUs run faster using the string copy instructions.
 	   It is also a lot simpler. Use this when possible */
 
+	.section .altinstr_replacement,"ax"
+1:	.byte 0xeb				/* jmp <disp8> */
+	.byte (memcpy_c - memcpy) - (2f - 1b)	/* offset */
+2:
+	.previous
 	.section .altinstructions,"a"
 	.align 8
-	.quad  memcpy
-	.quad  memcpy_c
-	.byte  X86_FEATURE_REP_GOOD
-	.byte  .Lfinal-memcpy
-	.byte  memcpy_c_end-memcpy_c
-	.previous
-
-	.section .altinstr_replacement,"ax"
- /* rdi	destination
-  * rsi source
-  * rdx count
-  */
-memcpy_c:
-	movq %rdi,%rax
-	movl %edx,%ecx
-	shrl $3,%ecx
-	andl $7,%edx	
-	rep 
-	movsq 
-	movl %edx,%ecx
-	rep
-	movsb
-	ret
-memcpy_c_end:
+	.quad memcpy
+	.quad 1b
+	.byte X86_FEATURE_REP_GOOD
+	.byte .Lfinal - memcpy
+	.byte 2b - 1b
 	.previous
Index: linux/arch/x86_64/lib/memset.S
===================================================================
--- linux.orig/arch/x86_64/lib/memset.S
+++ linux/arch/x86_64/lib/memset.S
@@ -1,4 +1,9 @@
 /* Copyright 2002 Andi Kleen, SuSE Labs */
+
+#include <linux/config.h>
+#include <linux/linkage.h>
+#include <asm/dwarf2.h>
+
 /*
  * ISO C memset - set a memory block to a byte value.
  *	
@@ -8,11 +13,29 @@
  * 
  * rax   original destination
  */	
- 	.globl __memset
-	.globl memset
-	.p2align 4
-memset:	
-__memset:
+	ALIGN
+memset_c:
+	CFI_STARTPROC
+	movq %rdi,%r9
+	movl %edx,%r8d
+	andl $7,%r8d
+	movl %edx,%ecx
+	shrl $3,%ecx
+	/* expand byte value  */
+	movzbl %sil,%esi
+	movabs $0x0101010101010101,%rax
+	mulq %rsi		/* with rax, clobbers rdx */
+	rep stosq
+	movl %r8d,%ecx
+	rep stosb
+	movq %r9,%rax
+	ret
+	CFI_ENDPROC
+ENDPROC(memset_c)
+
+ENTRY(memset)
+ENTRY(__memset)
+	CFI_STARTPROC
 	movq %rdi,%r10
 	movq %rdx,%r11
 
@@ -25,6 +48,7 @@ __memset:
 	movl  %edi,%r9d
 	andl  $7,%r9d
 	jnz  .Lbad_alignment
+	CFI_REMEMBER_STATE
 .Lafter_bad_alignment:
 
 	movl %r11d,%ecx
@@ -75,6 +99,7 @@ __memset:
 	movq	%r10,%rax
 	ret
 
+	CFI_RESTORE_STATE
 .Lbad_alignment:
 	cmpq $7,%r11
 	jbe	.Lhandle_7
@@ -84,42 +109,26 @@ __memset:
 	addq %r8,%rdi
 	subq %r8,%r11
 	jmp .Lafter_bad_alignment
+.Lfinal:
+	CFI_ENDPROC
+ENDPROC(memset)
+ENDPROC(__memset)
 
 	/* Some CPUs run faster using the string instructions.
 	   It is also a lot simpler. Use this when possible */
 
 #include <asm/cpufeature.h>
 
+	.section .altinstr_replacement,"ax"
+1:	.byte 0xeb				/* jmp <disp8> */
+	.byte (memset_c - memset) - (2f - 1b)	/* offset */
+2:
+	.previous
 	.section .altinstructions,"a"
 	.align 8
-	.quad  memset
-	.quad  memset_c
-	.byte  X86_FEATURE_REP_GOOD
-	.byte  memset_c_end-memset_c
-	.byte  memset_c_end-memset_c
-	.previous
-
-	.section .altinstr_replacement,"ax"
- /* rdi	destination
-  * rsi value
-  * rdx count
-  */
-memset_c:
-	movq %rdi,%r9
-	movl %edx,%r8d
-	andl $7,%r8d		
-	movl %edx,%ecx
-	shrl $3,%ecx		
-	/* expand byte value  */
-	movzbl %sil,%esi
-	movabs $0x0101010101010101,%rax
-	mulq   %rsi		/* with rax, clobbers rdx */
-	rep
-	stosq	
-	movl %r8d,%ecx
-	rep
-	stosb
-	movq %r9,%rax
-	ret
-memset_c_end:
+	.quad memset
+	.quad 1b
+	.byte X86_FEATURE_REP_GOOD
+	.byte .Lfinal - memset
+	.byte 2b - 1b
 	.previous
Index: linux/arch/x86_64/lib/putuser.S
===================================================================
--- linux.orig/arch/x86_64/lib/putuser.S
+++ linux/arch/x86_64/lib/putuser.S
@@ -25,25 +25,26 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/dwarf2.h>
 #include <asm/page.h>
 #include <asm/errno.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 
 	.text
-	.p2align 4
-.globl __put_user_1
-__put_user_1:
+ENTRY(__put_user_1)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	cmpq threadinfo_addr_limit(%r8),%rcx
 	jae bad_put_user
 1:	movb %dl,(%rcx)
 	xorl %eax,%eax
 	ret
+	CFI_ENDPROC
+ENDPROC(__put_user_1)
 
-	.p2align 4
-.globl __put_user_2
-__put_user_2:
+ENTRY(__put_user_2)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $1,%rcx
 	jc 20f
@@ -55,10 +56,11 @@ __put_user_2:
 	ret
 20:	decq %rcx
 	jmp bad_put_user
+	CFI_ENDPROC
+ENDPROC(__put_user_2)
 
-	.p2align 4
-.globl __put_user_4
-__put_user_4:
+ENTRY(__put_user_4)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $3,%rcx
 	jc 30f
@@ -70,10 +72,11 @@ __put_user_4:
 	ret
 30:	subq $3,%rcx
 	jmp bad_put_user
+	CFI_ENDPROC
+ENDPROC(__put_user_4)
 
-	.p2align 4
-.globl __put_user_8
-__put_user_8:
+ENTRY(__put_user_8)
+	CFI_STARTPROC
 	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
 	jc 40f
@@ -85,10 +88,15 @@ __put_user_8:
 	ret
 40:	subq $7,%rcx
 	jmp bad_put_user
+	CFI_ENDPROC
+ENDPROC(__put_user_8)
 
 bad_put_user:
+	CFI_STARTPROC
 	movq $(-EFAULT),%rax
 	ret
+	CFI_ENDPROC
+END(bad_put_user)
 
 .section __ex_table,"a"
 	.quad 1b,bad_put_user
