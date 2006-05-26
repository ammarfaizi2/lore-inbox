Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750924AbWEZPo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750924AbWEZPo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 11:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWEZPo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 11:44:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3997 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750923AbWEZPo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 11:44:26 -0400
Date: Fri, 26 May 2006 08:43:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: jbeulich@novell.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 6/6] reliable stack trace support (i386 entry.S
 annotations)
Message-Id: <20060526084327.433e2be0.akpm@osdl.org>
In-Reply-To: <200605260918.52484.ak@suse.de>
References: <4471D691.76E4.0078.0@novell.com>
	<20060524222359.06f467e8.akpm@osdl.org>
	<200605260918.52484.ak@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> You probably need newer binutils.

Don't think so.

With this:

diff -puN arch/i386/kernel/entry.S~a arch/i386/kernel/entry.S
--- devel/arch/i386/kernel/entry.S~a	2006-05-26 08:32:04.000000000 -0700
+++ devel-akpm/arch/i386/kernel/entry.S	2006-05-26 08:36:50.000000000 -0700
@@ -733,6 +733,7 @@ nmi_debug_stack_check:
 
 nmi_16bit_stack:
 	/* create the pointer to lss back */
+	CFI_STARTPROC simple
 	pushl %ss
 	pushl %esp
 	movzwl %sp, %esp

That great stream of assembler errors comes down to:

arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:858: Error: open CFI at the end of file; missing .cfi_endproc directive
make[1]: *** [arch/i386/kernel/entry.o] Error 1

So there seems to be a missing startproc in there.

With this:

--- devel/arch/i386/kernel/entry.S~a	2006-05-26 08:32:04.000000000 -0700
+++ devel-akpm/arch/i386/kernel/entry.S	2006-05-26 08:38:43.000000000 -0700
@@ -733,6 +733,7 @@ nmi_debug_stack_check:
 
 nmi_16bit_stack:
 	/* create the pointer to lss back */
+	CFI_STARTPROC simple
 	pushl %ss
 	pushl %esp
 	movzwl %sp, %esp
@@ -850,6 +851,8 @@ ENTRY(arch_unwind_init_running)
 ENDPROC(arch_unwind_init_running)
 #endif
 
+	CFI_ENDPROC
+
 .section .rodata,"a"
 #include "syscall_table.S"
 

I get

arch/i386/kernel/entry.S: Assembler messages:
arch/i386/kernel/entry.S:860: Error: invalid sections for operation on `L0' and `L0'

Which is a bit mysterious.

Still, I expect that with a bit of fiddling this patch can be made to work
with older binutils.  I also suspect there's actually something wrong with
it.

