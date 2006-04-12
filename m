Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWDLNU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWDLNU4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWDLNU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:20:56 -0400
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:64499
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751115AbWDLNUz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:20:55 -0400
Message-ID: <002901c65e33$ceac9e00$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Jens Axboe" <axboe@suse.de>
Cc: <dax@gurulabs.com>,
       =?UTF-8?B?Iijlu6Plronnp5HmioAp5a6J5Y+vTyI=?= 
	<billion.wu@areca.com.tw>,
       "\"Al Viro\"" <viro@ftp.linux.org.uk>,
       "\"Andrew Morton\"" <akpm@osdl.org>,
       "\"Randy.Dunlap\"" <rdunlap@xenotime.net>,
       "\"Matti Aarnio\"" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>,
       "\"James Bottomley\"" <James.Bottomley@steeleye.com>,
       "Chris Caputo" <ccaputo@alt.net>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net> <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Date: Wed, 12 Apr 2006 21:20:00 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 12 Apr 2006 13:15:43.0921 (UTC) FILETIME=[343A3210:01C65E33]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens Axboe,

I had found a big difference of generic_make_request(struct bio *bio)
got message : sdb1: rw=0, want=...., limit=.....


*****************
** TEST 1
*****************

I used "MAX_XFER_SECTORS  4096" driver to do mkfs.ext2 with ARECA RAID 
volume sdb1.
and copy a big file (900MB) into sdb1.
If I copy this file from sdb1, the message rw=.... ,want=......, 
limit=...... will appear immediately.

When I reboot the system and used  "MAX_XFER_SECTORS  512" driver.
I copy this big file from sdb1, the message rw=.... ,want=......, 
limit=...... still appear immediately.

When I redo mkfs.ext2 with ARECA RAID volume sdb1 (used  "MAX_XFER_SECTORS 
512")
and copy the same file (900MB) into sdb1.
I copy this file from sdb1 again,the message rw=.... ,want=......, 
limit=...... disappear.

****************
** TEST 2
****************

When I do another test with "MAX_XFER_SECTORS  4096" driver

#echo 0 > /sys/block/sdb/queue/read_ahead_kb
#mkfs.ext2 /dev/sdb1

then copy the same file (900MB) into sdb1.
I copy this file from sdb1 again,the message rw=.... ,want=......, 
limit=...... disappear.
Even I redo "echo 4096 > /sys/block/sdb/queue/read_ahead_kb" with ARECA RAID 
volume.
The message rw=.... ,want=......, limit=...... never appear at my "copy 
compare" test script.

Now I can say the bug come from "block read ahead".

And this bug will certainly appear when do "mkfs.ext2" if read_ahead_kb 
value large enough.


Best Regards
Erich Chen
----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "James Bottomley" <James.Bottomley@steeleye.com>; <erich@areca.com.tw>
Sent: Friday, March 31, 2006 3:42 PM
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken


>
> (irk, Erich wasn't in the cc, sorry to Andrew and James for getting this
> mail twice)
>
> On Thu, Mar 30 2006, Andrew Morton wrote:
>> "erich" <erich@areca.com.tw> wrote:
>> >
>> > Dear Chris Caputo,
>> >
>> >  Thanks you to conform this issue again, my colleague assisted me and 
>> > to
>> >  double check my older version driver yesterday.
>> >  and the old driver is working fine as your mention before.
>> >
>> >  The ARCMSR_MAX_XFER_SECTORS is the reason why cause "attempt to access
>> >  beyond end of device".
>> >
>> >  #define ARCMSR_MAX_XFER_SECTORS
>> >  256     -----old
>> >  #define ARCMSR_MAX_XFER_SECTORS
>> >  4096     -----new
>>
>> That seems odd.  ARCMSR_MAX_XFER_SECTORS just gets put into
>> scsi_host_template.max_sectors.  Could it be a scsi core buglet?
>
> Perhaps the larger max sectors setting is causing read-ahead to be
> overly optimistic and going beyond the end? Should not happen.
>
> Erich, can you try and shrink read-ahead on that device and retest?
> Basically just do
>
> # echo 0 > /sys/block/sdX/queue/read_ahead_kb
>
> and see if it still complains.
>
> -- 
> Jens Axboe
> 

