Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266967AbTAPAFW>; Wed, 15 Jan 2003 19:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266964AbTAPAEI>; Wed, 15 Jan 2003 19:04:08 -0500
Received: from fmr01.intel.com ([192.55.52.18]:3537 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265196AbTAPAD6>;
	Wed, 15 Jan 2003 19:03:58 -0500
Message-ID: <D9223EB959A5D511A98F00508B68C20C17F1C774@orsmsx108.jf.intel.com>
From: "Fleischer, Julie N" <julie.n.fleischer@intel.com>
To: "'george anzinger'" <george@mvista.com>
Cc: "'high-res-timers-discourse@lists.sourceforge.net'" 
	<high-res-timers-discourse@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [BUG - HRT patch] disabling timer hangs system when multiple 
	 overruns
Date: Wed, 15 Jan 2003 16:12:45 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> George Anzinger wrote:
> I suspect that you have run into a bug I fixed in the latest
> version having to do with handing off a timer from id look
> up to the spin lock on the timer.  I was releasing the look
> up lock prior to taking the timer lock which allowed an
> interrupt to sneek in there and set up a dead lock with the
> interrupt code.  Most likey to happen when processing
> overruning timers.
> 
> This is fixed in the latest patch.

George -
Again, sorry about not testing on your latest version (and thanks for the
bk6 patch! :) ).  I ran this test again on your latest patch (the
2.5.54-bk6-1.0 patches), and I'm still seeing a hang of the test case.
There is a good difference, though, I think due to your fix.  In 2.5.54-bk1,
I had to reboot the system after the hang(or 2/3 times I usually had to).
Now, I do not have to reboot the system (or 3/3 times I don't have to), but
the test case still hangs (i.e., I have to manually kill the session the
test case was started in).

I forgot to mention reproducibility before.  The test case hang is always
reproducible (bk6 or bk1 patches).  As I mentioned, the system hang no
longer happens with bk6 (probably the issue you fixed), but the system would
hang ~1/3 times with the bk1 patches.

Someone also suggested I use strace to get more output.  That seemed to help
pinpoint exactly that the issue came doing the "timer_settime(<an its with
it_value=0>)" call.

Here's that output:
(...)
write(1, "setup first timer\n", 18setup first timer
)     = 18
ipc_subcall(0x8000003, 0, 0xbffff8e0, 0) = 0
write(1, "sleep\n", 6sleep
)                  = 6
rt_sigprocmask(SIG_BLOCK, [CHLD], [ALRM], 8) = 0
rt_sigaction(SIGCHLD, NULL, {SIG_DFL}, 8) = 0
rt_sigprocmask(SIG_SETMASK, [ALRM], NULL, 8) = 0
nanosleep({1, 0}, {1, 0})               = 0
write(1, "awoke\n", 6awoke
)                  = 6
rt_sigaction(SIGALRM, {0x80485c0, [], 0x4000000}, NULL, 8) = 0
write(1, "setup second timer\n", 19setup second timer
)    = 19
ipc_subcall(0x8000003, 0, 0xbffff8e0, 0

This is the point where the test case hangs.  If I'm using strace, I just do
a Ctrl-C to get out.

I'm using these patches:
  hrtimers-core-2.5.54-bk6-1.0.patch 
  hrtimers-hrposix-2.5.54-bk6-1.0.patch
  hrtimers-i386-2.5.54-bk6-1.0.patch 
  hrtimers-posix-2.5.54-bk6-1.0.patch 
  hrtimers-support-2.5.52-1.0.patch

Thanks.
- Julie

**These views are not necessarily those of my employer.**
 
