Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423124AbWJYI2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423124AbWJYI2d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423132AbWJYI2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:28:32 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16314 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1423124AbWJYI23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:28:29 -0400
Subject: Re: [PATCH] Use extents for recording what swap is allocated.
From: Nigel Cunningham <ncunningham@linuxmail.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20061025081135.GM5851@elf.ucw.cz>
References: <1161576857.3466.9.camel@nigel.suspend2.net>
	 <200610242208.34426.rjw@sisk.pl> <20061024213402.GC5662@elf.ucw.cz>
	 <1161728153.22729.22.camel@nigel.suspend2.net>
	 <20061024221950.GB5851@elf.ucw.cz>
	 <1161729027.22729.37.camel@nigel.suspend2.net>
	 <20061025081135.GM5851@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 25 Oct 2006 18:28:27 +1000
Message-Id: <1161764907.22729.86.camel@nigel.suspend2.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2006-10-25 at 10:11 +0200, Pavel Machek wrote:
> Hi!
> 
> > > > That's right. In using this, we're relying on the fact that the swap
> > > > allocator tries to act sensibly. I've only seen worse case performance
> > > > when a user had two swap devices with the same priority (striped), but
> > > > that was a bug. :)
> > > 
> > > Ok, but if the allocator somehow manages to stripe between two swap
> > > devices, what happens?
> > > 
> > > IIRC original code was something like .1% overhead (8bytes per 4K, or
> > > something?), bitmaps should be even better. If it is 1% in worst case,
> > > that's probably okay, but it would be bad if it had overhead bigger
> > > than 10times original code (worst case).
> > 
> > With the code I have in Suspend2 (which is what I'm working towards),
> > the value includes the swap_type, so there's no overlap. Assuming the
> > swap allocator does it's normal thing and swap allocated is contiguous,
> > you'll probably end up with two extents: one containing the swap
> > allocated on the first device, and the other containing the swap
> > allocated on the second device. So (with the current version), striping
> > would use 6 * sizeof(unsigned long) instead of 3 * sizeof(unsigned
> > long).
> 
> And now, can you do same computation assuming the swap allocator goes
> completely crazy, and free space is in 1-page chunks?

The worst case is 3 * sizeof(unsigned long) *
number_of_swap_extents_allocated bytes.

> In particular, how much swap space can we have before we run out of
> low memory? What is the overhead compared to bitmaps?

That depends on a lot of things: the size of swap space, the amount of
low memory available to begin with and so on.

I would simply say that 

1) the likelihood of the worst case is extremely low, particularly in an
age where swapspace is generally useless except for in suspending to
disk. If it was higher, your question would be much more poignant;

2) if the worst case happens, we should handle it properly, backing out,
freeing whatever we've allocated and returning control to the user, just
as we should if allocating a bitmap were to fail.

Regards,

Nigel

