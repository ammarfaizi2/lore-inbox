Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265094AbTBLCja>; Tue, 11 Feb 2003 21:39:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbTBLCj3>; Tue, 11 Feb 2003 21:39:29 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40200 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S265094AbTBLCj3>; Tue, 11 Feb 2003 21:39:29 -0500
Date: Tue, 11 Feb 2003 18:45:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: <200302120206.h1C26sI19476@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302111833120.2667-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Feb 2003, Roland McGrath wrote:
> 
> I think sys_semop would be closer to right if it used ERESTARTSYS instead
> of EINTR.

You probably mean ERESTARTSYSNOHAND.

There are lots of system calls that simply are not restartable. So 
TIF_SIGPENDING in general should be set only if required, and not "because 
it's easier".

> The reason I am concerned about this is that I think any case that is
> broken by the lack of the optimization in the patch below must also be
> broken vis a vis the semantics of stop signals and SIGCONT (when SIG_DFL,
> SIG_IGN, or blocked).  POSIX says that when a process is stopped by
> e.g. SIGSTOP, and then continued by SIGCONT, any functions that were in
> progress at the time of stop are unaffected unless SIGCONT runs a handler.
> That is, nobody returns EINTR because of the stop/continue.

This is what ERESTARTNOHAND does, but quite often if you get interrupted
you have to return _partial_ results, which is quite inefficient and
sometimes breaks programs (ie you get things like a read() from a pipe
that returns a partial result because you resized the window, and a 
SIGWINCH happened - and that is _bad_).

The old code tried rather hard to make signals that were truly ignored 
(SIGSTOP/SIGCONT is not of that kind) be total non-events because of 
things like this. 

		Linus

