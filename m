Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264000AbTDJHz3 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 03:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264003AbTDJHz3 (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 03:55:29 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:32669 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264000AbTDJHzZ (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 03:55:25 -0400
Date: Thu, 10 Apr 2003 17:02:37 +0900 (JST)
Message-Id: <20030410.170237.74756028.kochi@hpc.bs1.fc.nec.co.jp>
To: marcelo@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [PATCH] duplicate PID fix for 2.4
From: Takayoshi Kochi <kochi@hpc.bs1.fc.nec.co.jp>
X-Mailer: Mew version 3.1 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Apr_10_17:02:37_2003_920)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Thu_Apr_10_17:02:37_2003_920)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello,

We found a problem that after a full pid situation occurs,
duplicate pids may be allocated.  A patch is attached to
this mail.  This happens only on 2.4.

Marcelo, please apply.

The detail is described below:

In get_pid(), a free pid is searched through all task_structs
even when there is no free pid.  If all pids are already allocated,
the kernel exits the loop with 'next_safe' untouched.

	if(last_pid >= next_safe) {
inside:
		next_safe = PID_MAX;
		read_lock(&tasklist_lock);
repeat:
	for_each_task(p) {
		if(p->pid == last_pid	||
		   p->pgrp == last_pid	||
		   p->tgid == last_pid	||
		   p->session == last_pid) {			<= (A)
			if(++last_pid >= next_safe) {		<= (B)
				if(last_pid & 0xffff8000)
					last_pid = 300;
				next_safe = PID_MAX;
			}
			if(unlikely(last_pid == beginpid))	<= (C)
				goto nomorepids;
			goto repeat;
		}
	...
	}

In a rare case, both (B) and (C) can be true and then, next_safe
will remain PID_MAX (32768).  In that case, following get_pid() will
always succeed until last_pid reaches 32768 and there may be duplicate
pids.

When this happens?

As 'beginpid' is the pid of the process that created by the last fork(),
the task_struct of that process should be located at the tail of
the task_struct list.  So one might think that if (C) is true,
all the task_structs are scanned and (B) will never be possible
on the ground that when we are all through the task_struct list,
next_safe shuould be beginpid+1.

But this assumption is wrong because in (B), last_pid is
pre-incremented so in (A), last_pid == beginpid-1.
If the PID=beginpid-1 process is on very early in
the task_struct list, (B) is possible.

To protect this case is simple: when the condition (C) is true,
set next_safe to 0 or any safe value to guarantee that a free pid
will be searched through next time.  Or simply move (C) before (B),
which also guarantees next time search because at that point
next_safe is beginpid+1.

We prefer the former because it explicitly sets next_safe
so that the next time search is guaranteed.

Thanks,
---
Takayoshi Kochi <kochi@hpc.bs1.fc.nec.co.jp>

----Next_Part(Thu_Apr_10_17:02:37_2003_920)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fork.c.diff"

--- linux-2.4.20/kernel/fork.c.orig	Wed Apr  9 16:48:19 2003
+++ linux-2.4.20/kernel/fork.c	Wed Apr  9 16:53:46 2003
@@ -114,8 +114,10 @@
 						last_pid = 300;
 					next_safe = PID_MAX;
 				}
-				if(unlikely(last_pid == beginpid))
+				if(unlikely(last_pid == beginpid)) {
+					next_safe = 0;
 					goto nomorepids;
+				}
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)

----Next_Part(Thu_Apr_10_17:02:37_2003_920)----
