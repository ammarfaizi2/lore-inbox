Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVFYL4C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVFYL4C (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 07:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVFYL4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 07:56:02 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30946 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261153AbVFYLyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 07:54:51 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Oliver Neukum <neukum@fachschaft.cup.uni-muenchen.de>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC] Driver writer's guide to sleeping
Date: Sat, 25 Jun 2005 14:54:36 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net
References: <200506251250.18133.vda@ilport.com.ua> <Pine.LNX.4.58.0506251327390.3206@fachschaft.cup.uni-muenchen.de>
In-Reply-To: <Pine.LNX.4.58.0506251327390.3206@fachschaft.cup.uni-muenchen.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506251454.36745.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 June 2005 14:29, Oliver Neukum wrote:
> On Sat, 25 Jun 2005, Denis Vlasenko wrote:
> 
> > schedule_timeout(timeout)
> > 	Whee, it has a comment! :)
> >  * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
> >  * pass before the routine returns. The routine will return 0
[snip]
> > 	Thus:
> > 	set_current_state(TASK_[UN]INTERRUPTIBLE);
> > 	schedule_timeout(timeout_in_jiffies)
> > 
> > msleep(ms)
> > 	Sleeps at least ms msecs.
> > 	Equivalent to:
> > 	set_current_state(TASK_UNINTERRUPTIBLE);
> > 	schedule_timeout(timeout)
> 
> If and only if you are not on any waitqueue. You may not be interrupted
> by a signal, but you still can be woken with an explicit wake_up()

Like this?
--
vda

--- linux-2.6.12.src/kernel/timer.c.orig	Sun Jun 19 16:11:00 2005
+++ linux-2.6.12.src/kernel/timer.c	Sat Jun 25 14:50:22 2005
@@ -1059,12 +1059,16 @@ static void process_timeout(unsigned lon
  *
  * You can set the task state as follows -
  *
- * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies are guaranteed to
- * pass before the routine returns. The routine will return 0
+ * %TASK_UNINTERRUPTIBLE - at least @timeout jiffies will pass
+ * before the routine returns, unless something explicitly
+ * wakes you up with wake_up_process(). Signals won't interrupt
+ * such sleep.
  *
  * %TASK_INTERRUPTIBLE - the routine may return early if a signal is
- * delivered to the current task. In this case the remaining time
- * in jiffies will be returned, or 0 if the timer expired in time
+ * delivered to the current task.
+ *
+ * The remaining time in jiffies will be returned, or 0 if the timer
+ * expired in time.
  *
  * The current task state is guaranteed to be TASK_RUNNING when this
  * routine returns.

