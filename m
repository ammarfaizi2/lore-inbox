Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTK3TjW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262838AbTK3TjW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:39:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:19397 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262859AbTK3TjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:39:14 -0500
Date: Sun, 30 Nov 2003 20:39:04 +0100
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
Message-ID: <20031130193904.GG6454@suse.de>
References: <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <3FCA2672.8020202@pobox.com> <20031130172855.GA6454@suse.de> <3FCA2BDA.60302@pobox.com> <20031130174552.GC6454@suse.de> <3FCA2F7F.8060206@pobox.com> <20031130182126.GE6454@suse.de> <3FCA3F44.6070401@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCA3F44.6070401@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30 2003, Jeff Garzik wrote:
> Jens Axboe wrote:
> >On Sun, Nov 30 2003, Jeff Garzik wrote:
> >>Current non-errata case:  1 taskfile, 1 completion func call
> >>Upcoming errata solution:  2 taskfiles, 1 completion func call
> >>Your errata suggestion seems to be:  2 taskfiles, 2 completion func calls
> >>
> >>That's obviously more work and more code for the errata case.
> >
> >
> >I don't see why, it's exactly 2 x non-errata case.
> 
> Since the hardware request API is (and must be) completely decoupled 
> from struct request API, I can achieve 1.5 x non-errata case.

Hmm I don't follow that... Being a bit clever, you could even send off
both A and B parts of the request in one go. Probably not worth it
though, that would add some complexity (things like not spanning a page,
stuff you probably don't want to bother the driver with).

> >>And for the non-errata case, partial completions don't make any sense at 
> >>all.
> >
> >
> >Of course, you would always complete these fully. But having partial
> >completions at the lowest layer gives it to you for free. non-errata
> >case uses the exact same path, it just happens to complete 100% of the
> >request all the time.
> 
> [editor's note:  I wonder if I've broken a grammar rule using so many 
> "non"s in a single email]

Hehe

> If I completely ignore partial completions on the normal [non-error] 
> paths, the current errata and non-errata struct request completion paths 
> would be exactly the same.  Only the error path would differ.  The 
> lowest [hardware req API] layer's request granularity is a single 
> taskfile, so it will never know about partial completions.

Indeed. The partial completions only exist at the driver -> block layer
(or -> scsi) layer, not talking to the hardware. The hardware always
gets 'a request', if that just happens to be only a part of a struct
request so be it.

> >>>>WRT error handling, according to ATA specs I can look at the error
> >>>>information to determine how much of the request, if any, completed
> >>>>successfully.  (dunno if this is also doable on ATAPI)  That's why
> >>>>partial completions in the error path make sense to me.
> >>>
> >>>
> >>>... so if you do partial completions in the normal paths (or rather
> >>>allow them), error handling will be simpler. And we all know where the
> >>
> >>In the common non-errata case, there is never a partial completion.
> >
> >
> >Right. But as you mention, error handling is a partial completion by
> >nature (almost always).
> 
> Agreed.  Just in case I transposed a word or something, I wish to
> clarify:  both errata and error paths are almost always partial
> completions.

Yup agree.

> However... for the case where both errata taskfiles completely 
> _successfully_, it is better have only 1 completion on the hot path (the 
> "1.5 x" mentioned above).  Particularly considering that errata 
> taskfiles are contiguous, and the second taskfile will completely fairly 
> quickly after the first...

Sure yes, the fewer completions the better. Where do you get the 1.5
from? You need to split the request handling no matter what for the
errata path, I would count that as 2 completions.

> The slow, error path is a whole different matter.  Ignoring partial 
> completions in the normal path keeps the error path simple, for errata 
> and non-errata cases.  Handling partial completions in the error code, 

How so?? There are no partial completions in the normal path. In fact,
ignore the term 'partial completion'. Just think completion count or
something like that. At end_io time, you look at how much io has
completed, and you complete that back to the layer above you (block or
scsi). The normal path would always have count == total request, and you
are done. The errata (and error) path would have count <= total request,
which just means you have a line or two of C to tell the layer above you
not put the request back at the front. That's about it for added code.

I think we are talking somewhat past each other. I don't mean to imply
that you want partial completions in the non-errata path. Of course you
don't. I'm purely talking about completion of a count of data which
necessarily doesn't have to be the total struct request size. Your
taskfile tells you how much.

> for both errata and non-errata cases, is definitely something I want to 
> do in the future.

Well yes, you have to.

> >>>hard and stupid bugs are - the basically never tested error handling.
> >>
> >>I have :)  libata error handling is stupid and simple, but it's also 
> >>solid and easy to verify.  Yet another path to be honed, of course :)
> >
> >
> >That's good :). But even given that, error handling is usually the less
> >tested path (by far). I do commend your 'keep it simple', I think that's
> >key there.
> 
> As a tangent, I'm hoping to convince some drive manufacturers (under NDA 
> most likely, unfortunately) to provide special drive firmwares that will 
> simulate read and write errors.  i.e. fault injection.

Would be nice to have ways of doing that which are better than 'mark
this drive bad with a label and pull it ouf of the drawer for testing
error handling' :)

-- 
Jens Axboe

