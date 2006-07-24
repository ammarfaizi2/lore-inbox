Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932223AbWGXRPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932223AbWGXRPa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 13:15:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWGXRPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 13:15:30 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:8073 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932223AbWGXRP2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 13:15:28 -0400
Subject: [PATCH -rt] Don't let raise_softirq_prio lower the prio (was: [RT]
	rt priority losing)
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Duetsch, Thomas LDE1" <thomas.duetsch@siemens.com>
In-Reply-To: <Pine.LNX.4.64.0607241854360.10471@localhost.localdomain>
References: <1153755660.4002.137.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607241758420.10471@localhost.localdomain>
	 <1153759042.11295.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607241854360.10471@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 24 Jul 2006 13:15:01 -0400
Message-Id: <1153761301.11295.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-24 at 18:54 +0100, Esben Nielsen wrote:

> >
> > OK, you are right about this.  The PI chain should not be affected.  But
> > this could still be a problem if the softirq was running at a high prio
> > for a task when a lower prio callback needs to be made.  It looks like
> > timer is removed from the base before the function runs.  So when the
> > interrupt looks at the base to determine the priority to set it at, it
> > might actually lower the priority of a running hrtimer thread.
> >
> 
> That is a simple bug which ought to be simple fixable.

I guess the simple fix is not to allow the interrupt to lower the
priority. But simple fixes do not always handle all the cases.

Thomas G., see any side effects with this patch?

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rt7/kernel/softirq.c
===================================================================
--- linux-2.6.17-rt7.orig/kernel/softirq.c	2006-07-24 13:08:53.000000000 -0400
+++ linux-2.6.17-rt7/kernel/softirq.c	2006-07-24 13:10:13.000000000 -0400
@@ -108,7 +108,12 @@ static void wakeup_softirqd_prio(int sof
 	struct task_struct *tsk = __get_cpu_var(ksoftirqd[softirq].tsk);
 
 	if (tsk) {
-		if (tsk->normal_prio != prio) {
+		/*
+		 * The lower the prio, the higher the priority.
+		 * This can only raise the priority but it can
+		 * not lower it.
+		 */
+		if (tsk->normal_prio > prio) {
 			struct sched_param param;
 
 			param.sched_priority = MAX_RT_PRIO-1 - prio;


