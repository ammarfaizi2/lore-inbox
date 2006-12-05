Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759939AbWLEV6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759939AbWLEV6N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759940AbWLEV6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:58:13 -0500
Received: from smtp.osdl.org ([65.172.181.25]:36901 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759939AbWLEV6L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:58:11 -0500
Date: Tue, 5 Dec 2006 13:57:53 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
Cc: Andy Fleming <afleming@freescale.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
Message-Id: <20061205135753.9c3844f8.akpm@osdl.org>
In-Reply-To: <adaac22c9cu.fsf@cisco.com>
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
	<adaac22c9cu.fsf@cisco.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 05 Dec 2006 13:37:37 -0800
Roland Dreier <rdreier@cisco.com> wrote:

>  > a) Ban the calling of flush_scheduled_work() from under rtnl_lock(). 
>  >    Sounds hard.
> 
> Unfortunate if this is happening a lot.  It seems like the most
> sensible fix -- flush_scheduled_work() is in effect calling into
> an unknown and changeable in the future set of functions (since it
> waits for them to finish), and it seems error-prone to hold a lock
> across such a call.

yes, I agree.  It's really bad to be calling flush_scheduled_work() with
any locks held at all.  Fragile, hard-to-maintain, source of
once-in-a-blue-moon failures, etc.  I guess lockdep will help.

But running flush_scheduled_work() from within dev_close() is a very
sensible thing to do, and dev_close is called under rtnl_lock().
davem is -> thattaway ;)


>  >    This will almost work, as long as it's done in workqueue.c with
>  >    appropriate locking.  The bug occurs when some other CPU is running
>  >    phy_change() right now - we'll end up freeing data which that CPU is
>  >    presently playing with.
>  > 
>  >    But perhaps we can take care of this within workqueue.c.  We need a
>  >    cancel function which will cancel the work and, if its callback is
>  >    presently executing it will block until that execution has completed.
> 
> I may be misunderstanding you, but this seems to deadlock in exactly
> the same way: if someone calls this cancel routine holding rtnl_lock,
> and the work function that will also take rtnl_lock has just started,
> it will get stuck when the work function tries to take rtnl_lock.

Ah.  The point is that the phy code doesn't want to flush _all_ pending
callbacks.  It only wants to flush its own one.  And its own one doesn't
take rtnl_lock().

IOW, the phy code has no interest in running some random other subsystem's
callback - it just wants to run its own.  Hence no deadlock.

Maybe the lesson here is that flush_scheduled_work() is a bad function.
It should really be flush_this_work(struct work_struct *w).  That is in
fact what approximately 100% of the flush_scheduled_work() callers actually
want to do.

hmm.
