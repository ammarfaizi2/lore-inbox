Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbTK3Ufr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 15:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263142AbTK3Ufr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 15:35:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61622 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263135AbTK3Ufn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 15:35:43 -0500
Message-ID: <3FCA548E.7070501@pobox.com>
Date: Sun, 30 Nov 2003 15:35:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <3FCA2672.8020202@pobox.com> <20031130172855.GA6454@suse.de> <3FCA2BDA.60302@pobox.com> <20031130174552.GC6454@suse.de> <3FCA2F7F.8060206@pobox.com> <20031130182126.GE6454@suse.de> <3FCA3F44.6070401@pobox.com> <20031130193904.GG6454@suse.de>
In-Reply-To: <20031130193904.GG6454@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Nov 30 2003, Jeff Garzik wrote:
>>Since the hardware request API is (and must be) completely decoupled 
>>from struct request API, I can achieve 1.5 x non-errata case.
> 
> Hmm I don't follow that... Being a bit clever, you could even send off
> both A and B parts of the request in one go. Probably not worth it
> though, that would add some complexity (things like not spanning a page,
> stuff you probably don't want to bother the driver with).
[...]
> Indeed. The partial completions only exist at the driver -> block layer
> (or -> scsi) layer, not talking to the hardware. The hardware always
> gets 'a request', if that just happens to be only a part of a struct
> request so be it.
[...]
> Sure yes, the fewer completions the better. Where do you get the 1.5
> from? You need to split the request handling no matter what for the
> errata path, I would count that as 2 completions.

Taskfile completion and struct request completion are separate.  That 
results in

* struct request received by libata
* libata detects errata
* libata creates 2 struct ata_queued_cmd's
* libata calls ata_qc_push() 2 times
* Time passes
* ata_qc_complete called 2 times
Option 1: {scsi|block} complete called 2 times, once for each taskfile
Option 2: {scsi|block} complete called 1 time, when both taskfiles are done

one way:  2 h/w completions, 1 struct request completion == 1.5
another way:  2 h/w completions, 2 struct request completions == 2.0

Maybe another way of looking at it:
It's a question of where the state is stored -- in ata_queued_cmd or 
entirely in struct request -- and what are the benefits/downsides of each.

When a single struct request causes the initiation of multiple 
ata_queued_cmd's, libata must be capable of knowing when multiple 
ata_queued_cmds forming a whole have completed.  struct request must 
also know this.  _But_.  The key distinction is that libata must handle 
multiple requests might not be based on sector progress.

For this SII errata, I _could_ do this at the block layer:
ata_qc_complete() -> blk_end_io(first half of sectors)
ata_qc_complete() -> blk_end_io(some more sectors)

And the request would be completed by the block layer (right?).

But under the hood, libata has to handle these situations:
* One or more ATA commands must complete in succession, before the 
struct request may be end_io'd.
* One or more ATA commands must complete asynchronously, before the 
struct request may be end_io'd.
* These ATA commands might not be sector based:  sometimes aggressive 
power management means that libata must issue and complete a PM-related 
taskfile, before issuing the {READ|WRITE} DMA passed to it in the struct 
request.

I'm already storing and handling this stuff at the hardware-queue level. 
   (remember hardware queues often bottleneck at the host and/or bus 
levels, not necessarily the request_queue level)

So what all this hopefully boils down to is:  if I have to do "internal 
completions" anyway, it's just more work for libata to separate out the 
2 taskfiles into 2 block layer completions.  For both errata and 
non-errata paths, I can just say "the last taskfile is done, clean up"



Yet another way of looking at it:
In order for all state to be kept at the block layer level, you would 
need this check:

	if ((rq->expected_taskfiles == rq->completed_taskfiles) &&
	    (rq->expected_sectors == rq->completed_sectors))
		the struct request is "complete"

and each call to end_io would require both a taskfile count and a sector 
count, which would increment ->completed_taskfiles and ->completed_sectors.

Note1: s/taskfile/cdb/ if that's your fancy :)
Note2: ->completed_sectors exists today under another name, yes, I know :)

	Jeff



