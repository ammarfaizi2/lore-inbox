Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbTCTVjR>; Thu, 20 Mar 2003 16:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262284AbTCTVjQ>; Thu, 20 Mar 2003 16:39:16 -0500
Received: from hera.cwi.nl ([192.16.191.8]:61840 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261898AbTCTVjP>;
	Thu, 20 Mar 2003 16:39:15 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 20 Mar 2003 22:50:14 +0100 (MET)
Message-Id: <UTC200303202150.h2KLoEl09978.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] alternative dev patch
Cc: Andries.Brouwer@cwi.nl, akpm@digeo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Zippel <zippel@linux-m68k.org>

> Here is a more detailed explanation of the patch

Thanks!

However, I am unconvinced.

(i)
There was some unused code, and you decide to start using that
in order to speed up the open() of a chardev. Is that urgent?
Is the speed of opening a chardev a bottleneck?
I think something is wrong with this philosophy.
Look at what happens on open("/dev/ttyS1") - there is a hash
lookup of the "dev", then a hash lookup of the "ttyS1", then
we find that this is device (4,65) and do a hash lookup for
(4,65). You want to eliminate this last hash lookup by building
infrastructure to cache it? That is possible of course.
Some extra code, an extra slab cache, a field i_cdev in struct inode,
a semaphore, refcounting..
I have not benchmarked anything but it sure feels like a lot of
machinery to avoid a simple hash lookup.

I very much doubt that Al had speeding up the open() in mind when
he wrote that (so far unused) infrastructure.

(ii)
> Further he introduces a new function register_chrdev_region(),
> which is only needed by the tty code and rather hides the problem
> than solves it.

What does one want? A driver announces the device number regions
that it wants to cover. Simple and straightforward.
Hardly a new idea. How is this done for block devices?
Using blk_register_region(). How is register_chrdev_region()
hiding problems? It eliminates the tty kludges that you only
move to a different file.

[Al muttered for an entirely different reason:
He wants to specify the region like "dev_t dev, unsigned long range",
where I left the parts of dev separate. I plan (eventually, there is
no hurry) to turn the dev_t here into a kdev_t since that is much
faster, and once that is done both blk_register_region() and
register_chrdev_region() can get a kdev_t as first parameter.]

(iii)
> this patch helps drivers to manage them without huge tables
> (this latter part is also missing in Andries patch).

I am not sure I understand. Where are these huge tables?
And how did you remove them?

Andries
