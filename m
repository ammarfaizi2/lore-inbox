Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281523AbRKHLle>; Thu, 8 Nov 2001 06:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281521AbRKHLlY>; Thu, 8 Nov 2001 06:41:24 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:2059 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S281523AbRKHLlM>;
	Thu, 8 Nov 2001 06:41:12 -0500
Date: Thu, 8 Nov 2001 12:41:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [patch] cciss dequeue race fix (was Re: preempt-patch cleared of blame)
Message-ID: <20011108124102.J27652@suse.de>
In-Reply-To: <20011108113615.F27652@suse.de> <Pine.LNX.4.33.0111081322570.8555-100000@localhost.localdomain> <20011108123808.I27652@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20011108123808.I27652@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 08 2001, Jens Axboe wrote:
> On Thu, Nov 08 2001, Ingo Molnar wrote:
> > 
> > On Thu, 8 Nov 2001, Jens Axboe wrote:
> > 
> > > On Wed, Nov 07 2001, J Sloan wrote:
> > > > I think there may be a problem with the
> > > > compaq smart/2p raid drivers, since
> > > > the "do_ida_intr" code keeps showing
> > > > up in the oops, and I have not seen a
> > > > problem with 2.4.14 on any other system.
> > >
> > > Does this fix it?
> > 
> > it did the trick on my system, which used to oops in/around do_ida_intr as
> > well.
> 
> Good, so it was a dequeue race. Thanks Ingo.

BTW, cciss has a similar race.

-- 
Jens Axboe


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cciss-dequeue-1

--- linux/drivers/block/cciss.c~	Thu Nov  8 11:36:24 2001
+++ linux/drivers/block/cciss.c	Thu Nov  8 11:37:03 2001
@@ -1307,6 +1307,8 @@
 	if (( c = cmd_alloc(h, 1)) == NULL)
 		goto startio;
 
+	blkdev_dequeue_request(creq);
+
 	spin_unlock_irq(&io_request_lock);
 
 	c->cmd_type = CMD_RWREQ;      
@@ -1386,12 +1388,6 @@
 
 	spin_lock_irq(&io_request_lock);
 
-	blkdev_dequeue_request(creq);
-
-        /*
-         * ehh, we can't really end the request here since it's not
-         * even started yet. for now it shouldn't hurt though
-         */
 	addQ(&(h->reqQ),c);
 	h->Qdepth++;
 	if(h->Qdepth > h->maxQsinceinit)

--cmJC7u66zC7hs+87--
