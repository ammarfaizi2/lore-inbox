Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290731AbSARQVT>; Fri, 18 Jan 2002 11:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290732AbSARQVJ>; Fri, 18 Jan 2002 11:21:09 -0500
Received: from mx2.elte.hu ([157.181.151.9]:36516 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S290731AbSARQUx>;
	Fri, 18 Jan 2002 11:20:53 -0500
Date: Fri, 18 Jan 2002 19:18:10 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        =?ISO-8859-1?Q?Dieter_=5Biso-8859-15=5D_N=FCtzel?= 
	<Dieter.Nuetzel@hamburg.de>,
        Martin Knoblauch <Martin.Knoblauch@TeraPort.de>,
        Davide Libenzi <davidel@xmailserver.org>,
        Ed Tomlinson <tomlins@cam.org>, Rene Rebe <rene.rebe@gmx.net>
Subject: [patch] O(1) scheduler updates, -J2
Message-ID: <Pine.LNX.4.33.0201181710520.10122-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the -J2 O(1) scheduler patch is available:

    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.5.3-pre1-J2.patch
    http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-J2.patch

Changes since -J0:

 - Ed Tomlinson: optimize wake_up_forked_process() further.

 - the -J0 patch had a broken version of the task migration code - it did
   not include all the necessery changes for task migration to work at
   all. This broke 3 or more CPU boxes. The setting of the task-migration
   IPI vector was missing. -J2test-booted on an 8-way system just fine.

 - micro-optimize wakeup: high-frequency wakeups do not call the average
   calculation code.

 - finishing touches on interactiveness:

  1) default-niceness processes can only reach 90% of the full priority
     range. This protects normal processes from nice +10 CPU hogs, and
     protects nice -20 interactive tasks (audio playback, emergency
     shells, etc.) from normal processes.

  2) updates on priority inheritance of forked children: child processes
     get 80% of the parent's priority. [it was 66% in -J0.] The difference
     is visible during high compilation load, xterms under Gnome/KDE start
     up much faster, because such startups create two new processes, thus
     the second process gets the penalty twice. With 80%, the penalty is
     just enough for the shell to stay out of the 'CPU-bound hell' of
     compilation jobs.

  3) the 0...39 'user priority' range is now split up into three areas:

        A) 'unconditionally interactive tasks' in the lower 25% range.
        B) 'CPU-bound tasks' in the high 25% range.
        C) 'conditionally interactive tasks' in the middle 50% range.

     tasks in category B) are interactive if they are 10% below their
     default priority. (ie. if they sleep more than they do run.)

the new interactivenes changes made my systems even smoother than they
were under 2.5.3-pre1. None of the interactiveness logic changes add
overhead to the fast path. (the changes are either compile-time, or are in
some slow path.) Every of the above three changes was measured to improve
interactivity in compilation workloads and other workloads.

Comments, reports, suggestions welcome. Especially the testing of
interactiveness would be great, comparing the -J2 patch against other
kernels. (stock or patched kernels, 2.4 or 2.5 kernels, older O(1)
scheduler patches, etc.)

	Ingo

