Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317371AbSGTFyq>; Sat, 20 Jul 2002 01:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317373AbSGTFyq>; Sat, 20 Jul 2002 01:54:46 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49159 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317371AbSGTFyp>; Sat, 20 Jul 2002 01:54:45 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH] 'select' failure or signal should not update timeout
Date: Sat, 20 Jul 2002 05:57:46 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ahau4q$1n2$1@penguin.transmeta.com>
References: <200207190952.g6J9q4I07044@sic.twinsun.com> <200207200038.g6K0cZO12086@devserv.devel.redhat.com>
X-Trace: palladium.transmeta.com 1027144647 14168 127.0.0.1 (20 Jul 2002 05:57:27 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 20 Jul 2002 05:57:27 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200207200038.g6K0cZO12086@devserv.devel.redhat.com>,
Alan Cox  <alan@redhat.com> wrote:
>> <http://www.opengroup.org/onlinepubs/007904975/functions/select.html>
>> says that 'select' may modify its timeout argument only "upon
>> successful completion".  However, the Linux kernel sometimes modifies
>> the timeout argument even when 'select' fails or is interrupted.
>
>This is extremely useful behaviour. POSIX is broken here. Fix it in the
>C library or somewhere it doesn't harm the clueful

Personally, I've gotten to the point where I think that the select()
time is broken. 

The thing is, nobody should really ever use timeouts, because the notion
of "I want to sleep X seconds" is simply not _useful_ if the process
also just got delayed by a page-out event as it said so.  What does "X
seconds" mean at that point? It's ambiguous - and the kernel will (quite
naturally) just always assume that it is "X seconds from when the kernel
got notified". 

A _useful_ interface would be to say "I want to sleep to at most time X"
or "to at least time X".  Those are unambiguous things to say, and are
not open to interpretation.

The "I want to sleep until at least time X" (or "at most time X") also
has the added advantage that it is inherently re-startable - restarting
the sleep has _no_ rounding issues, and again no ambiguity.

Note that select() is definitely not the only offender here.  Other
system calls like "nanosleep()" have the exact same problem - what do
you do if you get interrupted by a signal and need to restart? 

The Linux behaviour of modifying the timeout is a half-assed try for
restartability, but the problem is that (a) nobody else does that or
expects it to happen, despite the man-pages originally claiming that
they were supposed to and (b) it inherently has rounding problems and
other ambiguities - making it even less useful. 

Oh, well.

I suspect almost nobody actually uses the Linux timeout feature because
of the nonportability issues, making the whole mess even less tasty.

		Linus
