Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262177AbUKKHEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbUKKHEB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 02:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbUKKHEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 02:04:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:29359 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262177AbUKKHD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 02:03:57 -0500
Date: Wed, 10 Nov 2004 23:03:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg Banks <gnb@melbourne.sgi.com>
Cc: oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/11] oprofile: i386 support for stack trace sampling
Message-Id: <20041110230347.7138f9d1.akpm@osdl.org>
In-Reply-To: <1099996693.1985.785.camel@hole.melbourne.sgi.com>
References: <1099996693.1985.785.camel@hole.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Banks <gnb@melbourne.sgi.com> wrote:
>
>  oprofile i386 arch updates, including some internal
>  API changes and support for stack trace sampling.

It needs this to compile and link on x86_64.  No idea if it works...

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/oprofile/backtrace.c |    8 +++++++-
 25-akpm/arch/x86_64/oprofile/Makefile  |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff -puN arch/x86_64/oprofile/Makefile~oprofile-i386-support-for-stack-trace-sampling-fix arch/x86_64/oprofile/Makefile
--- 25/arch/x86_64/oprofile/Makefile~oprofile-i386-support-for-stack-trace-sampling-fix	2004-11-10 22:59:02.000000000 -0800
+++ 25-akpm/arch/x86_64/oprofile/Makefile	2004-11-10 22:59:09.000000000 -0800
@@ -11,7 +11,7 @@ DRIVER_OBJS = $(addprefix ../../../drive
 	oprofilefs.o oprofile_stats.o \
 	timer_int.o )
 
-OPROFILE-y := init.o
+OPROFILE-y := init.o backtrace.o
 OPROFILE-$(CONFIG_X86_LOCAL_APIC) += nmi_int.o op_model_athlon.o op_model_p4.o \
 				     op_model_ppro.o
 OPROFILE-$(CONFIG_X86_IO_APIC)    += nmi_timer_int.o 
diff -puN arch/i386/oprofile/backtrace.c~oprofile-i386-support-for-stack-trace-sampling-fix arch/i386/oprofile/backtrace.c
--- 25/arch/i386/oprofile/backtrace.c~oprofile-i386-support-for-stack-trace-sampling-fix	2004-11-10 23:00:43.000000000 -0800
+++ 25-akpm/arch/i386/oprofile/backtrace.c	2004-11-10 23:05:54.008203048 -0800
@@ -96,7 +96,13 @@ static int valid_kernel_stack(struct fra
 void
 x86_backtrace(struct pt_regs * const regs, unsigned int depth)
 {
-	struct frame_head * head = (struct frame_head *)regs->ebp;
+	struct frame_head *head;
+
+#ifdef CONFIG_X86_64
+	head = (struct frame_head *)regs->rbp;
+#else
+	head = (struct frame_head *)regs->ebp;
+#endif
 
 	if (!user_mode(regs)) {
 		while (depth-- && valid_kernel_stack(head, regs))
_

