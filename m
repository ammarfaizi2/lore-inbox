Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbSLEBmu>; Wed, 4 Dec 2002 20:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbSLEBmu>; Wed, 4 Dec 2002 20:42:50 -0500
Received: from kathmandu.sun.com ([192.18.98.36]:21126 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S267177AbSLEBml>;
	Wed, 4 Dec 2002 20:42:41 -0500
From: Timothy Hockin <th122948@scl2.sfbay.sun.com>
Message-Id: <200212050150.gB51oDa16915@scl2.sfbay.sun.com>
Subject: [BK SUMMARY] Remove NGROUPS hard limit (re-re-re-re-send)
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Date: Wed, 4 Dec 2002 17:50:13 -0800 (PST)
Reply-To: thockin@sun.com
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

This patch removes the hard NGROUPS limit.  It has been in use in a similar
form on our systems for some time.

There is a small change needed for glibc, and I will send that patch to the
glibc people when this gets pulled.

Unlike some prior versions of this patch, I have changed qsort() to a simple
non-recursive sort.  Several people indicated that this change would solve
their objections.  I have also changed the behavior of sys_setgroups to use an
inline array of gid_t for small sets of groups.  Larger sets of groups use
kmalloc, and very large sets use vmalloc.  This has turned up a big speed
increase for the (admittedly stupid) test of setgroups() in a loop with random
data and sets of 1-32 items, repeated hundreds of thousands of times, as well
as the tests of setgroups with random set sizes between 1 and 10000.

Lastly, this does not fixup all the architectures.  I have or will soon have
other patchsets for that, which need to be reviewed by arch maintainers.

Tim


Please do a

	bk pull http://suncobalt.bkbits.net/ngroups-2.5

This will update the following files:

 fs/nfsd/auth.c                 |   11 +--
 fs/proc/array.c                |    2 
 include/asm-i386/param.h       |    4 -
 include/linux/init_task.h      |    1 
 include/linux/kernel.h         |    3 
 include/linux/limits.h         |    3 
 include/linux/sched.h          |    6 +
 include/linux/sunrpc/svcauth.h |    3 
 kernel/exit.c                  |    7 +
 kernel/fork.c                  |    7 +
 kernel/sys.c                   |  144 ++++++++++++++++++++++++++++++++++-------
 kernel/uid16.c                 |   64 +++++++++++++-----
 lib/Makefile                   |    4 -
 lib/bsearch.c                  |   49 +++++++++++++
 net/sunrpc/svcauth_unix.c      |    4 -
 15 files changed, 256 insertions(+), 56 deletions(-)

through these ChangeSets (diffs in separate email):

<thockin@freakshow.cobalt.com> (02/12/04 1.906)
   Remove the limit of 32 groups.  We now have a per-task, dynamic array of
   groups, which is kept sorted and refcounted.  If the task has less than 32 
   groups, we behave like older kernels and use an inline array.
   
   This ChangeSet incorporates all the core functionality. but does not fixup
   all the incorrect architecture usages of groups.

