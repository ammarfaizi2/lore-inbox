Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264917AbUHTIfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUHTIfJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbUHTIdR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:33:17 -0400
Received: from mx1.elte.hu ([157.181.1.137]:34020 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S267777AbUHTIbs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:31:48 -0400
Date: Fri, 20 Aug 2004 10:33:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Nathan Lynch <nathanl@austin.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: 2.6.8.1-mm2
Message-ID: <20040820083322.GA8392@elte.hu>
References: <20040819014204.2d412e9b.akpm@osdl.org> <1092964083.4946.7.camel@biclops.private.network> <20040819181603.700a9a0e.akpm@osdl.org> <1092987650.28849.349.camel@bach>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092987650.28849.349.camel@bach>
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


* Rusty Russell <rusty@rustcorp.com.au> wrote:

> Nathan, can you revert that, and apply this?  This actually fixes the
> might_sleep problem, and should fix at least the problem Vatsa saw. 
> If it doesn't solve your problem, we need to look again.

i've attached a much simpler replacement: dont allow CPU hotplug during
self-reap.

	Ingo

DESC

disable preemption in the self-reap codepath, as such tasks may not be
on the tasklist anymore and CPU-hotplug relies on the tasklist to
migrate tasks.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/kernel/exit.c.orig	
+++ linux/kernel/exit.c	
@@ -25,6 +25,7 @@
 #include <linux/proc_fs.h>
 #include <linux/mempolicy.h>
 #include <linux/perfctr.h>
+#include <linux/cpu.h>
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -780,8 +781,14 @@ static void exit_notify(struct task_stru
 
 	/* If the process is dead, release it - nobody will wait for it */
 	if (state == TASK_DEAD) {
+		lock_cpu_hotplug();
 		release_task(tsk);
 		write_lock_irq(&tasklist_lock);
+		/*
+		 * No preemption may happen from this point on,
+		 * or CPU hotplug (and task exit) breaks:
+		 */
+		unlock_cpu_hotplug();
 		tsk->state = state;
 		_raw_write_unlock(&tasklist_lock);
 		local_irq_enable();
