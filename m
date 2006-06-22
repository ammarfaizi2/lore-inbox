Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030588AbWFVDJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbWFVDJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 23:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030592AbWFVDJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 23:09:58 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:64510 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S1030588AbWFVDJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 23:09:57 -0400
Message-ID: <449A09E8.1030703@ak.jp.nec.com>
Date: Thu, 22 Jun 2006 12:09:28 +0900
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

     [PACCT] none-delayed process accounting accumulation

     In current 2.6.17 implementation, signal_struct refered from task_struct
     is used for per-process data structure. The pacct facility also uses it
     as a per-process data structure to store stime, utime, minflt, majflt.
     But those members are saved in __exit_signal(). It's too late.

     For example, if some threads exits at same time, pacct facility has
     a possibility to drop accountings for a part of those threads.
     (see, the following 'The results of original 2.6.17 kernel')
     I think accounting information should be completely collected into
     the per-process data structure before writing out an accounting record.

     This patch fixes this matter. Accumulation of stime, utime, minflt
     and majflt are done before generating accounting record.

     Signed-off-by: KaiGai Kohei <kaigai@ak.jp.nec.com>

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6905ac0..06c72fb 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -360,10 +360,12 @@ struct sighand_struct {

  struct pacct_struct {
  	int			ac_flag;
  	long			ac_exitcode;
  	unsigned long		ac_mem;
+	cputime_t		ac_utime, ac_stime;
+	unsigned long		ac_minflt, ac_majflt;
  };

  /*
   * NOTE! "signal_struct" does not have it's own
   * locking, because a shared signal_struct always
diff --git a/kernel/acct.c b/kernel/acct.c
index 7111fe7..48c701c 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -426,11 +426,10 @@ static void do_acct_process(struct file
  	mm_segment_t fs;
  	unsigned long flim;
  	u64 elapsed;
  	u64 run_time;
  	struct timespec uptime;
-	unsigned long jiffies;

  	/*
  	 * First check to see if there is enough free_space to continue
  	 * the process accounting system.
  	 */
@@ -467,16 +466,10 @@ static void do_acct_process(struct file
  		ac.ac_etime_lo = (u16) etime;
  	}
  #endif
  	do_div(elapsed, AHZ);
  	ac.ac_btime = xtime.tv_sec - elapsed;
-	jiffies = cputime_to_jiffies(cputime_add(current->utime,
-						 current->signal->utime));
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(jiffies));
-	jiffies = cputime_to_jiffies(cputime_add(current->stime,
-						 current->signal->stime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(jiffies));
  	/* we really need to bite the bullet and change layout */
  	ac.ac_uid = current->uid;
  	ac.ac_gid = current->gid;
  #if ACCT_VERSION==2
  	ac.ac_ahz = AHZ;
@@ -495,20 +488,20 @@ static void do_acct_process(struct file
  	ac.ac_tty = current->signal->tty ?
  		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
  	read_unlock(&tasklist_lock);

  	spin_lock(&current->sighand->siglock);
+	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_utime)));
+	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(cputime_to_jiffies(pacct->ac_stime)));
  	ac.ac_flag = pacct->ac_flag;
  	ac.ac_mem = encode_comp_t(pacct->ac_mem);
+	ac.ac_minflt = encode_comp_t(pacct->ac_minflt);
+	ac.ac_majflt = encode_comp_t(pacct->ac_majflt);
  	ac.ac_exitcode = pacct->ac_exitcode;
  	spin_unlock(&current->sighand->siglock);
  	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
  	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
-	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
-				     current->min_flt);
-	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
-				     current->maj_flt);
  	ac.ac_swaps = encode_comp_t(0);

  	/*
           * Kernel segment override to datasegment and write it
           * to the accounting file.
@@ -530,10 +523,11 @@ static void do_acct_process(struct file
   * acct_init_pacct - initialize a new pacct_struct
   */
  void acct_init_pacct(struct pacct_struct *pacct)
  {
  	memset(pacct, 0, sizeof(struct pacct_struct));
+	pacct->ac_utime = pacct->ac_stime = cputime_zero;
  }

  /**
   * acct_collect - collect accounting information into pacct_struct
   * @exitcode: task exit code
@@ -567,10 +561,14 @@ void acct_collect(long exitcode, int gro
  		pacct->ac_flag |= ASU;
  	if (current->flags & PF_DUMPCORE)
  		pacct->ac_flag |= ACORE;
  	if (current->flags & PF_SIGNALED)
  		pacct->ac_flag |= AXSIG;
+	pacct->ac_utime = cputime_add(pacct->ac_utime, current->utime);
+	pacct->ac_stime = cputime_add(pacct->ac_stime, current->stime);
+	pacct->ac_minflt += current->min_flt;
+	pacct->ac_majflt += current->maj_flt;
  	spin_unlock(&current->sighand->siglock);
  }

  /**
   * acct_process - now just a wrapper around do_acct_process

-- 
Open Source Software Promotion Center, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>
