Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbSI1DY3>; Fri, 27 Sep 2002 23:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262693AbSI1DY3>; Fri, 27 Sep 2002 23:24:29 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:26890
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262692AbSI1DY2>; Fri, 27 Sep 2002 23:24:28 -0400
Subject: Re: Sleeping function called from illegal context...
From: Robert Love <rml@tech9.net>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Andrew Morton <akpm@digeo.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10209272013370.13669-100000@master.linux-ide.org>
Content-Type: text/plain
Organization: 
Message-Id: <1033183786.22582.30.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 27 Sep 2002 23:29:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-27 at 23:21, Andre Hedrick wrote:

> Glad we agree on the lock issue, thanks for confirming the point!

Great!

> There is an issue of interrupt acknowledgement and when one can pre-empt.
> I would like to resolve the issue, but I need a global caller/notifier api
> from you so I can block IO in a safe spot on the 'data transfer' state
> bar.  Yeah, blah blah on underfined terms.

Well, I do not know what the problem is (or what the hell you are
talking about, to be honest).  You really should not have any problems
with preemption over regular SMP issues.  If your code has a problem
with other code running concurrently, then it should already hold a lock
and thus be non-preemptive?

Also note we do not preempt interrupt handlers (obviously).

If you have a critical section in which you do not want to be preempted,
do a:

	preempt_disable();
	/* critical section ... */
	preempt_enable();

This would have to be code that is in user-context and does not already
hold a lock.  There are very few explicit places that need this.  You
would be the first block driver, I believe.

Whatever this issue is, note it is entirely separate from the above
locking issue.  I also want to iterate that the locking problem
(rescheduling while holding a lock) is a problem on UP even.  Yes, think
about it.  Assuming the lock really needs to be held, it is protecting a
critical region.  If we reschedule, we can enter that region (or another
one of the same data protected hopefully by the same lock).  On SMP, we
would deadlock.  But on UP we will just silently corrupt the data. 
I.e., we can race on UP here.

	Robert Love

