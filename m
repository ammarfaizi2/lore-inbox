Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTLKXz7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTLKXz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:55:58 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:48835 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264428AbTLKXz4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:55:56 -0500
Message-ID: <3FD90580.5080209@pacbell.net>
Date: Thu, 11 Dec 2003 16:02:08 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>, Duncan Sands <baldrick@free.fr>
CC: linux-kernel@vger.kernel.org,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312111119.00289.oliver@neukum.org> <200312112243.37328.baldrick@free.fr> <200312112357.15661.oliver@neukum.org>
In-Reply-To: <200312112357.15661.oliver@neukum.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
>>(1) If both subsys.rwsem and dev->serialize are taken, then
>>subsys.rwsem must be taken first.
> 
> 
> Yes.

Erm, no.  As I pointed out the other day, it's a locking
hierarchy.  It must always go the other way:

  - dev->serialize first.  That controls the existence
    of the devices representing each interface ... which
    are different depending on device configuration.
    (Example, one config might have three interfaces,
    another one might just have one.)

    Needs to be grabbed during normal enumeration paths
    and by paths that can re-enumerate -- reset_device().
    The critical step is setting the configuration.

  - subsys.rwsem is grabbed automatically by the driver
    model core when it probes to see which driver will
    bind to the per-interface devices, or unbinds them
    (disconnect callbacks).

    It needs to be manually grabbed during claim() and
    release() style driver binding ... usbfs was doing
    this wrong, and I recently posted a patch that should
    fix it (same thread as the other binding fixups).

If you get the lock sequence wrong you'll eventually
deadlock with something that's using the correct
lock sequence.  Like khubd -- wedging much of USB.


>>(2) dev->serialize atomizes changes to the struct usb_device.
>>
>>Why then is dev->serialize not taken in usb_reset_device
>>(except in a dud code path)?

It IS taken in usb_reset_device(), and that "dud" path
is broken because that needs to be done in some other
task context.  (Because the reset must fail, and yet
the device is still there -- it needs to re-enumerate,
which that thread can't do.)

That "physical" reset_device doesn't grab it, since
its caller is guaranteed to already have the lock.


>>Also, why isn't dev->serialize enough to protect against
>>probe() during usb_reset_device?  After all, won't
>>dev->serialize be held during the probe calls (I didn't
>>check this and I'm in need of coffee - I hope I'm on the
>>right planet...)

Why?  See above about lock hierarchy.  When devices are
configured -- during enumeration, or eventually during
the re-enumeration on that "dud" codepath) -- devices
are created for each interface.


> In the current code definitely not.
> You must make sure that the configuration is still available.
> Guarding against probe() during reset is not enough.
> AFAIK David is currently rewriting this.

I have some unfinished code, but it's got to wait utnil
those two "fix driver binding" patches get merged:
the one for usbcore (everyone seemed OK with that one),
and the other for usbfs (no feedback yet).

There are entirely too many locks involved in all this,
and many of them will cause problems the minute any
very "interesting" things start getting done ... which
is why locking cleanups need to be done first.

- Dave



> 
> 	Regards
> 		Oliver
> 
> 


