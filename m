Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTK3TEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 14:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTK3TEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 14:04:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44981 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262986AbTK3TEv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 14:04:51 -0500
Message-ID: <3FCA3F44.6070401@pobox.com>
Date: Sun, 30 Nov 2003 14:04:36 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Silicon Image 3112A SATA trouble
References: <3FCA1220.2040508@gmx.de> <200311301721.41812.bzolnier@elka.pw.edu.pl> <20031130162523.GV10679@suse.de> <3FCA1DD3.70004@pobox.com> <20031130165146.GY10679@suse.de> <3FCA2672.8020202@pobox.com> <20031130172855.GA6454@suse.de> <3FCA2BDA.60302@pobox.com> <20031130174552.GC6454@suse.de> <3FCA2F7F.8060206@pobox.com> <20031130182126.GE6454@suse.de>
In-Reply-To: <20031130182126.GE6454@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Sun, Nov 30 2003, Jeff Garzik wrote:
>>Current non-errata case:  1 taskfile, 1 completion func call
>>Upcoming errata solution:  2 taskfiles, 1 completion func call
>>Your errata suggestion seems to be:  2 taskfiles, 2 completion func calls
>>
>>That's obviously more work and more code for the errata case.
> 
> 
> I don't see why, it's exactly 2 x non-errata case.

Since the hardware request API is (and must be) completely decoupled 
from struct request API, I can achieve 1.5 x non-errata case.


>>And for the non-errata case, partial completions don't make any sense at 
>>all.
> 
> 
> Of course, you would always complete these fully. But having partial
> completions at the lowest layer gives it to you for free. non-errata
> case uses the exact same path, it just happens to complete 100% of the
> request all the time.

[editor's note:  I wonder if I've broken a grammar rule using so many 
"non"s in a single email]

If I completely ignore partial completions on the normal [non-error] 
paths, the current errata and non-errata struct request completion paths 
would be exactly the same.  Only the error path would differ.  The 
lowest [hardware req API] layer's request granularity is a single 
taskfile, so it will never know about partial completions.



>>>>WRT error handling, according to ATA specs I can look at the error
>>>>information to determine how much of the request, if any, completed
>>>>successfully.  (dunno if this is also doable on ATAPI)  That's why
>>>>partial completions in the error path make sense to me.
>>>
>>>
>>>... so if you do partial completions in the normal paths (or rather
>>>allow them), error handling will be simpler. And we all know where the
>>
>>In the common non-errata case, there is never a partial completion.
> 
> 
> Right. But as you mention, error handling is a partial completion by
> nature (almost always).

Agreed.  Just in case I transposed a word or something, I wish to 
clarify:  both errata and error paths are almost always partial completions.

However... for the case where both errata taskfiles completely 
_successfully_, it is better have only 1 completion on the hot path (the 
"1.5 x" mentioned above).  Particularly considering that errata 
taskfiles are contiguous, and the second taskfile will completely fairly 
quickly after the first...

The slow, error path is a whole different matter.  Ignoring partial 
completions in the normal path keeps the error path simple, for errata 
and non-errata cases.  Handling partial completions in the error code, 
for both errata and non-errata cases, is definitely something I want to 
do in the future.


>>>hard and stupid bugs are - the basically never tested error handling.
>>
>>I have :)  libata error handling is stupid and simple, but it's also 
>>solid and easy to verify.  Yet another path to be honed, of course :)
> 
> 
> That's good :). But even given that, error handling is usually the less
> tested path (by far). I do commend your 'keep it simple', I think that's
> key there.

As a tangent, I'm hoping to convince some drive manufacturers (under NDA 
most likely, unfortunately) to provide special drive firmwares that will 
simulate read and write errors.  i.e. fault injection.

	Jeff



