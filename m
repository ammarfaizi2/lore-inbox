Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265982AbUBQFME (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUBQFME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:12:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:24715 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265982AbUBQFL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:11:58 -0500
Date: Mon, 16 Feb 2004 21:11:55 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Tridgell <tridge@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16433.38038.881005.468116@samba.org>
Message-ID: <Pine.LNX.4.58.0402162034280.30742@home.osdl.org>
References: <16433.38038.881005.468116@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ Al cc'd, because while I'm pretty certain that he agrees with me 100% on 
  the craziness of case-insensitive name lookups, he may have some input
  on the "samba helper" function approach. That input may well boil down 
  to "Linus is crazy", of course. Wouldn't be the first time ;)

  Andrew - you really should assume that case insensitivity is a hell of a 
  lot more costly than you think it is, and forget that particular idea. 
  Let's see if there are acceptable half-measures. ]

On Tue, 17 Feb 2004 tridge@samba.org wrote:
>
> Given how much pain the "kernel is agnostic to charset encoding"
> attitude has cost me in terms of programming pain, I thought I should
> de-cloak from lurk mode and put my 2c into the UTF-8 issue.
> 
> Personally I think that eventually the Linux kernel will have to
> embrace the interpretation of the byte streams that applications have
> given it, despite the fact that this will be very painful and
> potentially quite complex.

I seriously doubt it. There just isn't any point.

>		 The reason is that I think that eventually
> the Linux kernel will need to efficiently support a userspace policy
> of case-insensitivity and the only way to do case-insensitive filename
> operations is to interpret those byte streams as a particular
> encoding.

The thing is, if you want to do efficient user-space case-insensitive 
lookups, that is a _completely_ different matter from having the kernel do 
case-insensitivity.

Kernel-level case insensitivity is a total disaster, and your "very
painful and potentially quite complex" assertion is the understatement of
the year. The thing is, you can't sanely do dentry caching, since the case
insensitivity has to be per-open or at least per-process (you MUST NOT be
case-insensitive in a POSIX process).

So the only way to do case-insensitive names is to do all lookups very 
slowly. I'm willing to bet that WNT opens files a hell of a lot slower 
than Linux does, and one big portion of that is exactly the fact that 
Linux can do a really good job with the dentry cache.

And that _depends_ on a well-defined and unique filename setup (by
changing the hashing function and compare function, a filesystem can do a
limited kind of case-insensitivity right now in Linux, but then it will
have to be not only fairly slow, but also case-insensitive for _everybody_
which is unacceptable in a mixed POSIX/samba environment).

In other words, just forget the whole notion. The only set people who have
any reason at _all_ to want it is the samba team, and we can solve the 
samba-specific problems other ways.

Just take that as a simple fact - case insensitivity in the kernel is such 
a horribly bad idea, that you really shouldn't go there.

With that destructive criticism out of the way, let's look at somewhat 
more constructive approaches, ie some way to allow certain processes that 
need it better help in their quest for case insensitivity.

Let's start with some assumptions:

 - MOST name lookups are likely results of some kind of "readdir()" 
   lookup, and tend to have the case right in the first place. So that 
   should go fast. Maybe Tridge has some statistics on this one?

 - samba probably has certain pretty well-defined special patterns for 
   what it wants to do with a filename, do you probably don't need a 
   generic "everything that takes a filename should be case-insensitive", 
   and it would be acceptable to have a few _very_ specific system calls.

With those assumptions out of the way, we could think of an interface that
exports some partial functionality of the "lookup_path()" code the kernel
as a special system call. In particular, something that takes an input
pathname, and is able to stop at any point of the name when a lookup
fails.

So some variation of the interface

	int magic_open(
		/* Input arguments */
		const char *pathname,
		unsigned long flags,
		mode_t mode,

		/* output arguments */
		int *fd,
		struct stat *st,
		int *successful_path_length);

ie the system call would:

 - look up as far into the pathname (using _exact_ lookup) as possible
 - return the error code of the last failure
 - the "flags" could be extended so that you can specify that you mustn't 
   traverse ".." or symlinks (ie those would count as failures)

but also:

 - fill in the "struct stat" information for the last _successful_ 
   pathname component.
 - fill in the "fd" with a fd of the last _successful_ pathname component.
 - tell how much of the pathname it could traverse.

so that the user can do a "readdir" and try to "fix up" the problem
without having to restart the whole thing. For the (hopefully common case)  
where the cases match, this would just boil down to an "open with stat
information" thing.

We'd need something more interesting to guarantee unique filename on file
create, possibly even including letting a trusted process maintain some
locks in the VFS layer. The point being that the kernel can _help_ some 
specific usage, but making case-insensitive names be part of the VFS layer 
proper is not acceptable.

I suspect we can do case-insensitive names faster than WNT even with a 
fairly complex user-mode interface. Just because _not_ having them in the 
kernel allows us to have much faster default behaviour.

			Linus
