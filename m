Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVCQRpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVCQRpq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 12:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbVCQRpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 12:45:46 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:712 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261879AbVCQRpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 12:45:38 -0500
Date: Thu, 17 Mar 2005 12:47:16 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PPC64 Fix kprobes calling smp_processor_id when preemptible
Message-ID: <20050317071716.GA7386@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <16949.6337.715642.803244@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16949.6337.715642.803244@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2005 at 03:53:21PM +1100, Paul Mackerras wrote:

Hi Paul,

> When booting with kprobes and preemption both enabled and
> CONFIG_DEBUG_PREEMPT=y, I get lots of warnings about smp_processor_id
> being called in preemptible code, from kprobe_exceptions_notify.  On
> ppc64, interrupts and preemption are not disabled in the handlers for
> most synchronous exceptions such as breakpoints and page faults
> (interrupts are disabled in the very early exception entry code but
> are reenabled before calling the C handler).
> 
> This patch adds a preempt_disable/enable pair to
> kprobe_exceptions_notify, and moves the preempt_disable() in
> kprobe_handler() to be done only in the case where we are about to
> single-step an instruction.  This eliminates the bug warnings.

The patch is fine, but it seems to break jprobes - we have an unbalanced
preempt_enable/disable path while handling jprobes. Patch below is
against 2.6.11-mm4 and fixes the issue.

Thanks,
Ananth


Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

diff -Naurp temp/linux-2.6.11/arch/ppc64/kernel/kprobes.c kprobes/linux-2.6.11/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.11/arch/ppc64/kernel/kprobes.c	2005-03-17 05:15:53.000000000 +0530
+++ kprobes/linux-2.6.11/arch/ppc64/kernel/kprobes.c	2005-03-17 19:46:21.000000000 +0530
@@ -262,7 +262,6 @@ int setjmp_pre_handler(struct kprobe *p,
 
 void jprobe_return(void)
 {
-	preempt_enable_no_resched();
 	asm volatile("trap" ::: "memory");
 }
 
