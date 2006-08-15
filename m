Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWHOKdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWHOKdr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 06:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbWHOKdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 06:33:47 -0400
Received: from gwmail.nue.novell.com ([195.135.221.19]:4589 "EHLO
	emea5-mh.id5.novell.com") by vger.kernel.org with ESMTP
	id S1030192AbWHOKdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 06:33:46 -0400
Message-Id: <44E1BF37.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Tue, 15 Aug 2006 12:33:59 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Chuck Ebbert" <76306.1226@compuserve.com>,
       "Jesper Juhl" <jesper.juhl@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Dave Jones" <davej@redhat.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
References: <200608061212_MC3-1-C747-C2AD@compuserve.com>
 <44D70F42.76E4.0078.0@novell.com> <200608071004.37849.ak@suse.de>
In-Reply-To: <200608071004.37849.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part694CC107.5__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=__Part694CC107.5__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> So it would seem to me. Nevertheless, in my opinion the proper fix is
to annotate the call site
>> (in head.S) to specify a zero EIP as return address (which denotes
the bottom of a frame).
>
>Can you please send a patch to do that?
>
>That seems to be missing in some other places too, e.g. i386 sysenter
path, x86-64 kernel_thread,
>more?

Attaching both an i386 version (boot/idle thread only, you did
kernel_thread already)
and an x86-64 one (boot/idle and kernel_thread). The i386 sysenter path
is a different
thing, there we have an actual caller (though outside of the kernel),
which I'd like to
continue to reflect/catch through arch_unw_user_mode().

Jan

--=__Part694CC107.5__=
Content-Type: text/plain; name="linux-2.6.18-rc4-unwind-x86_64-term.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.18-rc4-unwind-x86_64-term.patch"

Add kernel thread stack frame termination for properly stopping stack
unwinds.

One open question: Should these added pushes perhaps be made
conditional upon CONFIG_STACK_UNWIND or CONFIG_UNWIND_INFO?

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc4/arch/x86_64/kernel/entry.S	2006-08-15 11:29:41.000000000 +0200
+++ 2.6.18-rc4-unwind-x86_64-term/arch/x86_64/kernel/entry.S	2006-08-15 10:15:40.000000000 +0200
@@ -973,6 +973,8 @@ ENTRY(kernel_thread)
 ENDPROC(kernel_thread)
 	
 child_rip:
+	pushq $0		# fake return address
+	CFI_STARTPROC
 	/*
 	 * Here we are in the child and the registers are set as they were
 	 * at kernel_thread() invocation in the parent.
@@ -983,6 +985,7 @@ child_rip:
 	# exit
 	xorl %edi, %edi
 	call do_exit
+	CFI_ENDPROC
 ENDPROC(child_rip)
 
 /*
--- linux-2.6.18-rc4/arch/x86_64/kernel/head.S	2006-06-18 03:49:35.000000000 +0200
+++ 2.6.18-rc4-unwind-x86_64-term/arch/x86_64/kernel/head.S	2006-08-15 11:05:13.000000000 +0200
@@ -191,6 +191,7 @@ startup_64:
 	 * jump
 	 */
 	movq	initial_code(%rip),%rax
+	pushq	$0		# fake return address
 	jmp	*%rax
 
 	/* SMP bootup changes these two */

--=__Part694CC107.5__=
Content-Type: text/plain; name="linux-2.6.18-rc4-unwind-i386-term.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="linux-2.6.18-rc4-unwind-i386-term.patch"

Add boot/idle kernel thread stack frame termination for properly
stopping stack unwinds.

One open question: Should this added push perhaps be made conditional
upon CONFIG_STACK_UNWIND or CONFIG_UNWIND_INFO?

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.18-rc4/arch/i386/kernel/head.S	2006-08-15 11:32:08.000000000 +0200
+++ 2.6.18-rc4-unwind-i386-term/arch/i386/kernel/head.S	2006-08-15 11:06:03.000000000 +0200
@@ -317,20 +317,14 @@ is386:	movl $2,%ecx		# set MP
 	movl %eax,%gs
 	lldt %ax
 	cld			# gcc2 wants the direction flag cleared at all times
+	pushl %eax		# fake return address
 #ifdef CONFIG_SMP
 	movb ready, %cl
 	movb $1, ready
-	cmpb $0,%cl
-	je 1f			# the first CPU calls start_kernel
-				# all other CPUs call initialize_secondary
-	call initialize_secondary
-	jmp L6
-1:
+	cmpb $0,%cl		# the first CPU calls start_kernel
+	jne initialize_secondary # all other CPUs call initialize_secondary
 #endif /* CONFIG_SMP */
-	call start_kernel
-L6:
-	jmp L6			# main should never return here, but
-				# just in case, we know what happens.
+	jmp start_kernel
 
 /*
  * We depend on ET to be correct. This checks for 287/387.

--=__Part694CC107.5__=--
