Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUDNUMm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 16:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDNUMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 16:12:42 -0400
Received: from 7ka-campus-gw.mipt.ru ([194.85.83.97]:45762 "EHLO
	7ka-campus-gw.mipt.ru") by vger.kernel.org with ESMTP
	id S261530AbUDNUMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 16:12:39 -0400
Date: Thu, 15 Apr 2004 00:13:36 +0400
From: Kirill Korotaev <kirillx@7ka.mipt.ru>
Reply-To: Kirill Korotaev <kirillx@7ka.mipt.ru>
X-Priority: 3 (Normal)
Message-ID: <807045345.20040415001336@7ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Subject: Q: kernel/pids.c code
In-Reply-To: <1310277139.20040415001215@7ka.mipt.ru>
References: <407D57F4.7090409@sw.ru> <1310277139.20040415001215@7ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have two questions both concerning code located in kernel/pids.c:

1. why do we hold task.struct pid_link pids[].pid in task_struct?
I looked through the code and found that such solution is ugly at
least because:
- it occupies at least 7*4=28 more integers in task_struct then could
be. Note that this memory is not used everytime.
- pids can held reference to task_struct thus making it's lifetime longer
and less predictable. Memory consumption is unpredictable.
- the code is really unreadable and messy
Why struct pid is not allocated in kmem_cache instead?

2. function switch_exec_pids() calls _detach_pid() 6 times
and attach_pid() 8 times, i.e. we put 6 references and take 8.
is it bug? if so, then it looks like
pids (SID and PGID) can leak (with corresponding task_structs)?

void switch_exec_pids(task_t *leader, task_t *thread)
{
         _detach_pid(leader, PIDTYPE_PID);
         _detach_pid(leader, PIDTYPE_TGID);
         _detach_pid(leader, PIDTYPE_PGID);
         _detach_pid(leader, PIDTYPE_SID);

         _detach_pid(thread, PIDTYPE_PID);
         _detach_pid(thread, PIDTYPE_TGID);

         leader->pid = leader->tgid = thread->pid;
         thread->pid = thread->tgid;

         attach_pid(thread, PIDTYPE_PID, thread->pid);
         attach_pid(thread, PIDTYPE_TGID, thread->tgid);
         attach_pid(thread, PIDTYPE_PGID, thread->pgrp);
         attach_pid(thread, PIDTYPE_SID, thread->session);

         attach_pid(leader, PIDTYPE_PID, leader->pid);
         attach_pid(leader, PIDTYPE_TGID, leader->tgid);
         attach_pid(leader, PIDTYPE_PGID, leader->pgrp);
         attach_pid(leader, PIDTYPE_SID, leader->session);
}

Kirill


