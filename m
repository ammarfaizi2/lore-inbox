Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319258AbSIKSJi>; Wed, 11 Sep 2002 14:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319259AbSIKSJi>; Wed, 11 Sep 2002 14:09:38 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:26031 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319258AbSIKSJe>; Wed, 11 Sep 2002 14:09:34 -0400
Subject: Killing/balancing processes when overcommited
To: linux-kernel@vger.kernel.org
Cc: riel@conectiva.com.br, ltc@linux.ibm.com, "Troy Reed" <tdreed@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFA28F240F.93209971-ON88256C31.005E5F03@boulder.ibm.com>
From: "Jim Sibley" <jlsibley@us.ibm.com>
Date: Wed, 11 Sep 2002 11:08:43 -0700
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/11/2002 12:13:33 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have run into a situation in a multi-user Linux environment that when
memory is exhausted, random things happen. The best case is that the
"offending" user's task is killed. Just as likely, another user's task is
killed. In some cases, important tasks such as the telnet deamon are
killed. In extreme cases, something is killed that is critical to the
over-all well being of the system, causing random loops, kernel panics, or
system "autism" (where it is not running and responds to no external
intervention other than a reboot).

Since Rik Riel is listed as the author of the oom_kill module (which is
still the one being used in Linux 2.5), I contacted him and he suggested I
contact the vger.kernel.org.

We running Linux in multi-user, SMP, large memory environment (an LPAR in a
zSeries with 2 GB of real memory, but this could just as well happen be on
any other hardware platform). We have several Linux systems running with
4-8 swap volumes or 10-18 GB of real+swap memory and we have run Linux
systems with over 40 GB of real+swap for significant periods, so the paging
mechanism seems to be quite robust in general.

However, when the memory+swap space becomes full, we start getting random
problems. I've turned on the debugging in oom_kill and have watched how the
"kill" scores are calculated and it seems rather random to me.  When the
memory is exhuasted Linux needs some attention. In a "well tuned" system,
we are safe, but when the system accidentally (or deliberately) becomes
"detuned", oom_kill is entered and arbitrarily kills  a  process.

Essentially, Linux has no real conception of "importance" to the
installation. In a single user environment, this is a moot point and
oom_kill works well enough.

In a multi-user environment oom_kill needs to be more selective. There is
no good algorithmic method to make a determination to terminate with
extreme prejudice:

1 - cpu usage may not be a good measure - the user causing the system to
"become detuned" may use little CPU. The assumption that the memory
offender is consuming CPU, such as being in a loop, is neither necessary
nor sufficient. If the system has been running for quite a while (days,
weeks, months), important tasks may have accumulated a relatively large
amount of CPU time and become higher profile targets for oom_kill.

2 - Large memory tasks may not be a good measure as some important tasks
often have large memory and working set prequirements, such as a database
server.

3 - Measuring memory by task rather than total memory usage of the user is
misleading because a single task which uses a moderate amount of memory
scores higher than a single user with a lot of small tasks using more
memory.

4 - Niceness is not really useful in a multi-user environment. Each user
gets to determine how nice he is. In a commerical environment, business
needs determine the "niceness". A long running process that uses a lot of
resources may be very important to the business, but could run at a lower
priority to allow better interactive response for all users. Killing it
just because it has been "niced" is not adequate.

5 - Other numerical limits tend to be arbitrary. Resources should be
allocated by  installation need. Resources should be used by the
installations most important users when they need them and others when the
resources are available.

Since algorithmic methods don't really do the job, I suggest that there
should be some way for the installation to designate importance (not just
for oom_kill, but for overall use of resources).

For example, a file in /etc could be read that lists the processes by
userid or group in the order of importance or give them a weight. When
oom_kill or other processes need to make a decision to limit resources or
kill a task, users or groups with the lowest priority would be most
restricted or killed first.

Suppose an installation decided to replace a lot of desktop Linuxes with
thin clients and a large central Linux server (hardware platform is up to
the installation) for running servers, client processes, data base
services, data storage and sharing, and backup.

You might see the installations priority list like this (lowest priority is
most important, highest value is least important).  Kill priority would be
the importance of keeping the process or task running. I've also added a
Resource priority to give an indication of who should get resources first
(such as CPU or devices).

                                    resource
     group                          priority                kill priority
     system                         0                       0 - never kill
     support                        1                       1
     payroll                        2                       2
     production                     3                       3
     general user                   4                       4
     production backgournd    5           3   <- make sure testing and
general user are killed BEFORE production
     testing                        6                       5

Note that in the example above, production has the second lowest resource
priority, but a higher kill priority ("we don't care how long it takes, but
it must complete").

In a system with sufficient resources, everyone would get what they needed.
As resources become limit, payroll gets resources first and testing gets
the least. In the extreme case, when the system is overwhelmed, testing is
the first to be removed.

This approach also has the advantage in a multi-user environment that the
system administrator would get phone calls and spam when before the
important processes are jeopardized from the less important users and
hopefully have time to react.


Regards, Jim
Linux S/390-zSeries Support, SEEL, IBM Silicon Valley Labs
t/l 543-4021, 408-463-4021, jlsibley@us.ibm.com
*** Grace Happens ***



