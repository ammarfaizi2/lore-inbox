Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312612AbSDKRVd>; Thu, 11 Apr 2002 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312616AbSDKRVc>; Thu, 11 Apr 2002 13:21:32 -0400
Received: from inje.iskon.hr ([213.191.128.16]:25290 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S312612AbSDKRVb>;
	Thu, 11 Apr 2002 13:21:31 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Stephen C. Tweedie" <sct@redhat.com>,
        Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: sard/iostat disk I/O statistics/accounting for 2.5.8-pre3
In-Reply-To: <dnu1qia3zg.fsf@magla.zg.iskon.hr>
	<20020411150219.A10486@infradead.org>
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Thu, 11 Apr 2002 19:20:54 +0200
Message-ID: <878z7u6tjd.fsf@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Common Lisp,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Thu, Apr 11, 2002 at 01:06:59PM +0200, Zlatko Calusic wrote:
>> I had to make some changes, as kernel internals have changed since the
>> time patch was originally written. Alan has also included this patch
>> in his 2.4.x-ac kernel series, but it is not working well.
>
> Oh, it's also in 2.4.19-pre6 and works pretty well..

Good. One more reason to put it in the 2.5.x as well. :)

>
>> First problem is that somehow, misteriously, ios_in_flight variable
>> drops to value of -1 when disks are idle. Of course, this skews lots
>> of other numbers and iostat reports garbage. I tried to find the cause
>> of this behaviour, but failed (looks like we have a request fired on
>> each disk, whose start is never accounted but completion is?!). So I
>> resolved it this way
>> 
>> if (hd->ios_in_flight)
>>                --hd->ios_in_flight;
>> 
>> which works well, but I would still love to know how number of I/Os
>> can drop below zero. :)
>
> I'm unable to reproduce it here - I only have idle partition though..

Here is how it looks here (SMP machine, it could matter):


major minor #blocks name rio rmerge rsect ruse wio wmerge wsect wuse running use aveq

34 0 40011552 hdg 23 62 189 70 4 3 32 0 -1 946410 -946410
33 0 60051600 hde 8349 18725 214666 108230 3781 15234 152176 91700 -1 927060 -746550
 3 0 19938240 hda 848 1023 14565 5470 1303 1542 22768 300 -1 942120 -940710


Notice negative numbers for running, aveq. Kernel is 2.4.19-pre5-ac3.

>
>> Second problem/nuisance is that blk_partition_remap() destroys
>> partition information from the bio->bi_dev before the request is
>> queued. That's why -ac kernel doesn't report per-partition
>> information.
>
> Bullocks.  2.4 doesn't even have blk_partition_remap, but the individual
> drivers do the partition remapping themselves.  I wouldn't have submitted
> sard for 2.4 inclusion if there would be such a bug.
>

Oops, you're right. I stand corrected. That particular problem doesn't
exist on 2.4.x. It is obviously a property of new bio layer which
exists only in the 2.5.x.

Regards,
-- 
Zlatko
