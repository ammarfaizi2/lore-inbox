Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283586AbRK3J56>; Fri, 30 Nov 2001 04:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRK3J5j>; Fri, 30 Nov 2001 04:57:39 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:12025 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283586AbRK3J5b>;
	Fri, 30 Nov 2001 04:57:31 -0500
Date: Fri, 30 Nov 2001 04:57:28 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David C. Hansen" <haveblue@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <3C057410.3090201@us.ibm.com>
Message-ID: <Pine.GSO.4.21.0111300444180.13367-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Nov 2001, David C. Hansen wrote:

> Alan Cox wrote:
> 
> >The release function was only partially serialized - what stops a release
> >and an open racing each other ? That in several cases was why the lock
> >was there. 

->release() is not serialized AT ALL.  It is serialized for given struct file,
but call open(2) twice and you've got two struct file for the same device.
close() both and you've got two calls of ->release(), quite possibly -
simultaneous.

> Nothing, because the BKL is not held for all opens anymore.  In most of 

RTFS.  fs/devices.c::chrdev_open().

> the cases that we addressed, the BKL was in release _only_, not in open 
> at all.  There were quite a few drivers where we added a spinlock, or 

See above.

> used atomic operations to keep open from racing with release.  

Right.  Including quite a few where you schedule under that spinlock.

In other words, patch is completely bogus.  BKL removal may be a good
idea, but you really need to audit the code.  Which requires at least
some understanding of the things you are doing.  There _are_ races
and they need to be dealt with.  But blind BKL removal doesn't fix any
and breaks quite a few places where the code was actually correct.

