Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278316AbRJMPjC>; Sat, 13 Oct 2001 11:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278317AbRJMPiw>; Sat, 13 Oct 2001 11:38:52 -0400
Received: from [212.21.93.146] ([212.21.93.146]:40579 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278316AbRJMPif>; Sat, 13 Oct 2001 11:38:35 -0400
Date: Sat, 13 Oct 2001 17:36:19 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: =?iso-8859-1?Q?Mattias_Engdeg=E5rd?= <f91-men@nada.kth.se>
Cc: pmenage@ensim.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Pollable /proc/<pid>/ - avoid SIGCHLD/poll() races
Message-ID: <20011013173619.C20499@kushida.jlokier.co.uk>
In-Reply-To: <E15p3JS-0000ko-00@pmenage-dt.ensim.com> <200110041418.QAA17395@my.nada.kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110041418.QAA17395@my.nada.kth.se>; from f91-men@nada.kth.se on Thu, Oct 04, 2001 at 04:18:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattias Engdegård wrote:
> I don't think it's contrived --- writing not a byte, but the pid and
> return status of the dead child to a pipe is an old but useful trick.
> It gives a natural serialisation of child deaths, and also eliminates
> the common race where a child dies before its parent has recorded its
> pid in a data structure. See it as a safe way of converting an
> asynchronous signal to a queued event.
>
> Using pipes to wake up blocking select()s is a useful thing in general,
> and often a lot cleaner than using signals when dealing with threads.

This mistake is exactly the reason that Netscape 4.x freezes from time
to time on Linux.

It tries to write too many things to a pipe, making the assumption that
this will never happen.

The correct thing to do, which never freezes, is to maintain a queue or
other structure inside your own process.  Just write a single byte to
the pipe when a condition flag becomes true for the first time, after
setting the flag (both inside the signal handler).  Clear the flag and
handle the pending conditions whenever you read the byte in the select()
loop.  A flag can be implemented as a pair of counters if you can't do
atomic sets and clears.

enjoy,
-- Jamie
