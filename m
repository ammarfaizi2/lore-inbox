Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316826AbSGHJQv>; Mon, 8 Jul 2002 05:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316827AbSGHJQu>; Mon, 8 Jul 2002 05:16:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:36260 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316826AbSGHJQu>;
	Mon, 8 Jul 2002 05:16:50 -0400
Message-Id: <200207080919.g689JE6w029012@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
To: "Andi Kleen" <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@zip.com.au,
       bcrl@redhat.com
Subject: Re: direct-to-BIO for O_DIRECT
Date: Mon, 08 Jul 2002 14:49:38 +0530
References: <3D2904C5.53E38ED4@zip.com.au.suse.lists.linux.kernel> <p73adp2wugy.fsf@oldwotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Jul 2002 13:00:12 +0530, Andi Kleen wrote:

> Andrew Morton <akpm@zip.com.au> writes:
> 
>> 	drivers/md/lvm-snap.c
>> 	drivers/media/video/video-buf.c
>> 	drivers/mtd/devices/blkmtd.c
>> 	drivers/scsi/sg.c
>> 
>> the video and mtd drivers seems to be fairly easy to de-kiobufize. I'm
>> aware of one proprietary driver which uses kiobufs.  XFS uses kiobufs a
>> little bit - just to map the pages.
> 
> lkcd uses it too for its kernel crash dump. I suspect it wouldn't be
> that hard to change.

No, it shouldn't be hard to change. In fact, we've had to think of
changing it for 2.5 anyhow, since most likely we can't afford bio
alloc's happening under the covers down that path.


> 
>> So with a bit of effort and maintainer-irritation, we can extract the
>> kiobuf layer from the kernel.
>> 
>> Do we want to do that?
> 
> I think yes - keeping two kinds of iovectors for IO (kiovecs and BIOs)
> seems to be redundant.
> kiovecs never fulfilled their original promise of a universal zero copy
> container (e.g. they were too heavy weight for networking) so it's
> probably best to remove them as a failed experiment.
> 

Yes, I think Kiobufs can go, and we can use something like kvecs
(from aio code base) instead which are better for representing 
readv/writev, for the generic case (i.e. when its not just
for block i/o). Its easy enough to map kvecs into bio s or
zero-copy networking. 

Regards 
Suparna




> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in the body of a message to majordomo@vger.kernel.org More majordomo
> info at  http://vger.kernel.org/majordomo-info.html Please read the FAQ
> at  http://www.tux.org/lkml/
