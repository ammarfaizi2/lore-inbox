Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264053AbTEOOuh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 10:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264059AbTEOOuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 10:50:37 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:11179 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264053AbTEOOug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 10:50:36 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16067.44089.914992.464224@gargle.gargle.HOWL>
Date: Thu, 15 May 2003 17:03:21 +0200
From: mikpe@csd.uu.se
To: CaT <cat@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-bk[89]: software suspend compile error
In-Reply-To: <20030515144933.GB632@zip.com.au>
References: <20030515144933.GB632@zip.com.au>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CaT writes:
 > tried to see if I could fix this myself but couldn't figure out what was
 > happening. the ld line that creates the built-in.o has suspend_asm.o in
 > it which, in turn, seems to contain the right labels so I'm a bit lost.
 > Anyhow, here's part of the output and the relevant (I hope) bit of the
 > .config.
 > 
 > ...
 > arch/i386/kernel/built-in.o: In function `do_suspend_lowlevel':
 > arch/i386/kernel/built-in.o(.data+0x160a): undefined reference to `saved_context_esp'
 > arch/i386/kernel/built-in.o(.data+0x160f): undefined reference to `saved_context_eax'
 > arch/i386/kernel/built-in.o(.data+0x1615): undefined reference to `saved_context_ebx'
etc

Known problem (my fault). Apply the patch below. I'm submitting it to Linus
shortly so hopefully it will be included in -bk11 or 2.5.70.

--- linux-2.5.69-bk9/arch/i386/kernel/suspend_asm.S.~1~	2003-05-15 11:07:04.000000000 +0200
+++ linux-2.5.69-bk9/arch/i386/kernel/suspend_asm.S	2003-05-15 11:09:29.000000000 +0200
@@ -7,6 +7,12 @@
 #include <asm/page.h>
 
 	.data
+	.align	4
+	.globl	saved_context_eax, saved_context_ebx
+	.globl	saved_context_ecx, saved_context_edx
+	.globl	saved_context_esp, saved_context_ebp
+	.globl	saved_context_esi, saved_context_edi
+	.globl	saved_context_eflags
 saved_context_eax:
 	.long	0
 saved_context_ebx:
