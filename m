Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264103AbUFKQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264103AbUFKQhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUFKQeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:34:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10180 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264103AbUFKQcM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:32:12 -0400
Message-ID: <40C9DE7F.8040002@pobox.com>
Date: Fri, 11 Jun 2004 12:31:59 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ed Tomlinson <edt@aei.ca>, Andrew Morton <akpm@osdl.org>
Subject: Re: flush cache range proposal (was Re: ide errors in 7-rc1-mm1 and
 later)
References: <1085689455.7831.8.camel@localhost> <20040605092447.GB13641@suse.de> <20040606161827.GC28576@bounceswoosh.org> <200406100238.11857.bzolnier@elka.pw.edu.pl> <20040610061141.GD13836@suse.de> <20040610164135.GA2230@bounceswoosh.org> <40C89F4D.4070500@pobox.com> <40C8A241.50608@pobox.com> <20040611075515.GR13836@suse.de> <20040611161701.GB11095@bounceswoosh.org>
In-Reply-To: <20040611161701.GB11095@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Fri, Jun 11 at  9:55, Jens Axboe wrote:
> 
>> Proposal looks fine, but please lets not forget that flush cache range
>> is really a band-aid because we don't have a proper ordered write in the
>> first place. Personally, I'd much rather see that implemented than flush
>> cache range. It would be way more effective.
> 
> 
> So something like:
> 
> WRITE FIRST PARTY DMA QUEUED BARRIER EXT
> READ FIRST PARTY DMA QUEUED BARRIER EXT
> READ DMA QUEUED BARRIER EXT
> READ DMA QUEUED BARRIER
> WRITE DMA QUEUED BARRIER
> WRITE DMA QUEUED BARRIER EXT

Honestly, Linux at least isn't going to care about "legacy TCQ" at all, 
unless in the very rare case that the controller implements TCQ support 
in hardware.

The overall difficulty with implementing atomic updates, journalling, 
barriers etc. on ATA is that traditionally the OS had no clue what was 
in the write cache, and what was actually on the platter.

Thus, I think that an FPDMA queued FUA read/write should be all that's 
needed, since that automatically gives the OS the knowledge of ordering, 
which gives barriers what they need.  Ordering need only be a matter of 
waiting for the hardware queue (all FUA commands) to drain, and then 
issuing an FUA commit block.

Unfortunately, that's not the answer drive guys want to hear, because 
FUA limits the optimization potential from previous ATA.  ;-)  Maybe 
drive performance is high enough these days that queued-FUA as a 
standard mode of operation is tolerable...


> ...
> 
> If the drive receives a queued barrier write (NCQ or Legacy), it will
> finish processing all previously-received queued commands and post
> good status for them, then it will process the barrier operation, post
> status for that barrier operation, then it will continue processing
> queued commands in the order received.

If queued-FUA is out of the question, this seems quite reasonable.  It 
appears to achieve the commit-block semantics described for barrier 
operation, AFAICS.

	Jeff


