Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263050AbTCSRv5>; Wed, 19 Mar 2003 12:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263094AbTCSRv5>; Wed, 19 Mar 2003 12:51:57 -0500
Received: from sccrmhc02.attbi.com ([204.127.202.62]:45963 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S263050AbTCSRvp>; Wed, 19 Mar 2003 12:51:45 -0500
Message-ID: <3E78B141.40901@kegel.com>
Date: Wed, 19 Mar 2003 10:04:49 -0800
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: de-de, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Possible downside to recent OOM killer change?
References: <200303111835.22251.torger@ludd.luth.se> <3E6E343E.9040202@kegel.com> <200303112252.13856.torger@ludd.luth.se> <3E6E6075.1020907@kegel.com>
In-Reply-To: <3E6E6075.1020907@kegel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The OOM killer in 2.4.18 (Red Hat 8.0) appears to have two problems in my testing:
1. it picks the wrong process at first
2. after killing the memory hog, it sometimes
then goes and kills one more process.  This might
be an unexpected side effect of Rik's recent change


Details:

I'm working to tighten up my apps so I can use strict overcommit
(see http://www.kegel.com/stackcheck/ for my notes) but
still feel the need for the OOM killer as a safety net.

I ran a test app (http://kegel.com/stackcheck/harsh.cc)
to malloc and touch 45 megabytes of RAM on a Red Hat 8.0
box with no swap and 64 MB RAM.  The OOM killer killed
several wrong processes before stumbling on the right one.

So I applied an oom killer patch that gives extra badness
to processes whose RSS is above one quarter of RLIMIT_RSS
(yes, it's a horrible kludge, and it only works if you
set RLIMIT_RSS to above the amount of physical memory;
patch at http://kegel.com/stackcheck/oom-dank2.patch).
This got the OOM killer to reliably kill the correct process first
in all cases I tested.  I would prefer some less hacky
way of getting the oom killer to pick the right process,
but this is ok for the moment, as it gets me to the next
problem.

When I log in to my test box via ssh, and run the following script:

  #!/bin/sh
  /sbin/swapoff -a
  # mark the process to be preferentially killed when OOM if RSS > 16MB
  ulimit -m 64000
  # create 50 threads, each mallocing 1MB, each with 100KB threadstack
  ./harsh 469 1 1 100 100 1024000

sometimes the OOM killer kills all the threads of the memory hog in one pass;
sometimes it kills some of its threads in a first pass, and
kills the rest in a second pass about five seconds later;
and sometimes it will do a third pass and kill some innocent process.
(Since the process is madly spawning threads, it's not suprising
the OOM killer doesn't get them all in one pass.)

I've enabled DEBUG in oom_kill.c, and am watching the badness values
it prints out.  In the latter case, where it kills an extra process,
the memory hog doesn't appear in the list of badness scores, possibly
because I've applied Rik's little patch from a few days ago that
skips processes with PF_MEMDIE.  My thinking is, if the threads
have not yet died for some reason, the oom killer has no choice
but to look for another victim.  Without Rik's change, the
system would have kept trying to kill the hog forever.
Maybe some revision is needed?

For what it's worth, here are the from dmesg showing the
last three passes of the OOM killer from one run.  The
last pass killed an innocent sshd.
- Dan

OOMkill: task 1 (init) got 10 points
OOMkill: task 411 (syslogd) got 10 points
OOMkill: task 415 (klogd) got 10 points
OOMkill: task 432 (portmap) got 185 points
OOMkill: task 451 (rpc.statd) got 191 points
OOMkill: task 562 (sshd) got 25 points
OOMkill: task 575 (xinetd) got 16 points
OOMkill: task 596 (sendmail) got 39 points
OOMkill: task 605 (sendmail) got 607 points
OOMkill: task 615 (gpm) got 10 points
OOMkill: task 624 (crond) got 11 points
OOMkill: task 655 (xfs) got 553 points
OOMkill: task 673 (atd) got 42 points
OOMkill: task 682 (mingetty) got 10 points
OOMkill: task 683 (mingetty) got 10 points
OOMkill: task 684 (mingetty) got 10 points
OOMkill: task 685 (mingetty) got 10 points
OOMkill: task 686 (mingetty) got 10 points
OOMkill: task 687 (mingetty) got 10 points
OOMkill: task 1663 (su) got 64 points
OOMkill: task 1667 (bash) got 69 points
OOMkill: task 1761 (sh) got 64 points
OOMkill: task 1963 (su) got 64 points
OOMkill: task 1987 (bash) got 69 points
OOMkill: task 5335 (sh) got 64 points
OOMkill: task 6564 (sshd) got 102 points
OOMkill: task 6616 (sshd) got 1666 points
OOMkill: task 6617 (bash) got 1114 points
OOMkill: task 7064 (su) got 64 points
OOMkill: task 7098 (bash) got 69 points
OOMkill: task 8262 (sh) got 63 points
OOMkill: task 8264 (harsh) got 5667 points
OOMkill: task 8269 (sleep) got 59 points
OOMkill: task 8270 (harsh) got 5667 points
OOMkill: task 8306 (harsh) got 5667 points
OOMkill: task 8307 (harsh) got 5667 points
OOMkill: task 8317 (sleep) got 59 points
OOMkill: task 8318 (sleep) got 59 points
OOMkill: task 8320 (harsh) got 5667 points
OOMkill: task 8321 (harsh) got 5667 points
OOMkill: task 8322 (harsh) got 5667 points
OOMkill: task 8323 (harsh) got 5667 points
OOMkill: task 8324 (harsh) got 5667 points
OOMkill: task 8325 (harsh) got 5667 points
OOMkill: task 8326 (harsh) got 5667 points
OOMkill: task 8327 (harsh) got 5667 points
OOMkill: task 8328 (harsh) got 5667 points
OOMkill: task 8330 (harsh) got 5667 points
Out of Memory: Killed process 8264 (harsh).
Out of Memory: Killed process 8270 (harsh).
OOMkill: task 1 (init) got 10 points
OOMkill: task 411 (syslogd) got 10 points
OOMkill: task 415 (klogd) got 10 points
OOMkill: task 432 (portmap) got 185 points
OOMkill: task 451 (rpc.statd) got 191 points
OOMkill: task 562 (sshd) got 25 points
OOMkill: task 575 (xinetd) got 16 points
OOMkill: task 596 (sendmail) got 39 points
OOMkill: task 605 (sendmail) got 607 points
OOMkill: task 615 (gpm) got 10 points
OOMkill: task 624 (crond) got 11 points
OOMkill: task 655 (xfs) got 553 points
OOMkill: task 673 (atd) got 42 points
OOMkill: task 682 (mingetty) got 10 points
OOMkill: task 683 (mingetty) got 10 points
OOMkill: task 684 (mingetty) got 10 points
OOMkill: task 685 (mingetty) got 10 points
OOMkill: task 686 (mingetty) got 10 points
OOMkill: task 687 (mingetty) got 10 points
OOMkill: task 1663 (su) got 64 points
OOMkill: task 1667 (bash) got 69 points
OOMkill: task 1761 (sh) got 64 points
OOMkill: task 1963 (su) got 64 points
OOMkill: task 1987 (bash) got 69 points
OOMkill: task 5335 (sh) got 64 points
OOMkill: task 6564 (sshd) got 102 points
OOMkill: task 6616 (sshd) got 1666 points
OOMkill: task 6617 (bash) got 1114 points
OOMkill: task 7064 (su) got 64 points
OOMkill: task 7098 (bash) got 69 points
OOMkill: task 8262 (sh) got 63 points
OOMkill: task 8269 (sleep) got 59 points
OOMkill: task 8306 (harsh) got 5667 points
OOMkill: task 8307 (harsh) got 5667 points
OOMkill: task 8317 (sleep) got 59 points
OOMkill: task 8318 (sleep) got 59 points
OOMkill: task 8320 (harsh) got 5667 points
OOMkill: task 8321 (harsh) got 5667 points
OOMkill: task 8322 (harsh) got 5667 points
OOMkill: task 8323 (harsh) got 5667 points
OOMkill: task 8324 (harsh) got 5667 points
OOMkill: task 8325 (harsh) got 5667 points
OOMkill: task 8326 (harsh) got 5667 points
OOMkill: task 8327 (harsh) got 5667 points
OOMkill: task 8328 (harsh) got 5667 points
OOMkill: task 8330 (harsh) got 5667 points
Out of Memory: Killed process 8306 (harsh).
Out of Memory: Killed process 8307 (harsh).
Out of Memory: Killed process 8320 (harsh).
Out of Memory: Killed process 8321 (harsh).
Out of Memory: Killed process 8322 (harsh).
Out of Memory: Killed process 8323 (harsh).
Out of Memory: Killed process 8324 (harsh).
Out of Memory: Killed process 8325 (harsh).
Out of Memory: Killed process 8326 (harsh).
Out of Memory: Killed process 8327 (harsh).
Out of Memory: Killed process 8328 (harsh).
Out of Memory: Killed process 8330 (harsh).
OOMkill: task 1 (init) got 10 points
OOMkill: task 411 (syslogd) got 10 points
OOMkill: task 415 (klogd) got 10 points
OOMkill: task 432 (portmap) got 185 points
OOMkill: task 451 (rpc.statd) got 191 points
OOMkill: task 562 (sshd) got 25 points
OOMkill: task 575 (xinetd) got 16 points
OOMkill: task 596 (sendmail) got 39 points
OOMkill: task 605 (sendmail) got 607 points
OOMkill: task 615 (gpm) got 10 points
OOMkill: task 624 (crond) got 11 points
OOMkill: task 655 (xfs) got 553 points
OOMkill: task 673 (atd) got 42 points
OOMkill: task 682 (mingetty) got 10 points
OOMkill: task 683 (mingetty) got 10 points
OOMkill: task 684 (mingetty) got 10 points
OOMkill: task 685 (mingetty) got 10 points
OOMkill: task 686 (mingetty) got 10 points
OOMkill: task 687 (mingetty) got 10 points
OOMkill: task 1663 (su) got 64 points
OOMkill: task 1667 (bash) got 69 points
OOMkill: task 1761 (sh) got 64 points
OOMkill: task 1963 (su) got 64 points
OOMkill: task 1987 (bash) got 69 points
OOMkill: task 5335 (sh) got 64 points
OOMkill: task 6564 (sshd) got 102 points
OOMkill: task 6616 (sshd) got 1666 points
OOMkill: task 6617 (bash) got 1114 points
OOMkill: task 7064 (su) got 64 points
OOMkill: task 7098 (bash) got 69 points
OOMkill: task 8262 (sh) got 63 points
OOMkill: task 8269 (sleep) got 59 points
OOMkill: task 8317 (sleep) got 59 points
OOMkill: task 8318 (sleep) got 59 points
Out of Memory: Killed process 6616 (sshd).


-- 
Dan Kegel
http://www.kegel.com
http://counter.li.org/cgi-bin/runscript/display-person.cgi?user=78045


