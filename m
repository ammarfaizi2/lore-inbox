Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbTKTVte (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:49:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTKTVtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:49:33 -0500
Received: from gaia.cela.pl ([213.134.162.11]:34572 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S263064AbTKTVta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:49:30 -0500
Date: Thu, 20 Nov 2003 22:48:26 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Jesse Pollard <jesse@cats-chateau.net>
cc: Florian Weimer <fw@deneb.enyo.de>, <Valdis.Kletnieks@vt.edu>,
       Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <03112013081700.27566@tabby>
Message-ID: <Pine.LNX.4.44.0311202206530.10515-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Assume 'fast'copy(int fd_in, int fd_out) where fd_in and fd_out reference
files.  fd_in is opened for read and fd_out is opened for write.  Ignore
filepos locations in both fd's.  fd_out must reference an empty/truncated
file (if not then fail).  Usually you'd call copy on fd_out straight out
of a creat call (and thus this would be a non-issue).

> 1. what happens if the copy is aborted?

I'd say the copy operation should be 'atomic', either it succeeds (full
copy) or fails (no changes to filesystems except for the truncate).  An
abort would obviously usually result in a failure (thus a possible revert,
which is rather easy since it's likely just an truncate of whatever has
already been copied) or if we've just finished and than a successful 
result.

> 2. what happens if the network drops while the remote server continues?

If the remote server has enough data to perform the operation then it does 
complete it otherwise there ain't enough info anyway (afterall the 
entire idea of this is to fit the entire copy into a single copy 
instruction thus a single packet/command whatever, no extra data is 
passed)...

> 3. what about buffer synchronization?

If this is happening remotely then I don't see what requires sync???

> 4. what errors should be reported ?

This is tougher:

Tests first performed locally (if they can be) than request forwarded to 
remote end and tests performed remotely - return either error or 
ACCEPTED, at which point local end tells it to go ahead, (at this 
point the operation is effectively performed (unless an abort is 
signalled) regardless of network connectivity).  On completion remote end 
will return info on completion or error code.

a) operation not supported by kernel :) - ENOSYS
b) fd_in/fd_out invalid file descriptor - EBADF
c) fd_in/fd_out is directory - EISDIR
d) can't read/write from/to fd_in/fd_out - EINVAL
e) an error if fd_out ain't empty - ENOTEMPTY
f) operation not supported by this combination of devices - EOPNOTSUPP
   [so you need to do it via usual loop]
g) input file bigger then output file can be - EFBIG
   [ie copy of 5GB file from remote filesystem which supports it to
   another filesystem on the same server with 2GB max file size]
h) low-level IO error - EIO - serious problems (i.e. HDD read/write error)
i) out of disk space during copy - ENOSPC
j) out of memory during copy - ENOMEM (unlikely, needed?)
k) lost network connection - ENETRESET (unknown whether succeeded)
   or ENOLINK ?
l) operation was aborted - EINTR [probably should be some other error 
   code, not sure]
m) success - either return 0 or the number of bytes copied
  [probably best to return the # of bytes copied, even if (for now?) we
   only accept full copies]

Did I miss anything?  What about non-blocking call? Basically as above but 
return INPROGRESS as soon as we tell remote end to go ahead... or perhaps 
don't support non-blocking call?

> 5. what happens when the syscall is interupted? Especially if the remote
>    copy may take a while (I've seen some require an hour or more - worst
>    case: days due to a media error (completed after the disk was replaced)).

Well, if it's interrupted by a SIGINT or the like then return EINTR and 
the copy was not performed (ie we backed the copy out, unless net failure 
detected during abort then ENOLINK/ENETRESET).

If it's a more normal signal than it should behave like any normal kernel 
restartable syscall (i.e. via ERESTARTNOHAND or something like that).

> 6. what about a client opening the copy before it is finished copying?

The file copy is atomic and thus the file doesn't per se exist until the 
copy operation completes (or the file exists with zero size and is locked 
and can't be opened).

Perhaps in the future we could support partial copies and restarting an 
interrupted copy, but let's first agree (or not) on the above.

I think a copy syscall would be very useful.  What I'd really like to see 
is some sort of block-hashed-space-compression with copy-on-write 
semantics file system for linux (for my 500 CD collection which probably 
has a 10-12 data duplicity factor).

Comments?

Cheers,
MaZe.


