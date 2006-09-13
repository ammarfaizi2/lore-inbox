Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWIMOXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWIMOXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWIMOXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:23:25 -0400
Received: from mxsf25.cluster1.charter.net ([209.225.28.225]:10955 "EHLO
	mxsf25.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1750861AbWIMOXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:23:24 -0400
X-IronPort-AV: i="4.09,160,1157342400"; 
   d="scan'208"; a="680093774:sNHT160548710"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17672.5209.158911.963437@smtp.charter.net>
Date: Wed, 13 Sep 2006 10:23:21 -0400
From: "John Stoffel" <john@stoffel.org>
To: Al Boldi <a1426z@gawab.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Subject: Re: What's in linux-2.6-block.git
In-Reply-To: <200609131435.31390.a1426z@gawab.com>
References: <200609131359.04972.a1426z@gawab.com>
	<20060913105932.GA4792@kernel.dk>
	<200609131435.31390.a1426z@gawab.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Al" == Al Boldi <a1426z@gawab.com> writes:

Al> Jens Axboe wrote:
>> On Wed, Sep 13 2006, Al Boldi wrote:
>> > Jens Axboe  wrote:
>> > > This lists the main features of the 'block' branch, which is bound for
>> > > Linus when 2.6.19 opens:
>> > >
>> > > - Splitting of request->flags into two parts:
>> > >         - cmd type
>> > >         - modified flags
>> > >   Right now it's a bit of a mess, splitting this up invites a cleaner
>> > >   usage and also enables us to implement generic "messages" passed on
>> > >   the regular queue for the device.
>> > >
>> > > - Abstract out the request back merging and put it into the core io
>> > >   scheduler layer. Cleans up all the io schedulers, and noop gets
>> > >   merging for "free".
>> > >
>> > > - Abstract out the rbtree sorting. Gets rid of duplicated code in
>> > >   as/cfq/deadline.
>> > >
>> > > - General shrinkage of the request structure.
>> > >
>> > > - Killing dynamic rq private structures in deadline/as/cfq. This
>> > > should speed up the io path somewhat, as we avoid allocating several
>> > > structures (struct request + scheduler private request) for each io
>> > > request.
>> > >
>> > > - meta data io logging for blktrace.
>> > >
>> > > - CFQ improvements.
>> > >
>> > > - Make the block layer configurable through Kconfig (David Howells).
>> > >
>> > > - Lots of cleanups.
>> >
>> > Does it also address the strange "max_sectors_kb<>192 causes a
>> > 50%-slowdown" problem?
>> 
>> (remember to cc me/others when replying, I can easily miss lkml
>> messages for several days otherwise).
>> 
>> It does not, the investigation of that is still pending I'm afraid. The
>> data is really puzzling, I'm inclined to think it's drive related. Are
>> you reproducing it just one box/drive, or on several?

Al> Several boxes, same drive.

Al> /dev/hda:

Al> ATA device, with non-removable media
Al> 	Model Number:       WDC WD1200JB-00DUA0                     
Al> 	Serial Number:      WD-WMACM1007651
Al> 	Firmware Revision:  65.13G65
Al> Standards:
Al> 	Supported: 6 5 4 3 
Al> 	Likely used: 6

I've got a pair of drives which are very close in model type, and I
can run some non-destructive tests on them if you like to confirm
what's going on here if you like:

    /dev/hde:

    ATA device, with non-removable media
	    Model Number:       WDC WD1200JB-00CRA1                     
	    Serial Number:      WD-WMA8C4365875
	    Firmware Revision:  17.07W17
    Standards:
	    Supported: 5 4 3 
	    Likely used: 6
    jfsnew:~> sudo hdparm -I /dev/hdg | head

    /dev/hdg:

    ATA device, with non-removable media
	    Model Number:       WDC WD1200JB-00EVA0                     
	    Serial Number:      WD-WMAEK2844058
	    Firmware Revision:  15.05R15
    Standards:
	    Supported: 6 5 4 
	    Likely used: 6


The drives have different defaul max_sectors too:

    > cat /sys/block/hdg/queue/max_sectors_kb
    512
    > cat /sys/block/hde/queue/max_sectors_kb
    128

Let me know your test method and I'll run it here and post the
results.

John
