Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbVFIKQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbVFIKQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 06:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVFIKQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 06:16:07 -0400
Received: from alog0011.analogic.com ([208.224.220.26]:10373 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262338AbVFIKQD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 06:16:03 -0400
Date: Thu, 9 Jun 2005 06:14:05 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
cc: Peter Staubach <staubach@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arm-kernel@lists.arm.linux.org.uk
Subject: Re: Zeroed pages returned for heap
In-Reply-To: <Pine.LNX.4.44.0506080934440.4569-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0506090605190.8306@chaos.analogic.com>
References: <Pine.LNX.4.44.0506080934440.4569-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005, Nagendra Singh Tomar wrote:

> On Tue, 7 Jun 2005, Peter Staubach wrote:
>
> > Nagendra Singh Tomar wrote:
> >
> > >Hi all,
> > >	The short version first.
> > >Is it OK for an application (a C library implementing malloc/calloc is
> > >also an application) to assume that the pages returned by the OS for heap
> > >allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will
> > >be zero filled.
> > >
> >
> > An application which makes assumptions about the contents of newly allocated
> > memory would seem to be making very dangerous assumptions.
>
> Thats what glibc does. Ulrich confirmed that. I would say thats not a bad
> optimization on glibc's part as it does not really make sense to zero out
> a memory again in user space if we know for sure that new heap memory that
> kernel hands over to us will be zeroed. I'm not sure though whether this
> is a documented kernel ABI.
>
> >
> > Ignoring that, would it not be considered to be a security violation to hand
> > pieces of memory to applications without erasing the old contents of the
> > pages?
>
> I understand that for a desktop/server running Linux but not for an
> embedded box where all the applications that run on the box is controlled
> by you.
>
> Thanx,
> Tomar

The user code can't assume anything about any memory allocated
by malloc(). The first time a buffer is allocated, it may be
zero-filled because of the zeroed pages allocated by the kernel
when the new break address is set. After that, all bets are off
because once you free a buffer and allocate another one, it
will probably contain data from malloc()'s previous allocation.

Even the very first time malloc() returns a pointer, doesn't
guarantee that the memory will all be cleared. This is because
many malloc()s use just-obtained memory (via brk) to do some
house-keeping which may result in some "strange" numbers in
the memory at some places.

It is extremely bad coding practice to assume a buffer is
zero filled when writing user-mode code. That's why we have
calloc().


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
 Notice : All mail here is now cached for review by Dictator Bush.
                 98.36% of all statistics are fiction.
