Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283298AbRK2QHA>; Thu, 29 Nov 2001 11:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283297AbRK2QGv>; Thu, 29 Nov 2001 11:06:51 -0500
Received: from web13606.mail.yahoo.com ([216.136.175.117]:27141 "HELO
	web13606.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283292AbRK2QGj>; Thu, 29 Nov 2001 11:06:39 -0500
Message-ID: <20011129160637.50471.qmail@web13606.mail.yahoo.com>
Date: Thu, 29 Nov 2001 08:06:37 -0800 (PST)
From: Balbir Singh <balbir_soni@yahoo.com>
Subject: Re: Patch: Fix serial module use count (2.4.16 _and_ 2.5)
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Err,
>	close(-ENOMEM);

>What's that going to close?  Hint: you _can't_ close
a descriptor that
>failed to open, since you don't have a descriptor to
close.  You can
>only try to close an error code, but that's not going
to make it anywhere
>near the kernel driver level.


Let me make it clearer to you,

lets say I call rs_open() on /dev/ttyS0 and if it
fails then I should not call rs_close() after a failed
rs_open().

I hope this is clear now.





> The same thing applies to the code below. I think
that the open routine
> should instead set tty->driver_data to NULL upon
failure.

>Here's an example why that'd be real bad:

>1. process A opens /dev/ttyS0 as a normal device. 
>This initialises
>   tty->driver_data.
>2. process B tries to open /dev/cua0
>3. process B fails with -EBUSY since the normal
>device is open and active
>   (see block_til_ready)
>4. since rs_open failed, we set tty->driver_data to
>be NULL (note that this
>   is the same tty device pointer as (1) above.
>5. process A writes to /dev/ttyS0
>6. rs_write does the following:

>        struct async_struct *info = (struct
async_struct *)tty->driver_data;

>7. Oops.

Lets see what happens with your approach

1. I call rs_open(), it fails, ref_count set to 1

2. I am sane enough not to call rs_close() on the
device which failed to open with rs_open the first
time, count is set to 1, driver never unloads.

I do not have access to block_til_ready currently.
But, I will see that function and revert with more
comments.

Comments,
Balbir Singh.


--
Russell King (rmk@arm.linux.org.uk)                The
developer of ARM Linux
            
http://www.arm.linux.org.uk/personal/aboutme.html



__________________________________________________
Do You Yahoo!?
Yahoo! GeoCities - quick and easy web site hosting, just $8.95/month.
http://geocities.yahoo.com/ps/info1
