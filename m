Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313080AbSDGKf7>; Sun, 7 Apr 2002 06:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313082AbSDGKf6>; Sun, 7 Apr 2002 06:35:58 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:34311 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S313080AbSDGKf5>;
	Sun, 7 Apr 2002 06:35:57 -0400
Date: Sun, 7 Apr 2002 06:35:55 -0400 (EDT)
From: Rob Radez <rob@osinvestor.com>
X-X-Sender: <rob@pita.lan>
To: Russell King <rmk@arm.linux.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: WatchDog Driver Updates
In-Reply-To: <20020407083207.A28922@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0204070624470.3791-100000@pita.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 7 Apr 2002, Russell King wrote:

> On Sat, Apr 06, 2002 at 09:49:57PM -0500, Rob Radez wrote:
> > I've put up a patch on http://osinvestor.com/bigwatchdog.diff against
> > 2.4.19-pre5-ac3.  The diff is 33k, and it affects 19 files in drivers/char/,
>
> And the purpose of this patch is...
>
> 1. copy_to_user is like memcpy() - it takes two pointers and an integer
>    size.  You're passing it two integers and a pointer:
>
>    static int wdt977_ioctl(... unsigned long arg)
>    ...
>             case WDIOC_GETSTATUS:
>                    if(copy_to_user(arg, &timer_alive, sizeof(timer_alive)))
>                               return -EFAULT;
>                    return 0;
>
> 2. sizeof(int) != sizeof(unsigned long).  You've changed the ABI in an
>    unsafe manner on 64-bit machines.  The ABI is defined by the ioctl
>    numbers, which specify an 'int' type.
>
> 3. copy_to_user of an int or unsigned long is a bit inefficient.  Why
>    not use put_user to write an int or unsigned long?

Ok, these first three points, yep, I screwed up.  I'll fix those up. Oops.

>
> 4. Unless I'm missing something, WDIOC_GETSTATUS can only ever return
>    an indication that the timer is open/alive - it's set when the driver
>    is opened, and cleared when it is closed.  Since you can't perform
>    an ioctl on a closed device, the times that you can perform the ioctl,
>    it'll always give you a non-zero result.

This is true, see below.

>
> 5. WDIOC_GETSTATUS is supposed to return the WDIOF_* flags.  Returning
>    "watchdog active" as bit 0 causes it to indicate WDIOF_OVERHEAT.

Hmm...I'm not seeing any standards here.  Some drivers would just send
whether the watchdog device was open, some would only send 0, sc1200
would send whether the device was enabled or disabled, one did 'int one=1'
and then a few lines later copy_to_user'd 'one', and it looks like all of
three of twenty would actually return proper WDIOF flags.  The lack of
proper documentation is fun, so I'll change them all to be consistent and
then add in the diffs for the documentation to bring those up to date too.
They'll all implement WDIOC_GETSTATUS, even if that implementation is just
put_user'ing 0.  None of them will return open status since of course, to
run the ioctl they have to be open and since open status would conflict
with the overheat flag.

Thanks,
Rob Radez

