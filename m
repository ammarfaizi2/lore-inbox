Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbVKXMuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKXMuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 07:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbVKXMuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 07:50:24 -0500
Received: from 1-1-8-31a.gmt.gbg.bostream.se ([82.182.75.118]:500 "EHLO
	mail.shipmail.org") by vger.kernel.org with ESMTP id S1750713AbVKXMuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 07:50:23 -0500
Message-ID: <19379.192.138.116.230.1132836621.squirrel@192.138.116.230>
In-Reply-To: <1132829378.3473.11.camel@mindpipe>
References: <1132807985.1921.82.camel@mindpipe>	   
 <8964.192.138.116.230.1132825958.squirrel@192.138.116.230>   
 <1132829378.3473.11.camel@mindpipe>
Date: Thu, 24 Nov 2005 13:50:21 +0100 (CET)
Subject: Re: 2.6.14-rt4: via DRM errors
From: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <unichrome@shipmail.org>
To: "Lee Revell" <rlrevell@joe-job.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "dri-devel@lists.sourceforge.net" <dri-devel@lists.sourceforge.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-BitDefender-Spam: No (0)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 2005-11-24 at 10:52 +0100, Thomas Hellström wrote:
>> I made a fix to the locking code in main drm a couple of months ago.
>>
>> The X server tries to get the DRM_QUIESCENT lock, but when the wait
>> was interrupted by a signal (like when you move a window around), the
>> locking function returned without error. This made the X server
>> release other clients' locks.
>>
>> This does affect all drivers with a quiescent() function. Not only
>> via.
>>
>> But it looks like this fix never made it into the kernel source?
>
> Thanks.
>
> BTW can you point me to a good explanation of DRM locking?  There's so
> much indirection in the DRM code I can't even tell whether there's one
> DRM lock or several, what kind of lock it is or what it's protecting
> (beyond "access to the hardware").  Is it just an advisory lock used by
> DRM clients to keep from stepping on each other?  It doesn't seem
> related to spinlocks or mutexes or any of the other types of lock in the
> kernel.
>
> Lee

There is some info in the old precision insight documentation about the
DRI infrastructure, (can't seem to find a link right now) But generally
there is only one global lock and something called the drawable spinlock
that is apparently not used anymore. The global lock is similar to a
futex, with the exception that the kernel is called both to resolve
contention and whenever a new context is about to take the lock, so that
optional context switching can take place, and also if the client requests
that some special action should take place after locking is done, like
wait for dma ready or quiescent. The lock should be taken before writing
to the hardware or before submitting DMA commands. If you want to be
_sure_ that noone else uses the hardware (like you want to  read a
particular register or something), you have to take the lock and wait for
DMA quiescent. For example, if you want to make sure the video scaler is
idle so you can write to it, you first take the lock so that noone else
writes to it or to the DMA queue, then you wait for the DMA queue to be
empty or make sure there are no pending commands for the scaler, then you
wait for the scaler to become idle.

The lock value is easily manipulated from user space and resides in one of
the shared memory areas. I guess this means that with the current drm
security policy it should be regarded as an advisory lock between drm
clients.

At one point I was about to implement a scheme for via with a number of
similar locks, one for each independent function on the video chip, Like
2D, 3D, Mpeg decoder, Video scaler 1 and 2, so that they didn't have to
wait for  eachother. The global lock would then only be taken to make sure
that no drawables were touched by the X server or other clients while the
lock was held, which would be compatible with how the X server works
today. Never got around to do that, however, but the mpeg decoders have a
futex scheme to prevent clients stepping on eachother. With that it is
possible to have multiple clients use the same hw decoder.

/Thomas

>
>
>
>


