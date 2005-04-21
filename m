Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261184AbVDUC3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbVDUC3m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 22:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbVDUC3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 22:29:42 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:3126 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261183AbVDUC3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 22:29:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=AiNC5+AG5kf4PrjFjRO9dPI9KsE44cNZc69fhs8yyhVYj3bq/tF3tkai3GckC2G9V8TQvA2AQ/BdYjdlWqzqiqIoK2BT/C1VDQ/1+OVpef/V2wxzrPwKZXAwi70eQOlZWizjKdcBgMZuX0gYurPNK5kisydoomxBkqsHGpPDQV8=
Message-ID: <42670FF7.3020404@home-tj.org>
Date: Thu, 21 Apr 2005 11:29:11 +0900
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Tejun Heo <htejun@gmail.com>, Jens Axboe <axboe@suse.de>,
       Christoph Hellwig <hch@infradead.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 03/05] scsi: make scsi_queue_insert() use
 blk_requeue_request()
References: <20050419231435.D85F89C0@htj.dyndns.org>	 <20050419231435.329FA30B@htj.dyndns.org>	 <1114039446.5933.17.camel@mulgrave>  <4266F1D0.2060003@gmail.com> <1114049793.5000.4.camel@mulgrave>
In-Reply-To: <1114049793.5000.4.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Thu, 2005-04-21 at 09:20 +0900, Tejun Heo wrote:
> 
>>  Hello, James.
>>
>>James Bottomley wrote:
>>
>>>On Wed, 2005-04-20 at 08:15 +0900, Tejun Heo wrote:
>>>
>>>
>>>>-	 * Insert this command at the head of the queue for it's device.
>>>>-	 * It will go before all other commands that are already in the queue.
>>>>-	 *
>>>>-	 * NOTE: there is magic here about the way the queue is plugged if
>>>>-	 * we have no outstanding commands.
>>>>-	 * 
>>>>-	 * Although this *doesn't* plug the queue, it does call the request
>>>>-	 * function.  The SCSI request function detects the blocked condition
>>>>-	 * and plugs the queue appropriately.
>>>
>>>
>>>This comment still looks appropriate to me ... why do you want to remove
>>>it?
>>>
>>
>>  Well, the thing is that we don't really care what exactly happens to 
>>the queue or how the queue is plugged or not.  All we need to do are to 
>>requeue the request and kick the queue in the ass.  Hmmm, maybe I should 
>>keep the comment about how the request will be put at the head of the 
>>queue, but the second part about plugging doesn't really belong here, I 
>>think.
> 
> 
> Really?  We do care greatly.  If you requeue with no other outstanding
> commands to the device, the block queue will never restart unless it's
> plugged, and the device will hang. The comment is explaining how this
> happens.
> 

 Yes, you're right.  My point was that that's scsi_run_queue()'s
business.  We don't need to comment that deep when we're requeueing a
request.  After we put a request on a queue, we kick the queue.  It's
the queue running function's responsibility to determine whether to run
the request right away or to defer processing (and thus plug).  I wasn't
saying that the eventual plugging isn't necessary, but that the comment
is sort of excessive.

 Anyways, if you think the comment is necessary, I don't feel strong
against it.  I'll rewrite above comment to fit the new code and repost
this patch soon.

> 
>>  Yes, that will be more efficient but I don't think it would make
>>any 
>>noticeable difference.  IMO, universally using scsi_run_queue() to
>>kick 
>>scsi request queues is better than mixing blk_run_queue() and 
>>scsi_run_queue() for probably unnoticeable optimization.  If we start
>>to 
>>mix'em, we need to rationalize why specific one is chosen in specific 
>>places and that's just unnecessary.
> 
> 
> Fair enough.

 Thanks.

--
tejun
