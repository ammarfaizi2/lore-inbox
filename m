Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263383AbVGAQmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbVGAQmb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 12:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVGAQmb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 12:42:31 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:49886 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S263383AbVGAQmM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 12:42:12 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 1/1] cciss per disk queue for 2.6
Date: Fri, 1 Jul 2005 11:41:28 -0500
Message-ID: <D4CFB69C345C394284E4B78B876C1CF107DC0868@cceexc23.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] cciss per disk queue for 2.6
Thread-Index: AcV+CqOrxKWqeph1Twej7tTQIcK6vQAQnz2g
From: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
To: "Jens Axboe" <axboe@suse.de>
Cc: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 01 Jul 2005 16:41:29.0106 (UTC) FILETIME=[BACD2F20:01C57E5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: Jens Axboe [mailto:axboe@suse.de] 
> Sent: Friday, July 01, 2005 2:02 AM
> To: Miller, Mike (OS Dev)
> Cc: akpm@osdl.org; linux-kernel@vger.kernel.org; 
> linux-scsi@vger.kernel.org
> Subject: Re: [PATCH 1/1] cciss per disk queue for 2.6
> 
> On Thu, Jun 30 2005, mike.miller@hp.com wrote:
> > This patch adds per disk queue functionality to cciss. 
> Sometime back I 
> > submitted a patch but it looks like only part of what I 
> needed. In the
> > 2.6 kernel if we have more than one logical volume the driver will 
> > Oops during rmmod. It seems all of the queues actually 
> point back to 
> > the same queue. So after deleting the first volume you hit a null 
> > pointer on the second one.
> > 
> > This has been tested in our labs. There is no difference in 
> > performance, it just fixes the Oops. Please consider this patch for 
> > inclusion.
> 
> Going to per-disk queues is undoubtedly a good idea, 
> performance will be much better this way. So far, so good.
> 
> But you need to do something about the queueing for this to 
> be acceptable, imho. You have a per-controller queueing limit 
> in place, you need to enforce some fairness to ensure an 
> equal distribution of commands between the disks.

Sometime back I submitted what we called the "fair enough" algorithm. I
don't know how I managed to separate the two. :( But it was accepted and
is in the mainstream kernel. Here's a snippet:
------------------------------------------------------------------------
-
-	/*
-	 * See if we can queue up some more IO
-	 * check every disk that exists on this controller
-	 * and start it's IO
-	 */
-	for(j=0; j < NWD; j++){
-		/* make sure the disk has been added and the drive is
real */
-		/* because this can be called from the middle of
init_one */
-		if(!(h->gendisk[j]->queue) || !(h->drv[j].heads))
+	/* check to see if we have maxed out the number of commands that
can
+	 * be placed on the queue.  If so then exit.  We do this check
here
+	 * in case the interrupt we serviced was from an ioctl and did
not
+	 * free any new commands.
+	*/
+	if ((find_first_zero_bit(h->cmd_pool_bits, NR_CMDS)) == NR_CMDS)
+		goto cleanup;
+
+	/* We have room on the queue for more commands.  Now we need to
queue
+	 * them up.  We will also keep track of the next queue to run so
+	 * that every queue gets a chance to be started first.
+	*/
+	for (j=0; j < NWD; j++){
+		int curr_queue = (start_queue + j) % NWD;
+		/* make sure the disk has been added and the drive is
real
+		 * because this can be called from the middle of
init_one.
+		*/
+		if(!(h->gendisk[curr_queue]->queue) || 
+		   !(h->drv[curr_queue].heads))
------------------------------------------------------------------------
-
> 
> Perhaps just limit the per-queue depth to something sane, 
> instead of the huuuge 384 commands you have now. I've had 
> several people complain to me, that ciss is doing some nasty 
> starvation with that many commands in flight and we've 
> effectively had to limit the queueing depth to something 
> really low to get adequate read performance in presence of writes.

The combination of per disk queues and this "fairness" prevents
starvation on different LV's. Ex: if volumes 0 & 1 are being written and
volume 3 is being read all will get _almost_ equal time. We believe the
elevator algoritm(s) may be causing writes to starve reads on the same
logical volume. We continue to investigate our other performance issues.

Thanks,
mikem


> 
> 
> --
> Jens Axboe
> 
> 
