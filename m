Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbTLAJDC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 04:03:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTLAJDC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 04:03:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40921 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262074AbTLAJCx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 04:02:53 -0500
Date: Mon, 1 Dec 2003 10:02:40 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031201090240.GJ6454@suse.de>
References: <20031130165146.GY10679@suse.de> <3FCA2672.8020202@pobox.com> <20031130172855.GA6454@suse.de> <3FCA2BDA.60302@pobox.com> <20031130174552.GC6454@suse.de> <3FCA2F7F.8060206@pobox.com> <20031130182126.GE6454@suse.de> <3FCA3F44.6070401@pobox.com> <20031130193904.GG6454@suse.de> <3FCA548E.7070501@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA548E.7070501@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Nov 30 2003, Jeff Garzik wrote:
> >>Since the hardware request API is (and must be) completely decoupled 
> >>from struct request API, I can achieve 1.5 x non-errata case.
> >
> >Hmm I don't follow that... Being a bit clever, you could even send off
> >both A and B parts of the request in one go. Probably not worth it
> >though, that would add some complexity (things like not spanning a page,
> >stuff you probably don't want to bother the driver with).
> [...]
> >Indeed. The partial completions only exist at the driver -> block layer
> >(or -> scsi) layer, not talking to the hardware. The hardware always
> >gets 'a request', if that just happens to be only a part of a struct
> >request so be it.
> [...]
> >Sure yes, the fewer completions the better. Where do you get the 1.5
> >from? You need to split the request handling no matter what for the
> >errata path, I would count that as 2 completions.
> 
> Taskfile completion and struct request completion are separate.  That 

Of course

> results in
> 
> * struct request received by libata
> * libata detects errata
> * libata creates 2 struct ata_queued_cmd's
> * libata calls ata_qc_push() 2 times
> * Time passes
> * ata_qc_complete called 2 times
> Option 1: {scsi|block} complete called 2 times, once for each taskfile
> Option 2: {scsi|block} complete called 1 time, when both taskfiles are done
> 
> one way:  2 h/w completions, 1 struct request completion == 1.5
> another way:  2 h/w completions, 2 struct request completions == 2.0

Well that's implementation detail in your driver, I meant hardware
completions. Doing one or 2 calls to scsi/block completion handling is
not expensive, at least when compared to the hardware completion.

And I'd greatly prefer option 1, so you end_io doesn't have to know
about the request being partial or not.

> Maybe another way of looking at it:
> It's a question of where the state is stored -- in ata_queued_cmd or 
> entirely in struct request -- and what are the benefits/downsides of each.

If you mangle the request, you only have to do it in one place. If your
private command is easier to handle, that wont be tricky as well. Given
that I don't really know your libata, I can't say for sure :)

> When a single struct request causes the initiation of multiple 
> ata_queued_cmd's, libata must be capable of knowing when multiple 
> ata_queued_cmds forming a whole have completed.  struct request must 

This is where I disagree. If you accept to serialize the request for the
errata case, then it does _not_ need to know! That would be adding some
complexity.

> also know this.  _But_.  The key distinction is that libata must handle 
> multiple requests might not be based on sector progress.
> 
> For this SII errata, I _could_ do this at the block layer:
> ata_qc_complete() -> blk_end_io(first half of sectors)
> ata_qc_complete() -> blk_end_io(some more sectors)
> 
> And the request would be completed by the block layer (right?).

Yes.

> But under the hood, libata has to handle these situations:
> * One or more ATA commands must complete in succession, before the 
> struct request may be end_io'd.

That's not tricky, as I've mentioned it's a 1-2 lines of code in your
end_io handling.

> * One or more ATA commands must complete asynchronously, before the 
> struct request may be end_io'd.

Depends on whether you want to accept serialization of that request for
the errata path.

> * These ATA commands might not be sector based:  sometimes aggressive 
> power management means that libata must issue and complete a PM-related 
> taskfile, before issuing the {READ|WRITE} DMA passed to it in the struct 
> request.

What's your point?

> I'm already storing and handling this stuff at the hardware-queue level. 
>   (remember hardware queues often bottleneck at the host and/or bus 
> levels, not necessarily the request_queue level)
> 
> So what all this hopefully boils down to is:  if I have to do "internal 
> completions" anyway, it's just more work for libata to separate out the 
> 2 taskfiles into 2 block layer completions.  For both errata and 
> non-errata paths, I can just say "the last taskfile is done, clean up"

I think you should just serialize the handling of that errata request.
If you need to provide truly partial completions of a request (where X+1
can complete before X), then you do need to clone the actual struct
request and do other magic. If you serialize it, it's basically no added
complexity.

> Yet another way of looking at it:
> In order for all state to be kept at the block layer level, you would 
> need this check:
> 
> 	if ((rq->expected_taskfiles == rq->completed_taskfiles) &&
> 	    (rq->expected_sectors == rq->completed_sectors))
> 		the struct request is "complete"
> 
> and each call to end_io would require both a taskfile count and a sector 
> count, which would increment ->completed_taskfiles and ->completed_sectors.

No it doesn't work at all still, you can't complete arbitrary parts of a
request like that. I don't see why you would need the
completed_taskfiles (and expected), if you complete more sectors per
taskfile than your driver is broken. So struct request already has
enough info for the above 'if', but it doesn't have (and will never
have) enough state to complete random parts of it non-sequentially.
That can't work for all requests anyways, consider barriers. The actual
implementation doesn't allow it either, with the one-way stringing of
bio's and partial completions (and wakeups) of those as well.

> Note1: s/taskfile/cdb/ if that's your fancy :)

taskfile contains way more info that cdb, so I'll stick to that :)

-- 
Jens Axboe

