Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263531AbTKQN6K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 08:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263532AbTKQN6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 08:58:10 -0500
Received: from leon-2.mat.uni.torun.pl ([158.75.2.64]:17057 "EHLO
	leon-2.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id S263531AbTKQN6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 08:58:05 -0500
Date: Mon, 17 Nov 2003 14:57:34 +0100 (CET)
From: Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
X-X-Sender: golbi@anna
To: Manfred Spraul <manfred@colorfullife.com>
cc: linux-kernel@vger.kernel.org, Urlich Drepper <drepper@redhat.com>,
       Michal Wronski <wrona@mat.uni.torun.pl>
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
In-Reply-To: <3FB79943.70902@colorfullife.com>
Message-ID: <Pine.GSO.4.58.0311171433430.18249@anna>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz> <3FB79943.70902@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Nov 2003, Manfred Spraul wrote:

> >+/proc/fs/mqueue/max_queues  is  a  read/write  file  for  setting/getting  the
> >+maximum number of message queues allowed on the system.
> >+
> >
> Why did you add your own proc file, instead of a sysctl entry?
Ok, we wanted to add this (proc support was done by Rusty Lynch) but when
we started to move implementation to syscalls we put it away.

>
> >+#define MQ_MAXMSG 	40	/* max number of messages in each queue */
> >
> >
> In the long run, this should be run time configurable. For now it
> doesn't matter, but think about that when chosing algorithms.
We do. We removed heaps implementation as on some different
(sensible) MQ_MAXMSG values it didn't show performance improve.

>
> >+#define MQ_MAXSYSSIZE	1048576	/* max size that all m.q. can have together */
> >
> Dito: we must try to avoid global counters - they limit the scalability.
Could you be more precise: This constant is non-POSIX. We added it only
because users (and some people on lkml) wanted so. It can be set to
MQ_MAXMSG*MQ_MAXMSG*MQ_MSGSIZE + 1 to turn off whole feature. So if I
understand you we add this just to limit scalability (and DoS attacks)

>
> >+static int wq_sleep(struct mqueue_inode_info *info, int sr,
> >+		    signed long timeout, struct ext_wait_queue *wq_ptr)
> >+{
> >
> [snip]
>
> >+		if ((current->pid == (list_entry(info->e_wait_q[sr].list.prev, struct ext_wait_queue, list))->task->pid)
> >
> Why current->pid? "current == ...->task" is sufficient.
Ok

>
> >diff -urN 2.6.0-test9-orig/ipc/msg.c 2.6.0-test9-patched/ipc/msg.c
> >--- 2.6.0-test9-orig/ipc/msg.c	2003-11-07 17:07:13.000000000 +0100
> >+++ 2.6.0-test9-patched/ipc/msg.c	2003-11-07 18:30:17.000000000 +0100
> >
> >[snip: move load_msg, free_msg to util.c]
> >
> Could you split that into a separate patch?

Hm, Michal said the same but considering that some preprocessor conditions
in util.c base on mqueues config I think that putting it different patch
would be little bit strange. But if you feel it ok - no problem.  Maybe
the best solution would be to make one patch that just moves functions
from msg.c to util.c and in main patch add only little #ifdef change in
util.c?


Regards
Krzysiek
