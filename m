Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262829AbREVVSh>; Tue, 22 May 2001 17:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262827AbREVVS1>; Tue, 22 May 2001 17:18:27 -0400
Received: from [195.63.194.11] ([195.63.194.11]:43524 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S262829AbREVVSU>; Tue, 22 May 2001 17:18:20 -0400
Message-ID: <3B0AD75E.92D44A49@evision-ventures.com>
Date: Tue, 22 May 2001 23:17:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: viro@math.psu.edu, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] struct char_device
In-Reply-To: <UTC200105222054.WAA79836.aeb@vlet.cwi.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> > They are entirely different. Too different sets of operations.
> 
> Maybe you didnt understand what I meant.
> both bdev and cdev take care of the correspondence
> device number <---> struct with operations.
> 
> The operations are different, but all bdev/cdev code is identical.
> 
> So the choice is between two uglies:
> (i) have some not entirely trivial amount of code twice in the kernel
> (ii) have a union at the point where the struct operations
> is assigned.
> 
> I preferred the union.
> 
> >> And a second remark: don't forget that presently the point where
> >> bdev is introduced is not quite right. We must only introduce it
> >> when we really have a device, not when there only is a device
> >> number (like on a mknod call).
> 
> > That's simply wrong. kdev_t is used for unopened objects quite often.
> 
> Yes, but that was my design mistake in 1995.

I fully agree with you. Most of the places where there kernel is passing
kdev_t
would be entierly satisfied with only the knowlendge of the minor number
used to
distinguish between different device ranges, which is BTW an abuse by
itself as well
since minors where for encounters of instances of similiar devices in
linux...
The places where this is the case are namely:

1. literally: all character devices.

2. The whole scsi stuff.

3. most of the ide stuff.

4. md/lvm and similiar culprits.

I did "discover" this by splitting the i_dev field from stuct inode
into explicit i_minor and i_major fields and then actually "fixing" my
particular kernel configuration until it worked again. This was
*very* insigtfull, since it discovered all the places where kdev_t get's
used, where it shouldn't be of any need anylonger anyway.

The remaining places where kdev_t comes into sight are mostly
the places where the kernel is mounting the initial root
device.

In case you would like to have a look at the resulting bit huge
patch I can send it to you...

> I think you'll find if you continue on this way,
> as I found and already wrote in kdev_t.h
> that it is bad to carry pointers around for unopened and unknown devices.
> 
> So, I think that the setup must be changed a tiny little bit
> and distinguish meaningless numbers from devices.
> 
> Andries
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
- phone: +49 214 8656 283
- job:   eVision-Ventures AG, LEV .de (MY OPINIONS ARE MY OWN!)
- langs: de_DE.ISO8859-1, en_US, pl_PL.ISO8859-2, last ressort:
ru_RU.KOI8-R
