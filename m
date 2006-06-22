Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWFVSDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWFVSDk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 14:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbWFVSDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 14:03:40 -0400
Received: from www.osadl.org ([213.239.205.134]:52453 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932274AbWFVSDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 14:03:39 -0400
Subject: Re: Why can't I set the priority of softirq-hrt? (Re: 2.6.17-rt1)
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Esben Nielsen <nielsen.esben@googlemail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@elte.hu>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0606221902560.10511@localhost.localdomain>
References: <20060618070641.GA6759@elte.hu>
	 <Pine.LNX.4.64.0606201656230.11643@localhost.localdomain>
	 <1150816429.6780.222.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606201725550.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606201229310.729@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606201903030.11643@localhost.localdomain>
	 <1150824092.6780.255.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606202217160.11643@localhost.localdomain>
	 <Pine.LNX.4.58.0606210418160.29673@gandalf.stny.rr.com>
	 <Pine.LNX.4.64.0606211204220.10723@localhost.localdomain>
	 <Pine.LNX.4.64.0606211638560.6572@localhost.localdomain>
	 <1150907165.25491.4.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0606220936290.15236@gandalf.stny.rr.com>
	 <1150986041.25491.53.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0606221021410.15236@gandalf.stny.rr.com>
	 <1150986396.25491.56.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0606221902560.10511@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 22 Jun 2006 20:05:17 +0200
Message-Id: <1150999517.25491.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-22 at 19:06 +0100, Esben Nielsen wrote:
> >
> > Thats a seperate issue. Though you are right.
> 
> Why not use my original patch and solve both issues?
> I have even updated it to avoid the double traversal. It also removes 
> one other traversal which shouldn't be needed. (I have not had time 
> to boot the kernel with it, though, but it does compile...:-)

Simply because it does not solve following scenario:

High prio task is blocked on lock and boosts 3 other tasks. Now the
higher prrio watchdog detects that the high prio task is stuck and
lowers the priority. You can wake it up as long as you want, the boosted
task is still busy looping. We want an immidate propagation.

And I do not like the idea of invoking the scheduler to do those
propagations. setscheduler is a synchronous effect in all other cases.
So it has to be synchronous in the propagation case too.

Preempt-RT and the dynamic priority adjustment of high resolution timers
is a different playground and we have to think about that seperately.

	tglx


