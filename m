Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWFWCIo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWFWCIo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 22:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbWFWCIo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 22:08:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbWFWCIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 22:08:44 -0400
Date: Thu, 22 Jun 2006 19:08:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [patch 2/3] rtmutex: Propagate priority settings into PI lock
 chains
Message-Id: <20060622190825.7da4eeae.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0606220959490.15236@gandalf.stny.rr.com>
References: <20060622082758.669511000@cruncher.tec.linutronix.de>
	<20060622082812.607857000@cruncher.tec.linutronix.de>
	<Pine.LNX.4.58.0606220959490.15236@gandalf.stny.rr.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2006 10:20:59 -0400 (EDT)
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +	if (!waiter || waiter->list_entry.prio == task->prio) {
> > +		spin_unlock_irqrestore(&task->pi_lock, flags);
> > +		return;
> > +	}
> > +
> > +	/* gets dropped in rt_mutex_adjust_prio_chain()! */
> > +	get_task_struct(task);
> > +	spin_unlock_irqrestore(&task->pi_lock, flags);
> > +
> > +	rt_mutex_adjust_prio_chain(task, 0, NULL, NULL, task);
> 
> The above means that you cant ever call sched_setscheduler from a
> interrupt handler (or softirq).  The rt_mutex_adjust_prio_chain since that
> grabs wait_lock which is not for interrupt use.

Running setscheduler() from IRQ context sounds rather perverse. 
BUG_ON(in_interrupt()) would reduce the temptation.
