Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318195AbSGQCUn>; Tue, 16 Jul 2002 22:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318196AbSGQCUm>; Tue, 16 Jul 2002 22:20:42 -0400
Received: from mail.eskimo.com ([204.122.16.4]:42257 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S318195AbSGQCUl>;
	Tue, 16 Jul 2002 22:20:41 -0400
Date: Tue, 16 Jul 2002 19:22:52 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717022252.GA30570@eskimo.com>
References: <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 02:03:02AM +0100, Alan Cox wrote:
> On Wed, 2002-07-17 at 00:22, Zack Weinberg wrote:
> 
> > There's also an ugly semantic bind if you make close detect errors.
> > If close returns an error other than EBADF, has that file descriptor
> > been closed?  The standards do not specify.  If it has not been
> > closed, you have a descriptor leak.  But if it has been closed, it is
> > too late to recover from the error.  [As far as I know, Unix
> > implementations generally do close the descriptor.]
> 
> If it bothers you close it again 8)

Consider:

Two threads share the file descriptor table.  

  1. Thread 1 performs close() on a file descriptor.  close fails.
  2. Thread 2 performs open().
* 3. Thread 1 performs close() again, just to make sure.


open() may return any file descriptor not currently in use.

Is step 3 necessary?  Is it dangerous?  The question is, is close
guaranteed to work, or isn't it?


Case 1: Close is guaranteed to close the file.

Thread 2 may have just re-used the file descriptor.  Thus, Thread 1
closes a different file in step 3.  Thread 2 is now using a bad file
descriptor, and becomes very angry because the kernel just said all was
right with the world, and then claims there was a mistake.  Thread 2
leaves in a huff.


Case 2: Close is guaranteed to leave the file open on error.

Thread 2 can't have just re-used the descriptor, so the world is ok in
that sense.  However, Thread 1 *must* perform step 3, or it leaks a
descriptor, the tables fill, and the world becomes a frozen wasteland.


Case 3: Close may or may not leave it open due to random chance or
filesystem peculiarities.

Thread 1 may be required to close it twice, or it may be required not to
close it twice.  It doesn't know!  Night is falling!  The world is in
flames!  Aaaaaaugh!


I believe this demonstrates the need for a standard, one way, or the
other.  :-)

-J
