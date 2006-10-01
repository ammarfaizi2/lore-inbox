Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751680AbWJALig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbWJALig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 07:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWJALic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 07:38:32 -0400
Received: from mx04.stofanet.dk ([212.10.10.14]:9631 "EHLO mx04.stofanet.dk")
	by vger.kernel.org with ESMTP id S932065AbWJALi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 07:38:27 -0400
Date: Sun, 1 Oct 2006 13:37:49 +0200 (CEST)
From: Esben Nielsen <nielsen.esben@googlemail.com>
X-X-Sender: simlo@frodo.shire
To: Ingo Molnar <mingo@elte.hu>
cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 5/5] Fix timeout bug in rtmutex in 2.6.18-rt
Message-ID: <Pine.LNX.4.64.0610011337250.29459@frodo.shire>
References: <20061001112829.630288000@frodo>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  kernel/futex.c |   11 +++++++++--
  1 file changed, 9 insertions(+), 2 deletions(-)

Index: linux-2.6.18-rt/kernel/futex.c
===================================================================
--- linux-2.6.18-rt.orig/kernel/futex.c
+++ linux-2.6.18-rt/kernel/futex.c
@@ -567,6 +567,7 @@ static int wake_futex_pi(u32 __user *uad
  	if (!pi_state)
  		return -EINVAL;

+	spin_lock(&pi_state->pi_mutex.wait_lock);
  	new_owner = rt_mutex_next_owner(&pi_state->pi_mutex);

  	/*
@@ -589,10 +590,14 @@ static int wake_futex_pi(u32 __user *uad
  		inc_preempt_count();
  		curval = futex_atomic_cmpxchg_inatomic(uaddr, uval, newval);
  		dec_preempt_count();
-		if (curval == -EFAULT)
+		if (curval == -EFAULT) {
+			spin_unlock(&pi_state->pi_mutex.wait_lock);
  			return -EFAULT;
-		if (curval != uval)
+		}
+		if (curval != uval) {
+			spin_unlock(&pi_state->pi_mutex.wait_lock);
  			return -EINVAL;
+		}
  	}

  	spin_lock_irq(&pi_state->owner->pi_lock);
@@ -606,6 +611,8 @@ static int wake_futex_pi(u32 __user *uad
  	pi_state->owner = new_owner;
  	spin_unlock_irq(&new_owner->pi_lock);

+	spin_unlock(&pi_state->pi_mutex.wait_lock);
+
  	rt_mutex_unlock(&pi_state->pi_mutex);

  	return 0;

--
