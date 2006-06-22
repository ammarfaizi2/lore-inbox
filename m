Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbWFVDI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbWFVDI3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWFVDI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:08:29 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:60640 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030589AbWFVDI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:08:27 -0400
Message-ID: <449A09A0.70009@ak.jp.nec.com>
Date: Thu, 22 Jun 2006 12:08:16 +0900
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

     [PACCT] two phase process accounting

     The pacct facility need an i/o operation when an accounting record
     is generated. There is a possibility to wake OOM killer up.
     If OOM killer is activated, it kills some processes to make them
     release process memory regions.
     But acct_process() is called in the killed processes context
     before calling exit_mm(), so those processes cannot release
     own memory. In the results, any processes stop in this point and
     it finally cause a system stall.

     ---- in kernel/exit.c : do_exit() ------------
             group_dead = atomic_dec_and_test(&tsk->signal->live);
             if (group_dead) {
                     hrtimer_cancel(&tsk->signal->real_timer);
                     exit_itimers(tsk->signal);
                     acct_process(code);
             }
                :
            - snip -
                :
             exit_mm(tsk);
     ----------------------------------------------

     This patch separates generating an accounting record facility
     into two-phase.
     In the first one, acct_collect() calculate vitual memory size
     of the process and stores it into pacct_struct before exit_mm().
     Then, acct_process() generates an accounting record and write
     it into medium.

     Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

diff --git a/include/linux/acct.h b/include/linux/acct.h
index 9a66401..6753687 100644
--- a/include/linux/acct.h
+++ b/include/linux/acct.h
@@ -121,16 +121,20 @@ struct acct_v3
  #ifdef CONFIG_BSD_PROCESS_ACCT
  struct vfsmount;
  struct super_block;
  extern void acct_auto_close_mnt(struct vfsmount *m);
  extern void acct_auto_close(struct super_block *sb);
+extern void acct_init_pacct(struct pacct_struct *pacct);
+extern void acct_collect();
  extern void acct_process(long exitcode);
  extern void acct_update_integrals(struct task_struct *tsk);
  extern void acct_clear_integrals(struct task_struct *tsk);
  #else
  #define acct_auto_close_mnt(x)	do { } while (0)
  #define acct_auto_close(x)	do { } while (0)
+#define acct_init_pacct(x)	do { } while (0)
+#define acct_collect()		do { } while (0)
  #define acct_process(x)		do { } while (0)
  #define acct_update_integrals(x)		do { } while (0)
  #define acct_clear_integrals(task)	do { } while (0)
  #endif

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 29b7d4f..918fdda 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -356,10 +356,14 @@ struct sighand_struct {
  	atomic_t		count;
  	struct k_sigaction	action[_NSIG];
  	spinlock_t		siglock;
  };

+struct pacct_struct {
+	unsigned long		ac_mem;
+};
+
  /*
   * NOTE! "signal_struct" does not have it's own
   * locking, because a shared signal_struct always
   * implies a shared sighand_struct, so locking
   * sighand_struct is always a proper superset of
@@ -447,10 +451,13 @@ struct signal_struct {
  	 * thing in threads created with CLONE_THREAD */
  #ifdef CONFIG_KEYS
  	struct key *session_keyring;	/* keyring inherited over fork */
  	struct key *process_keyring;	/* keyring private to this process */
  #endif
+#ifdef CONFIG_BSD_PROCESS_ACCT
+	struct pacct_struct pacct;	/* per-process accounting information */
+#endif
  };

  /* Context switch must be unlocked if interrupts are to be enabled */
  #ifdef __ARCH_WANT_INTERRUPTS_ON_CTXSW
  # define __ARCH_WANT_UNLOCKED_CTXSW
diff --git a/kernel/acct.c b/kernel/acct.c
index b327f4d..f1a4e12 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -419,13 +419,13 @@ static u32 encode_float(u64 value)
  /*
   *  do_acct_process does all actual work. Caller holds the reference to file.
   */
  static void do_acct_process(long exitcode, struct file *file)
  {
+	struct pacct_struct *pacct = &current->signal->pacct;
  	acct_t ac;
  	mm_segment_t fs;
-	unsigned long vsize;
  	unsigned long flim;
  	u64 elapsed;
  	u64 run_time;
  	struct timespec uptime;
  	unsigned long jiffies;
@@ -503,24 +503,13 @@ static void do_acct_process(long exitcod
  		ac.ac_flag |= ASU;
  	if (current->flags & PF_DUMPCORE)
  		ac.ac_flag |= ACORE;
  	if (current->flags & PF_SIGNALED)
  		ac.ac_flag |= AXSIG;
-
-	vsize = 0;
-	if (current->mm) {
-		struct vm_area_struct *vma;
-		down_read(&current->mm->mmap_sem);
-		vma = current->mm->mmap;
-		while (vma) {
-			vsize += vma->vm_end - vma->vm_start;
-			vma = vma->vm_next;
-		}
-		up_read(&current->mm->mmap_sem);
-	}
-	vsize = vsize / 1024;
-	ac.ac_mem = encode_comp_t(vsize);
+	spin_lock(&current->sighand->siglock);
+	ac.ac_mem = encode_comp_t(pacct->ac_mem);
+	spin_unlock(&current->sighand->siglock);
  	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
  	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
  	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
  				     current->min_flt);
  	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
@@ -544,10 +533,42 @@ static void do_acct_process(long exitcod
  	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
  	set_fs(fs);
  }

  /**
+ * acct_init_pacct - initialize a new pacct_struct
+ */
+void acct_init_pacct(struct pacct_struct *pacct)
+{
+	memset(pacct, 0, sizeof(struct pacct_struct));
+}
+
+/**
+ * acct_collect - collect accounting information into pacct_struct
+ */
+void acct_collect(void)
+{
+	struct pacct_struct *pacct = &current->signal->pacct;
+	unsigned long vsize = 0;
+
+	if (current->mm) {
+		struct vm_area_struct *vma;
+		down_read(&current->mm->mmap_sem);
+		vma = current->mm->mmap;
+		while (vma) {
+			vsize += vma->vm_end - vma->vm_start;
+			vma = vma->vm_next;
+		}
+		up_read(&current->mm->mmap_sem);
+	}
+
+	spin_lock(&current->sighand->siglock);
+	pacct->ac_mem = vsize / 1024;
+	spin_unlock(&current->sighand->siglock);
+}
+
+/**
   * acct_process - now just a wrapper around do_acct_process
   * @exitcode: task exit code
   *
   * handles process accounting for an exiting task
   */
diff --git a/kernel/exit.c b/kernel/exit.c
index e06d0c1..54bdbd9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -893,11 +893,11 @@ fastcall NORET_TYPE void do_exit(long co
  	}
  	group_dead = atomic_dec_and_test(&tsk->signal->live);
  	if (group_dead) {
   		hrtimer_cancel(&tsk->signal->real_timer);
  		exit_itimers(tsk->signal);
-		acct_process(code);
+		acct_collect();
  	}
  	if (unlikely(tsk->robust_list))
  		exit_robust_list(tsk);
  #ifdef CONFIG_COMPAT
  	if (unlikely(tsk->compat_robust_list))
@@ -905,10 +905,12 @@ fastcall NORET_TYPE void do_exit(long co
  #endif
  	if (unlikely(tsk->audit_context))
  		audit_free(tsk);
  	exit_mm(tsk);

+	if (group_dead)
+		acct_process(code);
  	exit_sem(tsk);
  	__exit_files(tsk);
  	__exit_fs(tsk);
  	exit_namespace(tsk);
  	exit_thread();
diff --git a/kernel/fork.c b/kernel/fork.c
index ac8100e..d6c812c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -869,10 +869,11 @@ static inline int copy_signal(unsigned l
  		 * of the whole CPU time limit.
  		 */
  		tsk->it_prof_expires =
  			secs_to_cputime(sig->rlim[RLIMIT_CPU].rlim_cur);
  	}
+	acct_init_pacct(&sig->pacct);

  	return 0;
  }

  void __cleanup_signal(struct signal_struct *sig)


-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
