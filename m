Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262795AbTK3RqK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264947AbTK3RqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:46:10 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46765 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262795AbTK3RqB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:46:01 -0500
Date: Sun, 30 Nov 2003 18:45:52 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "Prakash K. Cheemplavam" <prakashkc@gmx.de>, marcush@onlinehome.de,
       linux-kernel@vger.kernel.org, eric_mudama@Maxtor.com
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130174552.GC6454@suse.de>
References: <3FC36057.40108@gmx.de> <200311301547.32347.bzolnier@elka.pw.edu.pl> <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <3FCA2672.8020202@pobox.com> <20031130172855.GA6454@suse.de> <3FCA2BDA.60302@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA2BDA.60302@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Nov 30 2003, Jeff Garzik wrote:
> >
> >>Jens Axboe wrote:
> >>
> >>>On Sun, Nov 30 2003, Jeff Garzik wrote:
> >>>
> >>>>fond of partial completions, as I feel they add complexity, 
> >>>>particularly so in my case:  I can simply use the same error paths for 
> >>>>both the single-sector taskfile and the "everything else" taskfile, 
> >>>>regardless of which taskfile throws the error.
> >>>
> >>>
> >>>It's just a questions of maintaining the proper request state so you
> >>>know how much and what part of a request is pending. Requests have been
> >>>handled this way ever since clustered requests, that is why
> >>>current_nr_sectors differs from nr_sectors. And with hard_* duplicates,
> >>>it's pretty easy to extend this a bit. I don't see this as something
> >>>complex, and if the alternative you are suggesting (your implementation
> >>>idea is not clear to me...) is to fork another request then I think it's
> >>>a lot better.
> >>
> >>[snip howto]
> >>
> >>Yeah, I know how to do partial completions.  The increased complexity 
> >>arises in my driver.  It's simply less code in my driver to treat each 
> >>transaction as an "all or none" affair.
> >>
> >>For the vastly common case, it's less i-cache and less interrupts to do 
> >>all-or-none.  In the future I'll probably want to put partial 
> >>completions in the error path...
> >
> >
> >Oh come one, i-cache? We're doing IO here, a cache line more or less in
> >request handling is absolutely so much in the noise. 
> >
> >What are the "increased complexity" involved with doing partial
> >completions? You don't even have to know it's a partial request in the
> >error handling, it's "just the request" state. Honestly, I don't see a
> >problem there. You'll have to expand on what exactly you see as added
> >complexity. To me it still seems like the fastest and most elegant way
> >to handle it. It requires no special attention on request buildup, it
> >requires no extra request and ugly split-code in the request handling.
> >And the partial-completions come for free with the block layer code.
> 
> libata, drivers/ide, and SCSI all must provide internal "submit this 
> taskfile/cdb" API that is decoupled from struct request.  Therefore, 

Yes

> submitting a transaction pair, or for ATAPI submitting the internal 
> REQUEST SENSE, is quite simple and only a few lines of code.

SCSI already does these partial completions...

> Any extra diddling of the hardware, and struct request, to provide 
> partial completions is extra code.  The hardware is currently set up to 
> provide only "it's done" or "it failed" information.  Logically, then, 
> partial completions must be more code than the current <none> ;-)

That's not a valid argument. Whatever you do, you have to add some lines
of code.

> WRT error handling, according to ATA specs I can look at the error
> information to determine how much of the request, if any, completed
> successfully.  (dunno if this is also doable on ATAPI)  That's why
> partial completions in the error path make sense to me.

... so if you do partial completions in the normal paths (or rather
allow them), error handling will be simpler. And we all know where the
hard and stupid bugs are - the basically never tested error handling.

> >>see.  I'll implement whichever is easier first, which will certainly
> >>be better than the current sledgehammer limit.  Any improvement over
> >>the 
> >
> >
> >Definitely, the current static limit completely sucks...
> >
> >
> >>current code will provide dramatic performance increases, and we can
> >>tune after that...
> >
> >
> >A path needs to be chosen first, though.
> 
> The path has been chosen:  the "it works" solution first, then tune.
> :)

Since one path excludes the other, you must choose a path first. Tuning
is honing a path, not rewriting that code.

-- 
Jens Axboe

