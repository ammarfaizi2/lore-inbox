Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVCYVny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVCYVny (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 16:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVCYVny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 16:43:54 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:61685 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261820AbVCYVnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 16:43:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=DSSikblFaGcG5hp83kkddyDmkQr3tXFNj18P/26aOjSEtkhBo+HamOQg+3bzhG7aDce+BHSGTgfyH/6A5HolUSUAU1Yp9S7X/pjJV0LLg+RSCSqIjMdZfdqRQQveYEFitxQqA/0nSpyPMppRMhogTWiBfg0ua2pNSsndPIZ8h6M=
Message-ID: <4244860E.5090800@gmail.com>
Date: Sat, 26 Mar 2005 06:43:42 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Debian Thunderbird 1.0 (X11/20050118)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Jens Axboe <axboe@suse.de>, SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH scsi-misc-2.6 08/08] scsi: fix hot unplug sequence
References: <20050323021335.960F95F8@htj.dyndns.org>	 <20050323021335.4682C732@htj.dyndns.org>	 <1111550882.5520.93.camel@mulgrave> <4240F5A9.80205@gmail.com>	 <20050323071920.GJ24105@suse.de> <1111591213.5441.19.camel@mulgrave>	 <20050323152550.GB16149@suse.de> <1111711558.5612.52.camel@mulgrave>	 <20050325031511.GA22114@htj.dyndns.org> <1111726965.5612.62.camel@mulgrave>	 <20050325053842.GA24499@htj.dyndns.org> <1111778388.5692.38.camel@mulgrave>
In-Reply-To: <1111778388.5692.38.camel@mulgrave>
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hello, James.

James Bottomley wrote:
> On Fri, 2005-03-25 at 14:38 +0900, Tejun Heo wrote:
> 
>> We have users of scsi_do_req() other than scsi_wait_req() and they
>>use different done() functions to do different things.  I've checked
>>other done functions and none uses contents inside the passed
>>scsi_cmnd, so using a dummy command should be okay with them.  Am I
>>missing something here?
> 
> 
> Well ... the other users are supposed to be going away.  They're
> actually all coded wrongly in some way or other ... perhaps I should
> speed up the process.

 Sounds great.  :-)

>> Oh, and I would really appreciate if you can fill me in / give a
>>pointer about the scsi_request/scsi_cmnd distinction.
> 
> The block layer speaks in terms of requests and the scsi layers in terms
> of commands.  The scsi_request_fn() actually associates a request with a
> command.  However, since SCSI uses the block layer for queueing, all the
> internal scsi command submit paths have to use requests.  This is what a
> scsi_request is.  The reason for the special casing is that we can't use
> the normal REQ_CMD or REQ_BLOCK_PC paths because they need ULD
> initialisation and back end processing.

 What I meant was we could just use scsi_cmnd instead of scsi_request
for commands.  Currently, we do the following for special commands.

 1. Allocate scsi_request and request (two are linked)
 2. Initialize scsi_request as needed
 3. queue the request
 4. the request is dispatched
 5. scsi_cmnd is initialized from scsi_request
 6. scsi_cmnd is executed
 7. result code and sense copied back to scsi_request
 8. request is completed

 Instead, we can

 1. Allocate scsi_cmnd and request (two are linked)
 2. Initialize scsi_cmnd as needed
 3. queue the request
 4. the request is dispatched
 5. scsi_cmnd is executed
 6. request is completed

 As the latter seemed more straight-forward to me, I was wondering if
there were reasons that I wasn't aware of.

 Thanks.

-- 
tejun

