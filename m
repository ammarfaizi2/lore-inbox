Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130139AbQLIHFE>; Sat, 9 Dec 2000 02:05:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130216AbQLIHEo>; Sat, 9 Dec 2000 02:04:44 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:58630 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S130139AbQLIHEl>; Sat, 9 Dec 2000 02:04:41 -0500
To: Peter Berger <peterb@telerama.com>
Cc: linux-kernel@vger.kernel.org, "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Subject: Re: Pthreads, linux, gdb, oh my! (fwd)
In-Reply-To: <Pine.BSI.4.02.10012081150130.17198-100000@frogger.telerama.com>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: Peter Berger's message of "Fri, 8 Dec 2000 11:53:07 -0500 (EST)"
Date: 09 Dec 2000 00:34:06 -0600
Message-ID: <vbasnny3xy9.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Berger <peterb@telerama.com> writes:
> 
> Hi.  I have the following tiny test program which fails dramatically,
> using pthreads, in a number of fascinating ways on various version of
> linux, using various versions of glibc, under various (current) versions
> of GDB.

It looks like a GDB bug.  GDB contains code to recognize when the
"pthreads" shared library has been loaded.  When this happens, it sets
itself up to properly handle threads (including setting up correct
SIG32 signal handling).  If you trick GDB into thinking "pthreads"
hasn't been loaded and set the SIG32 stuff up yourself, like so:

   buhr@saurus:~/src$ gdb thread-test
   GNU gdb 19990928
   Copyright 1998 Free Software Foundation, Inc.
   GDB is free software, covered by the GNU General Public License, and you are
   welcome to change it and/or distribute copies of it under certain conditions.
   Type "show copying" to see the conditions.
   There is absolutely no warranty for GDB.  Type "show warranty" for details.
   This GDB was configured as "i686-pc-linux-gnu"...
   (gdb) set auto-solib-add 0
   (gdb) handle SIG32 nostop noprint pass
   Signal        Stop      Print   Pass to program Description
   SIG32         No        No      Yes             Real-time event 32
   (gdb) run

then your program works fine.  Ergo, this is strong evidence that
GDB's thread handling is broken.  Presumably, it's simply not reaping
threads when they exit.

I don't know if Petr just happened to run his GDB 5.0 with "set
auto-solib-add 0" in his ".gdbinit" (a rather necessary precaution if
you're hacking on, say, Mozilla) and didn't see any problem for that
reason, or if some aspect of his configuration has fixed the problem.
Alternatively, maybe Petr is using a GDB that doesn't actually support
threads---if so, he'd *have* to set the SIG32 stuff up manually, and
he wouldn't notice any problem.

Kevin <buhr@stat.wisc.edu>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
