Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbTGHSbG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 14:31:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266937AbTGHSbG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 14:31:06 -0400
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:4622 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S264937AbTGHSbC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 14:31:02 -0400
Date: Tue, 8 Jul 2003 13:45:37 -0500
From: Ryan Underwood <nemesis-lists@icequake.net>
To: linux-kernel@vger.kernel.org
Cc: witwerg@icequake.net
Subject: Forking shell bombs
Message-ID: <20030708184537.GJ1030@dbz.icequake.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

:(){ :|:&};:

Paste that into bash and watch linux die. (2.4.21 stock)

I've seen some methods of dealing with infinitely forking processes, but
short of solving the Halting Problem I doubt we will ever find a perfect
solution to _preventing_ them.  So I had a few ideas that might help an
admin _deal_ with a fork storm when it is occurring so that the S-U-B
approach can be avoided.

I also found it interesting that alt-sysrq-S took about 5 minutes to
complete the sync.  Is there some sort of priority issue there?  I would
think that kernel operations should forget about all the little annoying
processes going crazy.  Also, eventually, the OOM killer started killing
off stuff, but I noticed that it would repeatedly attempt to kill the
same pid, such as gpm's pid, up to 10 times or so.  Was it not getting
enough CPU time to die, or something?

Anyway, here are my half-baked ideas, maybe someone else has more
suggestions:

1) Alt-SysRq-<x>- then type the name of a process and hit enter.  All
processes matching this name are killed.  Drawback -- if you use this to
kill e.g. bash, all your login shells will die too, putting a desktop
user back at a login prompt.  This is ok for servers, not for desktops.
This would solve shell bombs but not compiled bombs -- a process would
just overwrite argv[0] after it forks with random gibberish to defeat
it.

2) Alt-SysRq-<x> - Kill all processes that share the most popular
process size in the system table.  This way even if the name is changed,
if there is a process making infinite copies of itself, since all the
processes are carrying out the same action, they may have the same size.
This is speculation and may be wrong.

3) Alt-SysRq-<x> - Kill the process that has the most descendent
processes.   This could be made "smart" so that it only kills off the
part of the process tree where it really starts branching off, which
is a likely candidate for where the fork bomb started.

4) Since processes are created with increasing pids, a "killall" against
a fork bomb does nothing.  It simply starts killing processes matching
that name starting at the lowest pid.  But the processes which are
forking at higher pids eventually wrap around and get lower pids again,
which makes you end up with a forkbomb ring buffer.  Not too effective
at getting rid of the problem.

What about some sort of reverse killall, or a killall with specific
capabilities tailored to taking out fork bombs?  My roommate suggested
perhaps a "killall-bomb" may be in order.  A killall that forks
infinitely just like the bomb does, but also works to kill off the bomb
by filling up the process table itself.  Eventually the predators should
exhaust their prey, and then expire themselves with nothing left to eat.

5) Alt-SysRq-<x> - Until this key combination is pressed again, when a
process tries to fork(), kill it instead.  After a couple seconds, all
the forking annoyances should be gone.   You may lose some legitimate
processes who try to fork within that interval, but you will most likely
retain control of your system with little interruption. (?)

6) A fork flag in a process header?  Perhaps like the digital copy
flag to impose restrictions on consumer devices, a process should only
be allowed to fork a set number of times before any further fork returns
-1.

When I am in sysadmin mode, the very last thing on earth I want to do is
admit defeat to errant programs running on my system.  Perhaps the Linux
kernel can be made more resilient to fork bomb behavior in the first
place, but if not, it would certainly help to be able to take care of
the problem once it is already happening, aside from a punch of the reset
button.

Comments appreciated!

See ya,

-- 
Ryan Underwood, <nemesis at icequake.net>, icq=10317253
