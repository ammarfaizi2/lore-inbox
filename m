Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272670AbTG1Fpd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 01:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272671AbTG1Fpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 01:45:33 -0400
Received: from pop.gmx.net ([213.165.64.20]:10963 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272670AbTG1Fpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 01:45:31 -0400
Message-Id: <5.2.1.1.2.20030728065857.01bc9708@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 28 Jul 2003 08:04:59 +0200
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] sched-2.6.0-test1-G6, interactivity changes
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1059333494.578.4.camel@teapot.felipe-alfaro.com>
References: <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
 <Pine.LNX.4.44.0307271535590.22937-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:18 PM 7/27/2003 +0200, Felipe Alfaro Solana wrote:
>On Sun, 2003-07-27 at 15:40, Ingo Molnar wrote:
> > my latest scheduler patchset can be found at:
> >
> >       redhat.com/~mingo/O(1)-scheduler/sched-2.6.0-test1-G6
> >
> > this version takes a shot at more scheduling fairness - i'd be interested
> > how it works out for others.
>
>This -G6 patch is fantastic, even without nicing the X server. I didn't
>even need to tweak any kernel scheduler knob to adjust for maximum
>smoothness on my desktop. Response times are impressive, even under
>heavy load. Great!

Can you try the following please?

This one I just noticed:
1.  start top.
2.  start dd if=/dev/zero | dd of=/dev/null
3.  wiggle a window very briefly.
Here, X becomes extremely jerky, and I think this is due to two 
things.  One, X uses it's sleep_avg very quickly, and expires.  Two, the 
piped dd now is highly interactive due to the ns resolution clock (uhoh).

This one, I've seen before, but it just became easily repeatable:
1.  start top.
2.  start make -j2 bzImage.  minimize window.
3.  start xmms, and enable it's gl visualization.
4.  grab top window and wiggle it until you see/feel X expire.  (don't blink)
         What you should notice:
         1.  your desktop response is now horrible.
         2.  X is sitting at prio 25, and is not getting better as minutes 
pass.
         3.  the gl thread (oink) is suddenly at interactive priority, and 
stays that way.
5.  minimize gl window
         What you should notice:
         1.  your desktop recovers, because..
         2.  X now recovers it's interactive priority, and the gl thread 
becomes non-interactive.
6.  scratch head ;-)

My conclusions:
1.  evil voodoo.  (then a while later..;)
2.  while X is running, but is in the expired array, the wakeups it is 
supposed to be sending to the gl thread are delayed by the amount of cpu 
used by the two cc1's (also at prio 25) it is round-robining with.  Ergo, 
the gl thread receives that quantity of additional boost.  X is not 
sleeping, he's trying to get the cpu, ergo he cannot receive sleep 
boost.  He can't get enough cpu to do his job and go to sleep long enough 
to recharge his sleep_avg.  He stays low priority.  Kobiashi-maru:  X can't 
keep the cpu long enough to catch up.  Either it expires, or it wakes the 
gl thread, is preempted, and _then_ expires, waits for cc1's, wakes gl 
thread (+big boost), gets preempted again... repeat forever, or until you 
reduce X's backlog, by minimizing,  covering or killing the gl thread.

Conclusion accuracy/inaccuracy aside, I'd like to see if anyone else can 
reproduce that second scenario.

         -Mike 

