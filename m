Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261205AbUDSWs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261205AbUDSWs4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 18:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261206AbUDSWs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 18:48:56 -0400
Received: from [209.195.52.120] ([209.195.52.120]:32931 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261205AbUDSWsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 18:48:52 -0400
Date: Mon, 19 Apr 2004 15:48:44 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Stephan T. Lavavej" <stl@nuwen.net>
cc: linux-kernel@vger.kernel.org
Subject: RE: Process Creation Speed
In-Reply-To: <200404191245.i3JCjqal006292@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404191538460.26348@dlang.diginsite.com>
References: <200404191245.i3JCjqal006292@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the 2.6 kernel does have significant advantages in file creation/shutdown
time when you have large numbers of processes.

I have a box that sits with ~3000 processes on it and with a 2.4.25 kernel
it resulted in 400 connections/sec and with a 2.6.4 it got 650
connections/sec (cutting the number of processes down to <50 resulted in
~620 connections/sec with 2.4.5)

however if you can compile you code staticly and not do shared library
lookups you may see even more drastic improvements. with the code above I
hard-coded a protocol lookup, eliminated a few hostname lookups and under
2.6.4 got it up to 2500 connections/sec!! (I eliminated hostname lookups
and got up to ~700/sec, then changed nsswitch so that it didn't look for
protocols.db and it climbed to 850/sec, I shortened /etc/protocols to a
minimal set and it climbed to 900/sec, I eliminated the
getpotobyname("ip") and it jumped to 2500/sec)

measurements on a dual athlon 2100 box with 1g of ram

note that the code was staticly compiled to start with, but doing a name
lookup invoked nsswitch and loaded in libraries from that. do a strace of
the app, dumping it to a file and see what files it opens.

especially if you have SMP try the 2.6 kernel and keep tweaking your cgi's

David Lang

On Mon, 19 Apr 2004, Stephan T. Lavavej wrote:

> Date: Mon, 19 Apr 2004 05:44:12 -0700
> From: Stephan T. Lavavej <stl@nuwen.net>
> To: linux-kernel@vger.kernel.org
> Subject: RE: Process Creation Speed
>
> Thanks to all who have responded.
>
> I had been measuring the time to create and terminate a do-nothing program.
> I had not been measuring CGI programs, though that was why I was doing the
> measurement in the first place.
>
> I changed my measurement strategy, and I now get about 110 microseconds for
> creation and termination of a do-nothing process (fork() followed by
> execve()).  Statically linking everything gave a significant speedup, which
> allowed me to reach that value.  This was on a 2.6.x kernel.  110
> microseconds is well within my "doesn't suck" range, so I'm happy - CGI will
> be fast enough for my needs, and I can always turn to FastCGI later if
> necessary.
>
> I am writing a web-based forum entirely in C++, rejecting interpreted
> languages (Perl, PHP, ASP, etc.) and relational databases (MySQL,
> PostGreSQL, etc.) entirely.  My forum consists of "kiddy" CGI processes
> which talk over the network to a persistent "mommy" daemon who keeps all
> forum state in main memory.
>
> My code runs on both Windows and GNU/Linux with no configuration needed, but
> separate measurements indicate that XP takes about 3.3 ms to create and
> terminate a do-nothing process.  Thus it looks like Linux 2.6.x will be the
> kernel of choice for my forum.
>
> Thanks again!
>
> Stephan T. Lavavej
> http://nuwen.net
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
