Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVCaHm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVCaHm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:42:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbVCaHmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:42:55 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:53077 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262021AbVCaHjk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:39:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=jSz57MroxK+F5avSA0JDlrDJwyzBtIKc5LzUrCqlLwWwduIj48RzoKA5Bo5k/WZd7QlI1hj2jvlR7nugmJMen5yF/jUJTsdUfzUhkjxCHWGKcXZ9mFj/QwhAf4PYTdtnHWheKMxszUIspx+rF9JWDpTMGibFjZD8im0r0rtl73w=
Message-ID: <df35dfeb05033023394170d6cc@mail.gmail.com>
Date: Wed, 30 Mar 2005 23:39:40 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org, mvw@planets.elm.net
Subject: [PATCH] Reduce stack usage in acct.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to reduce stack usage in acct.c (linux-2.6.12-rc1-mm3). Stack
usage was noted using checkstack.pl. Specifically:

Before patch
------------
check_free_space - 128
do_acct_process - 105

After patch
-----------
check_free_space - 36
do_acct_process - 44

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- a/kernel/acct.c	2005-03-25 22:11:06.000000000 -0800
+++ b/kernel/acct.c	2005-03-30 15:33:05.000000000 -0800
@@ -103,30 +103,32 @@
  */
 static int check_free_space(struct file *file)
 {
-	struct kstatfs sbuf;
-	int res;
-	int act;
-	sector_t resume;
-	sector_t suspend;
+	struct kstatfs *sbuf = NULL;
+	int res, act;
+	sector_t resume, suspend;
 
 	spin_lock(&acct_globals.lock);
 	res = acct_globals.active;
 	if (!file || !acct_globals.needcheck)
-		goto out;
+		goto out_unlock;
 	spin_unlock(&acct_globals.lock);
 
+	sbuf = kmalloc(sizeof (struct kstatfs), GFP_KERNEL);
+	if (!sbuf)
+		goto out_res;
+
 	/* May block */
-	if (vfs_statfs(file->f_dentry->d_inode->i_sb, &sbuf))
-		return res;
-	suspend = sbuf.f_blocks * SUSPEND;
-	resume = sbuf.f_blocks * RESUME;
+	if (vfs_statfs(file->f_dentry->d_inode->i_sb, sbuf))
+		goto out_free_sbuf;
+	suspend = sbuf->f_blocks * SUSPEND;
+	resume = sbuf->f_blocks * RESUME;
 
 	sector_div(suspend, 100);
 	sector_div(resume, 100);
 
-	if (sbuf.f_bavail <= suspend)
+	if (sbuf->f_bavail <= suspend)
 		act = -1;
-	else if (sbuf.f_bavail >= resume)
+	else if (sbuf->f_bavail >= resume)
 		act = 1;
 	else
 		act = 0;
@@ -139,7 +141,7 @@
 	if (file != acct_globals.file) {
 		if (act)
 			res = act>0;
-		goto out;
+		goto out_unlock;
 	}
 
 	if (acct_globals.active) {
@@ -159,8 +161,11 @@
 	acct_globals.timer.expires = jiffies + ACCT_TIMEOUT*HZ;
 	add_timer(&acct_globals.timer);
 	res = acct_globals.active;
-out:
+out_unlock:
 	spin_unlock(&acct_globals.lock);
+out_free_sbuf:
+	kfree(sbuf);
+out_res:
 	return res;
 }
 
@@ -380,7 +385,7 @@
  */
 static void do_acct_process(long exitcode, struct file *file)
 {
-	acct_t ac;
+	acct_t *ac;
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
@@ -395,14 +400,18 @@
 	if (!check_free_space(file))
 		return;
 
+	ac = kmalloc(sizeof (acct_t), GFP_KERNEL);
+	if (!ac)
+		return;
+
 	/*
 	 * Fill the accounting struct with the needed info as recorded
 	 * by the different kernel functions.
 	 */
-	memset((caddr_t)&ac, 0, sizeof(acct_t));
+	memset(ac, 0, sizeof(acct_t));
 
-	ac.ac_version = ACCT_VERSION | ACCT_BYTEORDER;
-	strlcpy(ac.ac_comm, current->comm, sizeof(ac.ac_comm));
+	ac->ac_version = ACCT_VERSION | ACCT_BYTEORDER;
+	strlcpy(ac->ac_comm, current->comm, sizeof(ac->ac_comm));
 
 	/* calculate run_time in nsec*/
 	do_posix_clock_monotonic_gettime(&uptime);
@@ -412,57 +421,57 @@
 	/* convert nsec -> AHZ */
 	elapsed = nsec_to_AHZ(run_time);
 #if ACCT_VERSION==3
-	ac.ac_etime = encode_float(elapsed);
+	ac->ac_etime = encode_float(elapsed);
 #else
-	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
+	ac->ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
 	                       (unsigned long) elapsed : (unsigned long) -1l);
 #endif
 #if ACCT_VERSION==1 || ACCT_VERSION==2
 	{
 		/* new enlarged etime field */
 		comp2_t etime = encode_comp2_t(elapsed);
-		ac.ac_etime_hi = etime >> 16;
-		ac.ac_etime_lo = (u16) etime;
+		ac->ac_etime_hi = etime >> 16;
+		ac->ac_etime_lo = (u16) etime;
 	}
 #endif
 	do_div(elapsed, AHZ);
-	ac.ac_btime = xtime.tv_sec - elapsed;
-	ac.ac_utime = encode_comp_t(jiffies_to_AHZ(
+	ac->ac_btime = xtime.tv_sec - elapsed;
+	ac->ac_utime = encode_comp_t(jiffies_to_AHZ(
 					    current->signal->utime +
 					    current->group_leader->utime));
-	ac.ac_stime = encode_comp_t(jiffies_to_AHZ(
+	ac->ac_stime = encode_comp_t(jiffies_to_AHZ(
 					    current->signal->stime +
 					    current->group_leader->stime));
 	/* we really need to bite the bullet and change layout */
-	ac.ac_uid = current->uid;
-	ac.ac_gid = current->gid;
+	ac->ac_uid = current->uid;
+	ac->ac_gid = current->gid;
 #if ACCT_VERSION==2
-	ac.ac_ahz = AHZ;
+	ac->ac_ahz = AHZ;
 #endif
 #if ACCT_VERSION==1 || ACCT_VERSION==2
 	/* backward-compatible 16 bit fields */
-	ac.ac_uid16 = current->uid;
-	ac.ac_gid16 = current->gid;
+	ac->ac_uid16 = current->uid;
+	ac->ac_gid16 = current->gid;
 #endif
 #if ACCT_VERSION==3
-	ac.ac_pid = current->tgid;
-	ac.ac_ppid = current->parent->tgid;
+	ac->ac_pid = current->tgid;
+	ac->ac_ppid = current->parent->tgid;
 #endif
 
 	read_lock(&tasklist_lock);	/* pin current->signal */
-	ac.ac_tty = current->signal->tty ?
+	ac->ac_tty = current->signal->tty ?
 		old_encode_dev(tty_devnum(current->signal->tty)) : 0;
 	read_unlock(&tasklist_lock);
 
-	ac.ac_flag = 0;
+	ac->ac_flag = 0;
 	if (current->flags & PF_FORKNOEXEC)
-		ac.ac_flag |= AFORK;
+		ac->ac_flag |= AFORK;
 	if (current->flags & PF_SUPERPRIV)
-		ac.ac_flag |= ASU;
+		ac->ac_flag |= ASU;
 	if (current->flags & PF_DUMPCORE)
-		ac.ac_flag |= ACORE;
+		ac->ac_flag |= ACORE;
 	if (current->flags & PF_SIGNALED)
-		ac.ac_flag |= AXSIG;
+		ac->ac_flag |= AXSIG;
 
 	vsize = 0;
 	if (current->mm) {
@@ -476,15 +485,15 @@
 		up_read(&current->mm->mmap_sem);
 	}
 	vsize = vsize / 1024;
-	ac.ac_mem = encode_comp_t(vsize);
-	ac.ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
-	ac.ac_rw = encode_comp_t(ac.ac_io / 1024);
-	ac.ac_minflt = encode_comp_t(current->signal->min_flt +
+	ac->ac_mem = encode_comp_t(vsize);
+	ac->ac_io = encode_comp_t(0 /* current->io_usage */);	/* %% */
+	ac->ac_rw = encode_comp_t(ac->ac_io / 1024);
+	ac->ac_minflt = encode_comp_t(current->signal->min_flt +
 				     current->group_leader->min_flt);
-	ac.ac_majflt = encode_comp_t(current->signal->maj_flt +
+	ac->ac_majflt = encode_comp_t(current->signal->maj_flt +
 				     current->group_leader->maj_flt);
-	ac.ac_swaps = encode_comp_t(0);
-	ac.ac_exitcode = exitcode;
+	ac->ac_swaps = encode_comp_t(0);
+	ac->ac_exitcode = exitcode;
 
 	/*
          * Kernel segment override to datasegment and write it
@@ -497,10 +506,11 @@
  	 */
 	flim = current->signal->rlim[RLIMIT_FSIZE].rlim_cur;
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = RLIM_INFINITY;
-	file->f_op->write(file, (char *)&ac,
+	file->f_op->write(file, (char *)ac,
 			       sizeof(acct_t), &file->f_pos);
 	current->signal->rlim[RLIMIT_FSIZE].rlim_cur = flim;
 	set_fs(fs);
+	kfree(ac);
 }
 
 /*
