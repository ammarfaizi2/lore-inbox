Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161142AbWGIU6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161142AbWGIU6k (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161143AbWGIU6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 16:58:40 -0400
Received: from aun.it.uu.se ([130.238.12.36]:16374 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1161142AbWGIU6k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 16:58:40 -0400
Date: Sun, 9 Jul 2006 22:58:31 +0200 (MEST)
Message-Id: <200607092058.k69KwVxN026427@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: linux-kernel@vger.kernel.org
Subject: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
Cc: johnstul@us.ibm.com, pavel@ucw.cz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006 21:01:26 +0200 (MEST), I wrote:
>Kernel 2.6.18-rc1 broke resume from APM suspend (to RAM)
>on my old Dell Latitude CPi laptop. At resume the disk
>spins up and the screen gets lit, but there is no response
>to the keyboard, not even sysrq. All other system activity
>also appears to be halted.
>
>I did the obvious test of reverting apm.c to the 2.6.17
>version and fixing up the fallout from the TIF_POLLING_NRFLAG
>changes, but it made no difference. So the problem must be
>somewhere else.

I've traced the cause of this problem to the i386 time-keeping
changes in kernel 2.6.17-git11. What happens is that:
- The kernel autoselects TSC as my clocksource, which is
  reasonable since it's a PentiumII. 2.6.17 also chose the TSC.
- Immediately after APM resumes (arch/i386/kernel/apm.c line
  1231 in 2.6.18-rc1) there is an interrupt from the PIT,
  which takes us to kernel/timer.c:update_wall_time().
- update_wall_time() does a clocksource_read() and computes
  the offset from the previous read. However, the TSC was
  reset by HW or BIOS during the APM suspend/resume cycle and
  is now smaller than it was at the prevous read. On my machine,
  the offset is 0xffffffd598e0a566 at this point, which appears
  to throw update_wall_time() into a very very long loop.

Hacks around the problem:
- echo jiffies>/sys/devices/system/clocksource/clocksource0/current_clocksource
  before suspending eliminates the hang. (Note: this doesn't affect
  the i386 delay loop implementation. Is that a bug or a feature?)
- Hacking apm.c to set a flag just before suspending and clear
  it only after all resume actions are done, and to have update_wall_time()
  return immediately when this flag is set also eliminates the hang.

I guess the appropriate fix would be to augment either the
TSC clocksource driver or the clocksource API to deal with
pseudo-monotonic clocks that get reset at suspend.

/Mikael
