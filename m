Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263849AbTIICCj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263856AbTIICCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:02:39 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:48913
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263849AbTIICCH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:02:07 -0400
Subject: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030820194940.6b949d9d.akpm@osdl.org>
References: <1061424262.24785.29.camel@localhost.localdomain>
	 <20030820194940.6b949d9d.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1063072786.4004.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 18:59:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 19:49, Andrew Morton wrote:
> Using current->thread_group->foo sounds like a reasonable solution

Here's a patch to use group_leader->pgrp rather than just ->pgrp so that
all threads in a group appear to have the same process group ID.  This
is against 2.6.0-test4-mm6, and so it backs out the previous patch to
kernel/sys.c.

I'm running this now, and it seems to work, including the original test
with which I noticed the original problem.  I can't claim to have
heavily tested it though.  I think I've compiled all the affected code,
except the non-x86 arch-specific stuff.  The only mildly subtle stuff
seems to be in around the handling of execve() in kernel/pid.c.

	J

 arch/h8300/kernel/signal.c     |    2 +-
 arch/m68k/kernel/signal.c      |    2 +-
 arch/m68knommu/kernel/signal.c |    2 +-
 arch/mips/kernel/irixelf.c     |    2 +-
 arch/mips/kernel/irixsig.c     |    2 +-
 arch/mips/kernel/sysirix.c     |    4 ++--
 arch/sparc64/solaris/misc.c    |    4 ++--
 drivers/char/n_tty.c           |    6 +++---
 drivers/char/rocket.c          |    2 +-
 drivers/char/tty_io.c          |    2 +-
 fs/autofs/autofs_i.h           |    2 +-
 fs/autofs/inode.c              |    2 +-
 fs/autofs/root.c               |    4 ++--
 fs/autofs4/autofs_i.h          |    2 +-
 fs/autofs4/inode.c             |    4 ++--
 fs/autofs4/root.c              |    4 ++--
 fs/binfmt_elf.c                |    4 ++--
 fs/coda/upcall.c               |    2 +-
 fs/devfs/base.c                |    6 +++---
 fs/proc/array.c                |    2 +-
 kernel/exit.c                  |   20 ++++++++++----------
 kernel/pid.c                   |    2 +-
 kernel/signal.c                |    4 ++--
 kernel/sys.c                   |   21 +++++----------------
 24 files changed, 48 insertions(+), 59 deletions(-)

diff -puN arch/h8300/kernel/signal.c~pgrp arch/h8300/kernel/signal.c
--- local-2.6/arch/h8300/kernel/signal.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/h8300/kernel/signal.c	2003-09-08 18:19:32.000000000 -0700
@@ -593,7 +593,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(current->group_leader->pgrp))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/m68k/kernel/signal.c~pgrp arch/m68k/kernel/signal.c
--- local-2.6/arch/m68k/kernel/signal.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/m68k/kernel/signal.c	2003-09-08 18:19:32.000000000 -0700
@@ -1082,7 +1082,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(current->group_leader->pgrp))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/m68knommu/kernel/signal.c~pgrp arch/m68knommu/kernel/signal.c
--- local-2.6/arch/m68knommu/kernel/signal.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/m68knommu/kernel/signal.c	2003-09-08 18:19:32.000000000 -0700
@@ -841,7 +841,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(current->group_leader->pgrp))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/mips/kernel/irixelf.c~pgrp arch/mips/kernel/irixelf.c
--- local-2.6/arch/mips/kernel/irixelf.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/mips/kernel/irixelf.c	2003-09-08 18:19:32.000000000 -0700
@@ -1129,7 +1129,7 @@ static int irix_core_dump(long signr, st
 	prstatus.pr_sighold = current->blocked.sig[0];
 	psinfo.pr_pid = prstatus.pr_pid = current->pid;
 	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
-	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
+	psinfo.pr_pgrp = prstatus.pr_pgrp = current->group_leader->pgrp;
 	psinfo.pr_sid = prstatus.pr_sid = current->session;
 	prstatus.pr_utime.tv_sec = CT_TO_SECS(current->utime);
 	prstatus.pr_utime.tv_usec = CT_TO_USECS(current->utime);
diff -puN arch/mips/kernel/irixsig.c~pgrp arch/mips/kernel/irixsig.c
--- local-2.6/arch/mips/kernel/irixsig.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/mips/kernel/irixsig.c	2003-09-08 18:19:32.000000000 -0700
@@ -582,7 +582,7 @@ repeat:
 		p = list_entry(_p,struct task_struct,sibling);
 		if ((type == P_PID) && p->pid != pid)
 			continue;
-		if ((type == P_PGID) && p->pgrp != pid)
+		if ((type == P_PGID) && p->group_leader->pgrp != pid)
 			continue;
 		if ((p->exit_signal != SIGCHLD))
 			continue;
diff -puN arch/mips/kernel/sysirix.c~pgrp arch/mips/kernel/sysirix.c
--- local-2.6/arch/mips/kernel/sysirix.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/mips/kernel/sysirix.c	2003-09-08 18:19:32.000000000 -0700
@@ -803,11 +803,11 @@ asmlinkage int irix_setpgrp(int flags)
 	printk("[%s:%d] setpgrp(%d) ", current->comm, current->pid, flags);
 #endif
 	if(!flags)
-		error = current->pgrp;
+		error = current->group_leader->pgrp;
 	else
 		error = sys_setsid();
 #ifdef DEBUG_PROCGRPS
-	printk("returning %d\n", current->pgrp);
+	printk("returning %d\n", current->group_leader->pgrp);
 #endif
 
 	return error;
diff -puN arch/sparc64/solaris/misc.c~pgrp arch/sparc64/solaris/misc.c
--- local-2.6/arch/sparc64/solaris/misc.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/arch/sparc64/solaris/misc.c	2003-09-08 18:19:32.000000000 -0700
@@ -392,7 +392,7 @@ asmlinkage int solaris_procids(int cmd, 
 	
 	switch (cmd) {
 	case 0: /* getpgrp */
-		return current->pgrp;
+		return current->group_leader->pgrp;
 	case 1: /* setpgrp */
 		{
 			int (*sys_setpgid)(pid_t,pid_t) =
@@ -403,7 +403,7 @@ asmlinkage int solaris_procids(int cmd, 
 			ret = sys_setpgid(0, 0);
 			if (ret) return ret;
 			current->tty = NULL;
-			return current->pgrp;
+			return current->group_leader->pgrp;
 		}
 	case 2: /* getsid */
 		{
diff -puN drivers/char/n_tty.c~pgrp drivers/char/n_tty.c
--- local-2.6/drivers/char/n_tty.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/drivers/char/n_tty.c	2003-09-08 18:19:32.000000000 -0700
@@ -977,11 +977,11 @@ do_it_again:
 	if (file->f_op->write != redirected_tty_write && current->tty == tty) {
 		if (tty->pgrp <= 0)
 			printk("read_chan: tty->pgrp <= 0!\n");
-		else if (current->pgrp != tty->pgrp) {
+		else if (current->group_leader->pgrp != tty->pgrp) {
 			if (is_ignored(SIGTTIN) ||
-			    is_orphaned_pgrp(current->pgrp))
+			    is_orphaned_pgrp(current->group_leader->pgrp))
 				return -EIO;
-			kill_pg(current->pgrp, SIGTTIN, 1);
+			kill_pg(current->group_leader->pgrp, SIGTTIN, 1);
 			return -ERESTARTSYS;
 		}
 	}
diff -puN drivers/char/rocket.c~pgrp drivers/char/rocket.c
--- local-2.6/drivers/char/rocket.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/drivers/char/rocket.c	2003-09-08 18:19:32.000000000 -0700
@@ -956,7 +956,7 @@ static int rp_open(struct tty_struct *tt
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
 	info->session = current->session;
-	info->pgrp = current->pgrp;
+	info->pgrp = current->group_leader->pgrp;
 
 	if ((info->flags & ROCKET_INITIALIZED) == 0) {
 		cp = &info->channel;
diff -puN drivers/char/tty_io.c~pgrp drivers/char/tty_io.c
--- local-2.6/drivers/char/tty_io.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/drivers/char/tty_io.c	2003-09-08 18:19:32.000000000 -0700
@@ -325,7 +325,7 @@ int tty_check_change(struct tty_struct *
 		printk(KERN_WARNING "tty_check_change: tty->pgrp <= 0!\n");
 		return 0;
 	}
-	if (current->pgrp == tty->pgrp)
+	if (current->group_leader->pgrp == tty->pgrp)
 		return 0;
 	if (is_ignored(SIGTTOU))
 		return 0;
diff -puN fs/autofs/autofs_i.h~pgrp fs/autofs/autofs_i.h
--- local-2.6/fs/autofs/autofs_i.h~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs/autofs_i.h	2003-09-08 18:19:32.000000000 -0700
@@ -123,7 +123,7 @@ static inline struct autofs_sb_info *aut
    filesystem without "magic".) */
 
 static inline int autofs_oz_mode(struct autofs_sb_info *sbi) {
-	return sbi->catatonic || current->pgrp == sbi->oz_pgrp;
+	return sbi->catatonic || current->group_leader->pgrp == sbi->oz_pgrp;
 }
 
 /* Hash operations */
diff -puN fs/autofs/inode.c~pgrp fs/autofs/inode.c
--- local-2.6/fs/autofs/inode.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs/inode.c	2003-09-08 18:19:32.000000000 -0700
@@ -51,7 +51,7 @@ static int parse_options(char *options, 
 	
 	*uid = current->uid;
 	*gid = current->gid;
-	*pgrp = current->pgrp;
+	*pgrp = current->group_leader->pgrp;
 
 	*minproto = *maxproto = AUTOFS_PROTO_VERSION;
 
diff -puN fs/autofs/root.c~pgrp fs/autofs/root.c
--- local-2.6/fs/autofs/root.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs/root.c	2003-09-08 18:19:32.000000000 -0700
@@ -213,7 +213,7 @@ static struct dentry *autofs_root_lookup
 
 	oz_mode = autofs_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, current->pgrp, sbi->catatonic, oz_mode));
+		 current->pid, current->group_leader->pgrp, sbi->catatonic, oz_mode));
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
@@ -527,7 +527,7 @@ static int autofs_root_ioctl(struct inod
 {
 	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
 
-	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",cmd,arg,sbi,current->pgrp));
+	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",cmd,arg,sbi,current->group_leader->pgrp));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
diff -puN fs/autofs4/autofs_i.h~pgrp fs/autofs4/autofs_i.h
--- local-2.6/fs/autofs4/autofs_i.h~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs4/autofs_i.h	2003-09-08 18:19:32.000000000 -0700
@@ -113,7 +113,7 @@ static inline struct autofs_info *autofs
    filesystem without "magic".) */
 
 static inline int autofs4_oz_mode(struct autofs_sb_info *sbi) {
-	return sbi->catatonic || current->pgrp == sbi->oz_pgrp;
+	return sbi->catatonic || current->group_leader->pgrp == sbi->oz_pgrp;
 }
 
 /* Does a dentry have some pending activity? */
diff -puN fs/autofs4/inode.c~pgrp fs/autofs4/inode.c
--- local-2.6/fs/autofs4/inode.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs4/inode.c	2003-09-08 18:19:32.000000000 -0700
@@ -101,7 +101,7 @@ static int parse_options(char *options, 
 	
 	*uid = current->uid;
 	*gid = current->gid;
-	*pgrp = current->pgrp;
+	*pgrp = current->group_leader->pgrp;
 
 	*minproto = AUTOFS_MIN_PROTO_VERSION;
 	*maxproto = AUTOFS_MAX_PROTO_VERSION;
@@ -192,7 +192,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = current->pgrp;
+	sbi->oz_pgrp = current->group_leader->pgrp;
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->queues = NULL;
diff -puN fs/autofs4/root.c~pgrp fs/autofs4/root.c
--- local-2.6/fs/autofs4/root.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/autofs4/root.c	2003-09-08 18:19:32.000000000 -0700
@@ -255,7 +255,7 @@ static struct dentry *autofs4_root_looku
 	lock_kernel();
 	oz_mode = autofs4_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, current->pgrp, sbi->catatonic, oz_mode));
+		 current->pid, current->group_leader->pgrp, sbi->catatonic, oz_mode));
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
@@ -518,7 +518,7 @@ static int autofs4_root_ioctl(struct ino
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
 
 	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
-		 cmd,arg,sbi,current->pgrp));
+		 cmd,arg,sbi,current->group_leader->pgrp));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
diff -puN fs/binfmt_elf.c~pgrp fs/binfmt_elf.c
--- local-2.6/fs/binfmt_elf.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/binfmt_elf.c	2003-09-08 18:19:32.000000000 -0700
@@ -1076,7 +1076,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_sighold = p->blocked.sig[0];
 	prstatus->pr_pid = p->pid;
 	prstatus->pr_ppid = p->parent->pid;
-	prstatus->pr_pgrp = p->pgrp;
+	prstatus->pr_pgrp = p->group_leader->pgrp;
 	prstatus->pr_sid = p->session;
 	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
 	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
@@ -1104,7 +1104,7 @@ static void fill_psinfo(struct elf_prpsi
 
 	psinfo->pr_pid = p->pid;
 	psinfo->pr_ppid = p->parent->pid;
-	psinfo->pr_pgrp = p->pgrp;
+	psinfo->pr_pgrp = p->group_leader->pgrp;
 	psinfo->pr_sid = p->session;
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
diff -puN fs/coda/upcall.c~pgrp fs/coda/upcall.c
--- local-2.6/fs/coda/upcall.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/coda/upcall.c	2003-09-08 18:19:32.000000000 -0700
@@ -54,7 +54,7 @@ static void *alloc_upcall(int opcode, in
 
         inp->ih.opcode = opcode;
 	inp->ih.pid = current->pid;
-	inp->ih.pgid = current->pgrp;
+	inp->ih.pgid = current->group_leader->pgrp;
 	coda_load_creds(&(inp->ih.cred));
 
 	return (void*)inp;
diff -puN fs/devfs/base.c~pgrp fs/devfs/base.c
--- local-2.6/fs/devfs/base.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/devfs/base.c	2003-09-08 18:19:32.000000000 -0700
@@ -1334,7 +1334,7 @@ static int is_devfsd_or_child (struct fs
     struct task_struct *p = current;
 
     if (p == fs_info->devfsd_task) return (TRUE);
-    if (p->pgrp == fs_info->devfsd_pgrp) return (TRUE);
+    if (p->group_leader->pgrp == fs_info->devfsd_pgrp) return (TRUE);
     read_lock(&tasklist_lock);
     for ( ; p != &init_task; p = p->real_parent)
     {
@@ -2745,8 +2745,8 @@ static int devfsd_ioctl (struct inode *i
 	    }
 	    fs_info->devfsd_task = current;
 	    spin_unlock (&lock);
-	    fs_info->devfsd_pgrp = (current->pgrp == current->pid) ?
-		current->pgrp : 0;
+	    fs_info->devfsd_pgrp = (current->group_leader->pgrp == current->pid) ?
+		current->group_leader->pgrp : 0;
 	    fs_info->devfsd_file = file;
 	    fs_info->devfsd_info = kmalloc (sizeof *fs_info->devfsd_info,
 					    GFP_KERNEL);
diff -puN fs/proc/array.c~pgrp fs/proc/array.c
--- local-2.6/fs/proc/array.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/fs/proc/array.c	2003-09-08 18:19:32.000000000 -0700
@@ -344,7 +344,7 @@ int proc_pid_stat(struct task_struct *ta
 		task->comm,
 		state,
 		ppid,
-		task->pgrp,
+		task->group_leader->pgrp,
 		task->session,
 		tty_nr,
 		tty_pgrp,
diff -puN kernel/exit.c~pgrp kernel/exit.c
--- local-2.6/kernel/exit.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/kernel/exit.c	2003-09-08 18:19:32.000000000 -0700
@@ -152,7 +152,7 @@ static int will_become_orphaned_pgrp(int
 				|| p->state >= TASK_ZOMBIE 
 				|| p->real_parent->pid == 1)
 			continue;
-		if (p->real_parent->pgrp != pgrp
+		if (p->real_parent->group_leader->pgrp != pgrp
 			    && p->real_parent->session == p->session) {
 			ret = 0;
 			break;
@@ -247,9 +247,9 @@ void __set_special_pids(pid_t session, p
 		curr->session = session;
 		attach_pid(curr, PIDTYPE_SID, session);
 	}
-	if (curr->pgrp != pgrp) {
+	if (curr->group_leader->pgrp != pgrp) {
 		detach_pid(curr, PIDTYPE_PGID);
-		curr->pgrp = pgrp;
+		curr->group_leader->pgrp = pgrp;
 		attach_pid(curr, PIDTYPE_PGID, pgrp);
 	}
 }
@@ -618,12 +618,12 @@ static void exit_notify(struct task_stru
 	 
 	t = tsk->real_parent;
 	
-	if ((t->pgrp != tsk->pgrp) &&
+	if ((t->group_leader->pgrp != tsk->group_leader->pgrp) &&
 	    (t->session == tsk->session) &&
-	    will_become_orphaned_pgrp(tsk->pgrp, tsk) &&
-	    has_stopped_jobs(tsk->pgrp)) {
-		__kill_pg_info(SIGHUP, (void *)1, tsk->pgrp);
-		__kill_pg_info(SIGCONT, (void *)1, tsk->pgrp);
+	    will_become_orphaned_pgrp(tsk->group_leader->pgrp, tsk) &&
+	    has_stopped_jobs(tsk->group_leader->pgrp)) {
+		__kill_pg_info(SIGHUP, (void *)1, tsk->group_leader->pgrp);
+		__kill_pg_info(SIGCONT, (void *)1, tsk->group_leader->pgrp);
 	}
 
 	/* Let father know we died 
@@ -813,10 +813,10 @@ static int eligible_child(pid_t pid, int
 		if (p->pid != pid)
 			return 0;
 	} else if (!pid) {
-		if (p->pgrp != current->pgrp)
+		if (p->group_leader->pgrp != current->group_leader->pgrp)
 			return 0;
 	} else if (pid != -1) {
-		if (p->pgrp != -pid)
+		if (p->group_leader->pgrp != -pid)
 			return 0;
 	}
 
diff -puN kernel/pid.c~pgrp kernel/pid.c
--- local-2.6/kernel/pid.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/kernel/pid.c	2003-09-08 18:19:32.000000000 -0700
@@ -250,7 +250,7 @@ void switch_exec_pids(task_t *leader, ta
 
 	attach_pid(thread, PIDTYPE_PID, thread->pid);
 	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
-	attach_pid(thread, PIDTYPE_PGID, thread->pgrp);
+	attach_pid(thread, PIDTYPE_PGID, leader->pgrp);
 	attach_pid(thread, PIDTYPE_SID, thread->session);
 	list_add_tail(&thread->tasks, &init_task.tasks);
 
diff -puN kernel/signal.c~pgrp kernel/signal.c
--- local-2.6/kernel/signal.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/kernel/signal.c	2003-09-08 18:19:32.000000000 -0700
@@ -1139,7 +1139,7 @@ kill_proc_info(int sig, struct siginfo *
 static int kill_something_info(int sig, struct siginfo *info, int pid)
 {
 	if (!pid) {
-		return kill_pg_info(sig, info, current->pgrp);
+		return kill_pg_info(sig, info, current->group_leader->pgrp);
 	} else if (pid == -1) {
 		int retval = 0, count = 0;
 		struct task_struct * p;
@@ -1798,7 +1798,7 @@ relock:
 
 			/* signals can be posted during this window */
 
-			if (is_orphaned_pgrp(current->pgrp))
+			if (is_orphaned_pgrp(current->group_leader->pgrp))
 				goto relock;
 
 			spin_lock_irq(&current->sighand->siglock);
diff -puN kernel/sys.c~pgrp kernel/sys.c
--- local-2.6/kernel/sys.c~pgrp	2003-09-08 18:19:32.000000000 -0700
+++ local-2.6-jeremy/kernel/sys.c	2003-09-08 18:40:17.000000000 -0700
@@ -290,7 +290,7 @@ asmlinkage long sys_setpriority(int whic
 			break;
 		case PRIO_PGRP:
 			if (!who)
-				who = current->pgrp;
+				who = current->group_leader->pgrp;
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid)
 				error = set_one_prio(p, niceval, error);
 			break;
@@ -346,7 +346,7 @@ asmlinkage long sys_getpriority(int whic
 			break;
 		case PRIO_PGRP:
 			if (!who)
-				who = current->pgrp;
+				who = current->group_leader->pgrp;
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
@@ -985,17 +985,6 @@ ok_pgid:
 		attach_pid(p, PIDTYPE_PGID, pgid);
 	}
 
-	{
-		/* update all threads in thread group
-		   to new process group */
-		struct task_struct *p;
-		struct pid *pidp;
-		struct list_head *l;
-
-		for_each_task_pid(pid, PIDTYPE_TGID, p, l, pidp)
-			p->pgrp = pgid;
-	}
-
 	err = 0;
 out:
 	/* All paths lead to here, thus we are safe. -DaveM */
@@ -1006,7 +995,7 @@ out:
 asmlinkage long sys_getpgid(pid_t pid)
 {
 	if (!pid) {
-		return current->pgrp;
+		return current->group_leader->pgrp;
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1018,7 +1007,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 		if (p) {
 			retval = security_task_getpgid(p);
 			if (!retval)
-				retval = p->pgrp;
+				retval = p->group_leader->pgrp;
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
@@ -1028,7 +1017,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 asmlinkage long sys_getpgrp(void)
 {
 	/* SMP - assuming writes are word atomic this is fine */
-	return current->pgrp;
+	return current->group_leader->pgrp;
 }
 
 asmlinkage long sys_getsid(pid_t pid)

_


