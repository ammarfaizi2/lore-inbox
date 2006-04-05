Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750739AbWDERiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750739AbWDERiq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWDERiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 13:38:46 -0400
Received: from mail.gmx.de ([213.165.64.20]:45213 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750739AbWDERiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 13:38:46 -0400
X-Authenticated: #14349625
Subject: Re: [patch 2.6.16-mm2 10/9] sched throttle tree extract - kill
	interactive task feedback loop
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Peter Williams <pwil3058@bigpond.net.au>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>
In-Reply-To: <1143883915.7617.77.camel@homer>
References: <1143880124.7617.5.camel@homer> <1143880397.7617.10.camel@homer>
	 <1143880683.7617.16.camel@homer>  <1143881058.7617.24.camel@homer>
	 <1143881494.7617.32.camel@homer>  <1143881983.7617.41.camel@homer>
	 <1143882731.7617.55.camel@homer>  <1143883385.7617.66.camel@homer>
	 <1143883607.7617.71.camel@homer>  <1143883915.7617.77.camel@homer>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 19:38:51 +0200
Message-Id: <1144258731.7894.12.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

The patch below stops interactive tasks from feeding off each other
during round-robin.

With this 10th patch in place, a busy server with _default_ throttle
settings (ie tunables may now be mostly unneeded) looks like this:

[root]:# w
 18:38:00 up 23 min,  2 users,  load average: 10.07, 9.94, 7.50
USER     TTY        LOGIN@   IDLE   JCPU   PCPU  WHAT
root     tty1      18:15   22:12  30.89s 30.84s  top d1
root     pts/0     18:20    0.00s  0.07s  0.00s  w
[root]:# time netstat|grep :81|wc -l
   1758

real    0m0.304s
user    0m0.144s
sys     0m0.135s
[root]:# time netstat|grep :81|wc -l
   1776

real    0m0.306s
user    0m0.118s
sys     0m0.163s
[root]:# time netstat|grep :81|wc -l
   1799

real    0m0.493s
user    0m0.146s
sys     0m0.141s
[root]:#

My desktop still feels just peachy.

Signed-off-by: Mike Galbraith <efault@gmx.de>

--- linux-2.6.16-mm2/kernel/sched.c-9.export_tunables	2006-03-31 13:37:09.000000000 +0200
+++ linux-2.6.16-mm2/kernel/sched.c	2006-04-05 19:22:01.000000000 +0200
@@ -3480,7 +3480,7 @@ go_idle:
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
 
-	if (!rt_task(next) && interactive_sleep(next->sleep_type)) {
+	if (!TASK_INTERACTIVE(next) && interactive_sleep(next->sleep_type)) {
 		unsigned long long delta = now - next->timestamp;
 		if (unlikely((long long)(now - next->timestamp) < 0))
 			delta = 0;


