Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281160AbRK3XNj>; Fri, 30 Nov 2001 18:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281166AbRK3XNa>; Fri, 30 Nov 2001 18:13:30 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:55450 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S281160AbRK3XNL>;
	Fri, 30 Nov 2001 18:13:11 -0500
Date: Fri, 30 Nov 2001 18:12:55 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: "David C. Hansen" <dave@sr71.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: [PATCH] remove BKL from drivers' release functions
In-Reply-To: <3C07E04A.7020301@sr71.net>
Message-ID: <Pine.GSO.4.21.0111301747160.7125-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 30 Nov 2001, David C. Hansen wrote:

> Alexander Viro wrote:
>  > ->release() is not serialized AT ALL.  It is serialized for given
>  > struct file, but call open(2) twice and you've got two struct file
>  > for the same device. close() both and you've got two calls of
>  > ->release(), quite possibly - simultaneous.
> OK, that clears some things up.  So, the file->fcount is only used in 
> cases where the file descriptor was dup'd, right?

Think for a minute - current IO position is in file->f_pos.  So if two
descriptors have independent current positions (lseek() on one of them
doesn't affect another) they have to have different instances of
struct file behind them.

struct file is an opened channel
descriptor refers to opened channel
file->f_count is the number of references to _this_ channel
dup() creates a descriptor refering to the same channel
so does fork()
open() creates a new channel and descriptor refering to it.

That difference between descriptors and opened channels exists in any
UNIX - otherwise you would either have lseek() done in one program
screwing everybody else or (if fork would create new channels instead
of new references to channels) have (ls; ls) > foo break (shell opens
foo and both ls(1) inherit it over fork(); you _really_ want changes
in current positions resulting from the first ls to affect the
stdout of the second one).
 
> back to Alexander  Viro:
>  > In other words, patch is completely bogus.
> No, not completely.  In a lot of cases we just replaced some regular 
> arithmetic with atomic instructions of some sort.  These changes are 
> still completely valid.  But, in the cases where we added locking, we 

Valid, but not necessary a good idea.  Notice that there are very real
races in ->release() and ->open() instances.  Removing BKL from these
(or replacing it with atomic operations) doesn't fix the existing race.
Moreover, it creates a false impression that thing had been reviewed
and fixed.

> need to reevaluate them for potential problem.  In the cases where we 
> just removed the BKL, we really need to check them to make sure that we 
> didn't introduce anything.

You really need that in all cases.  Sorry for "told you so", but that's
what I'd been trying to explain from the very beginning - back when the
idea of that patch had been discussed the first time.  That work really
has to be done driver-by-driver...

