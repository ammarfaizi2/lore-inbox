Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932723AbVHSUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723AbVHSUnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbVHSUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 16:43:45 -0400
Received: from magic.adaptec.com ([216.52.22.17]:38371 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S932255AbVHSUnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 16:43:43 -0400
Message-ID: <4306447D.7090204@adaptec.com>
Date: Fri, 19 Aug 2005 16:43:41 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Patrick Mansfield <patmans@us.ibm.com>
CC: Jeff Garzik <jgarzik@pobox.com>, Tejun Heo <htejun@gmail.com>,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata error handling
References: <20050729050654.GA10413@havoc.gtf.org> <20050807054850.GA13335@htj.dyndns.org> <430556BF.5070004@pobox.com> <4306290B.6080608@adaptec.com> <20050819193853.GA1549@us.ibm.com> <43063B03.8050008@adaptec.com> <20050819201121.GA2523@us.ibm.com>
In-Reply-To: <20050819201121.GA2523@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2005 20:43:41.0868 (UTC) FILETIME=[AF3E6EC0:01C5A4FE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/19/05 16:11, Patrick Mansfield wrote:
> On Fri, Aug 19, 2005 at 04:03:15PM -0400, Luben Tuikov wrote:
>>The eh_timed_out + eh_strategy_handler is actually pretty perfect,
>>and _complete_, for any application and purpose in recovering a
> 
> 
> One other point: Another problems is that we quiesce all shost IO before
> waking up the eh. 

Yes, this is true.
 
> I was changing it to wakeup the eh even while other IO is outstanding, so
> the eh can wakeup and cancel individual commands while other IO is still
> using the HBA.

Hmm, if you want to do this, then SCSI Core needs to know about:
	- Domain,
	- Domain device and
	- LU.

The reason, is that you do not know why a task timed out.
Is it the LU, is it the device, is it the domain?

(Those are concepts talked about in SAM.)

Since currently, SCSI Core has no clue about those concepts,
the current infrastructure, stalling IO to the host on eh,
satisfies.

> So, for EH_NOT_HANDLED, do you add the scmd to a LLDD list in your
> eh_timed_out, then wait for the eh to run?

No, no Patrick, I don't.  The SCSI Core does this for me, and then
calls my eh_strategy routine and all the commands are on the list.

> Or maybe your host can_queue is 1 :)

No, it is actually pretty huge for a controller, and have to 
more than halve it and give that to SCSI Core.
 
> I don't see it ... hence my question above.

Hmm, let me know if I'm missing something out.

	Luben

