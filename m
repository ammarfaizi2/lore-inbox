Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283488AbRLFPYn>; Thu, 6 Dec 2001 10:24:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284091AbRLFPYY>; Thu, 6 Dec 2001 10:24:24 -0500
Received: from dsl-213-023-038-110.arcor-ip.net ([213.23.38.110]:64018 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S283745AbRLFPYM>;
	Thu, 6 Dec 2001 10:24:12 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nathan Scott <nathans@sgi.com>, Linus Torvalds <torvalds@transmeta.com>,
        Alexander Viro <viro@math.psu.edu>, Andi Kleen <ak@suse.de>,
        Andreas Gruenbacher <ag@bestbits.at>
Subject: Re: [PATCH] Revised extended attributes interface
Date: Thu, 6 Dec 2001 16:25:41 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@oss.sgi.com
In-Reply-To: <20011205143209.C44610@wobbly.melbourne.sgi.com> <E16Boqr-0000m9-00@starship.berlin> <20011206164131.F50483@wobbly.melbourne.sgi.com>
In-Reply-To: <20011206164131.F50483@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16C0PD-0000ot-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On December 6, 2001 06:41 am, Nathan Scott wrote:
> hey there.
> 
> > I still don't like the class parsing inside the kernel, it's hard to see
> > what is good about that.
> 
> I guess it ultimately comes down to simplicity.  The IRIX interfaces
> have this separation of name and namespace - each operation has to
> indicate which namespace is to be used.  That becomes very messy when
> you wish to work with multiple attribute names and namespaces at once.
> Since the namespace is intimately tied to the name anyway, this idea
> of specifying the two components together provides very clean APIs.

Right now we have two namespaces, user and system.  That's one bit of 
information, and the proposal is to represent it with 5-7 bytes, passing it 
on every call, and decoding it with a memcmp or similar.  This is just extra 
fluff as far as I can see, and provides every bit as much opportunity for 
implementing a private API as the original cmd parameter did, by encoding 
whatever one pleases before the dot.

> The term "parsing" is a bit of an overstatement too.  We're talking
> strncmp() complexity here, not lex/yacc. ;)  And its not clear that
> you can get out of doing that level of parsing in the kernel anyway
> (unless you go for a binary namespace representation, and that's a
> real can of worms).

I'm suggesting we take a look at that.

> > Is there a difference between these two?:
> > 
> >    long sys_setxattr(char *path, char *name, void *value, size_t size, 
int flags)
> >    long sys_lsetxattr(char *path, char *name, void *value, size_t size, 
int flags)
> > 
> 
> Yes, definately.  The easiest reason - there are filesystems which
> support extended attributes on symlinks already (XFS does), coming
> from other operating systems, and there should be a way to get at
> that information too.

OK, well it looks like you're going a little overboard here in dividing out 
the functionality.  What you're talking about is 'follow symlink or not', 
right?  That really does sound to me as though it's naturally expressed with 
a flag bit.  I really don't see a compelling reason to go beyond 8 syscalls:

  get, fget, set, fset, del, fdel, list, flist

--
Daniel
