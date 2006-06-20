Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965084AbWFTGZP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbWFTGZP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 02:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWFTGZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 02:25:15 -0400
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:57820 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S965084AbWFTGZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 02:25:12 -0400
Message-ID: <449794BB.8010108@ak.jp.nec.com>
Date: Tue, 20 Jun 2006 15:24:59 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Add pacct_struct to fix some pacct bugs.
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I noticed three problems in pacct facility.

1. Pacct facility has a possibility to write incorrect ac_flag
   in multi-threading cases.
2. There is a possibility to be waken up OOM Killer from
   pacct facility. It will cause system stall.
3. If several threads are killed at same time, There is
   a possibility not to pick up a part of those accountings.

The attached patch will resolve those matters.
Any comments please. Thanks,

Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

[The details of those matters]

(1) about incorrect ac_flag
When pacct facility generate an 'ac_flag' field in accounting record,
it refers a task_struct of the thread which died last in the process.
But any other task_structs are ignored.

Therefore, pacct facility drops ASU flag even if root-privilege
operations are used by any other threads except the last one.
In addition, AFORK flag is always set when the thread of group-leader
didn't die last, although this process has called execve() after fork().

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
----------------------------------------------
I think ASU, ACORE, AXSIG flag should be set if any task_structs
satisfy the conditions. And, AFORK flag should not be checked
for any threads except the group leader.


(2) about OOM killer
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
I think acct_process() should be called after exit_mm() to avoid
this matter. As mm_struct is necessary to calculate ac_mem field,
it should be kept before exit_mm().


(3) about race condition in pacct
In current 2.6.17 implementation, signal_struct refered from task_struct
is used for per-process data structure. The pacct facility also uses it
as a per-process data structure to save stime, utime, minflt, majflt.
But those members are saved in __exit_signal(). It's too late.

For example, if some threads exits at same time, pacct facility has
a possibility to drop accountings for a part of those threads.
(see, the following 'The results of original 2.6.17 kernel')
I think accounting information should be completely collected into
the per-process data structure before writing out an accounting record.


[The solution for those matters]
a. pacct_struct is newly defined, and it's deployed into signal_struct
   as a per-process accounting storage.
b. acct_collect() is newly added to collect any thread's accountings
   before generating accounting record and calling exit_mm().
c. Calling acct_process() is moved after exit_mm().
d. do_acct_process() becomes to refer the per-process accounting
   structure, not task_strcut of the last thread.


[The results of original 2.6.17 kernel]
* test for ac_flag
  # time -p ./bugacct
  real 10.11
  user 5.94
  sys 0.17
  # touch /tmp/acct-`uname -r`
  # accton /tmp/acct-`uname -r`
  # time -p ./bugacct
  real 10.04
  user 5.86
  sys 0.17
  -- The accounting results -----------------------------------------
  FLAG  BTIME          ETIME UTIME STIME    MEM MINFLT MAJFLT    COMM
  F---  06/20-14:31:47  1003   586    16 140992  32776      0 bugacct

  (*) 'F' means it didn't execve() after fork().
      'P' means it used root-privilege operations.

  => original 2.6.17 drops 'P' flag, and appends undesired 'F' flag.

* test for the race condition
  # time -p ./raceacct 4
  real 2.59
  user 7.56
  sys 0.00
  # time -p ./raceacct 4
  real 2.27
  user 6.62
  sys 0.00
  # time -p ./raceacct 4
  real 2.16
  user 6.16
  sys 0.00
  # time -p ./raceacct 4
  real 2.87
  user 8.36
  sys 0.00
  # time -p ./raceacct 4
  real 2.77
  user 8.11
  sys 0.00

  -- The accounting results -----------------------------------------
  FLAG  BTIME          ETIME UTIME STIME    MEM MINFLT MAJFLT    COMM
  F---  06/20-11:18:57   259   596     0  28528     38      0 raceacct *
  ----  06/20-11:19:14   227   662     0  28528    171      0 raceacct
  F---  06/20-11:19:18   216   509     0  28528     38      0 raceacct *
  F---  06/20-11:19:22   287   651     0  28528     39      0 raceacct *
  ----  06/20-11:19:25   276   811     0  28528    170      0 raceacct
  (*) = UTIME does not match with the result of 'time -p'


[The results of patched 2.6.17-kg kernel]
* test for ac_flag
  # time -p ./bugacct
  real 10.07
  user 5.88
  sys 0.17
  -- The accounting results -----------------------------------------
  FLAG  BTIME          ETIME UTIME STIME    MEM MINFLT MAJFLT    COMM
  -P--  06/20-14:08:06  1007   588    16 140992  32944      0 bugacct

* test for the race condition
  # time -p ./raceacct 4
  real 2.55
  user 7.48
  sys 0.00
  # time -p ./raceacct 4
  real 2.59
  user 7.58
  sys 0.00
  # time -p ./raceacct 4
  real 2.64
  user 7.75
  sys 0.00
  # time -p ./raceacct 4
  real 2.29
  user 6.71
  sys 0.00
  # time -p ./raceacct 4
  real 2.68
  user 7.83
  sys 0.00
  -- The accounting results -----------------------------------------
  FLAG  BTIME          ETIME UTIME STIME    MEM MINFLT MAJFLT     COMM
  ----  06/20-11:09:33   255   748     0  28528    171      0 raceacct
  ----  06/20-11:09:37   259   758     0  28528    171      0 raceacct
  ----  06/20-11:09:41   264   775     0  28528    170      0 raceacct
  ----  06/20-11:09:44   229   671     0  28528    170      0 raceacct
  ----  06/20-11:09:57   268   783     0  28528    170      0 raceacct

[The test program : raceacct.c]
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *worker(void *dummy) {
    int i, *flag = dummy;

    for (i=0; i < 100000000 && *flag; i++);
    *flag = 0;
    pthread_exit(NULL);
}

int main(int argc, char *argv[]) {
    pthread_t pthread;
    int i, num = 0, flag = 1;

  if (argc > 2) {
      fprintf(stderr, "argument too large\n");
      return 1;
  } else if (argc == 2) {
      num = atoi(argv[1]);
  }
  for (i=1; i < num; i++)
      pthread_create(&pthread, NULL, worker, (void *)&flag);
  worker((void *)&flag);
}

[The test program : bugacct.c]
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <sys/time.h>

#define BUFFER_SIZE (128 * 1024 * 1024)  /* 128MB */

void *mychild(void *buffer) {
        struct timeval tv;
        u_int64_t t1, t2;

        gettimeofday(&tv, NULL);
        t1 = tv.tv_sec * 1000000 + tv.tv_usec;
        t2 = t1 + 6 * 1000000;
        /* heavy CPU/Mem job */
        srand(tv.tv_usec);
        while(t1 < t2) {
            memset(buffer, rand(), BUFFER_SIZE);
            gettimeofday(&tv, NULL);
            t1 = tv.tv_sec * 1000000 + tv.tv_usec;
        }
        return NULL;
}

int main(int argc, char *argv[]) {
        pthread_t pthread;
        void *buffer = NULL;

        buffer = malloc(BUFFER_SIZE);
        if (!buffer)
            return 1;

        sleep(4);
        pthread_create(&pthread, NULL, mychild, buffer);
        nice(-1);
        sleep(1);
        pthread_exit(0);
}

[The patch against to 2.6.17]
--- linux-2.6.17/include/linux/acct.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.kg/include/linux/acct.h	2006-06-19 17:04:11.000000000 +0900
@@ -123,13 +123,17 @@ struct vfsmount;
 struct super_block;
 extern void acct_auto_close_mnt(struct vfsmount *m);
 extern void acct_auto_close(struct super_block *sb);
-extern void acct_process(long exitcode);
+extern void acct_init_pacct(struct pacct_struct *pacct, struct task_struct *tsk);
+extern void acct_collect(long exitcode, int group_dead);
+extern void acct_process(void);
 extern void acct_update_integrals(struct task_struct *tsk);
 extern void acct_clear_integrals(struct task_struct *tsk);
 #else
 #define acct_auto_close_mnt(x)	do { } while (0)
 #define acct_auto_close(x)	do { } while (0)
-#define acct_process(x)		do { } while (0)
+#define acct_init_pacct(x,y)	do { } while (0)
+#define acct_collect(x,y)	do { } while (0)
+#define acct_process()		do { } while (0)
 #define acct_update_integrals(x)		do { } while (0)
 #define acct_clear_integrals(task)	do { } while (0)
 #endif
--- linux-2.6.17/include/linux/sched.h	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.kg/include/linux/sched.h	2006-06-19 16:59:16.000000000 +0900
@@ -358,6 +358,15 @@ struct sighand_struct {
 	spinlock_t		siglock;
 };

+struct pacct_struct {
+	int		ac_flag;
+	long		ac_exitcode;
+	cputime_t	ac_utime, ac_stime;
+	unsigned long	ac_mem;
+	unsigned long	ac_minflt, ac_majflt;
+	struct timespec	ac_start_time;
+};
+
 /*
  * NOTE! "signal_struct" does not have it's own
  * locking, because a shared signal_struct always
@@ -449,6 +458,9 @@ struct signal_struct {
 	struct key *session_keyring;	/* keyring inherited over fork */
 	struct key *process_keyring;	/* keyring private to this process */
 #endif
+#ifdef CONFIG_BSD_PROCESS_ACCT
+	struct pacct_struct pacct;	/* per-process accounting information */
+#endif
 };

 /* Context switch must be unlocked if interrupts are to be enabled */
--- linux-2.6.17/kernel/acct.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.kg/kernel/acct.c	2006-06-20 14:55:34.000000000 +0900
@@ -75,7 +75,7 @@ int acct_parm[3] = {4, 2, 30};
 /*
  * External references and all of the globals.
  */
-static void do_acct_process(long, struct file *);
+static void do_acct_process(struct file *);

 /*
  * This structure is used so that all the data protected by lock
@@ -196,7 +196,7 @@ static void acct_file_reopen(struct file
 	if (old_acct) {
 		mnt_unpin(old_acct->f_vfsmnt);
 		spin_unlock(&acct_globals.lock);
-		do_acct_process(0, old_acct);
+		do_acct_process(old_acct);
 		filp_close(old_acct, NULL);
 		spin_lock(&acct_globals.lock);
 	}
@@ -419,16 +419,16 @@ static u32 encode_float(u64 value)
 /*
  *  do_acct_process does all actual work. Caller holds the reference to file.
  */
-static void do_acct_process(long exitcode, struct file *file)
+static void do_acct_process(struct file *file)
 {
+	struct signal_struct *sig = current->signal;
+	struct pacct_struct *pacct = &sig->pacct;
 	acct_t ac;
 	mm_segment_t fs;
-	unsigned long vsize;
 	unsigned long flim;
 	u64 elapsed;
 	u64 run_time;
 	struct timespec uptime;
-	unsigned long jiffies;

 	/*
 	 * First check to see if there is enough free_space to continue
@@ -449,8 +449,8 @@ static void do_acct_process(long exitcod
 	/* calculate run_time in nsec*/
 	do_posix_clock_monotonic_gettime(&uptime);
 	run_time = (u64)uptime.tv_sec*NSEC_PER_SEC + uptime.tv_nsec;
-	run_time -= (u64)current->group_leader->start_time.tv_sec * NSEC_PER_SEC
-		       + current->group_leader->start_time.tv_nsec;
+	run_time -= (u64)pacct->ac_start_time.tv_sec * NSEC_PER_SEC
+			+ pacct->ac_start_time.tv_nsec;
 	/* convert nsec -> AHZ */
 	elapsed = nsec_to_AHZ(run_time);
 #if ACCT_VERSION==3
@@ -469,12 +469,8 @@ static void do_acct_process(long exitcod
 #endif
 	do_div(elapsed, AHZ);
 	ac.ac_btime = xtime.tv_sec - elapsed;
-	jiffies = cputime_to_jiffies(cputime_add(current->utime,
-						 current->signal->utime));
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(jiffies));
-	jiffies = cputime_to_jiffies(cputime_add(current->stime,
-						 current->signal->stime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(jiffies));
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_stime)));
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
@@ -496,37 +492,14 @@ static void do_acct_process(long exitcod
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
+	ac.ac_flag = pacct->ac_flag;
+	ac.ac_mem = encode_comp_t(pacct->ac_mem);
 	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
 	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
-	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
-				     current->min_flt);
-	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
-				     current->maj_flt);
+	ac.ac_minflt = encode_comp_t(pacct->ac_minflt);
+	ac.ac_majflt = encode_comp_t(pacct->ac_majflt);
 	ac.ac_swaps = encode_comp_t(0);
-	ac.ac_exitcode = exitcode;
+	ac.ac_exitcode = pacct->ac_exitcode;

 	/*
          * Kernel segment override to datasegment and write it
@@ -545,13 +518,56 @@ static void do_acct_process(long exitcod
 	set_fs(fs);
 }

+void acct_init_pacct(struct pacct_struct *pacct, struct task_struct *tsk)
+{
+	memset(pacct, 0, sizeof(struct pacct_struct));
+	pacct->ac_utime = pacct->ac_stime = cputime_zero;
+}
+
+void acct_collect(long exitcode, int group_dead)
+{
+	struct pacct_struct *pacct = &current->signal->pacct;
+	unsigned long vsize = 0;
+
+	if (group_dead && current->mm) {
+		struct vm_area_struct *vma;
+		down_read(&current->mm->mmap_sem);
+		vma = current->mm->mmap;
+		while (vma) {
+			vsize += vma->vm_end - vma->vm_start;
+			vma = vma->vm_next;
+		}
+		up_read(&current->mm->mmap_sem);
+	}
+	spin_lock(&current->sighand->siglock);
+	if (group_dead)
+		pacct->ac_mem = vsize / 1024;
+	if (thread_group_leader(current)) {
+		pacct->ac_start_time = current->start_time;
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
+	pacct->ac_utime = cputime_add(pacct->ac_utime, current->utime);
+	pacct->ac_stime = cputime_add(pacct->ac_stime, current->stime);
+	pacct->ac_minflt += current->min_flt;
+	pacct->ac_majflt += current->maj_flt;
+	spin_unlock(&current->sighand->siglock);
+}
+
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

@@ -570,11 +586,10 @@ void acct_process(long exitcode)
 	get_file(file);
 	spin_unlock(&acct_globals.lock);

-	do_acct_process(exitcode, file);
+	do_acct_process(file);
 	fput(file);
 }

-
 /**
  * acct_update_integrals - update mm integral fields in task_struct
  * @tsk: task_struct for accounting
--- linux-2.6.17/kernel/fork.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.kg/kernel/fork.c	2006-06-19 16:16:30.000000000 +0900
@@ -871,6 +871,7 @@ static inline int copy_signal(unsigned l
 		tsk->it_prof_expires =
 			secs_to_cputime(sig->rlim[RLIMIT_CPU].rlim_cur);
 	}
+	acct_init_pacct(&sig->pacct, tsk);

 	return 0;
 }
--- linux-2.6.17/kernel/exit.c	2006-06-18 10:49:35.000000000 +0900
+++ linux-2.6.17.kg/kernel/exit.c	2006-06-19 16:14:31.000000000 +0900
@@ -895,8 +895,8 @@ fastcall NORET_TYPE void do_exit(long co
 	if (group_dead) {
  		hrtimer_cancel(&tsk->signal->real_timer);
 		exit_itimers(tsk->signal);
-		acct_process(code);
 	}
+	acct_collect(code, group_dead);
 	if (unlikely(tsk->robust_list))
 		exit_robust_list(tsk);
 #ifdef CONFIG_COMPAT
@@ -907,6 +907,8 @@ fastcall NORET_TYPE void do_exit(long co
 		audit_free(tsk);
 	exit_mm(tsk);

+	if (group_dead)
+		acct_process();
 	exit_sem(tsk);
 	__exit_files(tsk);
 	__exit_fs(tsk);
