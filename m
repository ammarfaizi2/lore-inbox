Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSETCDH>; Sun, 19 May 2002 22:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSETCDG>; Sun, 19 May 2002 22:03:06 -0400
Received: from sydney1.au.ibm.com ([202.135.142.193]:51979 "EHLO
	wagner.rustcorp.com.au") by vger.kernel.org with ESMTP
	id <S315709AbSETCDG>; Sun, 19 May 2002 22:03:06 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap. 
In-Reply-To: Your message of "Sun, 19 May 2002 11:29:06 MST."
             <Pine.LNX.4.44.0205191125120.3104-100000@home.transmeta.com> 
Date: Mon, 20 May 2002 12:06:07 +1000
Message-Id: <E179cYq-0004I3-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0205191125120.3104-100000@home.transmeta.com> you wri
te:
> 
> 
> On Sat, 18 May 2002, Benjamin Herrenschmidt wrote:
> >
> > Looking at generic_file_write(), it ignore the count returned by
> > copy_from_user and always commit a write for the whole requested
> > count, regardless of how much could actually be read from userland.
> > The result of copy_from_user is only used as an error condition.
> 
> And this is exactly what makes it re-startable.

If read always returns the amount read (ignoring any copy_to_user
errors), then you can repeat it by seeking backwards[1] and redoing the
read.

So copy_to_user can simply deliver a SIGSEGV and return "success", and
everything will work (except sockets, pipes, etc).

Is this satisfactory?  I'd really like to get rid of 5,500 code paths
in the kernel...

BTW, SuSv3/POSIX.1.2001 says it's OK,
Rusty.
[1] No, this won't work on pipes & sockets, but the whole idea won't
work on many devices anyway...
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
