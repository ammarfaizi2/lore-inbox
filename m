Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTIIERB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263934AbTIIERB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:17:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:20673 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263945AbTIIEQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:16:21 -0400
Date: Mon, 8 Sep 2003 21:17:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: jeremy@goop.org, mingo@redhat.com, roland@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
Message-Id: <20030908211746.25fff0f1.akpm@osdl.org>
In-Reply-To: <3F5D4EFA.30102@redhat.com>
References: <1061424262.24785.29.camel@localhost.localdomain>
	<20030820194940.6b949d9d.akpm@osdl.org>
	<1063072786.4004.11.camel@localhost.localdomain>
	<20030908191215.22f501a2.akpm@osdl.org>
	<1063073637.4004.14.camel@localhost.localdomain>
	<20030908202147.3cba2ecd.akpm@osdl.org>
	<3F5D4EFA.30102@redhat.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
>  Definitely.  All occurrences have to be changed.

OK.  There were a few missing ones.  Here's what I have, against test5.  Do
you have a test suite which would give us reasonable confidence?

Could you please grep for `__pgrp' and make sure that we got everything
right there?

All other instances of foo->pgrp have been converted to process_group(foo),
which is foo->group_leader->__pgrp.

Should setpgrp() in a thread affect the group leader?   It does...


 arch/h8300/kernel/signal.c     |    2 +-
 arch/m68k/kernel/signal.c      |    2 +-
 arch/m68knommu/kernel/signal.c |    2 +-
 arch/mips/kernel/irixelf.c     |    2 +-
 arch/mips/kernel/irixsig.c     |    2 +-
 arch/mips/kernel/sysirix.c     |    4 ++--
 arch/sparc64/solaris/misc.c    |    4 ++--
 drivers/char/n_tty.c           |    6 +++---
 drivers/char/rocket.c          |    2 +-
 drivers/char/tty_io.c          |   10 +++++-----
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
 include/linux/sched.h          |    7 ++++++-
 kernel/exit.c                  |   24 ++++++++++++------------
 kernel/fork.c                  |    2 +-
 kernel/pid.c                   |    4 ++--
 kernel/signal.c                |    4 ++--
 kernel/sys.c                   |   17 +++++++++--------
 26 files changed, 66 insertions(+), 60 deletions(-)

diff -puN kernel/sys.c~group_leader-rework kernel/sys.c
--- 25/kernel/sys.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/kernel/sys.c	2003-09-08 21:12:46.000000000 -0700
@@ -290,7 +290,7 @@ asmlinkage long sys_setpriority(int whic
 			break;
 		case PRIO_PGRP:
 			if (!who)
-				who = current->pgrp;
+				who = process_group(current);
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid)
 				error = set_one_prio(p, niceval, error);
 			break;
@@ -346,7 +346,7 @@ asmlinkage long sys_getpriority(int whic
 			break;
 		case PRIO_PGRP:
 			if (!who)
-				who = current->pgrp;
+				who = process_group(current);
 			for_each_task_pid(who, PIDTYPE_PGID, p, l, pid) {
 				niceval = 20 - task_nice(p);
 				if (niceval > retval)
@@ -979,11 +979,12 @@ ok_pgid:
 	if (err)
 		goto out;
 
-	if (p->pgrp != pgid) {
+	if (process_group(p) != pgid) {
 		detach_pid(p, PIDTYPE_PGID);
-		p->pgrp = pgid;
+		p->group_leader->__pgrp = pgid;
 		attach_pid(p, PIDTYPE_PGID, pgid);
 	}
+
 	err = 0;
 out:
 	/* All paths lead to here, thus we are safe. -DaveM */
@@ -994,7 +995,7 @@ out:
 asmlinkage long sys_getpgid(pid_t pid)
 {
 	if (!pid) {
-		return current->pgrp;
+		return process_group(current);
 	} else {
 		int retval;
 		struct task_struct *p;
@@ -1006,7 +1007,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 		if (p) {
 			retval = security_task_getpgid(p);
 			if (!retval)
-				retval = p->pgrp;
+				retval = process_group(p);
 		}
 		read_unlock(&tasklist_lock);
 		return retval;
@@ -1016,7 +1017,7 @@ asmlinkage long sys_getpgid(pid_t pid)
 asmlinkage long sys_getpgrp(void)
 {
 	/* SMP - assuming writes are word atomic this is fine */
-	return current->pgrp;
+	return process_group(current);
 }
 
 asmlinkage long sys_getsid(pid_t pid)
@@ -1059,7 +1060,7 @@ asmlinkage long sys_setsid(void)
 	__set_special_pids(current->pid, current->pid);
 	current->tty = NULL;
 	current->tty_old_pgrp = 0;
-	err = current->pgrp;
+	err = process_group(current);
 out:
 	write_unlock_irq(&tasklist_lock);
 	return err;
diff -puN arch/h8300/kernel/signal.c~group_leader-rework arch/h8300/kernel/signal.c
--- 25/arch/h8300/kernel/signal.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/h8300/kernel/signal.c	2003-09-08 21:12:46.000000000 -0700
@@ -593,7 +593,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(process_group(current)))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/m68k/kernel/signal.c~group_leader-rework arch/m68k/kernel/signal.c
--- 25/arch/m68k/kernel/signal.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/m68k/kernel/signal.c	2003-09-08 21:12:46.000000000 -0700
@@ -1082,7 +1082,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(process_group(current)))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/m68knommu/kernel/signal.c~group_leader-rework arch/m68knommu/kernel/signal.c
--- 25/arch/m68knommu/kernel/signal.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/m68knommu/kernel/signal.c	2003-09-08 21:12:46.000000000 -0700
@@ -841,7 +841,7 @@ asmlinkage int do_signal(sigset_t *oldse
 				continue;
 
 			case SIGTSTP: case SIGTTIN: case SIGTTOU:
-				if (is_orphaned_pgrp(current->pgrp))
+				if (is_orphaned_pgrp(process_group(current)))
 					continue;
 				/* FALLTHRU */
 
diff -puN arch/mips/kernel/irixelf.c~group_leader-rework arch/mips/kernel/irixelf.c
--- 25/arch/mips/kernel/irixelf.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/mips/kernel/irixelf.c	2003-09-08 21:12:46.000000000 -0700
@@ -1129,7 +1129,7 @@ static int irix_core_dump(long signr, st
 	prstatus.pr_sighold = current->blocked.sig[0];
 	psinfo.pr_pid = prstatus.pr_pid = current->pid;
 	psinfo.pr_ppid = prstatus.pr_ppid = current->parent->pid;
-	psinfo.pr_pgrp = prstatus.pr_pgrp = current->pgrp;
+	psinfo.pr_pgrp = prstatus.pr_pgrp = process_group(current);
 	psinfo.pr_sid = prstatus.pr_sid = current->session;
 	prstatus.pr_utime.tv_sec = CT_TO_SECS(current->utime);
 	prstatus.pr_utime.tv_usec = CT_TO_USECS(current->utime);
diff -puN arch/mips/kernel/irixsig.c~group_leader-rework arch/mips/kernel/irixsig.c
--- 25/arch/mips/kernel/irixsig.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/mips/kernel/irixsig.c	2003-09-08 21:12:46.000000000 -0700
@@ -582,7 +582,7 @@ repeat:
 		p = list_entry(_p,struct task_struct,sibling);
 		if ((type == P_PID) && p->pid != pid)
 			continue;
-		if ((type == P_PGID) && p->pgrp != pid)
+		if ((type == P_PGID) && process_group(p) != pid)
 			continue;
 		if ((p->exit_signal != SIGCHLD))
 			continue;
diff -puN arch/mips/kernel/sysirix.c~group_leader-rework arch/mips/kernel/sysirix.c
--- 25/arch/mips/kernel/sysirix.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/mips/kernel/sysirix.c	2003-09-08 21:12:46.000000000 -0700
@@ -803,11 +803,11 @@ asmlinkage int irix_setpgrp(int flags)
 	printk("[%s:%d] setpgrp(%d) ", current->comm, current->pid, flags);
 #endif
 	if(!flags)
-		error = current->pgrp;
+		error = process_group(current);
 	else
 		error = sys_setsid();
 #ifdef DEBUG_PROCGRPS
-	printk("returning %d\n", current->pgrp);
+	printk("returning %d\n", process_group(current));
 #endif
 
 	return error;
diff -puN arch/sparc64/solaris/misc.c~group_leader-rework arch/sparc64/solaris/misc.c
--- 25/arch/sparc64/solaris/misc.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/arch/sparc64/solaris/misc.c	2003-09-08 21:12:46.000000000 -0700
@@ -392,7 +392,7 @@ asmlinkage int solaris_procids(int cmd, 
 	
 	switch (cmd) {
 	case 0: /* getpgrp */
-		return current->pgrp;
+		return process_group(current);
 	case 1: /* setpgrp */
 		{
 			int (*sys_setpgid)(pid_t,pid_t) =
@@ -403,7 +403,7 @@ asmlinkage int solaris_procids(int cmd, 
 			ret = sys_setpgid(0, 0);
 			if (ret) return ret;
 			current->tty = NULL;
-			return current->pgrp;
+			return process_group(current);
 		}
 	case 2: /* getsid */
 		{
diff -puN drivers/char/n_tty.c~group_leader-rework drivers/char/n_tty.c
--- 25/drivers/char/n_tty.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/drivers/char/n_tty.c	2003-09-08 21:12:46.000000000 -0700
@@ -977,11 +977,11 @@ do_it_again:
 	if (file->f_op->write != redirected_tty_write && current->tty == tty) {
 		if (tty->pgrp <= 0)
 			printk("read_chan: tty->pgrp <= 0!\n");
-		else if (current->pgrp != tty->pgrp) {
+		else if (process_group(current) != tty->pgrp) {
 			if (is_ignored(SIGTTIN) ||
-			    is_orphaned_pgrp(current->pgrp))
+			    is_orphaned_pgrp(process_group(current)))
 				return -EIO;
-			kill_pg(current->pgrp, SIGTTIN, 1);
+			kill_pg(process_group(current), SIGTTIN, 1);
 			return -ERESTARTSYS;
 		}
 	}
diff -puN drivers/char/rocket.c~group_leader-rework drivers/char/rocket.c
--- 25/drivers/char/rocket.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/drivers/char/rocket.c	2003-09-08 21:12:46.000000000 -0700
@@ -956,7 +956,7 @@ static int rp_open(struct tty_struct *tt
 	 * Info->count is now 1; so it's safe to sleep now.
 	 */
 	info->session = current->session;
-	info->pgrp = current->pgrp;
+	info->pgrp = process_group(current);
 
 	if ((info->flags & ROCKET_INITIALIZED) == 0) {
 		cp = &info->channel;
diff -puN drivers/char/tty_io.c~group_leader-rework drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/drivers/char/tty_io.c	2003-09-08 21:12:46.000000000 -0700
@@ -325,13 +325,13 @@ int tty_check_change(struct tty_struct *
 		printk(KERN_WARNING "tty_check_change: tty->pgrp <= 0!\n");
 		return 0;
 	}
-	if (current->pgrp == tty->pgrp)
+	if (process_group(current) == tty->pgrp)
 		return 0;
 	if (is_ignored(SIGTTOU))
 		return 0;
-	if (is_orphaned_pgrp(current->pgrp))
+	if (is_orphaned_pgrp(process_group(current)))
 		return -EIO;
-	(void) kill_pg(current->pgrp,SIGTTOU,1);
+	(void) kill_pg(process_group(current), SIGTTOU, 1);
 	return -ERESTARTSYS;
 }
 
@@ -1406,7 +1406,7 @@ got_driver:
 		task_unlock(current);
 		current->tty_old_pgrp = 0;
 		tty->session = current->session;
-		tty->pgrp = current->pgrp;
+		tty->pgrp = process_group(current);
 	}
 	return 0;
 }
@@ -1580,7 +1580,7 @@ static int tiocsctty(struct tty_struct *
 	task_unlock(current);
 	current->tty_old_pgrp = 0;
 	tty->session = current->session;
-	tty->pgrp = current->pgrp;
+	tty->pgrp = process_group(current);
 	return 0;
 }
 
diff -puN fs/autofs4/autofs_i.h~group_leader-rework fs/autofs4/autofs_i.h
--- 25/fs/autofs4/autofs_i.h~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs4/autofs_i.h	2003-09-08 21:12:46.000000000 -0700
@@ -113,7 +113,7 @@ static inline struct autofs_info *autofs
    filesystem without "magic".) */
 
 static inline int autofs4_oz_mode(struct autofs_sb_info *sbi) {
-	return sbi->catatonic || current->pgrp == sbi->oz_pgrp;
+	return sbi->catatonic || process_group(current) == sbi->oz_pgrp;
 }
 
 /* Does a dentry have some pending activity? */
diff -puN fs/autofs4/inode.c~group_leader-rework fs/autofs4/inode.c
--- 25/fs/autofs4/inode.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs4/inode.c	2003-09-08 21:12:46.000000000 -0700
@@ -101,7 +101,7 @@ static int parse_options(char *options, 
 	
 	*uid = current->uid;
 	*gid = current->gid;
-	*pgrp = current->pgrp;
+	*pgrp = process_group(current);
 
 	*minproto = AUTOFS_MIN_PROTO_VERSION;
 	*maxproto = AUTOFS_MAX_PROTO_VERSION;
@@ -192,7 +192,7 @@ int autofs4_fill_super(struct super_bloc
 	sbi->magic = AUTOFS_SBI_MAGIC;
 	sbi->catatonic = 0;
 	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = current->pgrp;
+	sbi->oz_pgrp = process_group(current);
 	sbi->sb = s;
 	sbi->version = 0;
 	sbi->queues = NULL;
diff -puN fs/autofs4/root.c~group_leader-rework fs/autofs4/root.c
--- 25/fs/autofs4/root.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs4/root.c	2003-09-08 21:12:46.000000000 -0700
@@ -255,7 +255,7 @@ static struct dentry *autofs4_root_looku
 	lock_kernel();
 	oz_mode = autofs4_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, current->pgrp, sbi->catatonic, oz_mode));
+		 current->pid, process_group(current), sbi->catatonic, oz_mode));
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
@@ -518,7 +518,7 @@ static int autofs4_root_ioctl(struct ino
 	struct autofs_sb_info *sbi = autofs4_sbi(inode->i_sb);
 
 	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",
-		 cmd,arg,sbi,current->pgrp));
+		 cmd,arg,sbi,process_group(current)));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
diff -puN fs/autofs/autofs_i.h~group_leader-rework fs/autofs/autofs_i.h
--- 25/fs/autofs/autofs_i.h~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs/autofs_i.h	2003-09-08 21:12:46.000000000 -0700
@@ -123,7 +123,7 @@ static inline struct autofs_sb_info *aut
    filesystem without "magic".) */
 
 static inline int autofs_oz_mode(struct autofs_sb_info *sbi) {
-	return sbi->catatonic || current->pgrp == sbi->oz_pgrp;
+	return sbi->catatonic || process_group(current) == sbi->oz_pgrp;
 }
 
 /* Hash operations */
diff -puN fs/autofs/inode.c~group_leader-rework fs/autofs/inode.c
--- 25/fs/autofs/inode.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs/inode.c	2003-09-08 21:12:46.000000000 -0700
@@ -51,7 +51,7 @@ static int parse_options(char *options, 
 	
 	*uid = current->uid;
 	*gid = current->gid;
-	*pgrp = current->pgrp;
+	*pgrp = process_group(current);
 
 	*minproto = *maxproto = AUTOFS_PROTO_VERSION;
 
diff -puN fs/autofs/root.c~group_leader-rework fs/autofs/root.c
--- 25/fs/autofs/root.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/autofs/root.c	2003-09-08 21:12:46.000000000 -0700
@@ -213,7 +213,7 @@ static struct dentry *autofs_root_lookup
 
 	oz_mode = autofs_oz_mode(sbi);
 	DPRINTK(("autofs_lookup: pid = %u, pgrp = %u, catatonic = %d, oz_mode = %d\n",
-		 current->pid, current->pgrp, sbi->catatonic, oz_mode));
+		 current->pid, process_group(current), sbi->catatonic, oz_mode));
 
 	/*
 	 * Mark the dentry incomplete, but add it. This is needed so
@@ -527,7 +527,7 @@ static int autofs_root_ioctl(struct inod
 {
 	struct autofs_sb_info *sbi = autofs_sbi(inode->i_sb);
 
-	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",cmd,arg,sbi,current->pgrp));
+	DPRINTK(("autofs_ioctl: cmd = 0x%08x, arg = 0x%08lx, sbi = %p, pgrp = %u\n",cmd,arg,sbi,process_group(current)));
 
 	if ( _IOC_TYPE(cmd) != _IOC_TYPE(AUTOFS_IOC_FIRST) ||
 	     _IOC_NR(cmd) - _IOC_NR(AUTOFS_IOC_FIRST) >= AUTOFS_IOC_COUNT )
diff -puN fs/binfmt_elf.c~group_leader-rework fs/binfmt_elf.c
--- 25/fs/binfmt_elf.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/binfmt_elf.c	2003-09-08 21:12:46.000000000 -0700
@@ -1076,7 +1076,7 @@ static void fill_prstatus(struct elf_prs
 	prstatus->pr_sighold = p->blocked.sig[0];
 	prstatus->pr_pid = p->pid;
 	prstatus->pr_ppid = p->parent->pid;
-	prstatus->pr_pgrp = p->pgrp;
+	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->session;
 	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
 	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
@@ -1104,7 +1104,7 @@ static void fill_psinfo(struct elf_prpsi
 
 	psinfo->pr_pid = p->pid;
 	psinfo->pr_ppid = p->parent->pid;
-	psinfo->pr_pgrp = p->pgrp;
+	psinfo->pr_pgrp = process_group(p);
 	psinfo->pr_sid = p->session;
 
 	i = p->state ? ffz(~p->state) + 1 : 0;
diff -puN fs/coda/upcall.c~group_leader-rework fs/coda/upcall.c
--- 25/fs/coda/upcall.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/coda/upcall.c	2003-09-08 21:12:46.000000000 -0700
@@ -54,7 +54,7 @@ static void *alloc_upcall(int opcode, in
 
         inp->ih.opcode = opcode;
 	inp->ih.pid = current->pid;
-	inp->ih.pgid = current->pgrp;
+	inp->ih.pgid = process_group(current);
 	coda_load_creds(&(inp->ih.cred));
 
 	return (void*)inp;
diff -puN fs/devfs/base.c~group_leader-rework fs/devfs/base.c
--- 25/fs/devfs/base.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/devfs/base.c	2003-09-08 21:12:46.000000000 -0700
@@ -1334,7 +1334,7 @@ static int is_devfsd_or_child (struct fs
     struct task_struct *p = current;
 
     if (p == fs_info->devfsd_task) return (TRUE);
-    if (p->pgrp == fs_info->devfsd_pgrp) return (TRUE);
+    if (process_group(p) == fs_info->devfsd_pgrp) return (TRUE);
     read_lock(&tasklist_lock);
     for ( ; p != &init_task; p = p->real_parent)
     {
@@ -2744,8 +2744,8 @@ static int devfsd_ioctl (struct inode *i
 	    }
 	    fs_info->devfsd_task = current;
 	    spin_unlock (&lock);
-	    fs_info->devfsd_pgrp = (current->pgrp == current->pid) ?
-		current->pgrp : 0;
+	    fs_info->devfsd_pgrp = (process_group(current) == current->pid) ?
+		process_group(current) : 0;
 	    fs_info->devfsd_file = file;
 	    fs_info->devfsd_info = kmalloc (sizeof *fs_info->devfsd_info,
 					    GFP_KERNEL);
diff -puN fs/proc/array.c~group_leader-rework fs/proc/array.c
--- 25/fs/proc/array.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/fs/proc/array.c	2003-09-08 21:12:46.000000000 -0700
@@ -341,7 +341,7 @@ int proc_pid_stat(struct task_struct *ta
 		task->comm,
 		state,
 		ppid,
-		task->pgrp,
+		process_group(task),
 		task->session,
 		tty_nr,
 		tty_pgrp,
diff -puN kernel/exit.c~group_leader-rework kernel/exit.c
--- 25/kernel/exit.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/kernel/exit.c	2003-09-08 21:12:46.000000000 -0700
@@ -152,7 +152,7 @@ static int will_become_orphaned_pgrp(int
 				|| p->state >= TASK_ZOMBIE 
 				|| p->real_parent->pid == 1)
 			continue;
-		if (p->real_parent->pgrp != pgrp
+		if (process_group(p->real_parent) != pgrp
 			    && p->real_parent->session == p->session) {
 			ret = 0;
 			break;
@@ -247,9 +247,9 @@ void __set_special_pids(pid_t session, p
 		curr->session = session;
 		attach_pid(curr, PIDTYPE_SID, session);
 	}
-	if (curr->pgrp != pgrp) {
+	if (process_group(curr) != pgrp) {
 		detach_pid(curr, PIDTYPE_PGID);
-		curr->pgrp = pgrp;
+		curr->group_leader->__pgrp = pgrp;
 		attach_pid(curr, PIDTYPE_PGID, pgrp);
 	}
 }
@@ -508,9 +508,9 @@ static inline void reparent_thread(task_
 	 * than we are, and it was the only connection
 	 * outside, so the child pgrp is now orphaned.
 	 */
-	if ((p->pgrp != father->pgrp) &&
+	if ((process_group(p) != process_group(father)) &&
 	    (p->session == father->session)) {
-		int pgrp = p->pgrp;
+		int pgrp = process_group(p);
 
 		if (will_become_orphaned_pgrp(pgrp, NULL) && has_stopped_jobs(pgrp)) {
 			__kill_pg_info(SIGHUP, (void *)1, pgrp);
@@ -618,12 +618,12 @@ static void exit_notify(struct task_stru
 	 
 	t = tsk->real_parent;
 	
-	if ((t->pgrp != tsk->pgrp) &&
+	if ((process_group(t) != process_group(tsk)) &&
 	    (t->session == tsk->session) &&
-	    will_become_orphaned_pgrp(tsk->pgrp, tsk) &&
-	    has_stopped_jobs(tsk->pgrp)) {
-		__kill_pg_info(SIGHUP, (void *)1, tsk->pgrp);
-		__kill_pg_info(SIGCONT, (void *)1, tsk->pgrp);
+	    will_become_orphaned_pgrp(process_group(tsk), tsk) &&
+	    has_stopped_jobs(process_group(tsk))) {
+		__kill_pg_info(SIGHUP, (void *)1, process_group(tsk));
+		__kill_pg_info(SIGCONT, (void *)1, process_group(tsk));
 	}
 
 	/* Let father know we died 
@@ -813,10 +813,10 @@ static int eligible_child(pid_t pid, int
 		if (p->pid != pid)
 			return 0;
 	} else if (!pid) {
-		if (p->pgrp != current->pgrp)
+		if (process_group(p) != process_group(current))
 			return 0;
 	} else if (pid != -1) {
-		if (p->pgrp != -pid)
+		if (process_group(p) != -pid)
 			return 0;
 	}
 
diff -puN kernel/pid.c~group_leader-rework kernel/pid.c
--- 25/kernel/pid.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/kernel/pid.c	2003-09-08 21:12:46.000000000 -0700
@@ -250,13 +250,13 @@ void switch_exec_pids(task_t *leader, ta
 
 	attach_pid(thread, PIDTYPE_PID, thread->pid);
 	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
-	attach_pid(thread, PIDTYPE_PGID, thread->pgrp);
+	attach_pid(thread, PIDTYPE_PGID, leader->__pgrp);
 	attach_pid(thread, PIDTYPE_SID, thread->session);
 	list_add_tail(&thread->tasks, &init_task.tasks);
 
 	attach_pid(leader, PIDTYPE_PID, leader->pid);
 	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
-	attach_pid(leader, PIDTYPE_PGID, leader->pgrp);
+	attach_pid(leader, PIDTYPE_PGID, leader->__pgrp);
 	attach_pid(leader, PIDTYPE_SID, leader->session);
 }
 
diff -puN kernel/signal.c~group_leader-rework kernel/signal.c
--- 25/kernel/signal.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/kernel/signal.c	2003-09-08 21:12:46.000000000 -0700
@@ -1139,7 +1139,7 @@ kill_proc_info(int sig, struct siginfo *
 static int kill_something_info(int sig, struct siginfo *info, int pid)
 {
 	if (!pid) {
-		return kill_pg_info(sig, info, current->pgrp);
+		return kill_pg_info(sig, info, process_group(current));
 	} else if (pid == -1) {
 		int retval = 0, count = 0;
 		struct task_struct * p;
@@ -1798,7 +1798,7 @@ relock:
 
 			/* signals can be posted during this window */
 
-			if (is_orphaned_pgrp(current->pgrp))
+			if (is_orphaned_pgrp(process_group(current)))
 				goto relock;
 
 			spin_lock_irq(&current->sighand->siglock);
diff -puN include/linux/sched.h~group_leader-rework include/linux/sched.h
--- 25/include/linux/sched.h~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/include/linux/sched.h	2003-09-08 21:12:46.000000000 -0700
@@ -360,7 +360,7 @@ struct task_struct {
 	unsigned long personality;
 	int did_exec:1;
 	pid_t pid;
-	pid_t pgrp;
+	pid_t __pgrp;		/* Accessed via process_group() */
 	pid_t tty_old_pgrp;
 	pid_t session;
 	pid_t tgid;
@@ -461,6 +461,11 @@ struct task_struct {
 	siginfo_t *last_siginfo; /* For ptrace use.  */
 };
 
+static inline pid_t process_group(struct task_struct *tsk)
+{
+	return tsk->group_leader->__pgrp;
+}
+
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
 #define put_task_struct(tsk) \
diff -puN kernel/fork.c~group_leader-rework kernel/fork.c
--- 25/kernel/fork.c~group_leader-rework	2003-09-08 21:12:46.000000000 -0700
+++ 25-akpm/kernel/fork.c	2003-09-08 21:12:46.000000000 -0700
@@ -1004,7 +1004,7 @@ struct task_struct *copy_process(unsigne
 	attach_pid(p, PIDTYPE_PID, p->pid);
 	if (thread_group_leader(p)) {
 		attach_pid(p, PIDTYPE_TGID, p->tgid);
-		attach_pid(p, PIDTYPE_PGID, p->pgrp);
+		attach_pid(p, PIDTYPE_PGID, process_group(p));
 		attach_pid(p, PIDTYPE_SID, p->session);
 		if (p->pid)
 			__get_cpu_var(process_counts)++;

_

