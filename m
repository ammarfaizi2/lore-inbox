Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbWBFTc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbWBFTc3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 14:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932310AbWBFTc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 14:32:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:11501 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932301AbWBFTc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 14:32:27 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 03/20] pid: Introduce a generic helper to test for
 init.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 12:29:51 -0700
In-Reply-To: <m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:27:08 -0700")
Message-ID: <m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are a lot of places in the kernel where we test for init because
we give it special properties.  Most  significantly init must not die.
This results in code all over the kernel test ->pid == 1.

Introduce is_init to capture this case.  

With multiple pid spaces for all of the cases affected we are looking
for only the first process on the system, not some other process that
has pid == 1. 

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 arch/alpha/mm/fault.c                |    2 +-
 arch/i386/lib/usercopy.c             |    2 +-
 arch/i386/mm/fault.c                 |    2 +-
 arch/ia64/mm/fault.c                 |    2 +-
 arch/m32r/mm/fault.c                 |    2 +-
 arch/m68k/mm/fault.c                 |    2 +-
 arch/mips/mm/fault.c                 |    2 +-
 arch/powerpc/mm/fault.c              |    2 +-
 arch/powerpc/platforms/pseries/ras.c |    2 +-
 arch/s390/mm/fault.c                 |    2 +-
 arch/sh/mm/fault.c                   |    2 +-
 arch/sh64/mm/fault.c                 |    6 +++---
 arch/um/kernel/trap_kern.c           |    2 +-
 arch/x86_64/mm/fault.c               |    2 +-
 arch/xtensa/mm/fault.c               |    2 +-
 drivers/char/snsc_event.c            |    2 +-
 include/linux/sched.h                |   13 +++++++++++++
 kernel/exit.c                        |    2 +-
 kernel/kexec.c                       |    2 +-
 kernel/sysctl.c                      |    2 +-
 mm/oom_kill.c                        |    6 +++---
 security/seclvl.c                    |    4 ++--
 22 files changed, 39 insertions(+), 26 deletions(-)

26458ca5ad0bf86dde7bbe914e0f475f11945f44
diff --git a/arch/alpha/mm/fault.c b/arch/alpha/mm/fault.c
index 64ace5a..36284e7 100644
--- a/arch/alpha/mm/fault.c
+++ b/arch/alpha/mm/fault.c
@@ -194,7 +194,7 @@ do_page_fault(unsigned long address, uns
 	/* We ran out of memory, or some other thing happened to us that
 	   made us unable to handle the page fault gracefully.  */
  out_of_memory:
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/i386/lib/usercopy.c b/arch/i386/lib/usercopy.c
index 4cf981d..ae9b319 100644
--- a/arch/i386/lib/usercopy.c
+++ b/arch/i386/lib/usercopy.c
@@ -543,7 +543,7 @@ survive:
 			retval = get_user_pages(current, current->mm,
 					(unsigned long )to, 1, 1, 0, &pg, NULL);
 
-			if (retval == -ENOMEM && current->pid == 1) {
+			if (retval == -ENOMEM && is_init(current)) {
 				up_read(&current->mm->mmap_sem);
 				blk_congestion_wait(WRITE, HZ/50);
 				goto survive;
diff --git a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
index cf572d9..adec5ef 100644
--- a/arch/i386/mm/fault.c
+++ b/arch/i386/mm/fault.c
@@ -485,7 +485,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (is_init(tsk)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/ia64/mm/fault.c b/arch/ia64/mm/fault.c
index af7eb08..3d27cf8 100644
--- a/arch/ia64/mm/fault.c
+++ b/arch/ia64/mm/fault.c
@@ -241,7 +241,7 @@ ia64_do_page_fault (unsigned long addres
 
   out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/m32r/mm/fault.c b/arch/m32r/mm/fault.c
index bf7fb58..3f98d5a 100644
--- a/arch/m32r/mm/fault.c
+++ b/arch/m32r/mm/fault.c
@@ -300,7 +300,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (is_init(tsk)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
index aec1527..0081729 100644
--- a/arch/m68k/mm/fault.c
+++ b/arch/m68k/mm/fault.c
@@ -181,7 +181,7 @@ good_area:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
index 2d9624f..c615567 100644
--- a/arch/mips/mm/fault.c
+++ b/arch/mips/mm/fault.c
@@ -172,7 +172,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (is_init(tsk)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index a4815d3..a002917 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -351,7 +351,7 @@ bad_area_nosemaphore:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/powerpc/platforms/pseries/ras.c b/arch/powerpc/platforms/pseries/ras.c
index b046bcf..5d6a4a6 100644
--- a/arch/powerpc/platforms/pseries/ras.c
+++ b/arch/powerpc/platforms/pseries/ras.c
@@ -314,7 +314,7 @@ static int recover_mce(struct pt_regs *r
 		   err->disposition == RTAS_DISP_NOT_RECOVERED &&
 		   err->target == RTAS_TARGET_MEMORY &&
 		   err->type == RTAS_TYPE_ECC_UNCORR &&
-		   !(current->pid == 0 || current->pid == 1)) {
+		   !(current->pid == 0 || is_init(current))) {
 		/* Kill off a user process with an ECC error */
 		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
 		       current->pid);
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 81ade40..9d9c009 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -316,7 +316,7 @@ no_context:
 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (tsk->pid == 1) {
+	if (is_init(tsk)) {
 		yield();
 		goto survive;
 	}
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index 775f86c..46e5e60 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -160,7 +160,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/sh64/mm/fault.c b/arch/sh64/mm/fault.c
index f08d0ea..8e2f6c2 100644
--- a/arch/sh64/mm/fault.c
+++ b/arch/sh64/mm/fault.c
@@ -277,7 +277,7 @@ bad_area:
 			show_regs(regs);
 #endif
 		}
-		if (tsk->pid == 1) {
+		if (is_init(tsk)) {
 			panic("INIT had user mode bad_area\n");
 		}
 		tsk->thread.address = address;
@@ -319,14 +319,14 @@ no_context:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		panic("INIT out of memory\n");
 		yield();
 		goto survive;
 	}
 	printk("fault:Out of memory\n");
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/arch/um/kernel/trap_kern.c b/arch/um/kernel/trap_kern.c
index d56046c..bed3e03 100644
--- a/arch/um/kernel/trap_kern.c
+++ b/arch/um/kernel/trap_kern.c
@@ -120,7 +120,7 @@ out_nosemaphore:
  * us unable to handle the page fault gracefully.
  */
 out_of_memory:
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		up_read(&mm->mmap_sem);
 		yield();
 		down_read(&mm->mmap_sem);
diff --git a/arch/x86_64/mm/fault.c b/arch/x86_64/mm/fault.c
index 26eac19..7beb271 100644
--- a/arch/x86_64/mm/fault.c
+++ b/arch/x86_64/mm/fault.c
@@ -545,7 +545,7 @@ no_context:
  */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) { 
+	if (is_init(current)) { 
 		yield();
 		goto again;
 	}
diff --git a/arch/xtensa/mm/fault.c b/arch/xtensa/mm/fault.c
index a945a33..dd0dbec 100644
--- a/arch/xtensa/mm/fault.c
+++ b/arch/xtensa/mm/fault.c
@@ -144,7 +144,7 @@ bad_area:
 	 */
 out_of_memory:
 	up_read(&mm->mmap_sem);
-	if (current->pid == 1) {
+	if (is_init(current)) {
 		yield();
 		down_read(&mm->mmap_sem);
 		goto survive;
diff --git a/drivers/char/snsc_event.c b/drivers/char/snsc_event.c
index baaa365..60d1343 100644
--- a/drivers/char/snsc_event.c
+++ b/drivers/char/snsc_event.c
@@ -207,7 +207,7 @@ scdrv_dispatch_event(char *event, int le
 		/* first find init's task */
 		read_lock(&tasklist_lock);
 		for_each_process(p) {
-			if (p->pid == 1)
+			if (is_init(p))
 				break;
 		}
 		if (p) { /* we found init's task */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e8ea561..86a92d6 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -894,6 +894,19 @@ static inline int pid_alive(struct task_
 	return p->pids[PIDTYPE_PID].nr != 0;
 }
 
+/**
+ * is_init - check if a task structure is the first user space
+ *	     task the kernel created.
+ * @p: Task structure to be checked.
+ */
+static inline int is_init(struct task_struct *tsk)
+{
+	/* Note there is only one task whose parent knows
+	 * it as pid 1.
+	 */
+	return tsk->wid == 1;
+}
+
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
diff --git a/kernel/exit.c b/kernel/exit.c
index 749bc8b..f1af8bb 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -786,7 +786,7 @@ fastcall NORET_TYPE void do_exit(long co
 		panic("Aiee, killing interrupt handler!");
 	if (unlikely(!tsk->pid))
 		panic("Attempted to kill the idle task!");
-	if (unlikely(tsk == child_reaper))
+	if (unlikely(is_init(tsk)))
 		panic("Attempted to kill init!");
 	if (tsk->io_context)
 		exit_io_context();
diff --git a/kernel/kexec.c b/kernel/kexec.c
index bf39d28..64d05ab 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -40,7 +40,7 @@ struct resource crashk_res = {
 
 int kexec_should_crash(struct task_struct *p)
 {
-	if (in_interrupt() || !p->pid || p->pid == 1 || panic_on_oops)
+	if (in_interrupt() || !p->pid || is_init(p) || panic_on_oops)
 		return 1;
 	return 0;
 }
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 71dd6f6..8e1bdc5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -1806,7 +1806,7 @@ int proc_dointvec_bset(ctl_table *table,
 		return -EPERM;
 	}
 
-	op = (current->pid == 1) ? OP_SET : OP_AND;
+	op = is_init(current) ? OP_SET : OP_AND;
 	return do_proc_dointvec(table,write,filp,buffer,lenp,ppos,
 				do_proc_dointvec_bset_conv,&op);
 }
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index b05ab8f..b417dce 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -148,8 +148,8 @@ static struct task_struct * select_bad_p
 		unsigned long points;
 		int releasing;
 
-		/* skip the init task with pid == 1 */
-		if (p->pid == 1)
+		/* skip the init task */
+		if (is_init(p))
 			continue;
 		if (p->oomkilladj == OOM_DISABLE)
 			continue;
@@ -184,7 +184,7 @@ static struct task_struct * select_bad_p
  */
 static void __oom_kill_task(task_t *p)
 {
-	if (p->pid == 1) {
+	if (is_init(p)) {
 		WARN_ON(1);
 		printk(KERN_WARNING "tried to kill init!\n");
 		return;
diff --git a/security/seclvl.c b/security/seclvl.c
index 8529ea6..a49f2dd 100644
--- a/security/seclvl.c
+++ b/security/seclvl.c
@@ -313,7 +313,7 @@ static int seclvl_ptrace(struct task_str
 static int seclvl_capable(struct task_struct *tsk, int cap)
 {
 	/* init can do anything it wants */
-	if (tsk->pid == 1)
+	if (is_init(tsk))
 		return 0;
 
 	switch (seclvl) {
@@ -479,7 +479,7 @@ static void seclvl_file_free_security(st
  */
 static int seclvl_umount(struct vfsmount *mnt, int flags)
 {
-	if (current->pid == 1)
+	if (is_init(current))
 		return 0;
 	if (seclvl == 2) {
 		seclvl_printk(1, KERN_WARNING, "Attempt to unmount in secure "
-- 
1.1.5.g3480

