Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967780AbWK3BIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967780AbWK3BIs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 20:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967781AbWK3BIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 20:08:48 -0500
Received: from smtp.osdl.org ([65.172.181.25]:11428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S967780AbWK3BIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 20:08:47 -0500
Date: Wed, 29 Nov 2006 17:08:35 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Miller <davem@davemloft.net>
Cc: wenji@fnal.gov, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 1/4] - Potential performance bottleneck for Linxu TCP
Message-Id: <20061129170835.72bd40b3.akpm@osdl.org>
In-Reply-To: <20061129.165311.45739865.davem@davemloft.net>
References: <HNEBLGGMEGLPMPPDOPMGCEAKCGAA.wenji@fnal.gov>
	<HNEBLGGMEGLPMPPDOPMGGEAKCGAA.wenji@fnal.gov>
	<20061129.165311.45739865.davem@davemloft.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 16:53:11 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> 
> Please, it is very difficult to review your work the way you have
> submitted this patch as a set of 4 patches.  These patches have not
> been split up "logically", but rather they have been split up "per
> file" with the same exact changelog message in each patch posting.
> This is very clumsy, and impossible to review, and wastes a lot of
> mailing list bandwith.
> 
> We have an excellent file, called Documentation/SubmittingPatches, in
> the kernel source tree, which explains exactly how to do this
> correctly.
> 
> By splitting your patch into 4 patches, one for each file touched,
> it is impossible to review your patch as a logical whole.
> 
> Please also provide your patch inline so people can just hit reply
> in their mail reader client to quote your patch and comment on it.
> This is impossible with the attachments you've used.
> 

Here you go - joined up, cleaned up, ported to mainline and test-compiled.

That yield() will need to be removed - yield()'s behaviour is truly awful
if the system is otherwise busy.  What is it there for?



From: Wenji Wu <wenji@fnal.gov>

For Linux TCP, when the network applcaiton make system call to move data from
socket's receive buffer to user space by calling tcp_recvmsg().  The socket
will be locked.  During this period, all the incoming packet for the TCP
socket will go to the backlog queue without being TCP processed

Since Linux 2.6 can be inerrupted mid-task, if the network application
expires, and moved to the expired array with the socket locked, all the
packets within the backlog queue will not be TCP processed till the network
applicaton resume its execution.  If the system is heavily loaded, TCP can
easily RTO in the Sender Side.



 include/linux/sched.h |    2 ++
 kernel/fork.c         |    3 +++
 kernel/sched.c        |   24 ++++++++++++++++++------
 net/ipv4/tcp.c        |    9 +++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff -puN net/ipv4/tcp.c~tcp-speedup net/ipv4/tcp.c
--- a/net/ipv4/tcp.c~tcp-speedup
+++ a/net/ipv4/tcp.c
@@ -1109,6 +1109,8 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	struct task_struct *user_recv = NULL;
 	int copied_early = 0;
 
+	current->backlog_flag = 1;
+
 	lock_sock(sk);
 
 	TCP_CHECK_TIMER(sk);
@@ -1468,6 +1470,13 @@ skip_copy:
 
 	TCP_CHECK_TIMER(sk);
 	release_sock(sk);
+
+	current->backlog_flag = 0;
+	if (current->extrarun_flag == 1){
+		current->extrarun_flag = 0;
+		yield();
+	}
+
 	return copied;
 
 out:
diff -puN include/linux/sched.h~tcp-speedup include/linux/sched.h
--- a/include/linux/sched.h~tcp-speedup
+++ a/include/linux/sched.h
@@ -1023,6 +1023,8 @@ struct task_struct {
 #ifdef	CONFIG_TASK_DELAY_ACCT
 	struct task_delay_info *delays;
 #endif
+	int backlog_flag; 	/* packets wait in tcp backlog queue flag */
+	int extrarun_flag;	/* extra run flag for TCP performance */
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -puN kernel/sched.c~tcp-speedup kernel/sched.c
--- a/kernel/sched.c~tcp-speedup
+++ a/kernel/sched.c
@@ -3099,12 +3099,24 @@ void scheduler_tick(void)
 
 		if (!rq->expired_timestamp)
 			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
-			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
-		} else
-			enqueue_task(p, rq->active);
+		if (p->backlog_flag == 0) {
+			if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
+				enqueue_task(p, rq->expired);
+				if (p->static_prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->static_prio;
+			} else
+				enqueue_task(p, rq->active);
+		} else {
+			if (expired_starving(rq)) {
+				enqueue_task(p,rq->expired);
+				if (p->static_prio < rq->best_expired_prio)
+					rq->best_expired_prio = p->static_prio;
+			} else {
+				if (!TASK_INTERACTIVE(p))
+					p->extrarun_flag = 1;
+				enqueue_task(p,rq->active);
+			}
+		}
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
diff -puN kernel/fork.c~tcp-speedup kernel/fork.c
--- a/kernel/fork.c~tcp-speedup
+++ a/kernel/fork.c
@@ -1032,6 +1032,9 @@ static struct task_struct *copy_process(
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
+	p->backlog_flag = 0;
+	p->extrarun_flag = 0;
+
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
  	p->sched_time = 0;
_

