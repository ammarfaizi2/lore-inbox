Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbTEOJQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTEOJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 05:16:37 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:58623 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263898AbTEOJQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 05:16:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16067.24042.126672.10150@gargle.gargle.HOWL>
Date: Thu, 15 May 2003 11:29:14 +0200
From: mikpe@csd.uu.se
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       Pavel Machek <pavel@suse.cz>
Subject: Re: 2.5.69-mm5: CONFIG_ACPI_SLEEP compile error
In-Reply-To: <20030514214536.GK1346@fs.tum.de>
References: <20030514012947.46b011ff.akpm@digeo.com>
	<20030514214536.GK1346@fs.tum.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:
 > It seems the following problem comes from Linus' tree:
 > 
 > <--  snip  -->
 > 
 > ...
 > ... --end-group  -o .tmp_vmlinux1
 > arch/i386/kernel/built-in.o(.data+0x1fae): In function `do_suspend_lowlevel':
 > : undefined reference to `saved_context_esp'
 > arch/i386/kernel/built-in.o(.data+0x1fb3): In function `do_suspend_lowlevel':
 > : undefined reference to `saved_context_eax'
 > arch/i386/kernel/built-in.o(.data+0x1fb9): In function `do_suspend_lowlevel':
 > : undefined reference to `saved_context_ebx'

My fault, sorry. When I grepped for these variables I failed to notice
the references in acpi/wakeup.S. This patch fixes this.

/Mikael

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
