Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFJTiy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 15:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbTFJThd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 15:37:33 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:32331 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262176AbTFJTgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 15:36:23 -0400
Date: Tue, 10 Jun 2003 12:46:13 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-Id: <20030610124613.40e65da7.akpm@digeo.com>
In-Reply-To: <12190000.1055266471@flay>
References: <60380000.1055188542@flay>
	<20030609140834.11ad0d63.akpm@digeo.com>
	<5930000.1055254447@[10.10.2.4]>
	<12190000.1055266471@flay>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Jun 2003 19:50:04.0647 (UTC) FILETIME=[7CBFB770:01C32F89]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> OK, well backing out dcache_lock-vs-tasklist_lock-take-3.patch does
> indeed seem to fix the problem. It's done 5.5 whole cycles now, and
> still going strong.

Well that patch fixed a real bug.  It abviously added or exposed another
one though.  

I continue to wonder if that task_struct is scrogged.  There seem to be no
other processes holding the lock.

Might be interesting to give the below patch a run with memory debug
enabled.

Also spinlock debugging enabled.  It would be nice to run with preempt and
sleep-in-spinlock debugging enabled too, but I think preempt is broken on
NUMA?

(Anton had a patch which just enabled the beancounting which is needed for
might_sleep() effectiveness without turning on preempt, but it needs more
work for ia32)


diff -puN fs/proc/base.c~a fs/proc/base.c
--- 25/fs/proc/base.c~a	Tue Jun 10 12:40:44 2003
+++ 25-akpm/fs/proc/base.c	Tue Jun 10 12:42:01 2003
@@ -1374,6 +1374,11 @@ struct dentry *proc_pid_lookup(struct in
 
 	dentry->d_op = &pid_base_dentry_operations;
 
+	if (task->bite_me != 0) {
+		printk("corrupted task_struct: 0x%x\n", task->bite_me);
+		BUG();
+	}
+
 	spin_lock(&task->proc_lock);
 	task->proc_dentry = dentry;
 	d_add(dentry, inode);
diff -puN include/linux/sched.h~a include/linux/sched.h
--- 25/include/linux/sched.h~a	Tue Jun 10 12:40:44 2003
+++ 25-akpm/include/linux/sched.h	Tue Jun 10 12:40:44 2003
@@ -330,6 +330,8 @@ struct task_struct {
 	struct list_head run_list;
 	prio_array_t *array;
 
+	u32 bite_me;
+
 	unsigned long sleep_avg;
 	unsigned long last_run;
 

_

