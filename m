Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbUKWSlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbUKWSlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKWSkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:40:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:4550 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261489AbUKWS3e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:29:34 -0500
Date: Tue, 23 Nov 2004 19:39:07 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in
 fs/fcntl.c
In-Reply-To: <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.61.0411231916410.3389@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost>
 <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk>
 <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004, Linus Torvalds wrote:
> 
> 
> On Tue, 23 Nov 2004, Jesper Juhl wrote:
> >
> > Linus, would you accept patches like this?
> 
> No, please don't.
> 
> The warning is sometimes useful, but when it comes to a construct like
> 
> 	if (a < 0 || a > X)
> 
> the fact that "a" is unsigned does not make the construct silly. First 
> off, it's (a) very readable and (b) the type of "a" may not be immediately 
> obvious if it's a user typedef, for example. 
> 
> In fact, the type of "a" might depend on the architecture, or even 
> compiler flags. Think about "char" - which may or may not be signed 
> depending on ABI and things like -funsigned-char.
> 
> In other places, it's not "unsigned" that is the problem, but the fact 
> that the range of a type is smaller on one architecture than another. So 
> you might have
> 
> 	inf fn(pid_t a)
> 	{
> 		if (a > 0xffff)
> 			...
> 	}
> 
> which might warn on an architecture where "pid_t" is just sixteen bits 
> wide. Does that make the code wrong? Hell no.
> 
I'm aware that there are pitfalls, one of the very first things I looked 
at was the usage of FIRST_USER_PGD_NR in mm/mmap.c:1513 On my main 
platform (i386) FIRST_USER_PGD_NR is zero which causes gcc -W to warn 
about   if (start_index < FIRST_USER_PGD_NR)   but, after seeing that it 
is not 0 on all platforms I left that one alone.


> IOW, a lot of the gcc warnings are just not valid, and trying to shut gcc 
> up about them can break (and _has_ broken) code that was correct before.
> 
Shutting up gcc is not the primary goal here, the goal is/was to  
a) review the code and make sure that it is safe and correct, and fix it 
when it is not.
b) remove comparisons that are just a waste of CPU cycles when the result 
is always true or false (in *all* cases on *all* archs).


> > I probably won't be able to properly evaluate/review *all* the instances 
> > of this in the kernel,
> 
> It's not even that I will drop the patches, it's literally that "fixing" 
> the code so that gcc doesn't complain can be a BUG. We've gone through 
> that. 
> 
I'll keep that firmly in mind and only submit patches for these kind of 
things if I find usage that is actually (provably) buggy or where it's 
completely clear that a comparison will *always* be true or false on all 
architectures and removing it does not decrease readability.
I hope that's a more resonable aproach.

Whether or not the list of potential patches is now down to zero remains 
to be seen, but it just got a hell of a lot shorter. :)

Thank you for the feedback.


--
Jesper Juhl

