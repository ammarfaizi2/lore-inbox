Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSG1CbL>; Sat, 27 Jul 2002 22:31:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318882AbSG1CbL>; Sat, 27 Jul 2002 22:31:11 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:44172 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317907AbSG1CbJ>; Sat, 27 Jul 2002 22:31:09 -0400
Content-Type: text/plain; charset=US-ASCII
From: Robert White <rwhite@pobox.com>
Reply-To: rwhite@pobox.com
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (a ll recent versions)
Date: Sat, 27 Jul 2002 19:34:27 -0700
User-Agent: KMail/1.4.1
Cc: Russell King <rmk@arm.linux.org.uk>, Ed Vance <EdV@macrolink.com>,
       "'Theodore Tso'" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       linux-serial@vger.kernel.org
References: <11E89240C407D311958800A0C9ACF7D13A789A@EXCHANGE> <200207271507.56873.rwhite@pobox.com> <20020727232129.GA26742@win.tue.nl>
In-Reply-To: <20020727232129.GA26742@win.tue.nl>
X-Evil-Bastard: True (but nice about it)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207271934.27102.rwhite@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't have access to the truely official posix standards document (posix.org 
want's a login and ieee want's dues/subscriptions).  The manual page citation 
is common to linux and sun and was accessable to all readers, between the two 
of them, so I cited it.  Besides, I am citing back the same source as the 
quotes I was getting cited at me... 8-)

Blocking a system call for something that can't be used by the call is dumb.

Repeatedly changing the value of VMIN before each read (doubling your system 
calls/context switches) is dumb.

Having virtually every user on the planet realize this and just set VMIN == 1 
is an fairly telling indicator.

Repeatedly calling the kernel to assemble an input buffer which is necessary 
if VMIN ==1, is dumb.

Having an upper limit of 255 on the number of characters you can wait for in a 
single read, now that communications speeds are usefully large, is dumb.

The lay-programmers I have shown this too so far (a small and unprovable set, 
I know 8-) think blocking for the extra characters is an error.  This is the 
tried-and-true "rule of least astonishment".  It is "astonishing" to make a 
call read(fd,buffer,N), when you know N characters are already buffered, and 
not have it return because VMIN is bigger than N.

The fix for rounding down is one line and breaks nothing on the planet that 
anybody can find (mostly because of the default VMIN==1 everybody uses).

The rounding up part (adds one condition to the afore mentioned and one other 
conditional assignment) is more arguable but still quite a win since there 
isn't a modern serial protocol existant that uses a prefered maximum buffer 
size of less that 256 characters.

So far all I am getting back is one non-public "that's a good idea, but I want 
to see what everybody else thinks" and a bunch of "but the standard says"...

The standard is OLD and UNREALISTIC (and if you get all lawyer-ish, somewhat 
inconsitant and vague.) and the modification is one hundred percent 
compatable with what is in the field and what "more than half" of the users 
expect.

Rob.

On Saturday 27 July 2002 16:21, Andries Brouwer wrote:
> On Sat, Jul 27, 2002 at 03:07:56PM -0700, Robert White wrote:
> > I agree that that is what that line of the text says, my position is that
> > the entire statement was was written nieavely, and proveably so. 
> > Throughout the entire section the standard (not the linux manual page)
> > discusses "satisfying a read" (singular).  The text was written with an
> > "everybody will know basically what I mean" aditude that leaves it flawed
> > for strict
> > interpretation.  And the linux manual pages still show through enough to
> > use as the bases of my argument.
>
> I followed this discussion with half an eye, and do not really want
> to spend the time figuring out what my point of view would be.
>
> But.
>
> In such discussions the Linux man pages carry hardly any weight.
> Of interest are the original man pages of the system where the
> feature was introduced. And of interest is the original implementation.
> And of interest is the POSIX standard.
>
> Sometimes the POSIX author misunderstands something and writes some
> silly text into the standard. There are technical committees that
> one can approach and try to get a correction. Until such a time,
> one should read the POSIX text as written, and not as intended.
>
> Generally, Linux follows POSIX. That is good: since everybody else
> also does that, we can exchange programs. Everybody the same silliness
> has advantages over each his own correct solution.
>
> Sometimes, when following POSIX is too silly or too painful, Linux
> chooses its own way. But in such cases Linux does not follow the Linux
> man pages, it is just the other way around. So, I am afraid citing
> the Linux man pages will never give you a powerful argument.
>
> Andries
> aeb@cwi.nl
>
> [yes, I maintain the man pages; of course they are almost perfect,
> since few people have corrections; but corrections are always welcome]

