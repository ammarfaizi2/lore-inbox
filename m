Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261182AbVCaHqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261182AbVCaHqE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCaHoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:44:44 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:11896 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262544AbVCaHnF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:43:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=gWJEvjPRWlg+v7DFpMBEu2Gop9IC0l5sw3frY5xz7F/1BdfPntQ/aLZ8Beev1foNSf1brw1Us4iVuGkKovlWVHYNlIpQO4cKn3x2k3NAQxN7TAN7wJaH2pExNp2aaRXxTB8pLfyetV3R2HnATjw31oNfk0I66onDFqYfun/Wujo=
Message-ID: <df35dfeb05033023432d10550e@mail.gmail.com>
Date: Wed, 30 Mar 2005 23:43:05 -0800
From: Yum Rayan <yum.rayan@gmail.com>
Reply-To: Yum Rayan <yum.rayan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] Reduce stack usage in itimer.c
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attempt to reduce stack usage in itimer.c (linux-2.6.12-rc1-mm3). Stack
usage was noted using checkstack.pl. Specifically

Before patch
------------
do_setitimer - 160

After patch
-----------
do_setitimer - none
do_setitimer_real 52
do_setitimer_virtual 52
do_setitimer_prof 52

A singularly heavy stack user do_setitimer(...) was broken down into 3
separate functions. Stack usage will now be lower depending on the path taken.

Signed-off-by: Yum Rayan <yum.rayan@gmail.com>

--- a/kernel/itimer.c	2005-03-25 22:10:33.000000000 -0800
+++ b/kernel/itimer.c	2005-03-30 15:59:11.000000000 -0800
@@ -141,83 +141,95 @@
 	it_real_arm(p, p->signal->it_real_incr);
 }
 
-int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
+static void do_setitimer_real(struct itimerval *value, struct
itimerval *ovalue)
 {
 	struct task_struct *tsk = current;
  	unsigned long val, interval;
+
+	spin_lock_irq(&tsk->sighand->siglock);
+	interval = tsk->signal->it_real_incr;
+	val = it_real_value(tsk->signal);
+	if (val)
+		del_timer_sync(&tsk->signal->real_timer);
+	tsk->signal->it_real_incr = timeval_to_jiffies(&value->it_interval);
+	it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
+	spin_unlock_irq(&tsk->sighand->siglock);
+	if (ovalue) {
+		jiffies_to_timeval(val, &ovalue->it_value);
+		jiffies_to_timeval(interval, &ovalue->it_interval);
+	}
+}
+
+static void do_setitimer_virtual(struct itimerval *value,
+				 struct itimerval *ovalue)
+{
+	struct task_struct *tsk = current;
+	cputime_t cval, cinterval, nval, ninterval;
+
+	nval = timeval_to_cputime(&value->it_value);
+	ninterval = timeval_to_cputime(&value->it_interval);
+	read_lock(&tasklist_lock);
+	spin_lock_irq(&tsk->sighand->siglock);
+	cval = tsk->signal->it_virt_expires;
+	cinterval = tsk->signal->it_virt_incr;
+	if (!cputime_eq(cval, cputime_zero) ||
+	    !cputime_eq(nval, cputime_zero)) {
+		if (cputime_gt(nval, cputime_zero))
+			nval = cputime_add(nval, jiffies_to_cputime(1));
+		set_process_cpu_timer(tsk, CPUCLOCK_VIRT, &nval, &cval);
+	}
+	tsk->signal->it_virt_expires = nval;
+	tsk->signal->it_virt_incr = ninterval;
+	spin_unlock_irq(&tsk->sighand->siglock);
+	read_unlock(&tasklist_lock);
+	if (ovalue) {
+		cputime_to_timeval(cval, &ovalue->it_value);
+		cputime_to_timeval(cinterval, &ovalue->it_interval);
+	}
+}
+static void do_setitimer_prof(struct itimerval *value, struct
itimerval *ovalue)
+{
+	struct task_struct *tsk = current;
 	cputime_t cval, cinterval, nval, ninterval;
+	nval = timeval_to_cputime(&value->it_value);
+	ninterval = timeval_to_cputime(&value->it_interval);
+	read_lock(&tasklist_lock);
+	spin_lock_irq(&tsk->sighand->siglock);
+	cval = tsk->signal->it_prof_expires;
+	cinterval = tsk->signal->it_prof_incr;
+	if (!cputime_eq(cval, cputime_zero) ||
+		!cputime_eq(nval, cputime_zero)) {
+		if (cputime_gt(nval, cputime_zero))
+			nval = cputime_add(nval, jiffies_to_cputime(1));
+		set_process_cpu_timer(tsk, CPUCLOCK_PROF, &nval, &cval);
+	}
+	tsk->signal->it_prof_expires = nval;
+	tsk->signal->it_prof_incr = ninterval;
+	spin_unlock_irq(&tsk->sighand->siglock);
+	read_unlock(&tasklist_lock);
+	if (ovalue) {
+		cputime_to_timeval(cval, &ovalue->it_value);
+		cputime_to_timeval(cinterval, &ovalue->it_interval);
+	}
+}
 
+int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
+{
 	switch (which) {
 	case ITIMER_REAL:
-		spin_lock_irq(&tsk->sighand->siglock);
-		interval = tsk->signal->it_real_incr;
-		val = it_real_value(tsk->signal);
-		if (val)
-			del_timer_sync(&tsk->signal->real_timer);
-		tsk->signal->it_real_incr =
-			timeval_to_jiffies(&value->it_interval);
-		it_real_arm(tsk, timeval_to_jiffies(&value->it_value));
-		spin_unlock_irq(&tsk->sighand->siglock);
-		if (ovalue) {
-			jiffies_to_timeval(val, &ovalue->it_value);
-			jiffies_to_timeval(interval,
-					   &ovalue->it_interval);
-		}
+		do_setitimer_real(value, ovalue);
 		break;
 	case ITIMER_VIRTUAL:
-		nval = timeval_to_cputime(&value->it_value);
-		ninterval = timeval_to_cputime(&value->it_interval);
-		read_lock(&tasklist_lock);
-		spin_lock_irq(&tsk->sighand->siglock);
-		cval = tsk->signal->it_virt_expires;
-		cinterval = tsk->signal->it_virt_incr;
-		if (!cputime_eq(cval, cputime_zero) ||
-		    !cputime_eq(nval, cputime_zero)) {
-			if (cputime_gt(nval, cputime_zero))
-				nval = cputime_add(nval,
-						   jiffies_to_cputime(1));
-			set_process_cpu_timer(tsk, CPUCLOCK_VIRT,
-					      &nval, &cval);
-		}
-		tsk->signal->it_virt_expires = nval;
-		tsk->signal->it_virt_incr = ninterval;
-		spin_unlock_irq(&tsk->sighand->siglock);
-		read_unlock(&tasklist_lock);
-		if (ovalue) {
-			cputime_to_timeval(cval, &ovalue->it_value);
-			cputime_to_timeval(cinterval, &ovalue->it_interval);
-		}
+		do_setitimer_virtual(value, ovalue);
 		break;
 	case ITIMER_PROF:
-		nval = timeval_to_cputime(&value->it_value);
-		ninterval = timeval_to_cputime(&value->it_interval);
-		read_lock(&tasklist_lock);
-		spin_lock_irq(&tsk->sighand->siglock);
-		cval = tsk->signal->it_prof_expires;
-		cinterval = tsk->signal->it_prof_incr;
-		if (!cputime_eq(cval, cputime_zero) ||
-		    !cputime_eq(nval, cputime_zero)) {
-			if (cputime_gt(nval, cputime_zero))
-				nval = cputime_add(nval,
-						   jiffies_to_cputime(1));
-			set_process_cpu_timer(tsk, CPUCLOCK_PROF,
-					      &nval, &cval);
-		}
-		tsk->signal->it_prof_expires = nval;
-		tsk->signal->it_prof_incr = ninterval;
-		spin_unlock_irq(&tsk->sighand->siglock);
-		read_unlock(&tasklist_lock);
-		if (ovalue) {
-			cputime_to_timeval(cval, &ovalue->it_value);
-			cputime_to_timeval(cinterval, &ovalue->it_interval);
-		}
+		do_setitimer_prof(value, ovalue);
 		break;
 	default:
 		return -EINVAL;
 	}
 	return 0;
 }
-
 asmlinkage long sys_setitimer(int which,
 			      struct itimerval __user *value,
 			      struct itimerval __user *ovalue)
