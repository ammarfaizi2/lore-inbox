Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbTLWMez (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 07:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbTLWMez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 07:34:55 -0500
Received: from fw.osdl.org ([65.172.181.6]:23194 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265117AbTLWMev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 07:34:51 -0500
Date: Tue, 23 Dec 2003 04:34:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Giacomo A. Catenazzi" <cate@debian.org>
cc: Florian Weimer <fw@deneb.enyo.de>, jw schultz <jw@pegasys.ws>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: SCO's infringing files list
In-Reply-To: <3FE811E3.6010708@debian.org>
Message-ID: <Pine.LNX.4.58.0312230317450.12483@home.osdl.org>
References: <1072125736.1286.170.camel@duergar> <200312221519.04677.tcfelker@mtco.com>
 <Pine.LNX.4.58.0312221337010.6868@home.osdl.org> <20031223002641.GD28269@pegasys.ws>
 <20031223092847.GA3169@deneb.enyo.de> <3FE811E3.6010708@debian.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Dec 2003, Giacomo A. Catenazzi wrote:

> Florian Weimer wrote:
> > 
> > The comments were added in Linux 0.99.1, and I'm not sure what was the
> > source.

No, the comments are already there in 0.97 (and they are _not_ in
0.96c-pl2, which is the last patch before that that I have found).

The timeline looks like (this is by no means guaranteed correct, the dates
are from things like the patch files that may not be the originals, but 
they look consistent):

 0.96c:		July 4th, 1992
 0.96c-pl1:	July 11th
 0.96c-pl2:	July 18th

	--- here somewhere ---

 0.97:		Aug 1st


The errno change was apparently done on or around July 25, 1992. That's
the date on the "errno.h" file in the linux-0.97 archive, and it is
consistent with the above release dates.

If anybody has newgroup/mailing list archives from around that time, it
would be very nice to see what that finds..

> >	  For example, Linux has:
> > 
> > #define ENOTTY          25      /* Not a typewriter */

My _suspicion_ is that it comes from "strerror()". That's how I'd
personally have done it (ie write a simple script to generate the errno
values and the comments). But this is over a decade ago, and I sure as 
hell can't remember who would have done that.

It might even have been me, but I doubt it - I've never been that big into
comments, so it's likely somebody else was more motivated than me to make 
errno.h cleaner. But if I did it, I definitely would have done it with a 
script.

Btw: there is some incidental "evidence" that that original 0.97 version
of <linux/errno.h> is automatically generated: the thing looks to have
very regular whitespace. It looks like it was generated with

	#define\t%s\t\t%2d\t/* %s */

and then tab-corrected for the symbolic name lengths. There are no spaces 
at ends-of-lines, and _all_ of the spaces between "define" and the actual 
error mnemonic are actually _tabs_.

And this is true for _all_ the Exxxx defines _except_ for the two special
kernel entries: ERESTARTSYS and ERESTARTNOINTR were clearly not generated
the same way, because they have a regular _space_ between the #define and
the EXXXX.

That just makes me go "hmm..". You can't actually see the TAB vs <space> 
thing when you open the file normally, because they both end up being 
aligned the same way. So I'd suspect a script that generated the 
list of the "normal" error codes simply because

 - people just aren't that regular by hand
 - most people would use a space in between #define and XXXX, as also 
   shown by the two cases that clearly are _not_ scripted.

For example, grepping for "#define" followed by space shows up 1836 such
entries in the 0.97 kernel. In contrast, doing the same for "#define"  
followed by a tab shows 227 such entries - of which the errno.h ones are a
solid block of 121 entries, while the others are a lot more random (and 44
of the remaining ~100 cases have multiple tabs and are thus _visible_ as
such).

So just from a regularity standpoint, it does look auto-generated.

> > Solaris:
> > 
> > #define ENOTTY  25      /* Inappropriate ioctl for device       */
> > 
> > Current POSIX:
> > 
> >     [ENOTTY]
> >         Inappropriate I/O control operation.
> > 
> > I couldn't find any historic Minix header files.  Minix 2 has:
> > 
> > #define ENOTTY        (_SIGN 25)  /* inappropriate I/O control operation */

The "Not a typewriter" thing is the obvious one from just reading the
error number mnemonic. Hard to tell where it comes from, but it definitely
does not rule out strerror() in that timeframe.

> In 
> http://www.opensource.apple.com/darwinsource/DevToolsMay2002/gcc-937.2/libiberty/strerror.c
> 
> /* Extended support for using errno values.
>     Written by Fred Fish.  fnf@cygnus.com
>     This file is in the public domain.  --Per Bothner.  */
> (...)
> #if defined (ENOTTY)
>    ENTRY(ENOTTY, "ENOTTY", "Not a typewriter"),
> #endif

Something like that may well be the source of the string. Fred Fish was 
active long before this timeframe (if it's the same Fred Fish - he used to 
do freeware collections for the Amiga in the '80's).

But there were multiple libc's around (estdio, libc5, glibc..), and it 
could be any of them.

Trying to find the kernel list archives from that timeframe would likely
clarify the issue. There were several lists back then: "linux-activists"  
mailing list, and of course the "comp.os.linux" newsgroup (this was before
it split into multiple newsgroups).

I've found some archives for linux-activists, but no newsgroup archives 
going that far back.. Anybody?

			Linus
