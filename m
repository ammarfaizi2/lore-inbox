Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWFQGiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWFQGiU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 02:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWFQGiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 02:38:20 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:4945 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932121AbWFQGiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 02:38:19 -0400
Message-ID: <4493A354.4020602@tls.msk.ru>
Date: Sat, 17 Jun 2006 10:38:12 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Michael Tokarev <mjt@tls.msk.ru>
CC: Wu Fengguang <wfg@mail.ustc.edu.cn>, Ingo Oeser <ioe-lkml@rameria.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH 4/5] readahead: backoff on I/O error
References: <20060609080801.741901069@localhost.localdomain> <349840680.03819@ustc.edu.cn> <200606102033.46844.ioe-lkml@rameria.de> <448B221D.3080907@tls.msk.ru> <350074764.23563@ustc.edu.cn> <448D4AC7.4040009@tls.msk.ru>
In-Reply-To: <448D4AC7.4040009@tls.msk.ru>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Tokarev wrote:
> Wu Fengguang wrote:
> []
>> Andrew:
>> I was a bit afraid about that because I have no CDROM to try it out.
>> But since Michael has tested it OK, it should be OK for the stable kernel.
> 
> Hmm.. I haven't "tested it OK" yet. I just ran a quick-n-dirty
> check.  Tomorrow I'll be in our office where I have more adequate
> "test environment" for this stuff (different CD/DVD drives and
> disks, some scratched), and I'll do some real testing.

Ok, almost a week has passed, and... oh well.

The patch itself works, reducing the readahead quickly, *when
I use dd with default bs=512* (see below), but it looks somewhat
strange:

hdc: command error: status=0x51 { DriveReady SeekComplete Error }
hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
ide: failed opcode was: unknown
end_request: I/O error, dev hdc, sector 706696
Buffer I/O error on device hdc, logical block 176674
Retracting readahead size of hdc to 32K
Retracting readahead size of hdc to 8K
Retracting readahead size of hdc to 0K

The strangeness is that the message "Retracting readahead size" is
repeated, without intermediate "hdc: command error: ..." things,
ie, from the dmesg output it looks like we reducing RA size 3
times in a row without any reason (after only one error, instead
of 3) (all the above messages are recorded in the same second).

But the interesting thing is the 2nd line above -- error=0x51
{ IllegalLengthIndication LastFailedSense=0x05 } -- this
IllegalLengthIndication bit.  In SBC-2 standard this bit is
called "Incorrect Length Indication (ILI)", not "Illegal"
(probably needs to be fixed in drivers/ide/ide-lib.c.

The meaning of this bit is that the drive completed PART of
the original request, ie, it has read SOME data, probably
up to the pre-error block, so it should be safe to fill in
the cache with the read data and continue, without changing
anything.

It looks like *ALL* cd-rom drives I have here return this sort
of error on problematic reads.  At least I wasn't able to find
any which does not (I tried - hence the delay in replying).

So... it looks like it should be possible to fix the original
issue in the right place.

Ok, here's the most interesting (IMHO) part.

All the above works if I'm using dd with default bs=512.  BUT.
Once I add bs=2k to the dd line..  it (the patch) stops working,
and shows exactly the behaviour I've seen originally (which
killed my drive):

10:18:41 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:18:41 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:18:41 ide: failed opcode was: unknown
10:18:41 end_request: I/O error, dev hdc, sector 706240
10:18:41 Buffer I/O error on device hdc, logical block 88280
10:18:47 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:18:47 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:18:47 ide: failed opcode was: unknown
10:18:47 end_request: I/O error, dev hdc, sector 706248
10:18:47 Buffer I/O error on device hdc, logical block 88281
10:18:53 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:18:53 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:18:53 ide: failed opcode was: unknown
10:18:53 end_request: I/O error, dev hdc, sector 706256
10:18:53 Buffer I/O error on device hdc, logical block 88282

....alot of similar errors skipped, with consequtive block numbers.
   At this point (10:18), I hit Ctrl+C on the xterm where dd was running...

10:23:44 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:23:44 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:23:44 ide: failed opcode was: unknown
10:23:44 end_request: I/O error, dev hdc, sector 706680
10:23:44 Buffer I/O error on device hdc, logical block 88335
10:23:54 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:23:54 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:23:54 ide: failed opcode was: unknown
10:23:54 end_request: I/O error, dev hdc, sector 706688
10:23:54 Buffer I/O error on device hdc, logical block 88336
10:24:32 hdc: command error: status=0x51 { DriveReady SeekComplete Error }
10:24:32 hdc: command error: error=0x51 { IllegalLengthIndication LastFailedSense=0x05 }
10:24:32 ide: failed opcode was: unknown
10:24:32 end_request: I/O error, dev hdc, sector 706696
10:24:32 Buffer I/O error on device hdc, logical block 88337
10:24:32 Retracting readahead size of hdc to 32K

And finally here we go: the new logic triggered.  And the dd command
unfroze as well (reacted to the interrupt).

So now I see why the first strangeness above (3 times "retracting RA
size" after only one error): the hw sector size is 2048 bytes, but
dd requested 512-byte blocks, so one failed hw sector = 4 failed
reads.

So finally.. it looks like the whole thing is somewhere else still.
The last batch of messages shows exactly the previous behaviour
(numerous attempts to read quite alot of failing sectors, which
takes quite some time too - depending on the CD-ROM drive alot),
BEFORE the new RA-reducing logic gets triggered.

I wonder...

 a) where all those read attempts comes from, and
 b) whenever it's possible to use this IncorrectLengthIndication
    (ILI) bit and all the returned data.

And btw.. why "ide: failed opcode was: unknown" ?

Thanks

/mjt
