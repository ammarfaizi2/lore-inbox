Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319056AbSHFKsW>; Tue, 6 Aug 2002 06:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSHFKsW>; Tue, 6 Aug 2002 06:48:22 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19462 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S319056AbSHFKsV>; Tue, 6 Aug 2002 06:48:21 -0400
Message-ID: <3D4FA924.3030601@evision.ag>
Date: Tue, 06 Aug 2002 12:47:00 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.30 IDE 113
References: <13AC5F92253@vcnet.vc.cvut.cz> <20020806104414.GC1132@suse.de>
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Tue, Aug 06 2002, Petr Vandrovec wrote:
> 
>>>After all ide_raw_taskfile only gets used for REQ_SPECIAL request
>>>types. This does *not* contain normal data request from block IO.
>>>As of master slave issues - well we have the data pre allocated per
>>>device not per channel! If q->request_fn would properly return the
>>>error count instead of void, we could even get rid ot the
>>>checking for rq->errors after finishment... But well that's
>>>entierly different story.
>>
>>For example do_cmd_ioctl() invokes ide_raw_taskfile, without any locking.
>>Two programs, both issuing HDIO_DRIVE_CMD at same time, will compete
>>over one drive->srequest struct: you'll get same drive->srequest structure
>>submitted twice to blk_insert_request (hm, Jens, will this trigger
>>BUG, or will this just damage request list?).
> 
> 
> Just silently damage request list. We _could_ easily add code to detect
> this, but it's not been a problem in the past so not worth looking for.
> 
> AFAICS, Petr is completely right wrt this race.

For the ioctl case yes. But:

1. We already look for blk_queue_empty there.
2. We have just to deal properly with the queue plugging there
to close it up.
3. I will just add spin locking on ide_lock to maintain that no two
ioctl can overlapp at all.

OK?


