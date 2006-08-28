Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWH1U0f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWH1U0f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 16:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWH1U0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 16:26:35 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:45839 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751478AbWH1U0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 16:26:34 -0400
Date: Mon, 28 Aug 2006 16:26:31 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>,
       SCSI development list <linux-scsi@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: [PATCH 0/4] Change return values from queue_work et al.
Message-ID: <Pine.LNX.4.44L0.0608281403330.5680-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew and Ingo:

As discussed earlier, the following patches change the representation used 
for the return values from queue_work(), schedule_work(), and related 
routines.

It turned out these functions were used in ~800 places, and in ~90% of
them the return value was ignored!  This is perhaps understandble, because
the only way these functions can fail is if their work_struct argument is
uninitialized or already in use.  (Whether it's robust for callers to
depend on this behavior remaining unchanged into the indefinite future is
more questionable.)

So I took a short cut which allowed most of the usages to remain as they
are.  queue_work(), schedule_work(), and their friends still exist and do
what they did before, but now they return void.  In addition, they call
WARN_ON if the submission fails; this seems safer than letting the failure
go silently unnoticed.  

However there is a risk to using WARN_ON: In at least one place
(drivers/char/vt.c) a call to schedule_work() is _expected_ to fail!  The
driver doesn't care whether or not the work_struct is already queued, so
long as the callback occurs eventually.  This amounts to relying on
undocumented behavior; I added an explanatory comment but it's not clear
what the right approach is.  The same thing may happen in other places.  
Perhaps the WARN_ON lines shouldn't be added.

Keeping the old routine names may complicate the changeover slightly, but 
it isn't dangerous.  The compiler will flag as an error any attempt to 
call the old routine names expecting a non-void return value.

In place of the original routines are add_work_to_q(), add_work(), and so
on.  They return int values, but now the values are 0 for success and
-EBUSY for failure instead of 1 for success and 0 for failure.  The
relatively small number of places that did check the return values have
been updated to use the new routines.  (Incidentally, rpc_make_runnable()  
in net/sunrpc/sched.c checked the return value in the wrong way -- which
is now the correct way.  So the patch _does_ qualify as a bug fix.)

There were four functions acting as wrappers around queue_work or 
queue_delayed_work:

	fc_queue_work() and fc_queue_devloss_work() in 
	drivers/scsi/scsi_transport_fc.c,

	scsi_queue_work() in drivers/scsi/hosts.c,

	and kblockd_schedule_work() in block/ll_rw_blk.c.

These functions passed the return value from queue_work back to their
callers, which might have made things awkward -- except that none of the
callers check the return value!  So I changed all these routines to
return void instead of int.

Finally, included is a patch which adds a new chapter to 
Documentation/CodingStyle.  It explains how to decide between returning a 
1/0 code vs. a 0/-Exxx code for success/failure, and it speaks for itself.

Alan Stern

