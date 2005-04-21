Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261849AbVDUAUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261849AbVDUAUz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 20:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261850AbVDUAUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 20:20:55 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:62834 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261849AbVDUAUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 20:20:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Scg/RZCSRaNsESt61CyJkIL+Rw5ydE90tLeTU5E2UXO5EoEcFTR5xcd15hac12lvz73sJ1Lfx0GBZQ6O5EHPl4BFHflHIKEtxtTxFALcOk+ghT6q3ENZdZX86d/C3b8KCBNL1iptxHbWlQlL/04RefGtPRNN9NcAJQjaEnEYzg4=
Message-ID: <4266F1D0.2060003@gmail.com>
Date: Thu, 21 Apr 2005 09:20:32 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050402)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use
 blk_requeue_request()
References: <20050419231435.D85F89C0@htj.dyndns.org>	 <20050419231435.329FA30B@htj.dyndns.org> <1114039446.5933.17.camel@mulgrave>
In-Reply-To: <1114039446.5933.17.camel@mulgrave>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Hello, James.

James Bottomley wrote:
> On Wed, 2005-04-20 at 08:15 +0900, Tejun Heo wrote:
> 
>>-	 * Insert this command at the head of the queue for it's device.
>>-	 * It will go before all other commands that are already in the queue.
>>-	 *
>>-	 * NOTE: there is magic here about the way the queue is plugged if
>>-	 * we have no outstanding commands.
>>-	 * 
>>-	 * Although this *doesn't* plug the queue, it does call the request
>>-	 * function.  The SCSI request function detects the blocked condition
>>-	 * and plugs the queue appropriately.
> 
> 
> This comment still looks appropriate to me ... why do you want to remove
> it?
> 

  Well, the thing is that we don't really care what exactly happens to 
the queue or how the queue is plugged or not.  All we need to do are to 
requeue the request and kick the queue in the ass.  Hmmm, maybe I should 
keep the comment about how the request will be put at the head of the 
queue, but the second part about plugging doesn't really belong here, I 
think.

> 
>>+	 * Requeue the command.
>> 	 */
>>-	blk_insert_request(device->request_queue, cmd->request, 1, cmd, 1);
>>+	spin_lock_irqsave(q->queue_lock, flags);
>>+	blk_requeue_request(q, cmd->request);
>>+	spin_unlock_irqrestore(q->queue_lock, flags);
>>+
>>+	scsi_run_queue(q);
> 
> 
> Really, wouldn't it be much more efficient simply to call blk_run_queue
> ()? since the blocked flags were set above, that's pretty much what
> scsi_run_queue() collapses to.
> 

  Yes, that will be more efficient but I don't think it would make any 
noticeable difference.  IMO, universally using scsi_run_queue() to kick 
scsi request queues is better than mixing blk_run_queue() and 
scsi_run_queue() for probably unnoticeable optimization.  If we start to 
mix'em, we need to rationalize why specific one is chosen in specific 
places and that's just unnecessary.

  Thanks.

-- 
tejun

