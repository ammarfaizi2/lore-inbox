Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315410AbSFTSSE>; Thu, 20 Jun 2002 14:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315411AbSFTSSE>; Thu, 20 Jun 2002 14:18:04 -0400
Received: from holomorphy.com ([66.224.33.161]:47807 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315410AbSFTSSC>;
	Thu, 20 Jun 2002 14:18:02 -0400
Date: Thu, 20 Jun 2002 11:17:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] scheduler bits from 2.5.23-dj1
Message-ID: <20020620181729.GY22961@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ingo Molnar <mingo@elte.hu>, Dave Jones <davej@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020620172059.GW22961@holomorphy.com> <Pine.LNX.4.44.0206201929310.9805-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206201929310.9805-100000@e2>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 07:31:18PM +0200, Ingo Molnar wrote:
> looks good to me - what do you think about my other pidhash suggestion:

An excellent idea. I didn't go all the way and make the pidhash entirely
private to fork.c but taking find_task_by_pid() out-of-line is implemented
in the following, built atop the prior patch. I can also privatize the
pidhash entirely if that's wanted.


Cheers,
Bill

diff -urN linux-2.5.23-virgin/include/linux/sched.h linux-2.5.23-wli/include/linux/sched.h
--- linux-2.5.23-virgin/include/linux/sched.h	Thu Jun 20 10:53:42 2002
+++ linux-2.5.23-wli/include/linux/sched.h	Thu Jun 20 10:55:18 2002
@@ -459,19 +459,7 @@
 	list_del(&p->pidhash_list);
 }
 
-static inline task_t *find_task_by_pid(int pid)
-{
-	list_t *p, *pid_list = &pidhash[pid_hashfn(pid)];
-
-	list_for_each(p, pid_list) {
-		task_t *t = list_entry(p, task_t, pidhash_list);
-
-		if(t->pid == pid)
-			return t;
-	}
-
-	return NULL;
-}
+extern task_t *find_task_by_pid(int pid);
 
 /* per-UID process charging. */
 extern struct user_struct * alloc_uid(uid_t);
diff -urN linux-2.5.23-virgin/kernel/fork.c linux-2.5.23-wli/kernel/fork.c
--- linux-2.5.23-virgin/kernel/fork.c	Thu Jun 20 10:53:42 2002
+++ linux-2.5.23-wli/kernel/fork.c	Thu Jun 20 10:55:55 2002
@@ -69,6 +69,21 @@
 		INIT_LIST_HEAD(&pidhash[i]);
 }
 
+task_t *find_task_by_pid(int pid)
+{
+	list_t *p, *pid_list = &pidhash[pid_hashfn(pid)];
+
+	list_for_each(p, pid_list) {
+		task_t *t = list_entry(p, task_t, pidhash_list);
+
+		if(t->pid == pid)
+			return t;
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL(find_task_by_pid);
+
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;  /* outer */
 
 void add_wait_queue(wait_queue_head_t *q, wait_queue_t * wait)
