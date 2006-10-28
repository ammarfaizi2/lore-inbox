Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751880AbWJ1Gzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbWJ1Gzp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 02:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751886AbWJ1Gzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 02:55:45 -0400
Received: from mail-gw3.adaptec.com ([216.52.22.36]:43192 "EHLO
	mail-gw3.adaptec.com") by vger.kernel.org with ESMTP
	id S1751880AbWJ1Gzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 02:55:45 -0400
Message-ID: <4542FF94.4090005@adaptec.com>
Date: Sat, 28 Oct 2006 12:28:28 +0530
From: Ravi Krishnamurthy <Ravi_Krishnamurthy@adaptec.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: axboe@suse.de
Subject: Block driver freezes when using CFQ
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2006 06:55:42.0554 (UTC) FILETIME=[15C1F3A0:01C6FA5E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

    I have written a block driver that registers a virtual device and
routes requests to appropriate real devices after some re-mapping of
the requests. I am testing the driver by creating a filesystem on the
virtual device and copying a large number of files on to it. The test
causes the device to become unresponsive after some time. After some
debugging, I noticed that this happens only if the I/O scheduler being
used is CFQ. I have not had any trouble if the scheduler is noop,
anticipatory or deadline. The problem occurs on all the kernels I have
tested - 2.6.18-rc2, 2.6.18-rc4, 2.6.19-rc3.

Below are some details about the driver and what I have observed during
testing:

The request function registered by my driver is a simple loop -

   while ((req = elv_next_request(q))) {
         blkdev_dequeue_request(req);

         /*
          Add request to an internal queue for further processing
          Wake up thread to start processing the queue
          Update some variables for book-keeping
          */
   }

Completed requests are handled in a different thread -
   while (work to be done) {
       /*
         Dequeue completed requests from internal queue
         Call end_that_request_first() and end_that_request_last()
         Update some variables for book-keeping
       */
   }

Several times during the test run, the while() loop in the request
function comes out without dequeuing any request even though the
elevator queue is not empty. (Confirmed by printing the return value of
elv_queue_empty(), and the values of q->rq.count[] outside the loop).
After one such occurrence, the request function is not called at all
and the device becomes unresponsive.
I added some code that lets me trigger the request function from userspace.
If I nudge the driver this way, I/Os continue for a short while and stop
again.

Since CFQ is the default I/O scheduler in current kernels, it has been
widely used and tested. So I suspect I am not doing something right in my
driver. Since the driver works well with the other schedulers, is there
something CFQ-specific that I should take care of?


Please Cc me on the responses since I am not subscribed to lkml.

Thanks,
Ravi.
