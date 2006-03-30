Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWC3Rix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWC3Rix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:38:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751348AbWC3Rix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:38:53 -0500
Received: from 26.mail-out.ovh.net ([213.186.42.179]:49585 "EHLO
	26.mail-out.ovh.net") by vger.kernel.org with ESMTP
	id S1751346AbWC3Riw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:38:52 -0500
Date: Thu, 30 Mar 2006 19:35:24 +0200
From: col-pepper@piments.com
To: "Mathis Ahrens" <Mathis.Ahrens@gmx.de>, "Chris Mason" <mason@suse.com>
Subject: Re: o_sync in vfat driver
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <op.s5lrw0hrj68xd1@mail.piments.com> <op.s5nkafhpj68xd1@mail.piments.com> <20060227151230.695de2af.akpm@osdl.org> <200602281347.46169.mason@suse.com> <4429ED2F.10407@gmx.de>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <op.s68ls1r8j68xd1@mail.piments.com>
In-Reply-To: <4429ED2F.10407@gmx.de>
User-Agent: Opera M2/8.52 (Linux, build 1631)
X-Ovh-Remote: 80.170.110.32 (d80-170-110-32.cust.tele2.fr)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: fait|type 1&3|2.3|H 0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2006 04:13:03 +0200, Mathis Ahrens <Mathis.Ahrens@gmx.de>  
wrote:

> Hi all,
>
> Chris Mason wrote:
>> On Monday 27 February 2006 18:12, Andrew Morton wrote:
>>
>>> We don't know that the same number of same-sized write()s were  
>>> happening in
>>> each case.
>>>
>>> There's been some talk about implementing fsync()-on-file-close for  
>>> this
>>> problem, and some protopatches.  But nothing final yet.
>>>
>>
>> Here's the patch I'm using in -suse right now.  What I want to do is  
>> make a much more generic -o flush, but it'll still need a few bits in  
>> individual filesystem to kick off metadata writes quickly.
>>
>> The basic goal behind the code is to trigger writes without waiting for  
>> both
>> data and metadata.  If the user is watching the memory stick, when the  
>> little light stops flashing all the data and metadata will be on disk.
>>
>> It also generally throttles userland a little during file release.   
>> This could be changed to throttle for each page dirtied, but most users  
>> I asked liked the current setup better.
>>
>
> I like the idea and would like to see something like this in mainline.
>
> Here is some non-scientific benchmark done with 2.6.16, comparing
> default mount and flush mount of a USB2 stick:
>
> /////////////////////////////////////////////////////////////////////
> Single File "Test": 43MB
> $ time cp Test /media/usbdisk/test/ && time umount /media/usbdisk/
> /////////////////////////////////////////////////////////////////////
>
> VANILLA:
>
> real    0m3.770s
> user    0m0.004s
> sys     0m0.308s
>
> real    0m9.439s
> user    0m0.000s
> sys     0m0.040s
>
> FLUSH:
>
> real    0m6.000s
> user    0m0.012s
> sys     0m0.400s
>
> real    0m3.668s
> user    0m0.000s
> sys     0m0.028s
>
> REAL TIME RATIO (FLUSH/VANILLA):
> 9.6 / 13.1 = 0.73
>
> /////////////////////////////////////////////////////////////////////
> Directory Tree "flushtest": 44MB (8866 files, 1820 dirs)
> $ time cp -R flushtest/ /media/usbdisk/ && time umount /media/usbdisk/
> /////////////////////////////////////////////////////////////////////
>
> VANILLA:
>
> real    0m0.966s
> user    0m0.024s
> sys     0m0.860s
>
> real    1m11.962s
> user    0m0.004s
> sys     0m0.160s
>
> FLUSH:
>
> real    1m41.645s
> user    0m0.032s
> sys     0m1.112s
>
> real    0m4.660s
> user    0m0.004s
> sys     0m0.068s
>
> REAL TIME RATIO (FLUSH/VANILLA):
> 106.3 / 77.9 = 1.36
>
>

That's interesting, albeit non-scientific, I think it is quite informative.

There are two basic problems with the current code: speed is down by  
around and order of magnitude compared to a non-synced write and the fact  
that the code is hammering the FAT.  The two are obviously related.

Viewing the system globally rather than considering the details of the  
techniques used, it would seem that any algorithm that does not  
drastically reduce write times, at least on the one large file test , is  
missing the mark and presumably repeating the problem in a slightly  
different way.

Not knocking the efforts Chris has put in , it's great to see this is  
getting some attention, but I think viewing overall performance times as  
shown above gives a touchstone as to whether any particular proto is  
effective.

The fact that flush can be almost 40% slower in some cases is worrying.

Thanks for the info.

