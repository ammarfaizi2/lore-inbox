Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUDDX5l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 19:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbUDDX5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 19:57:40 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:58761
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261671AbUDDX5i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 19:57:38 -0400
Date: Mon, 5 Apr 2004 01:57:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: one more kthread_should_stop smp race
Message-ID: <20040404235740.GA21069@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

reviewing the patchsets between 2.6.5-rc3 and 2.6.5 I noticed another
race like in do_softirq:

---------------
PatchSet 17177
Date: 2004/03/30 19:49:13
Author: vatsa
Branch: HEAD
Tag: (none)
Log:
[PATCH] Fix obvious stupid race in do_stop

We don't set the task state to TASK_INTERRUPTIBLE _before_ checking for
kthread_should_stop in do_stop.

BKrev: 4069c129adimxhudm2NaqM222iNj9A

Members:
        ChangeSet:1.17177->1.17178
        kernel/stop_machine.c:1.3->1.4

Index: linux-2.5/kernel/stop_machine.c
diff -u linux-2.5/kernel/stop_machine.c:1.3
linux-2.5/kernel/stop_machine.c:1.4
--- linux-2.5/kernel/stop_machine.c:1.3 Wed Mar 10 02:03:28 2004
+++ linux-2.5/kernel/stop_machine.c     Tue Mar 30 20:49:13 2004
@@ -149,10 +149,12 @@
        complete(&smdata->done);

        /* Wait for kthread_stop */
+       __set_current_state(TASK_INTERRUPTIBLE);
        while (!kthread_should_stop()) {
-               __set_current_state(TASK_INTERRUPTIBLE);
                schedule();
+               __set_current_state(TASK_INTERRUPTIBLE);
        }
+       __set_current_state(TASK_RUNNING);
        return ret;
 }
---------------

the TASK_INTERRUPTIBLE may become visible to other cpus after the
current cpu read kthread_should_stop.

Fix:

--- x/kernel/stop_machine.c.~1~	2004-04-04 08:09:33.000000000 +0200
+++ x/kernel/stop_machine.c	2004-04-05 01:54:00.719800824 +0200
@@ -149,10 +149,10 @@ static int do_stop(void *_smdata)
 	complete(&smdata->done);
 
 	/* Wait for kthread_stop */
-	__set_current_state(TASK_INTERRUPTIBLE);
+	set_current_state(TASK_INTERRUPTIBLE);
 	while (!kthread_should_stop()) {
 		schedule();
-		__set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE);
 	}
 	__set_current_state(TASK_RUNNING);
 	return ret;
