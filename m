Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262391AbUFEXSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUFEXSb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUFEXSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 19:18:31 -0400
Received: from fw.osdl.org ([65.172.181.6]:39321 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262391AbUFEXS3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 19:18:29 -0400
Date: Sat, 5 Jun 2004 16:18:16 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Davide Libenzi <davidel@xmailserver.org>
cc: Robert Love <rml@ximian.com>, Chris Wedgwood <cw@f00f.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Russell Leighton <russ@elegant-software.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
Message-ID: <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org>
References: <40C1E6A9.3010307@elegant-software.com> 
 <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org> 
 <20040605205547.GD20716@devserv.devel.redhat.com>  <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 5 Jun 2004, Davide Libenzi wrote:
> 
> It is likely used by pthread_self(), that is pretty much performance 
> sensitive. I'd agree with Ulrich here.

It _can't_ be used for pthread_self(), since the pid is the _same_ across 
all threads in a pthread environment.

See?

I re-iterate:

 - getpid() was used in some historical threading packages (maybe even 
   LinuxThreads) to get the thread ID thing.

   But this particular usage requires the old Linux behaviour of returning 
   separate threads ID's for separate threads. CLONE_THREAD does not do 
   that, and in particular the glibc caching _breaks_ any such attempt 
   even when you don't use CLONE_THREAD.

   pthreads() in modern libc sets CLONE_THREAD and then uses the 
   per-thread segment thing to identify threads. No getpid() anywhere.

   Ergo: getpid() caching may result in faster execution, but in this case 
   it's actively _wrong_, and breaks the app.  It's easy to make things go 
   fast if you don't actually care about whether the end result is correct
   or not.

 - getpid() is used in some silly benchmarks.

   But in this case caching getpid() just lies to the benchmark, and is
   pointless.

   Ergo: getpid() caching results in higher scores, but the scores are now 
   meaningless, since they have nothing to do with system call speed any
   more.

So in both of these cases, the caching literally results in WRONG
behaviour.

Can somebody actually find an application that doesn't fall into either of
the above two categories, and calls getpid() more than a handful of times?

		Linus
