Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129348AbQK1Pqr>; Tue, 28 Nov 2000 10:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129351AbQK1Pqi>; Tue, 28 Nov 2000 10:46:38 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21314 "EHLO
        penguin.e-mind.com") by vger.kernel.org with ESMTP
        id <S129348AbQK1PqV>; Tue, 28 Nov 2000 10:46:21 -0500
Date: Tue, 28 Nov 2000 16:16:12 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Alexander Viro <viro@math.psu.edu>, kumon@flab.fujitsu.co.jp,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0"
Message-ID: <20001128161612.B14675@athlon.random>
In-Reply-To: <Pine.GSO.4.21.0011272234550.7352-100000@weyl.math.psu.edu> <200011280955.eAS9t6I22393@hawking.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200011280955.eAS9t6I22393@hawking.suse.de>; from schwab@suse.de on Tue, Nov 28, 2000 at 10:55:06AM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2000 at 10:55:06AM +0100, Andreas Schwab wrote:
> Alexander Viro <viro@math.psu.edu> writes:
> 
> |> On Tue, 28 Nov 2000, Andrea Arcangeli wrote:
> |> 
> |> > On Tue, Nov 28, 2000 at 12:10:33PM +0900, kumon@flab.fujitsu.co.jp wrote:
> |> > > If you have two files:
> |> > > test1.c:
> |> > > int a,b,c;
> |> > > 
> |> > > test2.c:
> |> > > int a,c;
> |> > > 
> |> > > Which is _stronger_?
> |> > 
> |> > Those won't link together as they aren't declared static.
> |> 
> |> Try it. They _will_ link together.
> 
> Not if you compile with -fno-common, which should actually be the default
> some day, IMHO.

I thought -fno-common was the default behaviour indeed, and I agree it should
become the default since current behaviour can lead to sublte bugs. (better I
discovered this gcc "extension" this way than after some day of debugging :)

I'm all for gcc extensions when they're powerful and useful, but this
one looks absolutely worthless. I don't see any advantage from the current
behaviour (avoid an "extern" in some include file that we have/want to write
anyways to write correct C code?), and at least in large project (like the
kernel) where different part of the project are handled by different people
using -fno-common is pretty much mandatory IMHO.

Think at somebody writing a driver starting from another driver, maybe
he renames most of the stuff but he forgets to rename an uninitialized
global variable. This bug won't trigger for him because he's not using
the other driver at the same time. It will trigger only when an unlucky
user will happen to use both drivers at the same time because he owns
both hardwares...

I disagree with GCC documentation:

`-fno-common'
     Allocate even uninitialized global variables in the bss section of
     the object file, rather than generating them as common blocks.
     This has the effect that if the same variable is declared (without
     `extern') in two different compilations, you will get an error
     when you link them.  The only reason this might be useful is if
			  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     you wish to verify that the program will work on other systems
     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
     which always work this way.
     ^^^^^^^^^^^^^^^^^^^^^^^^^^

That's one reason, but it's really not the interesting one...

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
