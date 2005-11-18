Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVKRPHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVKRPHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 10:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750828AbVKRPHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 10:07:45 -0500
Received: from zproxy.gmail.com ([64.233.162.202]:61296 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750820AbVKRPHp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 10:07:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=LpoGdC/Dn0FHmp88DdXzYC0+rbaa8XPfm367WIej9KOKHcDEaWTqa+u4j455ZCzojaCx/UlbKy4Ny04EQKUIDggFg6DU/tJRMLZx3FidytMsZPVZYVZo/LLsx+q2ii7HarGjJRMeKz+m5BQxynPqmlQpnqZedlQTIbemNEZ7TXg=
Message-ID: <437DEE35.9060901@gmail.com>
Date: Sat, 19 Nov 2005 00:07:33 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: axboe@suse.de, jgarzik@pobox.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6-block:post-2.6.15 08/10] blk: update IDE to
 use new blk_ordered
References: <20051117153509.B89B4777@htj.dyndns.org>	 <20051117153509.061D8991@htj.dyndns.org> <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
In-Reply-To: <58cb370e0511171211p60e7c248mda477015cf1bd7c5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Bartlomiej.

Bartlomiej Zolnierkiewicz wrote:
> On 11/17/05, Tejun Heo <htejun@gmail.com> wrote:
> 
> I fail to see how the partial completions (good + bad sectors)
> are done in your new scheme, please explain.
> 

It doesn't.  I've noted this way back when I posted this patchset the 
second time.

http://marc.theaimsgroup.com/?l=linux-kernel&m=111795127124020&w=2

Rationales

* The actual barrier IO request is issued as a part of ordered sequence. 
  When any part of this sequence fails (any of leading flush, barrier IO 
or post flush), the whole sequence should be considered to have failed.

e.g. if leading flush fails, there's no point in reporting partial or 
full success of barrier IO.  Ditto for tailing flush.  We can special 
case when only part of barrier IO fails and report partial barrier 
success, but 1. benefits are doubtful  2. even if it's implemented, it 
wouldn't work (see next rationale)

* Barrier requests are not mergeable.  ie. Each barrier bio is turned 
into one barrier request and partially completing the request doesn't 
result in any successfully completed bio.

* SCSI doesn't handle partial completion of barrier IOs.

> 
>>-
>>-static int idedisk_prepare_flush(request_queue_t *q, struct request *rq)
>>-{
>>-       ide_drive_t *drive = q->queuedata;
>>-
>>-       if (!drive->wcache)
>>-               return 0;
> 
> 
> What does happen if somebody disables drive->wcache later?
> 

Thanks for pointing out.  I've moved ordered configuration into 
write_cache such that ordered is reconfigured when write_cache changes.

There can be in-flight barrier requests which are inconsistent with the 
newly updated setting, but 1. it's not too unfair to assume that user is 
responsible for that synchronization 2. the original implementation had 
the same issue 3. the consequence is not catastrophic.

> 
>>        memset(rq->cmd, 0, sizeof(rq->cmd));
>>
>>@@ -735,9 +694,8 @@ static int idedisk_prepare_flush(request
>>                rq->cmd[0] = WIN_FLUSH_CACHE;
>>
>>
>>-       rq->flags |= REQ_DRIVE_TASK | REQ_SOFTBARRIER;
>>+       rq->flags |= REQ_DRIVE_TASK;
>>        rq->buffer = rq->cmd;
>>-       return 1;
>> }
>>
>> static int idedisk_issue_flush(request_queue_t *q, struct gendisk *disk,
>>@@ -1012,11 +970,12 @@ static void idedisk_setup (ide_drive_t *
>>        printk(KERN_INFO "%s: cache flushes %ssupported\n",
>>                drive->name, barrier ? "" : "not ");
>>        if (barrier) {
>>-               blk_queue_ordered(drive->queue, QUEUE_ORDERED_FLUSH);
>>-               drive->queue->prepare_flush_fn = idedisk_prepare_flush;
>>-               drive->queue->end_flush_fn = idedisk_end_flush;
>>+               blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN_FLUSH,
>>+                                 idedisk_prepare_flush, GFP_KERNEL);
>>                blk_queue_issue_flush_fn(drive->queue, idedisk_issue_flush);
>>-       }
>>+       } else if (!drive->wcache)
>>+               blk_queue_ordered(drive->queue, QUEUE_ORDERED_DRAIN,
>>+                                 NULL, GFP_KERNEL);
> 
> 
> What does happen if somebody enables drive->wcache later?
> 

ditto.

> 
>> }
>>
>> static void ide_cacheflush_p(ide_drive_t *drive)
>>@@ -1034,6 +993,8 @@ static int ide_disk_remove(struct device
>>        struct ide_disk_obj *idkp = drive->driver_data;
>>        struct gendisk *g = idkp->disk;
>>
>>+       blk_queue_ordered(drive->queue, QUEUE_ORDERED_NONE, NULL, 0);
>>+
> 
> 
> Shouldn't this be done in ide_disk_release()?

Hmmm... The thing is that, AFAIK, requests are not supposed to be issued 
after ->remove is called (->remove is called only on module unload 
unless hardware is hot-unplugged and HL driver cannot be unloaded while 
it's still opened).  I think that's why both sd and ide-disk issue the 
last cache flush in ->remove callbacks but not in ->release.

I think the most natural place to put ordered deconfiguration is right 
above the last cache flush.  Hmmm... If above is not true, I think we 
should move both ordered deconfig and the last cache flushes to 
->release callbacks.  What do you think?

Thanks.

-- 
tejun
