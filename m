Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbTBLDD5>; Tue, 11 Feb 2003 22:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266933AbTBLDD5>; Tue, 11 Feb 2003 22:03:57 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:36223 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S266932AbTBLDDx>; Tue, 11 Feb 2003 22:03:53 -0500
Date: Tue, 11 Feb 2003 19:13:33 -0800
Message-Id: <200302120313.h1C3DX419736@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
X-Fcc: ~/Mail/linus
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: another subtle signals issue
In-Reply-To: Linus Torvalds's message of  Tuesday, 11 February 2003 18:45:19 -0800 <Pine.LNX.4.44.0302111833120.2667-100000@home.transmeta.com>
X-Fcc: ~/Mail/linus
Emacs: the Swiss Army of Editors.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You probably mean ERESTARTSYSNOHAND.

Indeed, that's the right one for functions like semop that are specified in
1003.1-2001 explicitly to wake up when a signal was caught.  I read the
SA_RESTART wording as not intending to apply to functions that say that
explicitly.

> There are lots of system calls that simply are not restartable. 

POSIX permits partial results for cases like read and write.  Those aside,
and leaving aside calls in uninterruptible sleeps (in which stops take
place only after the sleep wakes), POSIX would seem to require that they be
restarted when there is a job control stop and continue.

> > The reason I am concerned about this is that I think any case that is
> > broken by the lack of the optimization in the patch below must also be
> > broken vis a vis the semantics of stop signals and SIGCONT (when SIG_DFL,
> > SIG_IGN, or blocked).  POSIX says that when a process is stopped by
> > e.g. SIGSTOP, and then continued by SIGCONT, any functions that were in
> > progress at the time of stop are unaffected unless SIGCONT runs a handler.
> > That is, nobody returns EINTR because of the stop/continue.
> 
> This is what ERESTARTNOHAND does [...]

ERESTARTSYS and ERESTARTNOHAND only differ when a handler is run,
which is not the case I am talking about.  

> The old code tried rather hard to make signals that were truly ignored 
> (SIGSTOP/SIGCONT is not of that kind)

POSIX clearly specifies that stopping and continuing "shall not affect the
behavior of any function" (when SIGCONT is SIG_DFL or SIG_IGN, or is blocked).

