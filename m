Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264547AbTK0QBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 11:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264548AbTK0QBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 11:01:34 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:59027 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264547AbTK0QBc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 11:01:32 -0500
Subject: Re: Never mind. Re: Signal left blocked after signal handler.
From: Albert Cahalan <albert@users.sf.net>
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: bruce@perens.com, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200311271012.07893.ioe-lkml@rameria.de>
References: <1069883580.723.416.camel@cube>
	 <200311271012.07893.ioe-lkml@rameria.de>
Content-Type: text/plain
Organization: 
Message-Id: <1069947938.722.437.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 27 Nov 2003 10:45:39 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-27 at 04:11, Ingo Oeser wrote:
> On Wednesday 26 November 2003 22:53, Albert Cahalan wrote:

> [2.4 vs. 2.6 wrt. thread synchronous signals]
> > How about making the process sleep in a killable state?
> >
> > This is as if the blocking was obeyed, but doesn't
> > burn CPU time. Only a debugger should be able to
> > tell the difference.
> 
> This has 2 problems:
> 
> 1) Servers and PID files or servers and simple monitoring software.
> 2) Processes spawned from init, which will not respawn.

It has benefits:

1. Continuous respawning is no good.
2. If the processes sleeps, you can attach a debugger.

The obviously correct behavior is to go back into
user space, likely to take the signal again. The only
thing wrong with this is that it eats CPU time.
So _pretend_ to do that. Have the process sleep,
ideally with an "R" state as seen in /proc, and maybe
even go back to the crazy loop if someone attaches a
debugger.

The crazy loop is most correct though. It's what the
user asked for. It perfectly handles the case of a
repeating SIGFPE (blocked) followed by some other
thread unmapping a page of instructions or data that
turns the SIGFPE into a SIGSEGV.



