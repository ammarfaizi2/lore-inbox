Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbWGYSO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbWGYSO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWGYSO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:14:28 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:8901 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S964796AbWGYSO1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:14:27 -0400
Message-ID: <44C65FAC.6040505@cs.wisc.edu>
Date: Tue, 25 Jul 2006 13:15:08 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] blk request timeout handler: mv scsi timer code to
  block layer
References: <1153820377.4166.22.camel@max> <20060725092400.GK4044@suse.de> <44C646E5.30608@cs.wisc.edu>
In-Reply-To: <44C646E5.30608@cs.wisc.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> Jens Axboe wrote:
>> On Tue, Jul 25 2006, Mike Christie wrote:
>>> For the request based multipath I thought I would need to run some code
>>> when a command times out. I did not want to duplicate the scsi code, so
>>> I did the following patches which move the scsi timer code to the block
>>> layer then convert scsi.
>>>
>>> I have tested the scsi_error.c and normal paths with iscsi. And, I have
>>> tested the normal IO paths with libata. Since libata uses the strategy
>>> handler it needs to be tested a lot more. Some of the drivers that were
>>> touching the timeout_per_command field need to be compile tested still
>>> too. I converted them, but I think some still need a "#include
>>> blkdev.h".
>>>
>>> The patches only move the scsi timer code to the block layer and hook it
>>> in so others can use it. I have not started on the abort, reset and
>>> quiesce code since it is not really needed for multipath. I wanted to
>>> see if the timer code move was ok on its own without the rest of the
>>> scsi eh move because I do not want to manage the patches out of tree
>>> with the other request multipath patches. I also wanted to check if the
>>> scsi timer code was ok in general. Maybe scsi got it wrong and needed to
>>> be rewritten :)
>> Excellent, one item off my TODO list :-). I had pending code, but not
>> completed yet.
>>
>> I had intended to make the timer addition/deletion implicit from the
>> activate/deactive rq paths, both to have it happen automatically and
>> from a cleanliness POV. That makes the timer only active when the
>> request is in the driver, and should also make the deletion implicit for
>> when the request gets requeued.
>>
> 
> Ok I did that, almost. For the normal request_fn/dequeue, requeue, and
> blk softiriq completion paths the block layer handles all the timer
> addition, deletion and restarting. There is one nasty path in the scsi,

Oops, during testing and my own code review I noticed there was also
some places in the hotplug removal error paths that I used the wrong
block layer function and did not delete the timer. I will fix those up
as well.
