Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316253AbSEKSTo>; Sat, 11 May 2002 14:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316256AbSEKSTo>; Sat, 11 May 2002 14:19:44 -0400
Received: from bitmover.com ([192.132.92.2]:23718 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S316253AbSEKSTm>;
	Sat, 11 May 2002 14:19:42 -0400
Date: Sat, 11 May 2002 11:19:35 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
        Andrew Morton <akpm@zip.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT performance impact on 2.4.18 (was: Re: [PATCH] 2.5.14 IDE 56)
Message-ID: <20020511111935.B30126@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Gerrit Huizenga <gh@us.ibm.com>, Lincoln Dale <ltd@cisco.com>,
	Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <E176LG9-0002cP-00@w-gerrit2> <Pine.LNX.4.44.0205111047280.2355-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 11:04:45AM -0700, Linus Torvalds wrote:
> The thing that has always disturbed me about O_DIRECT is that the whole
> interface is just stupid, and was probably designed by a deranged monkey
> on some serious mind-controlling substances [*].
> 
> I bet you could get _better_ performance more cleanly by splitting up the
> actual IO generation and the "user-space mapping" thing sanely. For
> example, if you want to do an O_DIRECT read into a buffer, there is no
> reason why it shouldn't be done in two phases:

You're only halfway right.  You want to avoid the mmap altogether.  To see
why, postulate that you have infinitely fast I/O devices (I know that's
not true but it's close enough if you get enough DMA channels going at
once, it doesn't take very many to saturate memory).  For any server
application, now all your time is in the mmap().  And there is no need
for it in general, it's just there because the upper layer of the system
is too lame to handle real page frames.

Go read the splice notes, ftp://bitmover.com/pub/splice.ps because those
were written after we had tuned things enough in IRIX that it was the
VM manipulations that became the bottleneck.

Another way to think of it is this: figure out how fast the hardware could
move the data.  Now make it go that fast.  Unless you can hide all the
VM crud somehow, you won't achieve 100% of the hardware's capability.

I know I've done a bad job explaining the splice crud, but there is 
some pretty cool stuff in there, if you really got it, you'd see how
the server stuff, the database stuff, the aio stuff, all I/O of any
kind can be done in terms of the splice:pull() and splice:push()
interfaces and that it is the absolute lowest cost way to have a
generic I/O layer.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
