Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135698AbRDSUrc>; Thu, 19 Apr 2001 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135702AbRDSUrX>; Thu, 19 Apr 2001 16:47:23 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:11722 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135698AbRDSUrJ>; Thu, 19 Apr 2001 16:47:09 -0400
Date: Thu, 19 Apr 2001 22:47:07 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: light weight user level semaphores
Message-ID: <20010419224707.K682@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3ADEA746.D3A44511@alsa-project.org> <Pine.LNX.4.31.0104190903560.3842-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.31.0104190903560.3842-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Thu, Apr 19, 2001 at 09:11:56AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 09:11:56AM -0700, Linus Torvalds wrote:
> No, this is NOT what the UNIX dogmas are all about.
> 
> When UNIX says "everything is a file", it really means that "everything is
> a stream of bytes". Things like magic operations on file desciptors are
> _anathema_ to UNIX. ioctl() is the worst wart of UNIX. Having magic
> semantics of file descriptors is NOT Unix dogma at all, it is a horrible
> corruption of the original UNIX cleanlyness.

Right. And on semaphores, this stream is exactly 0 bytes long.
This is perfectly normal and can be handled by all applications
I'm aware of.

My idea violates nothing here.

> Please don't excuse "semaphore file descriptors" with the "everything is a
> file" mantra. It is not at ALL applicable.
> 
> The "everything is a file" mantra is to make pipe etc meaningful -
> processes don't have to worry about whether the fd they have is from a
> file open, a pipe() system call, opening a special block device, or a
> socket()+connect() thing. They can just read and write. THAT is what UNIX
> is all about.
 
Right. And with my approach read() and write() with a buffer
pointer != NULL would either yield an return value of "0" or
-1 and set errno=EINVAL ("object not suitable for reading/writing").
Anyway they should return IMMIDIATELY in these cases.

We already have these special semantics with devices. Look at
/dev/sgX for an example how we pass even structured data via
normal read/write (instead of "stream of bytes").

> And this is obviously NOT true of a "magic file descriptors for
> semaphores". You can't pass it off as stdin to another process and expect
> anything useful from it unless the other process _knows_ it is a special
> semaphore thing and does mmap magic or something.

see above. NOTHING special about this idea. No magic handling
involved, unless the user of the fd knows what it is. For other
users it will be just a normal fd with normal operations, since
the special case is hidden well enough. 

This is even WAY simpler as all that tty-crap and similar
devices, which read/write very dependend on their actual ioctl
configuration.

But since stupid POSIX forbids using fds for semaphores
(according to Ulrich Drepper), this nice, simple and
non-intrusive solution is out.

Instead we should go with several new syscalls, user space
dependencies, strange error handling and yet-to-discuss
semantics.

Everybody else byt you would have been kicked out by the core
people for suggesting this ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
