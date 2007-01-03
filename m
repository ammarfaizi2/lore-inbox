Return-Path: <linux-kernel-owner+w=401wt.eu-S1754338AbXACGga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbXACGga (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754373AbXACGg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:36:29 -0500
Received: from mga03.intel.com ([143.182.124.21]:48997 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754302AbXACGg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:36:29 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,228,1165219200"; 
   d="scan'208"; a="164666546:sNHT19635014"
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Zach Brown'" <zach.brown@oracle.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>, <linux-aio@kvack.org>,
       <linux-kernel@vger.kernel.org>, "'Benjamin LaHaise'" <bcrl@kvack.org>,
       <suparna@in.ibm.com>
Subject: RE: [patch] aio: add per task aio wait event condition
Date: Tue, 2 Jan 2007 22:36:25 -0800
Message-ID: <000001c72f01$7e4e1e30$8b8c030a@amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Accu28ojKMHj5LKaSaKVV4BZ3u6TNgAIDWNQ
In-Reply-To: <96568BA6-9ECD-4E1D-B5B3-3AA41463A8EE@oracle.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote on Tuesday, January 02, 2007 6:06 PM
> > In the example you
> > gave earlier, task with min_nr of 2 will be woken up after 4 completed
> > events.
> 
> I only gave 2 ios/events in that example.
> 
> Does that clear up the confusion?

It occurs to me that people might not be aware how peculiar the
current io_getevent wakeup scheme is, to the extend of erratic
behavior.

In the blocking path of read_events(), we essentially doing the
following loop (simplified for clarity):

        while (i < nr) {
                add_wait_queue_exclusive(&ctx->wait, &wait);
                do {
                        ret = aio_read_evt(ctx, &ent);
                        if (!ret)
                                schedule();
                while (1);
                remove_wait_queue(&ctx->wait, &wait);
                copy_to_user(event, &ent, sizeof(ent));
        }

Noticed that when thread comes out of schedule(), it removes itself
from the wait queue, and requeue itself at the end of the wait queue
for each and every event it reaps.  So if there are multiple threads
waiting in io_getevents, completed I/O are handed out in round robin
scheme to all waiting threads.

To illustrate it in ascii graph, here is what happens:

               thread 1               thread 2

               queue at head
               schedule()

                                      queue at 2nd position
                                      schedule

aio_complete
(event 1)
               remove_wait_queue      (now thread 2 is at head)
               reap event 1
               requeue at tail
               schedule

aio_complete
(event 2)
                                      remove_wait_queue (now thread 1 is at head)
                                      reap event 2
                                      requeue at tail
                                      schedule

If thread 1 sleeps first with min_nr = 2, and thread 2 sleeps
second with min_nr = 3, then thread 1 wakes up on event _3_.
But if thread 2 sleeps first, thread 1 sleeps second, thread 1
wakes up on event _4_.  If someone ask me to describe algorithm
of io_getevents wake-up scheme in the presence of multiple
waiters, I call it erratic and un-deterministic.

Looking back to the example Zach gave earlier, current
implementation behaves just like what described as an undesired
bug (modified and tortured):

issue 2 ops
first io_getevents sleeps with a min_nr of 2
second io_getevents sleeps with min_nr of 3
2 ops complete
first sleeper twiddles thumbs

So I can categorize my patchset as a bug fix instead of a
performance patch ;-)  Let's be serious, this ought to be fixed
one way or the other.


- Ken
