Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUBQP4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 10:56:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266285AbUBQP4t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 10:56:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:20693 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266279AbUBQP4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 10:56:42 -0500
Date: Tue, 17 Feb 2004 07:56:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Marc <pcg@goof.com>
cc: Jamie Lokier <jamie@shareable.org>, Marc Lehmann <pcg@schmorp.de>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: UTF-8 practically vs. theoretically in the VFS API (was: Re:
 JFS default behavior)
In-Reply-To: <20040217071448.GA8846@schmorp.de>
Message-ID: <Pine.LNX.4.58.0402170739580.2154@home.osdl.org>
References: <200402150006.23177.robin.rosenberg.lists@dewire.com>
 <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
 <200402150107.26277.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.58.0402141827200.14025@home.osdl.org> <20040216183616.GA16491@schmorp.de>
 <Pine.LNX.4.58.0402161040310.30742@home.osdl.org> <20040216200321.GB17015@schmorp.de>
 <Pine.LNX.4.58.0402161205120.30742@home.osdl.org> <20040216222618.GF18853@mail.shareable.org>
 <Pine.LNX.4.58.0402161431260.30742@home.osdl.org> <20040217071448.GA8846@schmorp.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, Marc wrote:
> On Mon, Feb 16, 2004 at 02:40:25PM -0800, Linus Torvalds <torvalds@osdl.org> wrote:
> > Try it with a regular C locale. Do a simple
> > 
> > 	echo > едц
> 
> Just for your info, though. You can't even input these characters in a C
> locale, since your libc (and/or xlib) is unable to handle them (lots of SO
> C functions will barf on this one). C is 7 bit only.

Ehh.. It's pointless to tell me that I can't do it. I just did.

The C locale is _not_ 7-bit only. The C locale is the traditional "byte 
locale" for UNIX. It will happily collate 8-bit-characters in their 
(numerical) order. Anything else would be seriously broken.

> > Which, if you think about is, is 100% EXACTLY equivalent to what a UTF-8
> > program should do when it sees broken UTF-8.
> 
> The problem is that the very common C language makes it a pain to use
> this in i18n programs. multibyte functions or iconv will no accept
> these, so programs wanting to do what you are expecting to do need to
> re-implement most if not all of the character handling of your typical
> libc.

These are all teething problems. The thing is, true multi-locale programs
haven't been around long enough that people take the problems for granted.  
A lot of them work today, but "work" is different from "always does the
right thing". These things take a _long_ time for people to sort out the
full implications of.

(Analogy time: how many people _still_ use "find ... | xargs xxx", even
though that can lead to problems and is thus wrong?  You should really use
"find ... -print0 | xargs -0 xxx" to get it _right_, but most people
ignore that, because the common form works for most cases.)

The process is complicated by the fact that most of the people who really 
care about UTF-8 and locales are very strict about it: they have been 
hitting their heads against latin1 users for a logn time, and they are 
frustrated and _tired_ of it, and so they often hate single-byte usage 
with a passion, and consider it not only wrong but EVIL. Which is 
obviously silly, but hey, I understand why they can feel a bit put off by 
the problem.

So the multi-byte people often stare at the standards, and then _refuse_
to touch anything that isn't standards-compliant. When they see something
incorrect, they'd rather dump core (or just truncate it) than try to
handle it gracefully, becuase they want the whole world to see how
incorrect it is.

Which flies in the face of "Be strict in what you generate, be liberal in 
what you accept". A lot of the functions are _not_ willing to be liberal 
in what they accept. Which sometimes just makes the problem worse, for no 
good reason.

The fact is, you shouldn't use "iconv()" unless you controlled the input.
It's a bit like "gets()" - unsafe to use unless you generated the damn
thing yourself and you _know_ it fits in the buffer. But we just don't 
have the functions (yet) to do it _right_, and to escape the input some 
way (yeah, yeah, I know you can do it with iconv() and a lot of cruft 
around it - the point is that nobody does it, because it's too painful).

		Linus
