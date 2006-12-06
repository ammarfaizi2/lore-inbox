Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934422AbWLFPZc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934422AbWLFPZc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 10:25:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934996AbWLFPZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 10:25:32 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:2991 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934422AbWLFPZa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 10:25:30 -0500
Date: Wed, 6 Dec 2006 15:25:22 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Andrew Morton <akpm@osdl.org>
cc: Roland Dreier <rdreier@cisco.com>, Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <20061205135753.9c3844f8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Dec 2006, Andrew Morton wrote:

> But running flush_scheduled_work() from within dev_close() is a very
> sensible thing to do, and dev_close is called under rtnl_lock().
> davem is -> thattaway ;)

 And when within dev_close() there is quite a chance there is 
linkwatch_event() somewhere in the event queue already. ;-)

> Ah.  The point is that the phy code doesn't want to flush _all_ pending
> callbacks.  It only wants to flush its own one.  And its own one doesn't
> take rtnl_lock().
> 
> IOW, the phy code has no interest in running some random other subsystem's
> callback - it just wants to run its own.  Hence no deadlock.

 Both are true.  It's linkwatch_event() that's somewhere in the queue 
already that makes the trouble here.

> Maybe the lesson here is that flush_scheduled_work() is a bad function.
> It should really be flush_this_work(struct work_struct *w).  That is in
> fact what approximately 100% of the flush_scheduled_work() callers actually
> want to do.

 There may be cases where flush_scheduled_work() is indeed needed, but 
likely outside drivers, and I agree such a specific call would be useful 
and work here.

  Maciej
