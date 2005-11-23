Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKWMw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKWMw0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 07:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750754AbVKWMwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 07:52:25 -0500
Received: from mailgate.tebibyte.org ([83.104.187.130]:21764 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S1750747AbVKWMwZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 07:52:25 -0500
Message-ID: <438465CC.6070904@tebibyte.org>
Date: Wed, 23 Nov 2005 12:51:24 +0000
From: Chris Ross <lak1646@tebibyte.org>
Organization: At home (Guildford, UK)
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Chris Ross <lak1646@tebibyte.org>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Greg Ungerer <gerg@snapgear.com>
Subject: Re: Kernel panic reading bad disk sector
References: <4381DA23.10201@tebibyte.org> <4382B815.5000701@snapgear.com>	<43836758.6050001@tebibyte.org> <4383C205.7020608@snapgear.com>	<43843594.9050009@tebibyte.org>	<20051123095640.GA5022@flint.arm.linux.org.uk> <438443E8.5040602@tebibyte.org>
In-Reply-To: <438443E8.5040602@tebibyte.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Ross escreveu:
> Russell King - ARM Linux escreveu:
>> On Wed, Nov 23, 2005 at 09:25:40AM +0000, Chris Ross wrote:
>>> Greg Ungerer escreveu:
>>>> Chris Ross wrote:
>>>>
>>>>> According System.map it is in the function ide_dma_timeout_retry.
>>>>
>>>> Ok, that is good information. I would try and figure out which
>>>> line of code in there is dereferencing a NULL pointer.
>>>
>>> It would seem to be this line
>>>
>>>     rq->errors = 0;
> 
> because rq is set to NULL by earlier the line
> 
>     ret = DRIVER(drive)->error(drive, "dma timeout retry",
>                 hwif->INB(IDE_STATUS_REG));

Which looks like the the correct thing to do. In idedisk_error once the 
threshold for the maximum number of retries has been reached the request 
is ended because it cannot be serviced

	if (rq->errors >= ERROR_MAX)
		DRIVER(drive)->end_request(drive, 0);

in idedisk_end_request the request is explicitly set to NULL because it 
is now ended, in the code block...

	if (!end_that_request_first(rq, uptodate, drive->name)) {
		add_blkdev_randomness(MAJOR(rq->rq_dev));
		blkdev_dequeue_request(rq);
		HWGROUP(drive)->rq = NULL;
		end_that_request_last(rq);
		ret = 0;
	}

Which means that ide_dma_timeout_retry should take account of the fact 
that the request might no longer be valid before using it.

In other words it should be...

	/* Check whether the request ended early due to disk errors */
	if( rq ) {
		rq->errors = 0;
		rq->sector = rq->bh->b_rsector;
		rq->current_nr_sectors = rq->bh->b_size >> 9;
		rq->hard_cur_sectors = rq->current_nr_sectors;
		rq->buffer = rq->bh->b_data;
	}


If anyone has a better solution I would be glad to hear it. Failing that 
I'll submit this in normal kernel patch format as soon as I've worked 
out how...

Regards,
Chris R.
