Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSGQEgg>; Wed, 17 Jul 2002 00:36:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318211AbSGQEgf>; Wed, 17 Jul 2002 00:36:35 -0400
Received: from mail.eskimo.com ([204.122.16.4]:5646 "EHLO mail.eskimo.com")
	by vger.kernel.org with ESMTP id <S318209AbSGQEgd>;
	Wed, 17 Jul 2002 00:36:33 -0400
Date: Tue, 16 Jul 2002 21:38:53 -0700
To: Stevie O <stevie@qrpff.net>
Cc: Elladan <elladan@eskimo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Zack Weinberg <zack@codesourcery.com>, linux-kernel@vger.kernel.org
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
Message-ID: <20020717043853.GA31493@eskimo.com>
References: <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <20020716232225.GH358@codesourcery.com> <1026867782.1688.108.camel@irongate.swansea.linux.org.uk> <5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020717001624.00ab8c00@whisper.qrpff.net>
User-Agent: Mutt/1.3.28i
From: Elladan <elladan@eskimo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 17, 2002 at 12:17:40AM -0400, Stevie O wrote:
> At 07:22 PM 7/16/2002 -0700, Elladan wrote:
> >  1. Thread 1 performs close() on a file descriptor.  close fails.
> >  2. Thread 2 performs open().
> >* 3. Thread 1 performs close() again, just to make sure.
> >
> >
> >open() may return any file descriptor not currently in use.
> 
> I'm confused here... the only way close() can fail is if the file
> descriptor is invalid (EBADF); wouldn't it be rather stupid to close()
> a known-to-be-bad descriptor?

Well, obviously, if that's the case.  However, the man page for close(2)
doesn't agree (see below).  close() is allowed to return EBADF, EINTR,
or EIO.

The question is, does the OS standard guarantee that the fd is closed,
even if close() returns EINTR or EIO?  Just going by the normal usage of
EINTR, one might think otherwise.  It doesn't appear to be documented
one way or another.

Alan said you could just issue close again to make sure - the example
shows that this is not the case.  A second close is either required or
forbidden in that example - and the behavior has to be well defined or
you won't know which to do.

-J

NAME
       close - close a file descriptor

SYNOPSIS
       #include <unistd.h>

       int close(int fd);

DESCRIPTION
       close closes a file descriptor, so that it no longer refers
       to any file and may be reused. Any locks held on the file it
       was associated with, and owned by the process, are removed
       (regardless of the file descriptor that was used to obtain the
       lock).

       If fd is the last copy of a particular file descriptor the
       resources associated with it are freed; if the descriptor was the
       last reference to a file which has been removed using unlink(2)
       the file is deleted.

RETURN VALUE
       close returns zero on success, or -1 if an error occurred.

ERRORS
       EBADF  fd isn't a valid open file descriptor.

       EINTR  The close() call was interrupted by a signal.

       EIO    An I/O error occurred.

CONFORMING TO
       SVr4,  SVID,  POSIX,  X/OPEN,  BSD 4.3.  SVr4 documents an
       additional ENOLINK error condition.

NOTES
       Not checking the return value of close is a common but
       nevertheless serious programming error.  File system
       implementations which use techniques as `write-behind' to
       increase performance may lead to write(2) succeeding, although
       the data has not been written yet.  The error status may be
       reported at a later write operation, but it is guaranteed to be
       reported on closing the file.  Not checking the return value when
       closing the file may lead to silent loss of data.  This can
       especially be observed with NFS and disk quotas.

       A successful close does not guarantee that the data has
       been successfully saved to  disk, as the kernel defers
       writes.  It is not common for a filesystem to flush the
       buffers when the stream is closed. If you need to be sure
       that the data is physically stored use fsync(2) or
       sync(2), they will get you closer to that goal (it will
       depend on the disk hardware at this point).

SEE ALSO
       open(2), fcntl(2), shutdown(2), unlink(2), fclose(3)
