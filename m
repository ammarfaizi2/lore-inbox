Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268970AbUIHCQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268970AbUIHCQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 22:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUIHCQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 22:16:20 -0400
Received: from coverity.dreamhost.com ([66.33.192.105]:63424 "EHLO
	coverity.dreamhost.com") by vger.kernel.org with ESMTP
	id S268970AbUIHCPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 22:15:53 -0400
Date: Tue, 7 Sep 2004 19:15:52 -0700 (PDT)
From: Dawson Engler <engler@coverity.dreamhost.com>
To: linux-kernel@vger.kernel.org
Cc: developers@coverity.com
Subject: [CHECKER] 2.6.8.1 deadlock in rpc_queue_lock <<===>>  rpc_sched_lock
Message-ID: <Pine.LNX.4.58.0409071915020.23546@coverity.dreamhost.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

below is a possible deadlock in linux-2.6.8.1 found by a static deadlock
checker I'm writing.  Let me know if it looks valid and/or whether the
output is too cryptic.  (Note, the error is in debugging code so maybe
not such a big deal).

Thanks,
Dawson

     rpc_queue_lock <<===>>  rpc_sched_lock

   thread 1: rpc_queue_lock ==>> rpc_sched_lock

       trace 1:
       /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:rpc_child_exit
          1023: rpc_child_exit(struct rpc_task *child)
          1024: {
          1025: 	struct rpc_task	*parent;
          1026:
===>      1027: 	spin_lock_bh(&rpc_queue_lock);
             1028: 	if ((parent = rpc_find_parent(child)) != NULL) {
             1029: 		parent->tk_status = child->tk_status;
===>         1030: 		__rpc_wake_up_task(parent);

             /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:__rpc_wake_up_task
                430: __rpc_wake_up_task(struct rpc_task *task)
                431: {
                432: 	dprintk("RPC: %4d __rpc_wake_up_task (now %ld inh %d)\n",
                433: 					task->tk_pid, jiffies, rpc_inhibit);
                434:
                435: #ifdef RPC_DEBUG
                436: 	if (task->tk_magic != 0xf00baa) {
                437: 		printk(KERN_ERR "RPC: attempt to wake up non-existing task!\n");
                438: 		rpc_debug = ~0;
===>            439: 		rpc_show_tasks();
                /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:rpc_show_tasks
                   1247: void rpc_show_tasks(void)
                   1248: {
                   1249: 	struct list_head *le;
                   1250: 	struct rpc_task *t;
                   1251:
===>               1252: 	spin_lock(&rpc_sched_lock);

     -----------
   thread 2: rpc_sched_lock:spinlock_t:<global lock> ==>> rpc_queue_lock:spinlock_t:<global lock>>
       trace 1: ncalls=1, ncond=1
       /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:rpc_killall_tasks
          1070: rpc_killall_tasks(struct rpc_clnt *clnt)
          1071: {
          1072: 	struct rpc_task	*rovr;
          1073: 	struct list_head *le;
          1074:
          ...
          1076:
          1077: 	/*
          1078: 	 * Spin lock all_tasks to prevent changes...
          1079: 	 */
===>      1080: 	spin_lock(&rpc_sched_lock);
             1081: 	alltask_for_each(rovr, le, &all_tasks)
             1082: 		if (!clnt || rovr->tk_client == clnt) {
             1083: 			rovr->tk_flags |= RPC_TASK_KILLED;
             1084: 			rpc_exit(rovr, -EIO);
===>         1085: 			rpc_wake_up_task(rovr);
             /u2/engler/mc/oses/linux/linux-2.6.8.1/net/sunrpc/sched.c:rpc_wake_up_task
                475: rpc_wake_up_task(struct rpc_task *task)
                476: {
                477: 	if (RPC_IS_RUNNING(task))
                478: 		return;
===>            479: 	spin_lock_bh(&rpc_queue_lock);

