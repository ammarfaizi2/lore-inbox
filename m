Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTELB7Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 21:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTELB7Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 21:59:24 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:56990 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261858AbTELB7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 21:59:23 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: linux-kernel@vger.kernel.org
Date: Mon, 12 May 2003 12:11:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.751.11951.951210@notabene.cse.unsw.edu.au>
Subject: PATCH/RFC - process limits problem
X-Mailer: VM 7.14 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is the problem:
 We have a multi-user server that has lots of people logging on to
 it and doing all sorts of weird things.  To help keep them contained
 we set the per-user process limit to 256.
 If this server happens to have 256 or more processes running as root
 (which happens from time to time), then ordinary users cannot 
 run "lpr" (lprng version) because it tries to fork and fails: EAGAIN.

 What appears to be happening is lpr tries to fork while it has it's
 effective uid restored to the calling user's uid, but it's real user
 is still root.

 Because real uid is root, process accounting is done against root's
 processes, and because euid is not root, capabilities have been
 dropped and the process is not allowed to exceed this limit.

 This doesn't seem fair: to count the usage as though the process were
 root, but to limit it as though the process wasn't root.

 It is not obvious to me how best to fix this problem.
 One approach would be to modify lpr to use capset(2) to claim
 CAP_SYS_RESOURCE before forking, but this seems to be fixing the
 symptom rather than the problem.

 Another approach is embodied in the patch below which makes a special
 case for root_user and not to impose any limits on root.  I think
 this is better but I would appreciate hearing other perspectives.

 In brief, my view is that it seems odd to use per-process attibutes
 (such as capabilites and even rlim) when limiting a per-user resource,
 such as number of processes.  I appreciate that for compatability
 reasons we really have to store the limit per-process rather than
 per-user, but I don't think it makes sense to use a per-process
 capability to over-ride a per-user limit.  It should be a per-user
 capability.

NeilBrown





diff ./kernel/fork.c~current~ ./kernel/fork.c
--- ./kernel/fork.c~current~	2003-05-12 11:51:28.000000000 +1000
+++ ./kernel/fork.c	2003-05-12 11:53:44.000000000 +1000
@@ -636,6 +636,7 @@ int do_fork(unsigned long clone_flags, u
 	 * than the amount of processes root is running. -- Rik
 	 */
 	if (atomic_read(&p->user->processes) >= p->rlim[RLIMIT_NPROC].rlim_cur
+		      && p->user != &root_user
 	              && !capable(CAP_SYS_ADMIN) && !capable(CAP_SYS_RESOURCE))
 		goto bad_fork_free;
 
