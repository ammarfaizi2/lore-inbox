Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSGHGaJ>; Mon, 8 Jul 2002 02:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315784AbSGHGaI>; Mon, 8 Jul 2002 02:30:08 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:10635 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315611AbSGHGaH> convert rfc822-to-8bit; Mon, 8 Jul 2002 02:30:07 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: BKL removal
Date: Mon, 8 Jul 2002 08:34:09 +0200
User-Agent: KMail/1.4.1
Cc: Thunder from the hill <thunder@ngforever.de>, Greg KH <greg@kroah.com>,
       kernel-janitor-discuss 
	<kernel-janitor-discuss@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207071702120.10105-100000@hawkeye.luckynet.adm> <200207080131.06119.oliver@neukum.name> <3D28D291.3020706@us.ibm.com>
In-Reply-To: <3D28D291.3020706@us.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207080834.09231.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > The BKL, unless used unbalanced, can never cause a bug. It could be
>  > insufficient or superfluous, but never be really buggy in itself.
>
> Does incredibly high lock contention qualify as a bug?

Only if it occurs at a place that is used often. Even then it's
a minor bug, while a race is always a race.

>  >> Is it really okay to "lock the whole kernel" because of one
>  >> struct file? This brings us back to spinlocks...
>  >>
>  >> You're possibly right about this one. What did Greg K-H say?
>  >
>  > I don't speak for Greg, but in this example it could be dropped
>  > IMO. The spinlock protects the critical section anyway. As a rule,
>  > if you do a kmalloc without GFP_ATOMIC under BKL you are doing
>  > either insufficient locking (you may need a semaphore) or useless
>  > locking.
>
> Don't forget that the BKL is released on sleep.  It is OK to hold it

Exactly therefore it won't protect you from reentrance if you do
something that sleeps. If that's the case, you've found a race condition.

> over a schedule()able operation.  If I remember right, there is no
> real protection needed for the file->private_data either because there
> is 1 and only 1 struct file per open, and the data is not shared among
> struct files.

But between threads. Anyway, this was an open, if you use struct file
before open returns even the BKL can't help you.

>  > This should have been posted on linux-usb long ago.
>
> I just pulled it out of thin air 10 minutes ago!

Yes, I understand. But this is a symptom. We should have heard
about it.
You need to understand that people who run UP mostly won't
care about SMP beyond making sure that the drivers are SMP-safe.
This is not true for core kernel code, but for devices outside
the block layer and perhaps some network drivers, that's the case.

So you do the greps and question locking usage on the right lists.
It's quite important, you might uncover bugs and speed up the kernel.
And you need to be persistent about it. Take your time to find out why
the lock is used. Or why it makes no sense.
You should be able to improve the locking situation that way, with respect
to BKL contention and driver quality.

	Regards
		Oliver

