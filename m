Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271820AbRH1QkE>; Tue, 28 Aug 2001 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271818AbRH1Qjy>; Tue, 28 Aug 2001 12:39:54 -0400
Received: from relay1.zonnet.nl ([62.58.50.37]:54187 "EHLO relay1.zonnet.nl")
	by vger.kernel.org with ESMTP id <S271817AbRH1Qjl>;
	Tue, 28 Aug 2001 12:39:41 -0400
Message-ID: <3B8BC94F.207E86EA@linux-m68k.org>
Date: Tue, 28 Aug 2001 18:39:43 +0200
From: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [IDEA+RFC] Possible solution for min()/max() war
In-Reply-To: <Pine.LNX.4.33.0108280732560.8585-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Linus Torvalds wrote:

> I'll show you a real example from drivers/acorn/scsi/acornscsi.c:
> 
>         min(host->scsi.SCp.this_residual, DMAC_BUFFER_SIZE / 2);
> 
> this_residual is "int", and "DMAC_BUFFER_SIZE" is just a #define for
> an integer constant. So the above is actually a signed comparison, and
> I'll bet you that was not what the author intended.
> 
> Now, this_residual is hopefully never negative, so it doesn't matter.

Let's assume it does. Joe Hacker uses the new min macro and uses int
because this_residual is an int. Later he realizes that this_residual
must be an unsigned int. Will he now also automatically change the type
in the min macro?

> But how many security bugs have you seen where people just didn't even
> _think_ of the user giving invalid values?
> 
> Think of code like
> 
>         #define BUFFER_SIZE (10)
> 
>         char buf[BUFFER_SIZE];
> 
>         len = min(user_len, BUFFER_SIZE);
>         if (copy_from_user(buf, user, len))
>                 return -EFAULT;
> 
> which is not all that broken. Sure, maybe you _should_ have marked
> BUFFER_SIZE explicitly unsigned, but face it, how many people actually do
> that?

How does the new macro help here? A negative value is invalid and so
should be tested _explicitly_.

What about code like this:

	if (len > BUFFER_SIZE)
		return -EINVAL;

This is not automagically fixed by this macro. So your new macro fixes a
few problems and hides other problems. I can't call this a solution.

> And did you realize, for example, that of the existing "min()"
> implementations, some were inline functions that implicitly cast their
> arguments to "int" (and one to "unsigned int")? This way we could also
> maintain those kinds of local conventions - where the programmer had
> originally (at least in the case of the unsigned int) on purpose made all
> "min()" functions unsigned.

I'm not arguing against a single (and correct) definition of min/max.
This had to be fixed of course.

> Now isn't it better to have a nice macro that _can_ be used for all of
> this, and that _does_ explicitly handle the issue of signedness that
> different parts of the code has very different opinions on, and that
> clearly encodes the assumptions that you have at the exact point of use?

But this assumption is only encoded once. Are you going to change the
min interface every second release, just to keep people thinking about
the types they're using? Breaking interfaces is fine, but it only works
_once_ and is simply forgotten afterwards. To quote my other argument,
that is still unanswered:

You maybe fixed a few bugs, but this new macro will only cause new
problems in the future. If we change only a single type, you have to
scan all min/max users if they possibly need to be changed too. Thanks
to the cast, the compiler won't even remotely help you finding them.

bye, Roman
