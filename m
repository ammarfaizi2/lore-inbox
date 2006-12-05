Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031655AbWLEVhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031655AbWLEVhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031669AbWLEVhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:37:41 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:35914 "EHLO
	sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031655AbWLEVhj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:37:39 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Andy Fleming <afleming@freescale.com>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
X-Message-Flag: Warning: May contain useful information
References: <1165125055.5320.14.camel@gullible>
	<20061203011625.60268114.akpm@osdl.org>
	<Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
	<20061205123958.497a7bd6.akpm@osdl.org>
	<6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
	<20061205132643.d16db23b.akpm@osdl.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Tue, 05 Dec 2006 13:37:37 -0800
In-Reply-To: <20061205132643.d16db23b.akpm@osdl.org> (Andrew Morton's message of "Tue, 5 Dec 2006 13:26:43 -0800")
Message-ID: <adaac22c9cu.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Dec 2006 21:37:37.0921 (UTC) FILETIME=[9578AF10:01C718B5]
Authentication-Results: sj-dkim-8; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim8002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > a) Ban the calling of flush_scheduled_work() from under rtnl_lock(). 
 >    Sounds hard.

Unfortunate if this is happening a lot.  It seems like the most
sensible fix -- flush_scheduled_work() is in effect calling into
an unknown and changeable in the future set of functions (since it
waits for them to finish), and it seems error-prone to hold a lock
across such a call.

 >    This will almost work, as long as it's done in workqueue.c with
 >    appropriate locking.  The bug occurs when some other CPU is running
 >    phy_change() right now - we'll end up freeing data which that CPU is
 >    presently playing with.
 > 
 >    But perhaps we can take care of this within workqueue.c.  We need a
 >    cancel function which will cancel the work and, if its callback is
 >    presently executing it will block until that execution has completed.

I may be misunderstanding you, but this seems to deadlock in exactly
the same way: if someone calls this cancel routine holding rtnl_lock,
and the work function that will also take rtnl_lock has just started,
it will get stuck when the work function tries to take rtnl_lock.

 - R.
