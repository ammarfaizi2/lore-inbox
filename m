Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318333AbSHPMbc>; Fri, 16 Aug 2002 08:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318338AbSHPMbc>; Fri, 16 Aug 2002 08:31:32 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:36833 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S318333AbSHPMbb>; Fri, 16 Aug 2002 08:31:31 -0400
Date: Fri, 16 Aug 2002 13:34:56 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] user-vm-unlock-2.5.31-A2
Message-ID: <20020816133456.A342@kushida.apsleyroad.org>
References: <20020816040902.A31570@kushida.apsleyroad.org> <Pine.LNX.4.44.0208161153060.3509-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208161153060.3509-100000@localhost.localdomain>; from mingo@elte.hu on Fri, Aug 16, 2002 at 12:02:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> non-POSIX programming methods like JVMs can still implement *any*
> semantics - but your whole example is based on POSIX issues like exit() or
> default signal handlers, not Java.

Sorry if I was unclear.  I'm specifically talking about non-POSIX
threading methods (normal C code though, not complicated JVMs).

Most uses of clone() that I've seen are not using any threading library
at all: some code that neads a helper thread calls clone(), and the
child does its own self-contained system calls (to avoid errno pollution).

It's conceptually fine that individual threads can die.  _Conceptually_,
clone-by-hand threads are very similar to processes, and I have seen
this used in practice a few times.

And it all works fine: just use SIGCHLD and waitpid().

Now you have written this wonderful resource optimisation, which removes
zombies: CLONE_DETACHED.  Unfortunately, catching invidual thread death
relies on the thread "exiting politely", as they say.  So I still have
to use SIGCHLD and waitpid(), or a pipe(), for non-POSIX-model threads
that want to robustly detect "impolite" thread death.

I think that's an unfair penalty on non-POSIX-model threads.

-- JAmie
