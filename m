Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129334AbRAYTGf>; Thu, 25 Jan 2001 14:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131417AbRAYTG0>; Thu, 25 Jan 2001 14:06:26 -0500
Received: from chaos.analogic.com ([204.178.40.224]:52112 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129334AbRAYTGP>; Thu, 25 Jan 2001 14:06:15 -0500
Date: Thu, 25 Jan 2001 14:05:38 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Jens Axboe <axboe@suse.de>
cc: Pete Zaitcev <zaitcev@metabyte.com>, linux-kernel@vger.kernel.org
Subject: Re: patchlet for cs46xx
In-Reply-To: <20010125185949.B444@suse.de>
Message-ID: <Pine.LNX.3.95.1010125135303.19687A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Jan 2001, Jens Axboe wrote:

> On Thu, Jan 25 2001, Richard B. Johnson wrote:
> > [SNIPPED...]
> > >From what I tested, copy_to/from_user, now seg-faults the caller directly.
> > If the function returns, it worked. Therefore you will never get a
> > chance to return -EFAULT.
> 
> Huh?? copy_to/from_user returns the bytes _not_ copied, in which
> case you return -EFAULT go segv the caller.
> 
> I think the confusion usually is that put/get_user return -EFAULT
> directly.
> 
> -- 
> * Jens Axboe <axboe@suse.de>
> * SuSE Labs

Looking at the code, you are right. However, testing it, by malloc()ing
a buffer in user, space, I have done the following.

(1) Allocate  a buffer from malloc().
(2) Allocate shared memory
(3) fork() child to write, one byte at a time until the child seg-faults.
    The address of the buffer to be written is put into shared memory
    just before the write. Parent checks that this is (correctly) just
    over a page boundary.
    Now I know the first address at which the parent would (should)
    seg-fault if it were to attempt the same.
(4) Now, I use one byte less than that address in a ioctl(), that
    does copy_to_user. It attempts to copy sizeof(termios) bytes.
    According to the "specs" it should just fail after copying 1 byte.
    It doesn't. It just seg-faults the parent.

I did just the same with a copy_from_user. Both ioctls are standard
TCGETS/TCSETS terminal ioctls(), with the termios structure pointer
moved around.

Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
