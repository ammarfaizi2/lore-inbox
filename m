Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318050AbSGWND3>; Tue, 23 Jul 2002 09:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318058AbSGWND3>; Tue, 23 Jul 2002 09:03:29 -0400
Received: from [195.63.194.11] ([195.63.194.11]:17427 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318050AbSGWND0>; Tue, 23 Jul 2002 09:03:26 -0400
Message-ID: <3D3D5355.40404@evision.ag>
Date: Tue, 23 Jul 2002 15:00:05 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: Morten Helgesen <morten.helgesen@nextframe.net>,
       linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207231437360.14042-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:
> On Tue, 23 Jul 2002, Morten Helgesen wrote:
> 
> 
>>On Mon, Jul 22, 2002 at 09:37:13PM +0200, Bartlomiej Zolnierkiewicz wrote:
>>
>>>IDE 99 which is included in 2.5.27 introduced really nasty bug.
>>>Possible lockups and data corruption. Please do not.
>>
>>Could you please elaborate a bit ?
> 
> 
> Bug is a result of Martin being careless and not sending patches for
> public review. It is easy to fix, but I won't, please excuse me.
> Also I wont go in technical details, lets see how quick it will be fixed.

The problem is of a somehow general nature.
Many of the block devices *need* a mechanism to run commands
asynchronously. The most preffered way to do this is
of course to go by the already present request queue.
However the generic queue handling layer
doesn't give us any mechanism to actually stuff
request from the driver and it doesn't behave well in boundary
conditions where the queues are nearly full.

So every single subsystem is (or at least should be) repeating something
along the lines of the following...

tatic void __scsi_insert_special(request_queue_t *q, struct request *rq,
				  void *data, int at_head)
{
	unsigned long flags;

	ASSERT_LOCK(q->queue_lock, 0);

	/*
	 * tell I/O scheduler that this isn't a regular read/write (ie
	 * must not attempt merges on this) and that it acts as a soft
	 * barrier
	 */
	rq->flags &= REQ_QUEUED;
	rq->flags |= REQ_SPECIAL | REQ_BARRIER;

	rq->special = data;

	spin_lock_irqsave(q->queue_lock, flags);
	/* If command is tagged, release the tag */
	if(blk_rq_tagged(rq))
		blk_queue_end_tag(q, rq);
	_elv_add_request(q, rq, !at_head, 0);
	q->request_fn(q);
	spin_unlock_irqrestore(q->queue_lock, flags);
}


int scsi_insert_special_req(Scsi_Request * SRpnt, int at_head)
{
	request_queue_t *q = &SRpnt->sr_device->request_queue;

	__scsi_insert_special(q, SRpnt->sr_request, SRpnt, at_head);
	return 0;
}

Well actually the proper patch will be modelled after what
is done in SCSI. Or maybe even unifying both.
At least it is immediately "obvious" that __scsi_insert_request()
has a signature which doesn't have anything to do with the SCSI
subsystem.
Becouse it is clear from the above as well
that for example at least setting the rq->flags should
be common among every kind of subsystem and it shouldn't
be done inside the subsystems implementation of this
method, since the flags are of a generic nature and there
are changes in this area from time to time.


For now the following *should* do for IDE:

===== drivers/ide/ide-taskfile.c 1.61 vs edited =====
--- 1.61/drivers/ide/ide-taskfile.c	Fri Jul 19 10:18:50 2002
+++ edited/drivers/ide/ide-taskfile.c	Tue Jul 23 12:12:55 2002
@@ -194,22 +194,16 @@
  	request_queue_t *q = &drive->queue;
  	struct list_head *queue_head = &q->queue_head;
  	DECLARE_COMPLETION(wait);
+	struct request req;

  #ifdef CONFIG_BLK_DEV_PDC4030
  	if (ch->chipset == ide_pdc4030 && buf)
  		return -ENOSYS;  /* special drive cmds not supported */
  #endif

-	rq = __blk_get_request(&drive->queue, READ);
-	if (!rq)
-		rq = __blk_get_request(&drive->queue, WRITE);
-
-	/*
-	 * FIXME: Make sure there is a free slot on the list!
-	 */
-
-	BUG_ON(!rq);
-
+	memset(&req, 0, sizeof(req));
+	rq = &req;
+	
  	rq->flags = REQ_SPECIAL;
  	rq->buffer = buf;
  	rq->special = ar;

