Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTLLEdf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 23:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTLLEdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 23:33:35 -0500
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:42133 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S264476AbTLLEda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 23:33:30 -0500
Date: Fri, 12 Dec 2003 13:33:03 +0900 (JST)
Message-Id: <20031212.133303.78702500.t-kochi@bq.jp.nec.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org, t-kochi@bq.jp.nec.com
Subject: [PATCH 2.4] duplicate PID fix
From: Takayoshi Kochi <t-kochi@bq.jp.nec.com>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Fri_Dec_12_13:33:03_2003_835)--"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----Next_Part(Fri_Dec_12_13:33:03_2003_835)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Marcelo,

This fix was sent to lkml in April, and was merged to -ac tree,
but is not merged in the main tree yet.
Please consider taking this in.

Without this, duplicate pids can be allocated, which will make
one of them unkillable (signals are deliverd to only one of them),
and this can be exploitable (I don't know for sure, but maybe,
like brk() ;)

This situation happens only when all pid space is full.
Usually, users cannot fork processes more than 32768 (PID_MAX),
but default user limit of max processes can be more
than PID_MAX on large memory machines such as 64bit
platforms (although it's adjustable by threads-max sysctl).

This patch modifies common code and affects all architectures,
but modifies code only executed when no pid is available,
so it doesn't hurt any normal path anyway.

(BTW, once I sent this patch to Rusty's Trivial patch monkey,
but his reply was non-trivial, and he also said this is
scary ;)

The details are described below:

In get_pid(), an available pid is searched through all task_structs
even when there is no available pid.  If a new pid is not available,
the kernel exits the loop with static variable 'next_safe' untouched,
which usually is no problem.


	spin_lock(&lastpid_lock);
	beginpid = last_pid;
	if((++last_pid) & 0xffff8000) {
		last_pid = 300;		/* Skip daemons etc. */
		goto inside;
	}
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
		if(p->pid > last_pid && next_safe > p->pid)
			next_safe = p->pid;
		if(p->pgrp > last_pid && next_safe > p->pgrp)
			next_safe = p->pgrp;
		if(p->tgid > last_pid && next_safe > p->tgid)
			next_safe = p->tgid;
		if(p->session > last_pid && next_safe > p->session)
			next_safe = p->session;
	}


In a rare case, both (B) and (C) can be true and then, next_safe
will remain PID_MAX (32768).  If that happens, following get_pid() will
always succeed until last_pid reaches 32768 and there may be many
duplicate pids.

For example, this happens when

 * PID space are full (300-32767 are all occupied)
 * the last pid allocated is 10000
 * task list chain is like:
   ...(pids < 9999), 9999, ...(pids 300~9998, 10001~32767)... , 10000

The loop starts searching an available pid with beginpid=10000 and
last_pid=10001.  last_pid is incremented until it gets PID_MAX
and then wraps around to 300, then is incremented again.

At the point that p->pid=9999 is found in tasklist (condition (A)),

  last_pid = 9999
  next_safe <= 9998

therefore condition (B) is true, and then

  last_pid = 10000
  next_safe = PID_MAX

and then, condition (C) is also true, and exits the loop.

To protect this case is simple; when the condition (C) is true,
set next_safe to 0 or any safe value to guarantee that a free pid
will be searched through next time.

Thanks,
---
Takayoshi Kochi <kochi@linux.bs1.fc.nec.co.jp/t-kochi@bq.jp.nec.com>

----Next_Part(Fri_Dec_12_13:33:03_2003_835)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fork.c.diff"

--- linux-2.4.23.orig/kernel/fork.c	Fri Dec 12 10:45:28 2003
+++ linux-2.4.23/kernel/fork.c	Fri Dec 12 10:49:12 2003
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

----Next_Part(Fri_Dec_12_13:33:03_2003_835)----
