Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311145AbSCMUI5>; Wed, 13 Mar 2002 15:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311140AbSCMUIr>; Wed, 13 Mar 2002 15:08:47 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:59148 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311145AbSCMUI2>; Wed, 13 Mar 2002 15:08:28 -0500
Message-ID: <3C8FB15B.67953DDD@zip.com.au>
Date: Wed, 13 Mar 2002 12:06:51 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.6: ide driver broken in PIO mode
In-Reply-To: <a6o30m$25j$1@penguin.transmeta.com> <Pine.LNX.4.10.10203131001230.19703-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> 
> ...
> Suparna understands the problem and it is a solution I have described,
> and I have been working with her on a solution but I suspect you will not
> take it.  Because it requires an in process operation of traversing
> several BIOS' in order to statisfy the hardware atomic.

I think I understood the problem a couple of days ago.  Let
me try to express it:

For a PIO-mode transfer, the driver needs to pump (say) 8192
bytes under CPU control into the host controller.  Later, an
interrupt comes back from the device which says "that worked",
or "I/O error".

So clearly the driver has to not signal completion against those
8192 bytes until the interrupt comes in.

So the driver needs to hang on to those 8192 bytes.

And those 8192 bytes may be represented by two vectors in a single
BIO.  That's OK.  The problem occurs when those 8192 bytes are
encapsulated in *mutliple* BIOs in a single request.  This is the
common case.

Apparently, the interface which is offered to the device driver
requires that the driver signal completion against the Nth BIO
before the driver can advance onto the N+1th BIO in the request.
As a consequence of this, the driver is accidentally signalling
completion against the Nth BIO *before* that interrupt has come
back.  So we're telling userspace that the read or write was OK
before we actually know that this is true.

So it seems that the IDE driver currently has some non-working
workarounds in place for this problem.

Andre, is this an accurate description?

If so, then it would seem that either

a) Someone needs to tell Andre (in simple, storage-person terms :))
   what the recommended workaround is or

b) The block layer needs to be extended so the driver can walk
   all the request's segments prior to signalling completion
   against any of them.

-
