Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbQLGQOT>; Thu, 7 Dec 2000 11:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131029AbQLGQOJ>; Thu, 7 Dec 2000 11:14:09 -0500
Received: from e56090.upc-e.chello.nl ([213.93.56.90]:61194 "EHLO unternet.org")
	by vger.kernel.org with ESMTP id <S131026AbQLGQN7>;
	Thu, 7 Dec 2000 11:13:59 -0500
Date: Thu, 7 Dec 2000 16:42:51 +0100
From: Frank de Lange <frank@unternet.org>
To: drepper@redhat.com
Cc: java-linux@java.blackdown.org, linux-kernel@vger.kernel.org
Subject: java (and possibly other threaded apps) hanging in rt_sigsuspend
Message-ID: <20001207164251.A3239@unternet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulrich,

I saw your remarks on the kernel mailing list wrt. 'threaded processes get
stuck in rt_sigsuspend/fillonedir/exit_notify' dd. 20000911-12, and thought you
might be interested in the fact that something quite like this also happens on
2.4.0-test11 with glibc-2.2 (release), BUT NOT ALWAYS...

I can reliably hang java (Blackdown port jdk1.3, FCS) using the -Xmx parameter
(which specifies a maximum heap size), the weird thing is that it does NOT hang
which this parameter is either not specified OR specified but larger than a
certain value. When it hangs, it always is stuck in a rt_sigsuspend call just
after a clone() call. An example:

 [frank@behemoth frank]$ java
        (java starts and spits out some info, then exits as it should)

 
 [frank@behemoth frank]$ java -Xmx32m
        (java ALWAYS gets stuck:

	pipe([6, 7])                            = 0
	clone()                                 = 14732
	[pid 14679] write(7, "\0\0\0\0\5\0\0\0~\266\2@ $T@\0 T@\0 T@\300\265\2@\0\0\0"..., 148) = 148
	[pid 14679] rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
	[pid 14679] write(7, "`S\3@\0\0\0\0\20\321\377\277pD\37@\30&\5\10\0\0\0\200\0"..., 148) = 148
	[pid 14679] rt_sigprocmask(SIG_SETMASK, NULL, [RT_0], 8) = 0
	[pid 14679] rt_sigsuspend([]
	)


 [frank@behemoth frank]$ java -Xmx64m
	(java runs, but it gets stuck if this command is repeated a few times in quick succession.)
 
 [frank@behemoth frank]$ java -Xmx80m
	(java runs, no matter how often the command is repeated)


Some data on the test system:

[uname -a]
Linux behemoth.localnet 2.4.0-test11 #1 SMP Wed Nov 22 22:10:52 CET 2000 i686 unknown

[/lib/libc-2.2.so]
GNU C Library stable release version 2.2, by Roland McGrath et al.
Copyright (C) 1992,93,94,95,96,97,98,99,2000 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.
There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.
Compiled by GNU CC version 2.95.2 19991024 (release).
Compiled on a Linux 2.4.0-test11 system on 2000-11-23.
Available extensions:
	GNU libio by Per Bothner
	crypt add-on version 2.1 by Michael Glad and others
	The C stubs add-on version 2.1.2.
	BIND-8.2.3-T5B
	NIS(YP)/NIS+ NSS modules 0.19 by Thorsten Kukuk
	Glibc-2.0 compatibility add-on by Cristian Gafton 
	linuxthreads-0.9 by Xavier Leroy
	libthread_db work sponsored by Alpha Processor Inc
Report bugs using the `glibcbug' script to <bugs@gnu.org>.

[java -version]
java version "1.3.0"
Java(TM) 2 Runtime Environment, Standard Edition (build Blackdown-1.3.0-FCS)
Java HotSpot(TM) Client VM (build Blackdown-1.3.0-FCS, mixed mode)


Why am I sending you this report? Well, since you indicate that you are working
on a rewrite of linuxthreads, this might be of interest. Especially the weird
behaviour wrt. the maximum heap size. I do not expect nor ask you to fix the
java problems, this is purely informational...

FYI, on a linux 2.2/glibc 2.1.3 box this problem does not occur, in case you
wondered...

I cc'd this message to the blackdown team, so they know something's amiss as
well.

Cheers//Frank
-- 
  WWWWW      _______________________
 ## o o\    /     Frank de Lange     \
 }#   \|   /                          \
  ##---# _/     <Hacker for Hire>      \
   ####   \      +31-320-252965        /
           \    frank@unternet.org    /
            -------------------------
 [ Hacker: http://www.jargon.org/html/entry/hacker.html ]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
