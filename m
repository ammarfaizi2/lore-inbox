Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318693AbSIEW03>; Thu, 5 Sep 2002 18:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318696AbSIEW03>; Thu, 5 Sep 2002 18:26:29 -0400
Received: from mx2.elte.hu ([157.181.151.9]:32921 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S318693AbSIEW0M>;
	Thu, 5 Sep 2002 18:26:12 -0400
Date: Fri, 6 Sep 2002 00:35:22 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Daniel Jacobowitz <dan@debian.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] ptrace-fix-2.5.33-A1
In-Reply-To: <20020905221558.GA12837@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0209060029200.16108-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


there are two kinds of wait4 calls, one that gets the WIFSTOPPED event
from the debugged task, for this the traced task has to be in the
debugger's ->children list.

Another one is when a debugged task exits and its parent wants the exit
event. But in this case the task is untraced already, so it gets back into
the parent's ->children list.

ie. wait4 should only look at the ->children list - zombies (or traced
tasks debugged by this task) can only be there.

The only addition is that in the wait4 non-blocking case we need to look
at the traced list as well - since a non-blocking wait4 is a 'could there
be any children exiting' kind of query.

	Ingo

