Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWEZQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWEZQGl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWEZQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 12:06:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:31394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750948AbWEZQGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 12:06:40 -0400
Date: Fri, 26 May 2006 09:05:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: ak@suse.de, jbeulich@novell.com, mingo@elte.hu,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
 annotations)
Message-Id: <20060526090518.7bac4824.akpm@osdl.org>
In-Reply-To: <20060526084327.433e2be0.akpm@osdl.org>
References: <4471D691.76E4.0078.0@novell.com>
	<20060524222359.06f467e8.akpm@osdl.org>
	<200605260918.52484.ak@suse.de>
	<20060526084327.433e2be0.akpm@osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
>  Andi Kleen <ak@suse.de> wrote:
>  >
>  > You probably need newer binutils.
> 
>  Don't think so.

<fiddles a bit more>

This makes it build.


diff -puN arch/i386/kernel/entry.S~a arch/i386/kernel/entry.S
--- devel/arch/i386/kernel/entry.S~a	2006-05-26 09:02:57.000000000 -0700
+++ devel-akpm/arch/i386/kernel/entry.S	2006-05-26 09:04:08.000000000 -0700
@@ -733,6 +733,7 @@ nmi_debug_stack_check:
 
 nmi_16bit_stack:
 	/* create the pointer to lss back */
+	CFI_STARTPROC simple
 	pushl %ss
 	pushl %esp
 	movzwl %sp, %esp
@@ -747,6 +748,7 @@ nmi_16bit_stack:
 	xorl %edx,%edx			# zero error code
 	call do_nmi
 	RESTORE_REGS
+	CFI_ENDPROC
 	lss 12+4(%esp), %esp		# back to 16bit stack
 1:	iret
 .section __ex_table,"a"
@@ -756,11 +758,13 @@ nmi_16bit_stack:
 
 KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int
+	CFI_STARTPROC simple
 	SAVE_ALL
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_int3
 	jmp ret_from_exception
+	CFI_ENDPROC
 	.previous .text
 
 ENTRY(overflow)
_

