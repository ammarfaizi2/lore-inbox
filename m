Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319026AbSHMSAD>; Tue, 13 Aug 2002 14:00:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319043AbSHMSAC>; Tue, 13 Aug 2002 14:00:02 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36252 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S319026AbSHMR7z>;
	Tue, 13 Aug 2002 13:59:55 -0400
Date: Tue, 13 Aug 2002 20:03:52 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131057390.9145-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208131959160.5990-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> > we dont really want any signal overhead, and we also dont want any extra
> > context-switching to the 'master thread'. And there's no master thread
> > anymore either.
> 
> That still doesn't make it any les crap: because any thread that exits
> without calling the "magic exit-flag interface" will then silently be
> lost, with no information left around anywhere.

that should be a pretty rare occurance: with the upcoming signals patch
any segmentation fault zaps all threads and does a proper (and
deadlock-free) multithreaded coredump. Sysadmin doing a kill(1) will get
all threads killed as well. The only possible way for an uncontrolled exit
is for the thread to call sys_exit() explicitly (which is not possible
without the glibc cleanup handlers being called), or for someone to send a
SIGKILL via sys_tkill().

but even in this rare and malicious case, whatever resources a thread has,
they are lost if there's an uncontrolled exit anyway. There's tons of
other stuff that glibc might have to clean up on exit - mutexes,
malloc()s, etc. Thread exit needs to be cooperative, no matter what. The
stack cache does not change this situation the least.

	Ingo

