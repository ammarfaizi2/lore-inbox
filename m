Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315752AbSEDAIh>; Fri, 3 May 2002 20:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315753AbSEDAIg>; Fri, 3 May 2002 20:08:36 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:52568 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315752AbSEDAIf>;
	Fri, 3 May 2002 20:08:35 -0400
Date: Sat, 4 May 2002 02:08:28 +0200
From: Roger Luethi <rl@hellgate.ch>
To: linux-kernel@vger.kernel.org
Subject: execve & elf loader errors
Message-ID: <20020504000828.GA6383@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.8-ac9 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been revisiting an ancient problem and I'd be interested to hear
what people think is the best solution.

execve(2) takes one file path as an argument, but for most cases deals
with a second file path: that of the dynamic loader. For the more common
failures [1] related to the loader (EACCES, ENOENT), it's up to userspace
to figure out if the error applies to the ELF binary itself or to its
dynamic loader.

This makes for some strange user experience:
# ./test
zsh: no such file or directory: ./test
# ls -l test
-rwxr-xr-x    1 rl       users        5096 Apr 27 16:56 test

In the presumably rare case where the loader is in a bad format (usually
it's ELF), we return ELIBBAD as a distinct error number [2].

Loading/mmaping the remaining files (shared libs) is handled by the loader
and comes with descriptive error messages already. The dynamic loader
itself is the only blind spot.

Standards: since man page and code were written, POSIX defined additional
errors. SuSv3 definitions certainly don't seem to cover use of EACCES and
ENOENT for loader errors the way Linux does now (they are specifically
referring to the path that was provided as an argument to the execve call),
but EINVAL might just work. Alternatively, as it looks like ELIBBAD is here
to stay, it might as well mean "ELF interpreter: not found, access denied,
or not in a recognised format". Either solution would tell the caller
whether there was something wrong with the loader.

The error number could be tweaked after fn() returns in search_binary_handler()
or after open_exec() returns in load_elf_binary().

Solutions in user space: It's rather unreasonable to expect the caller
(typically a shell) to parse the header of the executable. Therefore, it
doesn't know the name of the loader (or if there is one at all) and the one
alternative to a change in the kernel is for the caller to stat() the
executable and if that call makes the execve error value look bogus, assume
that the problem must be with the dynamic loader. Doable, but not pretty.

Roger

[1] Happens for instance when people try to run lib5 binaries on a pure
    libc6 system. LSB binaries expect their loader in a different place,
    too.

[2] Translates to "Accessing a corrupted shared library" (errno.h) or "An
    ELF interpreter was not in a recognised  format." (man execve(2)).
    That particular error value is used only once in the kernel.
