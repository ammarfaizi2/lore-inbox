Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132614AbRC1Xu1>; Wed, 28 Mar 2001 18:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132620AbRC1XuR>; Wed, 28 Mar 2001 18:50:17 -0500
Received: from hercules.telenet-ops.be ([195.130.132.33]:28085 "HELO
	smtp1.pandora.be") by vger.kernel.org with SMTP id <S132614AbRC1XuF>;
	Wed, 28 Mar 2001 18:50:05 -0500
Message-ID: <3AC26865.8D034960@pandora.be>
Date: Thu, 29 Mar 2001 00:40:37 +0200
From: johan verrept <johan.verrept@pandora.be>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-usb-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org, Tony Hoyle <tmh@magenta-netlogic.com>
Subject: Re: [linux-usb-devel] Repeatable lockup on SMP w/usbprocfs
In-Reply-To: <3AC24EF0.6060800@magenta-netlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tony Hoyle wrote:
> 
> If an application calls the USBDEVFS_SUBMITURB ioctl to submit a read,
> when the async completion routine is called, the kernel goes into a hard
> deadlock (no response to ping, etc.).  I've narrowed it down to the
> async_completed routine in usb.c.  That's the only place where spinlocks
> are used.  I'm not familiar enough with them to see what the error is,
> though.

It is async_completed in devio.c btw.
I have looked at this too, but I am not sure whether this happens when the completion is called or
when the program does a USBDEVFS_REAPURB(NDELAY).
I have looked at the code, but I do not see anything obviously wrong.

One thing I considered weird is the "wake_up(&ps->wait);" in async_completed().
This will wake up the program that has submitted the urb, whether is expects to be woken or not. I
am not sure what the consequences of this are, but it seems harmless enough.

> The system runs fine until the packet is returned, then it just locks 
> solid (On the alcatel USB modem I used for testing it will not respond 
> until it gets sync, which may be several seconds).

I have also noticed this only with the Alcatel SpeedTouch USB driver. I am not aware of any other
driver that uses this although I am writing one that will be using this. It is very possible the
program does something wrong (For example the code mixes the async and the sync versions of the urb
ioctl's...), but even then it is not supposed to be able to lock up the whole machine.

> Others have found that just compiling SMP into the kernel is enough to
> break it, you don't actually need two processors.

Probably because when you turn SMP off, spinlocks are disabled so deadlocks are avoided.

	J.
