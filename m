Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVC3GGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVC3GGS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 01:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVC3GGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 01:06:18 -0500
Received: from zeus.kernel.org ([204.152.189.113]:4333 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261581AbVC3GGM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 01:06:12 -0500
Date: Tue, 29 Mar 2005 22:05:30 -0800
From: Paul Jackson <pj@engr.sgi.com>
To: gh@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net
Subject: Re: [patch 0/8] CKRM:   Core patch set
Message-Id: <20050329220530.4a5639c8.pj@engr.sgi.com>
In-Reply-To: <E1DGTK2-0007gO-00@w-gerrit.beaverton.ibm.com>
References: <E1DGTK2-0007gO-00@w-gerrit.beaverton.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gerrit wrote:
> This is the core patch set for CKRM

Welcome.

Newcomers to CKRM might want to start reading these patches with "[patch
8/8] CKRM:  Documentation".  Starting with patch 0/8 or 1/8 will be
difficult, at least if you're as dimm witted as I am.

Even the documentation included in patch 8/8 is missing the motivation
and context essential to understanding this patch set.  It might have
helped if the Introduction text at http://ckrm.sourceforge.net/ had been
included in some form, as part of patch 0/8.  I'm just a little penguin
here (lkml), but from what I can tell by watching how things work,
you're going to have to "make the case" -- explain what this is, how
it's put togeher, and why it's needed.  This is a sizable patch, in
lines of code, in hooks in critical places, and in amount of "new
concepts."  I presume (unless you've managed to bribe or blackmail some
big penguin) you're going to have convince some others that this is
worth having.  I for one am a CKRM skeptic, so won't be much help to you
in that quest.  Good luck.

I don't see any performance numbers, either on small systems, or
scalability on large systems.  Certainly this patch does not fall under
the "obviously no performance impact" exclusion.

Here's a combined diffstat showing how much code is added by these
patches, where.  Some of the patches have individual diffstat's, some
don't seem to.

 Documentation/ckrm/TODO          |   17
 Documentation/ckrm/ckrm_basics   |   66 ++
 Documentation/ckrm/core_usage    |   72 +++
 Documentation/ckrm/crbce         |   33 +
 Documentation/ckrm/installation  |   70 +++
 Documentation/ckrm/rbce_basics   |   67 ++
 Documentation/ckrm/rbce_usage    |   98 ++++
 fs/Makefile                      |    1
 fs/exec.c                        |    2
 fs/proc/array.c                  |   18
 fs/proc/base.c                   |   17
 fs/proc/internal.h               |    1
 fs/rcfs/Makefile                 |    9
 fs/rcfs/dir.c                    |  220 +++++++++
 fs/rcfs/inode.c                  |  160 ++++++
 fs/rcfs/magic.c                  |  517 ++++++++++++++++++++++
 fs/rcfs/rootdir.c                |  220 +++++++++
 fs/rcfs/socket_fs.c              |  280 ++++++++++++
 fs/rcfs/super.c                  |  291 ++++++++++++
 fs/rcfs/tc_magic.c               |   93 ++++
 include/linux/ckrm_ce.h          |   95 ++++
 include/linux/ckrm_events.h      |  230 +++++++++-
 include/linux/ckrm_net.h         |   42 +
 include/linux/ckrm_rc.h          |  345 +++++++++++++++
 include/linux/ckrm_tc.h          |   46 ++
 include/linux/ckrm_tsk.h         |   35 +
 include/linux/rcfs.h             |  116 ++++-
 include/linux/sched.h            |  105 ++++
 include/linux/taskdelays.h       |   35 +
 include/net/sock.h               |    3
 include/net/tcp.h                |    4
 init/Kconfig                     |   68 ++
 init/main.c                      |    2
 kernel/Makefile                  |    1
 kernel/ckrm/Makefile             |   14
 kernel/ckrm/ckrm.c               |  892 +++++++++++++++++++++++++++++++++++++++
 kernel/ckrm/ckrm_events.c        |   86 +++
 kernel/ckrm/ckrm_numtasks.c      |  522 ++++++++++++++++++++++
 kernel/ckrm/ckrm_numtasks_stub.c |   53 ++
 kernel/ckrm/ckrm_sockc.c         |  559 ++++++++++++++++++++++++
 kernel/ckrm/ckrm_tc.c            |  745 ++++++++++++++++++++++++++++++++
 kernel/ckrm/ckrmutils.c          |  188 ++++++++
 kernel/exit.c                    |    3
 kernel/fork.c                    |   12
 kernel/sched.c                   |   20
 kernel/sys.c                     |   11
 mm/memory.c                      |   10
 net/ipv4/tcp_ipv4.c              |    5
 48 files changed, 6460 insertions(+), 39 deletions(-)

A couple of nits:

 1) Instead of disabling routines with #defines:
         #define numtasks_put_ref(core_class)  do {} while (0)
    one can do it with static inlines, preserving more compiler
    checking.

 2) I take it that the following constitutes the 'documentation'
    for what is in /proc/<pid>/delay.  Perhaps I missed something.

	+	res  = sprintf(buffer,"%u %llu %llu %u %llu %u %llu\n",
	+		       (unsigned int) get_delay(task,runs),
	+		       (uint64_t) get_delay(task,runcpu_total),
	+		       (uint64_t) get_delay(task,waitcpu_total),
	+		       (unsigned int) get_delay(task,num_iowaits),
	+		       (uint64_t) get_delay(task,iowait_total),
	+		       (unsigned int) get_delay(task,num_memwaits),
	+		       (uint64_t) get_delay(task,mem_iowait_total)

 3) Typo in init/Kconfig "atleast":

    If you say Y here, enable the Resource Class File System and atleast

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
