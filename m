Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264941AbUGGHeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264941AbUGGHeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 03:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264937AbUGGHeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 03:34:19 -0400
Received: from mx1.elte.hu ([157.181.1.137]:35243 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S264941AbUGGHeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 03:34:17 -0400
Date: Wed, 7 Jul 2004 09:35:10 +0200
From: Ingo Molnar <mingo@elte.hu>
To: "David S. Miller" <davem@redhat.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: 2.6.7-mm6
Message-ID: <20040707073510.GA27609@elte.hu>
References: <20040705023120.34f7772b.akpm@osdl.org> <20040706125438.GS21066@holomorphy.com> <20040706233618.GW21066@holomorphy.com> <20040706170247.5bca760c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040706170247.5bca760c.davem@redhat.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David S. Miller <davem@redhat.com> wrote:

> On Tue, 6 Jul 2004 16:36:18 -0700
> William Lee Irwin III <wli@holomorphy.com> wrote:
> 
> > I have it isolated down to the sched-clean-init-idle.patch and
> > sched-clean-fork.patch. sched-clean-init-idle.patch fails to build without
> > the second of those two applied, so I didn't do any work to narrow it down
> > further.
> 
> One thing to note is that we don't currently call the
> wake_up_forked_process() thing in our SMP idle bootup
> dispatcher in arch/sparc64/kernel/smp.c

the patch below should solve this. Is it safe on sparc to do a
fork_by_hand() like this?

	Ingo

--- linux/arch/sparc64/kernel/smp.c.orig	
+++ linux/arch/sparc64/kernel/smp.c	
@@ -293,6 +293,16 @@ extern unsigned long sparc64_cpu_startup
  */
 static struct thread_info *cpu_new_thread = NULL;
 
+static struct task_struct * __init fork_by_hand(void)
+{
+	struct pt_regs regs;
+	/*
+	 * don't care about the regs settings since
+	 * we'll never reschedule the forked task.
+	 */
+	return copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL);
+}
+
 static int __devinit smp_boot_one_cpu(unsigned int cpu)
 {
 	unsigned long entry =
@@ -302,9 +312,7 @@ static int __devinit smp_boot_one_cpu(un
 	struct task_struct *p;
 	int timeout, ret, cpu_node;
 
-	kernel_thread(NULL, NULL, CLONE_IDLETASK);
-
-	p = prev_task(&init_task);
+	p = fork_by_hand();
 
 	init_idle(p, cpu);
 
