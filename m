Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270482AbTGNBWq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 21:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270484AbTGNBWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 21:22:46 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:62681 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S270482AbTGNBWo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 21:22:44 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 14 Jul 2003 11:37:27 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16146.2391.214514.872743@gargle.gargle.HOWL>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Fix two bugs with process limits (RLIMIT_NPROC)
X-Mailer: VM 7.16 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch fixes to problems with RLIMIT_NPROC.
I posted the first to linux-kernel some weeks ago and got zero
response, which presumably means it is perfect :-)

The second bit is new and corresponds to the comment that has been
moved from set_user to user.c:switch_uid and says:
	/* What if a process setreuid()'s and this brings the
	 * new uid over his NPROC rlimit?  We can check this now
	 * cheaply with the new uid cache, so if it matters
	 * we should be checking for it.  -DaveM
	 */

NeilBrown


### Comments for ChangeSet
1/ If a setuid process swaps it's real and effective uids and then forks,
 the fork fails if the new realuid has more processes 
 than the original process was limited to.
 This is particularly a problem if a user with a process limit
 (e.g. 256) runs a setuid-root program which does setuid() + fork() 
 (e.g. lprng) while root already has more than 256 process (which 
 is quite possible).

 The root problem here is that a limit which should be a per-user 
 limit is being implemented as a per-process limit with
 per-process (e.g. CAP_SYS_RESOURCE) controls.
 Being a per-user limit, it should be that the root-user can over-ride 
 it, not just some process with CAP_SYS_RESOURCE.

 This patch adds a test to ignore process limits if the real user is root.

2/ When a root-owned process (e.g. cgiwrap) sets up process limits and then
  calls setuid, the setuid should fail if the user would then be running 
  more than rlim_cur[RLIMIT_NPROC] processes, but it doesn't.  This patch
  adds an appropriate test.  With this patch, and per-user process limit 
  imposed in cgiwrap really works.

 ----------- Diffstat output ------------
 ./kernel/fork.c |    3 ++-
 ./kernel/sys.c  |    8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff ./kernel/fork.c~current~ ./kernel/fork.c
--- ./kernel/fork.c~current~	2003-07-14 09:06:11.000000000 +1000
+++ ./kernel/fork.c	2003-07-14 09:06:11.000000000 +1000
@@ -792,7 +792,8 @@ struct task_struct *copy_process(unsigne
 
 	retval = -EAGAIN;
 	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur) {
-		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
+		if (!capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE)
+		    && p->user != &root_user)
 			goto bad_fork_free;
 	}
 

diff ./kernel/sys.c~current~ ./kernel/sys.c
--- ./kernel/sys.c~current~	2003-07-14 09:06:11.000000000 +1000
+++ ./kernel/sys.c	2003-07-14 09:06:11.000000000 +1000
@@ -601,6 +601,14 @@ static int set_user(uid_t new_ruid, int 
 	new_user = alloc_uid(new_ruid);
 	if (!new_user)
 		return -EAGAIN;
+
+	if (atomic_read(&new_user->processes) >= current->rlim[RLIMIT_NPROC].rlim_cur
+	    && new_user != &root_user
+		) {
+		free_uid(new_user);
+		return -EAGAIN;
+	}
+
 	switch_uid(new_user);
 
 	if(dumpclear)
