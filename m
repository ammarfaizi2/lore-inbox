Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283279AbRK2Phz>; Thu, 29 Nov 2001 10:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283280AbRK2Php>; Thu, 29 Nov 2001 10:37:45 -0500
Received: from [212.18.232.186] ([212.18.232.186]:36623 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283279AbRK2Phf>; Thu, 29 Nov 2001 10:37:35 -0500
Date: Thu, 29 Nov 2001 15:37:20 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: BALBIR SINGH <balbir.singh@wipro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
Message-ID: <20011129153720.C6214@flint.arm.linux.org.uk>
In-Reply-To: <20011129131059.A6214@flint.arm.linux.org.uk> <3C063CB3.4090708@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C063CB3.4090708@wipro.com>; from balbir.singh@wipro.com on Thu, Nov 29, 2001 at 07:18:35PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2001 at 07:18:35PM +0530, BALBIR SINGH wrote:
> The current code on my system 2.5.0 looks like
> 
>                 if (!page) {
>                         MOD_DEC_USE_COUNT;
>                         return -ENOMEM;
>                 }
> 
> 
> I was wondering that if the open failed with something like this
> 
>     open(/dev/ttyS0, args) = -ENOMEM;
> 
> why would somebody call close on /dev/ttyS0? If you call close on
> a descriptor that failed to open, it is *BAD* code.

Err,
	close(-ENOMEM);

What's that going to close?  Hint: you _can't_ close a descriptor that
failed to open, since you don't have a descriptor to close.  You can
only try to close an error code, but that's not going to make it anywhere
near the kernel driver level.

> I am assuming
> that the tty layer that talks to the serial driver calls rs_close().

Correct.

> The same thing applies to the code below. I think that the open routine
> should instead set tty->driver_data to NULL upon failure.

Here's an example why that'd be real bad:

1. process A opens /dev/ttyS0 as a normal device.  This initialises
   tty->driver_data.
2. process B tries to open /dev/cua0
3. process B fails with -EBUSY since the normal device is open and active
   (see block_til_ready)
4. since rs_open failed, we set tty->driver_data to be NULL (note that this
   is the same tty device pointer as (1) above.
5. process A writes to /dev/ttyS0
6. rs_write does the following:

        struct async_struct *info = (struct async_struct *)tty->driver_data;

7. Oops.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

