Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313083AbSDGKur>; Sun, 7 Apr 2002 06:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313084AbSDGKuq>; Sun, 7 Apr 2002 06:50:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:28943 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313083AbSDGKuq>;
	Sun, 7 Apr 2002 06:50:46 -0400
Message-ID: <3CB0246D.23CED3C6@zip.com.au>
Date: Sun, 07 Apr 2002 03:50:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.8-pre2
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <Pine.GSO.4.21.0204071215220.2567-100000@lisianthus.sonytel.be> <20020407112716.A30048@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> (Oh, and a bugbear - people go running around adding checks for the
> return value of request_region and friends on embedded devices where
> there can't be the possibility of a clash waste memory needlessly.)

If you do:

#define request_region(start, n, name)
	({
		__request_region(start, n, name);
		(struct resource *)1;
	})
#define release_region(start, n) do { } while (0)

then the compiler will remove all those error checks for you,
as well as the release_region calls.

Of course if you actually want to use the innards of the
returned resource * then that's not so good.

However, you can make it:

#define request_region()                                \
        ({                                              \
                struct resource *r;                     \
                r = __request_region();                 \
                (struct resource *)((long)r | 1);       \
        })

and, amazingly, the compiler still knows that the value
is non-zero, and still will elide those tests.  You'll
need to mask that bit off again to use the pointer.

Whether you'll stoop this low depends upon how much you
want those bytes back :)

-
