Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbWC1I2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbWC1I2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 03:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWC1I2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 03:28:38 -0500
Received: from www.osadl.org ([213.239.205.134]:46489 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751264AbWC1I2i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 03:28:38 -0500
Subject: Re: [patch 2/2] hrtimer
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <20060327235530.GA7024@oleg>
References: <20060325121219.172731000@localhost.localdomain>
	 <20060325121223.966390000@localhost.localdomain>
	 <20060325183213.63ab667c.akpm@osdl.org>
	 <1143411016.5344.139.camel@localhost.localdomain>
	 <20060327235530.GA7024@oleg>
Content-Type: text/plain
Date: Tue, 28 Mar 2006 10:29:33 +0200
Message-Id: <1143534573.5344.172.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-28 at 03:55 +0400, Oleg Nesterov wrote:
> Instead of exit(), 'task' can go to TASK_STOPPED or TASK_UNINTERRUPTIBLE
> after return from do_nanosleep(), it will be awakened by hrtimer_wakeup()
> unexpectedly.

Yep, you are right.

Index: linux-2.6.16/kernel/hrtimer.c
===================================================================
--- linux-2.6.16.orig/kernel/hrtimer.c
+++ linux-2.6.16/kernel/hrtimer.c
@@ -684,10 +684,9 @@ static int __sched do_nanosleep(struct h
 
 		schedule();
 
-		if (unlikely(t->task)) {
-			hrtimer_cancel(&t->timer);
-			mode = HRTIMER_ABS;
-		}
+		hrtimer_cancel(&t->timer);
+		mode = HRTIMER_ABS;
+
 	} while (t->task && !signal_pending(current));
 
 	return t->task == NULL;




