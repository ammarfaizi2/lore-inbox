Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSLWSB4>; Mon, 23 Dec 2002 13:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266936AbSLWSB4>; Mon, 23 Dec 2002 13:01:56 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:49067 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP
	id <S266932AbSLWSBz>; Mon, 23 Dec 2002 13:01:55 -0500
Date: Mon, 23 Dec 2002 10:15:47 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: USB 2.0 is too slow?
To: linux-kernel@vger.kernel.org
Message-id: <3E0752D3.3060000@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <3E034860.70509@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject:  Re: USB 2.0 is too slow?
> From:     "Joseph" <jospehchan () yahoo ! com ! tw>
> 
>> You didn't mention what kernel or driver version you used.
>> I'd expect more success with the latest 2.5 code, which
>> should appear as a patch against 2.4.21pre soon.
> 
> Kernel 2.5.45, 2.5.51, 2.5.52 and 2.4.20 which I've tested.
> Redhat 8.0, VIA VT8235 SB, Lacie USB2.0/1394 10GB HDD.

I think you'd be better off with 2.5.52bk8 or 2.4.20pre with
the ehci24-1220 patch [*].  Fewer problems over all, and with
that version, fewer severe ones.


> Sometimes I got the messages below during copying some large data. (in
> kernel 2.5.45)
>    drivers/usb/core/message.c: usb_sg_cancel, unlink --> -22
>    drivers/usb/core/message.c: usb_sg_cancel, unlink --> -22
>    drivers/usb/core/message.c: driver for bus 00:08.2 dev 2 ep 2-in
> corrupted data!

All stuff that would never have appeared before 2.5.45; storage
is now stressing bulk queueing in all the hcds, using scatterlist
primitives.  The ohci and uhci drivers have had much more time to
get stable queueing than the ehci code.  That explains some of
the recent updates to the ehci-hcd driver.

I think "message.c" needs a small patch.  The unlink diagnostics
have a FIXME next to them (there are false alarms), and I'm not
entirely trusting that "corrupted" diagnostic either.


> If the messages were shown, it spent more longer than 20 secs.
> Although it didn't show the same messages above in kernel 2.5.52, but it
> copied slowly as before.

Some kind of fault was reported, and some of the usb-storage
error cleanup paths will delay "HZ*6" (6 seconds).  For my tests
I sometimes just make it "HZ/6" (36x shorter).

There was a recent usb-storage change (fixed in bk8) to recognize
that a particular fault code doesn't indicate an error (so no
recovery is needed); it likely affected some of these cases, and
the "cleanups" would indeed have caused "slow" transfers.


>    BTW, do u have any solution for  following problem.
>    **If two USB2.0 devices (HDD and CD-RW) are pluged into the same usb hub,
>        Two situations I met as follow. ( check /proc/scsi/scsi )
>         A. 2 devices are found and can be attached.
>         B. 2 devices are found but only one device can be attached.

You're describing a situation where /proc/bus/usb/devices shows the
devices, but they don't make it all the way into /proc/scsi/scsi?
Sounds familiar, as if someone else reported it too.

- Dave

[*] http://marc.theaimsgroup.com/?l=linux-usb-devel&m=104040598627391&w=2




