Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315427AbSGQQrO>; Wed, 17 Jul 2002 12:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSGQQrO>; Wed, 17 Jul 2002 12:47:14 -0400
Received: from mail.eskimo.com ([204.122.16.4]:12300 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S315427AbSGQQrM>;
	Wed, 17 Jul 2002 12:47:12 -0400
Date: Wed, 17 Jul 2002 09:49:33 -0700
To: Andreas Schwab <schwab@suse.de>
Cc: Elladan <elladan@eskimo.com>, Stevie O <stevie@qrpff.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717164933.GA2136@eskimo.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net> <20020717043853.GA31493@eskimo.com> <je65zel8pr.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <je65zel8pr.fsf@sykes.suse.de>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 04:39:28PM +0200, Andreas Schwab wrote:
> Elladan <elladan@eskimo.com> writes:
> 
> |> On Wed, Jul 17, 2002 at 12:17:40AM -0400, Stevie O wrote:
> |> > At 07:22 PM 7/16/2002 -0700, Elladan wrote:
> |> > >  1. Thread 1 performs close() on a file descriptor.  close fails.
> |> > >  2. Thread 2 performs open().
> |> > >* 3. Thread 1 performs close() again, just to make sure.
> |> > >
> |> > >
> |> > >open() may return any file descriptor not currently in use.
> |> > 
> |> > I'm confused here... the only way close() can fail is if the file
> |> > descriptor is invalid (EBADF); wouldn't it be rather stupid to close()
> |> > a known-to-be-bad descriptor?
> |> 
> |> Well, obviously, if that's the case.  However, the man page for close(2)
> |> doesn't agree (see below).  close() is allowed to return EBADF, EINTR,
> |> or EIO.
> |> 
> |> The question is, does the OS standard guarantee that the fd is closed,
> |> even if close() returns EINTR or EIO?  Just going by the normal usage of
> |> EINTR, one might think otherwise.  It doesn't appear to be documented
> |> one way or another.
> 
> POSIX says the state of the file descriptor when close fails (with errno
> != EBADF) is unspecified, which means:
> 
>     The value or behavior may vary among implementations that conform to
>     IEEE Std 1003.1-2001. An application should not rely on the existence
>     or validity of the value or behavior. An application that relies on
>     any particular value or behavior cannot be assured to be portable
>     across conforming implementations.

This doesn't mean an OS shouldn't specify the behavior.  Just because
the cross-platform standard leaves it unspecified doesn't mean the OS
should.

Consider what this says, if a particular OS doesn't pick a standard
which the application can port to.  It means that the *only way* to
correctly close a file descriptor is like this:

int ret;
do {
	ret = close(fd);
} while(ret == -1 && errno != EBADF);

That means, if we get an error, we have to loop until the kernel throws
a BADF error!  We can't detect that the file is closed from any other
error value, because only BADF has a defined behavior.

This would sort of work, though of course be hideous, for a single
threaded app.  Now consider a multithreaded app.  To correctly implement
this we have to lock around all calls to close and
open/socket/dup/pipe/creat/etc...

This is clearly ridiculous, and not at all as intended.  Either standard
will work for an OS (though guaranteeing close the first time is much
simpler all around), but it needs to be specified and stuck to, or you
get horrible things like this to work around a bad spec:


void lock_syscalls();
void unlock_syscalls();

int threadsafe_open(const char *file, int flags, mode_t mode)
{
	int fd;
	lock_syscalls();
	fd = open(file, flags, mode);
	unlock_syscalls();
	return fd;
}

int threadsafe_close(int fd)
{
	int ret;
	lock_syscalls();
	do {
		ret = close(fd);
	} while(ret == -1 && errno != EBADF);
	unlock_syscalls();
	return ret;
}

int threadsafe_socket() ...
int threadsafe_pipe() ...
int threadsafe_dup() ...
int threadsafe_creat() ...
int threadsafe_socketpair() ...
int threadsafe_accept() ...

-J

