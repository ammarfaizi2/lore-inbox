Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVC2Cei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVC2Cei (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 21:34:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVC2Cei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 21:34:38 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:10408 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262155AbVC2Cea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 21:34:30 -0500
Date: Mon, 28 Mar 2005 21:34:08 -0500
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: William Cohen <wcohen@redhat.com>
Cc: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       prasanna@in.ibm.com, linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: kprobe_handler should  check pre_handler function
Message-ID: <20050329023408.GA4847@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <424872C8.6080207@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424872C8.6080207@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2005 at 04:10:32PM -0500, William Cohen wrote:

Hi Will,

> I found kprobes expects there to be a pre_handler function in the 
> structure. I was writing a probe that only needed a post_handler 
> function, no pre_handler function. The probe was tracking the 
> destinations of indirect calls and jumps, the probe needs to fire after 
> the instruction single steps to get the target address. The probe 
> crashed the machine because arch/i386/kernel/kprobe.c:kprobe_handler() 
> blindly calls p->pre_handler().  There should be a check to verify that 
> the pointer is non-null. There are cases where the pre_handler is not 
> needed and it would make sense to set it to NULL. Thus, a check should 
> be done for pre_handler like post_handler and fault_handler.

You are right. The check for pre_handler is needed and here is a patch
against 2.6.12-rc1-mm3 that does this.

Thanks,
Ananth

Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>


diff -Narup temp/linux-2.6.12-rc1/arch/i386/kernel/kprobes.c linux-2.6.12-rc1/arch/i386/kernel/kprobes.c
--- temp/linux-2.6.12-rc1/arch/i386/kernel/kprobes.c	2005-03-17 20:34:10.000000000 -0500
+++ linux-2.6.12-rc1/arch/i386/kernel/kprobes.c	2005-03-28 17:51:21.000000000 -0500
@@ -159,17 +159,16 @@ static int kprobe_handler(struct pt_regs
 	if (is_IF_modifier(p->opcode))
 		kprobe_saved_eflags &= ~IF_MASK;
 
-	if (p->pre_handler(p, regs)) {
+	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
 		return 1;
-	}
 
-      ss_probe:
+ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
-      no_kprobe:
+no_kprobe:
 	preempt_enable_no_resched();
 	return ret;
 }
diff -Narup temp/linux-2.6.12-rc1/arch/ppc64/kernel/kprobes.c linux-2.6.12-rc1/arch/ppc64/kernel/kprobes.c
--- temp/linux-2.6.12-rc1/arch/ppc64/kernel/kprobes.c	2005-03-28 17:48:56.000000000 -0500
+++ linux-2.6.12-rc1/arch/ppc64/kernel/kprobes.c	2005-03-28 17:51:31.000000000 -0500
@@ -128,10 +128,9 @@ static inline int kprobe_handler(struct 
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	current_kprobe = p;
 	kprobe_saved_msr = regs->msr;
-	if (p->pre_handler(p, regs)) {
+	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
 		return 1;
-	}
 
 ss_probe:
 	prepare_singlestep(p, regs);
diff -Narup temp/linux-2.6.12-rc1/arch/sparc64/kernel/kprobes.c linux-2.6.12-rc1/arch/sparc64/kernel/kprobes.c
--- temp/linux-2.6.12-rc1/arch/sparc64/kernel/kprobes.c	2005-03-17 20:34:33.000000000 -0500
+++ linux-2.6.12-rc1/arch/sparc64/kernel/kprobes.c	2005-03-28 17:50:55.000000000 -0500
@@ -128,7 +128,7 @@ static int kprobe_handler(struct pt_regs
 
 	kprobe_status = KPROBE_HIT_ACTIVE;
 	current_kprobe = p;
-	if (p->pre_handler(p, regs))
+	if (p->pre_handler && p->pre_handler(p, regs))
 		return 1;
 
 ss_probe:
diff -Narup temp/linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c
--- temp/linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c	2005-03-28 17:48:57.000000000 -0500
+++ linux-2.6.12-rc1/arch/x86_64/kernel/kprobes.c	2005-03-28 17:51:10.000000000 -0500
@@ -293,17 +293,16 @@ int kprobe_handler(struct pt_regs *regs)
 	if (is_IF_modifier(p->ainsn.insn))
 		kprobe_saved_rflags &= ~IF_MASK;
 
-	if (p->pre_handler(p, regs)) {
+	if (p->pre_handler && p->pre_handler(p, regs))
 		/* handler has already set things up, so skip ss setup */
 		return 1;
-	}
 
-      ss_probe:
+ss_probe:
 	prepare_singlestep(p, regs);
 	kprobe_status = KPROBE_HIT_SS;
 	return 1;
 
-      no_kprobe:
+no_kprobe:
 	preempt_enable_no_resched();
 	return ret;
 }
