Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbUFEXB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbUFEXB2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:01:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbUFEXB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:01:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:28046 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262389AbUFEXBV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:01:21 -0400
Date: Sat, 5 Jun 2004 16:01:10 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Robert Love <rml@ximian.com>
cc: Chris Wedgwood <cw@f00f.org>, Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <1086475663.7940.50.camel@localhost>
Message-ID: <Pine.LNX.4.58.0406051550580.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004, Robert Love wrote:
> 
> It is almost certainly done to improve the speed of some stupid
> microbenchmark - say, one that just calls getpid() repeatedly (simple
> because it is NOT slow) to measure system call overhead.

getpid() is only used in bad benchmarks these days, exactly because 
caching of "pid" has been done for a long time. Every single microkernel 
OS ever built did it, I think.

So yes, you'll find some broken benchmarks using getpid(), but nobody sane 
would take those benchmarks seriously anyway. If you want _real_ system 
call performance measurements, use something like lmbench, which does:

 - getppid() - same cost as getpid(), except you can't just cache the
   results on any POSIX OS (well, you could, but it's more complex:
   you end up having to map the uarea-equvalent into user space or have 
   some notifier for the parent dying).
 - read/write: a hell of a lot more important than the simple system calls 
   anyway.
 - open/close/stat/fstat: very common system calls with interesting 
   performance issues.

That gives you some _real_ data.

> Or maybe libc uses the PID a lot internally.  I don't know.

I think some threading libraries historically used hashes of the
thread-specific pid to look up the thread-specific data. But since glibc
shows the same pid for all regular threads, and gets the pid wrong for
other threads, that's clearly _not_ a valid reason for caching it either.

		Linus
