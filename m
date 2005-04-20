Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVDTGo6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVDTGo6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 02:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbVDTGo6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 02:44:58 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:53461 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261353AbVDTGov (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 02:44:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=GiPnE95sxREnpVbMDKRgRR+u4OR9GkYncG1HrkaWywcKaBdgblgijP39y2LbKPz5HR76xhGp34WBwNs3vAHOgtu1lNfTla7Nd2/EdxLKkouLZy5aGuH3fexX5KkqYX4wH6iRyH/blNqmDuZOpMCZV/DyCdmBV1n04s00w4KQzms=
Message-ID: <4265FA5C.8030801@gmail.com>
Date: Wed, 20 Apr 2005 15:44:44 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: James.Bottomley@steeleye.com, Christoph Hellwig <hch@infradead.org>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH scsi-misc-2.6 01/05] scsi: make blk layer set REQ_SOFTBARRIER
 when a request is dispatched
References: <20050419231435.D85F89C0@htj.dyndns.org> <20050419231435.2DEBE102@htj.dyndns.org> <20050420063009.GB9371@suse.de>
In-Reply-To: <20050420063009.GB9371@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Wed, Apr 20 2005, Tejun Heo wrote:
> 
>>01_scsi_blk_make_started_requests_ordered.patch
>>
>>	Reordering already started requests is without any real
>>	benefit and causes problems if the request has its
>>	driver-specific resources allocated (as in SCSI).  This patch
>>	makes elv_next_request() set REQ_SOFTBARRIER automatically
>>	when a request is dispatched.
>>
>>	As both as and cfq schedulers don't allow passing requeued
>>	requests, the only behavior change is that requests deferred
>>	by prep_fn won't be passed by other requests.  This change
>>	shouldn't cause any problem.  The only affected driver other
>>	than SCSI is i2o_block.
>>
>>Signed-off-by: Tejun Heo <htejun@gmail.com>
>>
>> elevator.c |    8 ++++----
>> 1 files changed, 4 insertions(+), 4 deletions(-)
>>
>>Index: scsi-reqfn-export/drivers/block/elevator.c
>>===================================================================
>>--- scsi-reqfn-export.orig/drivers/block/elevator.c	2005-04-20 08:13:01.000000000 +0900
>>+++ scsi-reqfn-export/drivers/block/elevator.c	2005-04-20 08:13:33.000000000 +0900
>>@@ -370,11 +370,11 @@ struct request *elv_next_request(request
>> 
>> 	while ((rq = __elv_next_request(q)) != NULL) {
>> 		/*
>>-		 * just mark as started even if we don't start it, a request
>>-		 * that has been delayed should not be passed by new incoming
>>-		 * requests
>>+		 * just mark as started even if we don't start it.
>>+		 * also, as a request that has been delayed should not
>>+		 * be passed by new incoming requests, set softbarrier.
>> 		 */
>>-		rq->flags |= REQ_STARTED;
>>+		rq->flags |= REQ_STARTED | REQ_SOFTBARRIER;
>> 
>> 		if (rq == q->last_merge)
>> 			q->last_merge = NULL;
> 
> 
> Do it on requeue, please - not on the initial spotting of the request.
> 

  The thing is that we also need to set REQ_SOFTBARRIER on 
BLKPREP_DEFER.  So, it will be two places - in elv_next_request and 
blk_requeue_request.  The end result will be the same.  Do you think 
doing on requeue paths is better?

-- 
tejun

