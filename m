Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318066AbSGWOBS>; Tue, 23 Jul 2002 10:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318067AbSGWOBS>; Tue, 23 Jul 2002 10:01:18 -0400
Received: from [195.63.194.11] ([195.63.194.11]:31492 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318066AbSGWOBR>; Tue, 23 Jul 2002 10:01:17 -0400
Message-ID: <3D3D6122.5010207@evision.ag>
Date: Tue, 23 Jul 2002 15:58:58 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020625
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
CC: martin@dalecki.de, Morten Helgesen <morten.helgesen@nextframe.net>,
       linux-kernel@vger.kernel.org
Subject: Re: please DON'T run 2.5.27 with IDE!
References: <Pine.SOL.4.30.0207231530450.29134-100000@mion.elka.pw.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bartlomiej Zolnierkiewicz wrote:

> Martin why aren't you telling people all facts?
> It was the default behaviour before your change in IDE 99.
> This patch in practice reverts IDE 99 change.
> 
> You have INTRODUCED a bug and now you try to
> pretend that it wasn't your fault and it was somehow broken before.

Never said that. Sure it was my fault I looked in the wrong direction
I looked at the ide-tcq code, becouse I still dont like the
idea that we pass a pointer for a struct on the local stack down.
(It's preventing the futile hope to make this thingee somehow 
asynchronous form ever taking place.)

I should have looked at SCSI in first place instead indeed.

> Before 2.5.27 code had the same functionality as scsi version.

That's actually not true... At least the setting of the
request rq->flags is significantly different here and there.
However I think but I'm not sure that the fact aht we have rq->special 
!= NULL here has the hidded side effect that we indeed accomplish the
same semantics.

> And yes it will be useful to move it to block layer.

Done. Just needs testing. I have at least an ZIP parport drive, which
allows me to do some basic checks.


BTW.> Having a fill up request queue trashing data transfers
is indicating that there may be are bugs in the generic block layer too. 
If it gets pushed to boundary conditions it's apparently not very 
robust... BTW.> I never ever will understand why
request_fn returns void instead of an status value.
It could save many places where evry single driver
has to call end_request explicitely.



> Regards
> --
> Bartlomiej
> 
> 
>>===== drivers/ide/ide-taskfile.c 1.61 vs edited =====
>>--- 1.61/drivers/ide/ide-taskfile.c	Fri Jul 19 10:18:50 2002
>>+++ edited/drivers/ide/ide-taskfile.c	Tue Jul 23 12:12:55 2002
>>@@ -194,22 +194,16 @@
>>  	request_queue_t *q = &drive->queue;
>>  	struct list_head *queue_head = &q->queue_head;
>>  	DECLARE_COMPLETION(wait);
>>+	struct request req;
>>
>>  #ifdef CONFIG_BLK_DEV_PDC4030
>>  	if (ch->chipset == ide_pdc4030 && buf)
>>  		return -ENOSYS;  /* special drive cmds not supported */
>>  #endif
>>
>>-	rq = __blk_get_request(&drive->queue, READ);
>>-	if (!rq)
>>-		rq = __blk_get_request(&drive->queue, WRITE);
>>-
>>-	/*
>>-	 * FIXME: Make sure there is a free slot on the list!
>>-	 */
>>-
>>-	BUG_ON(!rq);
>>-
>>+	memset(&req, 0, sizeof(req));
>>+	rq = &req;
>>+
>>  	rq->flags = REQ_SPECIAL;
>>  	rq->buffer = buf;
>>  	rq->special = ar;
>>
> 
> 
> 



