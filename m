Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267727AbUHJWWr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267727AbUHJWWr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 18:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267751AbUHJWWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 18:22:47 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:1547 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id S267727AbUHJWWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 18:22:44 -0400
Message-ID: <41194EA5.80706@hp.com>
Date: Tue, 10 Aug 2004 18:39:33 -0400
From: Robert Picco <Robert.Picco@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc4-mm1
References: <20040810002110.4fd8de07.akpm@osdl.org> <200408100937.47451.jbarnes@engr.sgi.com> <20040810212033.GY11200@holomorphy.com>
In-Reply-To: <20040810212033.GY11200@holomorphy.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

copy_thread expects a switch_stack below pt_regs  on the stack.  the 
switch_stack would have the parent's bspstore value for computing how 
much register backing store to copy into child.  there isn't a 
switch_stack and the resultant bspstore size computed is enormous 
(depends on what there is on stack).  i suspect printk has changed stack 
and the code layout changed too.

diff -ruN -X /home/picco/losl/dontdiff linux-2.6.8-rc3-mm2-orig/arch/ia64/kernel/process.c linux-2.6.8-rc3-mm2/arch/ia64/kernel/process.c
--- linux-2.6.8-rc3-mm2-orig/arch/ia64/kernel/process.c	2004-08-10 17:24:51.000000000 -0400
+++ linux-2.6.8-rc3-mm2/arch/ia64/kernel/process.c	2004-08-10 17:33:51.000000000 -0400
@@ -352,7 +352,7 @@
 	 * For SMP idle threads, fork_by_hand() calls do_fork with
 	 * NULL regs.
 	 */
-	if (!regs)
+	if (clone_flags & CLONE_IDLETASK)
 		return 0;
 #endif
 
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.8-rc3-mm2-orig/include/linux/sched.h linux-2.6.8-rc3-mm2/include/linux/sched.h
--- linux-2.6.8-rc3-mm2-orig/include/linux/sched.h	2004-08-10 17:25:07.000000000 -0400
+++ linux-2.6.8-rc3-mm2/include/linux/sched.h	2004-08-10 17:31:56.000000000 -0400
@@ -40,6 +40,7 @@
 #define CLONE_FS	0x00000200	/* set if fs info shared between processes */
 #define CLONE_FILES	0x00000400	/* set if open files shared between processes */
 #define CLONE_SIGHAND	0x00000800	/* set if signal handlers and blocked signals shared */
+#define CLONE_IDLETASK	0x00001000	/* set if new pid should be 0 (kernel only)*/
 #define CLONE_PTRACE	0x00002000	/* set if we want to let tracing continue on the child too */
 #define CLONE_VFORK	0x00004000	/* set if the parent wants the child to wake it up on mm_release */
 #define CLONE_PARENT	0x00008000	/* set if we want to have the same parent as the cloner */
diff -ruN -X /home/picco/losl/dontdiff linux-2.6.8-rc3-mm2-orig/kernel/fork.c linux-2.6.8-rc3-mm2/kernel/fork.c
--- linux-2.6.8-rc3-mm2-orig/kernel/fork.c	2004-08-10 17:25:10.000000000 -0400
+++ linux-2.6.8-rc3-mm2/kernel/fork.c	2004-08-10 17:32:56.000000000 -0400
@@ -1196,7 +1196,7 @@
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(struct pt_regs));
-	task = copy_process(CLONE_VM, 0, &regs, 0, NULL, NULL, 0);
+	task = copy_process(CLONE_VM|CLONE_IDLETASK, 0, &regs, 0, NULL, NULL, 0);
 	if (!task)
 		return ERR_PTR(-ENOMEM);
 	init_idle(task, cpu);


