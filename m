Return-Path: <linux-kernel-owner+w=401wt.eu-S1422791AbWLUHMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422791AbWLUHMz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 02:12:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422788AbWLUHMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 02:12:54 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:21775 "EHLO
	noname.neutralserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422787AbWLUHMx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 02:12:53 -0500
Message-ID: <458A33D3.6020704@monatomic.org>
Date: Thu, 21 Dec 2006 09:12:19 +0200
From: Dan Aloni <da-x@monatomic.org>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: Steven Hayter <steven@hayter.me.uk>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>,
       James.Bottomley@steeleye.com
Subject: Re: [PATCH] scsi_execute_async() should add to the tail of the queue
References: <20061219000234.GA5330@localdomain> <45899FBD.9070803@hayter.me.uk>
In-Reply-To: <45899FBD.9070803@hayter.me.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Hayter wrote:
> Dan Aloni wrote:
>> Hello,
>>
>> scsi_execute_async() has replaced scsi_do_req() a few versions ago, 
>> but it also incurred a change of behavior. I noticed that 
>> over-queuing a SCSI device using that function causes I/Os to be 
>> starved from low-level queuing for no justified reason.
>>  
>> I think it makes much more sense to perserve the original behaviour 
>> of scsi_do_req() and add the request to the tail of the queue.
>
> As far as I'm aware the way in which scsi_do_req() was to insert at 
> the head of the queue, leading to projects like SCST to come up with 
> scsi_do_req_fifo() as queuing multiple commands using scsi_do_req() 
> with constant head insertion might lead to out of order execution.
>
> Just thought I'd throw some light on the history and what others have 
> done in the past.
>
In Linux 2.4.31 scsi_do_req() still inserts at the tail. This was also 
valid until 2.6.5.
James, is the change you inserted in Linux 2.6.5 still relevant in 2.6 
today?

<James.Bottomley@steeleye.com>
        [PATCH] add device quiescing to the SCSI API
       
        This patch adds the ability to quiesce a SCSI device.  The idea 
is that
        user issued commands (including filesystem ones) would get blocked,
        while mid-layer and device issued ones would be allowed to proceed.
        This is for things like Domain Validation which like to operate 
on an
        otherwise quiet device.
       
        There is one big change: to get all of this to happen correctly,
        scsi_do_req() has to queue on the *head* of the request queue, 
not the
        tail as it was doing previously.  The reason is that deferred 
requests
        block the queue, so anything needing executing after a deferred 
request
        has to go in front of it.  I don't think there are any untoward
        consequences of this.

-- 
Dan Aloni
XIV LTD, http://www.xivstorage.com
da-x (at) monatomic.org, dan (at) xiv.co.il

