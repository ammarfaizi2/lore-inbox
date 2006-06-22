Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030590AbWFVDJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030590AbWFVDJg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030588AbWFVDJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:09:36 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:45310 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030590AbWFVDJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:09:35 -0400
Message-ID: <449A09E2.1030607@ak.jp.nec.com>
Date: Thu, 22 Jun 2006 12:09:22 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: KaiGai Kohei <kaigai@ak.jp.nec.com>, linux-kernel@vger.kernel.org
Subject: Re: Add pacct_struct to fix some pacct bugs.
References: <449794BB.8010108@ak.jp.nec.com> <20060619234212.b95e5734.akpm@osdl.org> <4497A34C.2000104@ak.jp.nec.com> <449A0967.2020701@ak.jp.nec.com>
In-Reply-To: <449A0967.2020701@ak.jp.nec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

     [PACCT] avoidance to refer the last thread as a representation of the process

     When pacct facility generate an 'ac_flag' field in accounting record,
     it refers a task_struct of the thread which died last in the process.
     But any other task_structs are ignored.

     Therefore, pacct facility drops ASU flag even if root-privilege
     operations are used by any other threads except the last one.
     In addition, AFORK flag is always set when the thread of group-leader
     didn't die last, although this process has called execve() after fork().

     We have a same matter in ac_exitcode. The recorded ac_exitcode is
     an exit code of the last thread in the process. There is a possibility
     this exitcode is not the group leader's one.

     ---- in kernel/acct.c : do_acct_process() ----
             ac.ac_flag = 0;
             if (current->flags & PF_FORKNOEXEC)
                     ac.ac_flag |= AFORK;
             if (current->flags & PF_SUPERPRIV)
                     ac.ac_flag |= ASU;
             if (current->flags & PF_DUMPCORE)
                     ac.ac_flag |= ACORE;
             if (current->flags & PF_SIGNALED)
                     ac.ac_flag |= AXSIG;
                       :
                    - snip -
                       :
             ac.ac_exitcode = exitcode;
     ----------------------------------------------

     This patch fixes those matters.
     - The exit code of group leader is recorded as ac_exitcode.
     - ASU, ACORE, AXSIG flag are marked if any task_struct satisfy
       the conditions.
     - AFORK flag is marked if only group leader thread satisfy
       the condition.

     Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

diff --git a/include/linux/acct.h b/include/linux/acct.h
index 6753687..879d441 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -122,20 +122,20 @@ struct acct_v3
  struct vfsmount;
  struct super_block;
  extern void acct_auto_close_mnt(struct vfsmount *m);
  extern void acct_auto_close(struct super_block *sb);
  extern void acct_init_pacct(struct pacct_struct *pacct);
-extern void acct_collect();
-extern void acct_process(long exitcode);
+extern void acct_collect(long exitcode, int group_dead);
+extern void acct_process(void);
  extern void acct_update_integrals(struct task_struct *tsk);
  extern void acct_clear_integrals(struct task_struct *tsk);
  #else
  #define acct_auto_close_mnt(x)	do { } while (0)
  #define acct_auto_close(x)	do { } while (0)
  #define acct_init_pacct(x)	do { } while (0)
-#define acct_collect()		do { } while (0)
-#define acct_process(x)		do { } while (0)
+#define acct_collect(x,y)	do { } while (0)
+#define acct_process()		do { } while (0)
  #define acct_update_integrals(x)		do { } while (0)
  #define acct_clear_integrals(task)	do { } while (0)
  #endif

  /*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 918fdda..6905ac0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -357,10 +357,12 @@ struct sighand_struct {
  	struct k_sigaction	action[_NSIG];
  	spinlock_t		siglock;
  };

  struct pacct_struct {
+	int			ac_flag;
+	long			ac_exitcode;
  	unsigned long		ac_mem;
  };

  /*
   * NOTE! "signal_struct" does not have it's own
diff --git a/kernel/acct.c b/kernel/acct.c
index f1a4e12..7111fe7 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -73,11 +73,11 @@ int acct_parm[3] = {4, 2, 30};
  #define ACCT_TIMEOUT	(acct_parm[2])	/* foo second timeout between checks */

  /*
   * External references and all of the globals.
   */
-static void do_acct_process(long, struct file *);
+static void do_acct_process(struct file *);

  /*
   * This structure is used so that all the data protected by lock
   * can be placed in the same cache line as the lock.  This primes
   * the cache line to have the data after getting the lock.
@@ -194,11 +194,11 @@ static void acct_file_reopen(struct file
  		add_timer(&acct_globals.timer);
  	}
  	if (old_acct) {
  		mnt_unpin(old_acct->f_vfsmnt);
  		spin_unlock(&acct_globals.lock);
-		do_acct_process(0, old_acct);
+		do_acct_process(old_acct);
  		filp_close(old_acct, NULL);
  		spin_lock(&acct_globals.lock);
  	}
  }

@@ -417,11 +417,11 @@ static u32 encode_float(u64 value)
   */

  /*
   *  do_acct_process does all actual work. Caller holds the reference to file.
   */
-static void do_acct_process(long exitcode, struct file *file)
+static void do_acct_process(struct file *file)
  {
  	struct pacct_struct *pacct = &current->signal->pacct;
  	acct_t ac;
  	mm_segment_t fs;
  	unsigned long flim;
@@ -494,30 +494,22 @@ static void do_acct_process(long exitcod
  	read_lock(&tasklist_lock);	/* pin current->signal */
  	ac.ac_tty = current->signal->tty ?
  		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
  	read_unlock(&tasklist_lock);

-	ac.ac_flag = 0;
-	if (current->flags & PF_FORKNOEXEC)
-		ac.ac_flag |= AFORK;
-	if (current->flags & PF_SUPERPRIV)
-		ac.ac_flag |= ASU;
-	if (current->flags & PF_DUMPCORE)
-		ac.ac_flag |= ACORE;
-	if (current->flags & PF_SIGNALED)
-		ac.ac_flag |= AXSIG;
  	spin_lock(&current->sighand->siglock);
+	ac.ac_flag = pacct->ac_flag;
  	ac.ac_mem = encode_comp_t(pacct->ac_mem);
+	ac.ac_exitcode = pacct->ac_exitcode;
  	spin_unlock(&current->sighand->siglock);
  	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
  	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
  	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
  				     current->min_flt);
  	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
  				     current->maj_flt);
  	ac.ac_swaps = encode_comp_t(0);
-	ac.ac_exitcode = exitcode;

  	/*
           * Kernel segment override to datasegment and write it
           * to the accounting file.
           */
@@ -542,17 +534,19 @@ void acct_init_pacct(struct pacct_struct
  	memset(pacct, 0, sizeof(struct pacct_struct));
  }

  /**
   * acct_collect - collect accounting information into pacct_struct
+ * @exitcode: task exit code
+ * @group_dead: not 0, if this thread is the last one in the process.
   */
-void acct_collect(void)
+void acct_collect(long exitcode, int group_dead)
  {
  	struct pacct_struct *pacct = &current->signal->pacct;
  	unsigned long vsize = 0;

-	if (current->mm) {
+	if (group_dead && current->mm) {
  		struct vm_area_struct *vma;
  		down_read(&current->mm->mmap_sem);
  		vma = current->mm->mmap;
  		while (vma) {
  			vsize += vma->vm_end - vma->vm_start;
@@ -560,21 +554,33 @@ void acct_collect(void)
  		}
  		up_read(&current->mm->mmap_sem);
  	}

  	spin_lock(&current->sighand->siglock);
-	pacct->ac_mem = vsize / 1024;
+	if (group_dead)
+		pacct->ac_mem = vsize / 1024;
+	if (thread_group_leader(current)) {
+		pacct->ac_exitcode = exitcode;
+		if (current->flags & PF_FORKNOEXEC)
+			pacct->ac_flag |= AFORK;
+	}
+	if (current->flags & PF_SUPERPRIV)
+		pacct->ac_flag |= ASU;
+	if (current->flags & PF_DUMPCORE)
+		pacct->ac_flag |= ACORE;
+	if (current->flags & PF_SIGNALED)
+		pacct->ac_flag |= AXSIG;
  	spin_unlock(&current->sighand->siglock);
  }

  /**
   * acct_process - now just a wrapper around do_acct_process
   * @exitcode: task exit code
   *
   * handles process accounting for an exiting task
   */
-void acct_process(long exitcode)
+void acct_process()
  {
  	struct file *file = NULL;

  	/*
  	 * accelerate the common fastpath:
@@ -589,11 +595,11 @@ void acct_process(long exitcode)
  		return;
  	}
  	get_file(file);
  	spin_unlock(&acct_globals.lock);

-	do_acct_process(exitcode, file);
+	do_acct_process(file);
  	fput(file);
  }


  /**
diff --git a/kernel/exit.c b/kernel/exit.c
index 54bdbd9..9d395c7 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -893,12 +893,12 @@ fastcall NORET_TYPE void do_exit(long co
  	}
  	group_dead = atomic_dec_and_test(&tsk->signal->live);
  	if (group_dead) {
   		hrtimer_cancel(&tsk->signal->real_timer);
  		exit_itimers(tsk->signal);
-		acct_collect();
  	}
+	acct_collect(code, group_dead);
  	if (unlikely(tsk->robust_list))
  		exit_robust_list(tsk);
  #ifdef CONFIG_COMPAT
  	if (unlikely(tsk->compat_robust_list))
  		compat_exit_robust_list(tsk);
@@ -906,11 +906,11 @@ fastcall NORET_TYPE void do_exit(long co
  	if (unlikely(tsk->audit_context))
  		audit_free(tsk);
  	exit_mm(tsk);

  	if (group_dead)
-		acct_process(code);
+		acct_process();
  	exit_sem(tsk);
  	__exit_files(tsk);
  	__exit_fs(tsk);
  	exit_namespace(tsk);
  	exit_thread();

-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
