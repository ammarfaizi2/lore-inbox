Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265066AbSLLTvV>; Thu, 12 Dec 2002 14:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbSLLTvV>; Thu, 12 Dec 2002 14:51:21 -0500
Received: from fmr01.intel.com ([192.55.52.18]:44286 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265066AbSLLTvU>;
	Thu, 12 Dec 2002 14:51:20 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1C6AF@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'jim.houston@attbi.com'" <jim.houston@attbi.com>,
       "Marco d'Itri" <md@Linux.IT>, linux-kernel@vger.kernel.org
Subject: RE: 2.5.51 nanosleep fails
Date: Thu, 12 Dec 2002 11:59:00 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> Marco d'Itri wrote:
> > nanosleep fails after being interrupted:
> >
> > [...]
> > nanosleep({1, 0},
> > [1]+  Stopped                 strace tail -f /var/log/uucp/Log
> > md@wonderland:~$ fg
> > strace tail -f /var/log/uucp/Log
> >  <unfinished ...>
> > --- SIGCONT (Continued) ---
> > <... nanosleep resumed> 0)              = -1 ENOSYS 
> (Function not implemented)>
> >
> > This can be reliably reproduced.                            
> I was able to reproduce this issue.  It happens on all the
> kernels I tried including a stock Redhat kernel.  This is just 
> an idiosyncrasy of strace. In this case both the strace and
> tail are sent a SIGTSTP when they are put into the background.
> Its not suprising that this might confuse strace.

I'm not sure this helps or is irrelevant (or already known), but I did try a
similar thing on a 2.5.50 kernel with the high-res-timers patches (all 4),
and it worked.  That same test did fail (as described above) in 2.5.51 (no
patches).

I have a feeling I may be missing something as I think (?) similar things
were discussed in the "[PATCH] compatibility syscall layer (lets try again)"
thread, but I know I didn't keep up.  I also may have misinterpreted the
original report.

In my test case, I set up a nanosleep to sleep for 5 seconds while I
interrupted it after 1 second with SIGSTOP and then SIGCONT.
On 2.5.50 w/HRT, it output:
  nanosleep() returned success [i.e., exitted w/no errors]
  Start 1039720777 sec; End 1039720782 sec
  Test PASSED

On 2.5.51 w/no HRT, it output:
  nanosleep() did not return success [i.e., exitted w/-1 and set errno]
  Start 1039721052 sec; End 1039721053 sec
  nanosleep() did not sleep long enough

>From strace of the 2.5.51 run:
nanosleep({1, 0}, {1, 0})               = 0
kill(1233, SIGSTOP)                     = 0
--- SIGCHLD (Child exited) ---
kill(1233, SIGCONTnanosleep() did not return success
)                     = 0
--- SIGCHLD (Child exited) ---
wait4(-1, [WIFEXITED(s) && WEXITSTATUS(s) == 1], 0, NULL) = 1233
gettimeofday({1039721104, 153936}, NULL) = 0

The test case was a variant of nanosleep/3-2.c on posixtest.sf.net.

- Julie
**These views are not necessarily those of my employer.**
