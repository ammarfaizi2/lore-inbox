Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310825AbSCRNoq>; Mon, 18 Mar 2002 08:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310828AbSCRNog>; Mon, 18 Mar 2002 08:44:36 -0500
Received: from [195.63.194.11] ([195.63.194.11]:18194 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310825AbSCRNoX>; Mon, 18 Mar 2002 08:44:23 -0500
Message-ID: <3C95EEE6.7070608@evision-ventures.com>
Date: Mon, 18 Mar 2002 14:43:02 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Roberto Nibali <ratz@drugphish.ch>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: Question about the ide related ioctl's BLK* in 2.5.7-pre1 kernel
In-Reply-To: <3C9007F5.1000003@drugphish.ch> <3C900A11.55BA4B32@zip.com.au> <3C905894.90407@drugphish.ch> <3C905B9D.A1E3ACF6@zip.com.au> <3C9091D6.6030301@evision-ventures.com> <3C910262.6010107@drugphish.ch> <3C95EB96.9020803@evision-ventures.com> <20020318133457.GJ28106@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> On Mon, Mar 18 2002, Martin Dalecki wrote:
> [BLKRAGET etc]
> 
>>BTW> It's quite propably right now, that I will just reintroduce them
>>myself and give them the semantics of the multi-write hardware settings,
>>just to fix the multi write PIO problem :-).
> 
> 
> What would that fix?
> 
> I've still got the multi-write fixes pending, out tomorrow I hope. Other
> stuff keeps getting in the way. I haven't forgotten :-)

I think that it would make the write operation atomic in respect
to the BIO chunk write order. Or please have a look at
the following piece of cr... code from ide-taskfile.c:

	/* (ks/hs): See task_mulin_intr */
	msect = drive->mult_count;
	nsect = rq->current_nr_sectors;
	if (nsect > msect)
		nsect = msect;

	pBuf = ide_map_rq(rq, &flags);
	DTF("Multiwrite: %p, nsect: %d , rq->current_nr_sectors: %ld\n",
		pBuf, nsect, rq->current_nr_sectors);
	drive->io_32bit = 0;
	taskfile_output_data(drive, pBuf, nsect * SECTOR_WORDS);
	ide_unmap_rq(rq, pBuf, &flags);
	drive->io_32bit = io_32bit;
	

in esp. the nsect versus msect games whould go away and
if we have current_nr_sectors > drive->mult_count, we
are not going to write everything in one operation as it stands...
The above just *feels* to me like something that should
be pushed one layer upwards, since the sematics it has fits
quite nicely into what the ioctl in question should be about.

Plase note that I'm just speculating and feels free to correct me
if I'm entierly mistaken for some reason.

Please note as well that this is more about extending then
about fixing.

