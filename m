Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262412AbVCSK4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbVCSK4m (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 05:56:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262442AbVCSK4m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 05:56:42 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:403 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262412AbVCSK4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 05:56:38 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp: Remove arch-specific references from generic code
Date: Sat, 19 Mar 2005 11:59:32 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
References: <20050316001207.GI21292@elf.ucw.cz>
In-Reply-To: <20050316001207.GI21292@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503191159.32569.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday, 16 of March 2005 01:12, Pavel Machek wrote:
> Hi!
> 
> This is fix for "swsusp_restore crap"-: we had some i386-specific code
> referenced from generic code. This fixes it by inlining tlb_flush_all
> into assembly.
> 
> Please apply,

Unfortunately, this patch requires the following fix.  Without it, swsusp will
leak lots of memory on every resume.  Sorry for this bug, it was really dumb.

Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nrup linux-2.6.12-rc1-a/arch/i386/power/swsusp.S linux-2.6.12-rc1-b/arch/i386/power/swsusp.S
--- linux-2.6.12-rc1-a/arch/i386/power/swsusp.S	2005-03-19 11:51:02.000000000 +0100
+++ linux-2.6.12-rc1-b/arch/i386/power/swsusp.S	2005-03-19 11:52:37.000000000 +0100
@@ -68,4 +68,6 @@ done:
 
 	pushl saved_context_eflags ; popfl
 
+	xorl	%eax, %eax
+
 	ret
diff -Nrup linux-2.6.12-rc1-a/arch/x86_64/kernel/suspend_asm.S linux-2.6.12-rc1-b/arch/x86_64/kernel/suspend_asm.S
--- linux-2.6.12-rc1-a/arch/x86_64/kernel/suspend_asm.S	2005-03-19 11:51:02.000000000 +0100
+++ linux-2.6.12-rc1-b/arch/x86_64/kernel/suspend_asm.S	2005-03-19 11:52:10.000000000 +0100
@@ -83,7 +83,7 @@ done:
 
 	movq saved_context_esp(%rip), %rsp
 	movq saved_context_ebp(%rip), %rbp
-	movq saved_context_eax(%rip), %rax
+	/* Don't restore %rax, it must be 0 */
 	movq saved_context_ebx(%rip), %rbx
 	movq saved_context_ecx(%rip), %rcx
 	movq saved_context_edx(%rip), %rdx
@@ -99,4 +99,6 @@ done:
 	movq saved_context_r15(%rip), %r15
 	pushq saved_context_eflags(%rip) ; popfq
 
+	xorq	%rax, %rax
+
 	ret

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
