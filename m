Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317620AbSGOUOM>; Mon, 15 Jul 2002 16:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317624AbSGOUOL>; Mon, 15 Jul 2002 16:14:11 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:57584 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317620AbSGOUOG>;
	Mon, 15 Jul 2002 16:14:06 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org,
       Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
References: <20020715075221.GC21470@uncarved.com>
	<Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com>
	<20020715133507.GF32155@merlin.emma.line.org>
	<s5gwurxt59x.fsf@egghead.curl.com>
	<1026749802.30202.13.camel@irongate.swansea.linux.org.uk>
	<s5ghej1t31f.fsf@egghead.curl.com>
	<1026752140.30454.17.camel@irongate.swansea.linux.org.uk>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 16:17:01 -0400
In-Reply-To: <1026752140.30454.17.camel@irongate.swansea.linux.org.uk>
Message-ID: <s5gofd8sq4i.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> Documentation/fs/fsync.txt or similar sounds a good idea

OK, attached is my first attempt at such a document.

What do you think?

 - Pat



--=-=-=
Content-Disposition: inline; filename=fsync.txt
Content-Description: fsync.txt

                       Linux fsync() semantics
                (or, "How to create a file reliably")


Introduction
============

Consider the following C program:

    #include <unistd.h>
    #include <stdio.h>
    #include <fcntl.h>
    #include <string.h>

    int
    main (int argc, char *argv[]) {
      int fd;
      char *s = "Hello, world!\n";

      fd = open ("/tmp/foo", O_WRONLY|O_CREAT|O_EXCL);
      if (fd < 0) return 1;

      if (write (fd, s, strlen(s)) < 0) return 3;
      if (fsync (fd) < 0) return 4;
      if (close (fd) < 0) return 5;

      return 0;
    }

Question: If you compile and run this program, and it exits zero
(success), and your machine then crashes, is it guaranteed that the
file /tmp/foo will exist upon reboot?

Answer: On many Unices, including *BSD, yes.
        On Linux, NO.

How could this be?  And what can you do about it?


History
=======

In the beginning was BSD with its Fast File System (FFS).  Under FFS,
changes to directories were "synchronous", meaning they were committed
to disk before the system call (open/link/rename/etc.) returned.
Changes to files (write()) were asynchronous.  The fsync() system call
allowed an application to force a file's pending writes to be
committed to persistent media.

In general, disks have reasonble throughput but horrible latency, so
it is much faster to write many things all at once rather than one at
a time.  In other words, synchronous operations are slow.

Enter Linux.  By default, Linux makes all operations, including
directory updates, asynchronous.  Early file system benchmarks showed
Linux beating the pants off of BSD, especially when lots of directory
operations were involved.  This annoyed the BSD folks, who claimed
that synchronous directory updates are required for reliable
operation.  (As with most points of contention between Linux and BSD,
this is both true and false...  See below.)

The problem with making directory operations asynchronous is that you
then need to provide a way for the application to commit those changes
to disk.  Otherwise, it is impossible to write reliable applications.


BSD softupdates
===============

Sometime during the 90s, the BSD developers introduced "soft updates"
to improve performance.  These do two things.  First, they make all
file system operations asynchronous (like Linux).  Second, they extend
the fsync() system call so that it commits to disk BOTH the file's
data AND any directories via which the file might be accessed.

In other words, BSD with soft updates requires that you call fsync()
on a file to commit any changes to its containing directory.  This is
why the program above "works" on BSD.

Many programs are written these days to expect soft update semantics,
because such algorithms will also work correctly under traditional
FFS.

The problem with the softupdates approach is that finding all paths to
a file is complex, and the Linux developers hate complexity.  Linux
does NOT support this behavior for fsync() and probably never will.


Standards
=========

Quick aside: What do the relevant standards (POSIX, SuS) say?  Is
Linux violating some standard here?

Well, different people, having read the standards, disagree on this
point.  This itself means the standards are not clear (which is a bad
thing for a standard).  This is probably because the standards were
written when synchronous directory updates were the norm, and the
authors did not even consider asynchronous directory updates.


The Linux Solution
==================

The Linux answer is simple: If you want to flush a modified directory
to disk, call fsync() on the directory.

In other words, to reliably create a file on Linux, you need to do
something like this:

    #include <unistd.h>
    #include <stdio.h>
    #include <fcntl.h>
    #include <string.h>

    int
    main (int argc, char *argv[]) {
      int fd, dirfd;
      char *s = "Hello, world!\n";

      fd = open ("/tmp/foo", O_WRONLY|O_CREAT|O_EXCL);
      if (fd < 0) return 1;

      dirfd = open ("/tmp", O_RDONLY);
      if (dirfd < 0) return 2;

      if (write (fd, s, strlen(s)) < 0) return 3;
      if (fsync (fd) < 0) return 4;
      if (close (fd) < 0) return 5;
      if (fsync (dirfd) < 0) return 6;
      if (close (dirfd) < 0) return 7;

      return 0;
    }

If this program exits zero, the file /tmp/foo is guaranteed to be on
disk and to have the correct contents.  This is true for ALL versions
of the Linux kernel and ALL file systems.


Other choices
=============

So you have written to the authors of your favorite MTA asking them to
support Linux properly by using fsync() on directories.  They have
responded saying that "Linux is broken".  (Be sure to ask them to
justify this claim with chapter and verse from a standard.  It is sure
to be interesting.)  What can you do?

If the application does all its work in one directory, or a few
directories, you can do "chattr +S" on the directory.  This will cause
all operations on that directory to be synchronous.

You can use the "-o sync" mount option.  This will cause ALL
operations on that partition to be synchronous.  This solves the
problem, but is likely to be slow.

In the current version of Linux, you can use the ext3 or ReiserFS file
systems.  These happen to commit their journals to disk whenever
fsync() is called, which has the side-effect of providing semantics
like BSD's soft updates.  But note: This behavior is not guaranteed,
and may change in future releases!

But really, the best idea is to convince application authors to
support the "Linux way" for committing directory updates.  The
semantics are simple, clear, and extremely efficient.  So go bug those
MTA authors until they listen :-).


 - Patrick LoPresti <patl@curl.com>
   July 2002

--=-=-=--
