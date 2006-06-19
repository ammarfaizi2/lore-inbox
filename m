Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932135AbWFSFEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135AbWFSFEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 01:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWFSFEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 01:04:51 -0400
Received: from omta02ps.mx.bigpond.com ([144.140.83.154]:36054 "EHLO
	omta02ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S932135AbWFSFEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 01:04:50 -0400
Message-ID: <44963070.1080106@bigpond.net.au>
Date: Mon, 19 Jun 2006 15:04:48 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: kernel@kolivas.org, sam@vilain.net, bsingharora@gmail.com,
       vatsa@in.ibm.com, dev@openvz.org, linux-kernel@vger.kernel.org,
       efault@gmx.de, kingsley@aurema.com, ckrm-tech@lists.sourceforge.net,
       mingo@elte.hu, rene.herman@keyaccess.nl
Subject: Re: [PATCH 0/4] sched: Add CPU rate caps
References: <20060618082638.6061.20172.sendpatchset@heathwren.pw.nest> <20060618025046.77b0cecf.akpm@osdl.org> <449529FE.1040008@bigpond.net.au>
In-Reply-To: <449529FE.1040008@bigpond.net.au>
Content-Type: multipart/mixed;
 boundary="------------020102010905040304070004"
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta02ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 19 Jun 2006 05:04:47 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020102010905040304070004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Peter Williams wrote:
> Andrew Morton wrote:
>> On Sun, 18 Jun 2006 18:26:38 +1000
>> Peter Williams <pwil3058@bigpond.net.au> wrote:
>>> 5. Code size measurements:
>>>
>>> Vanilla kernel:
>>>
>>>    text    data     bss     dec     hex filename
>>>   33800    4689     296   38785    9781 sched.o
>>>    2554      79       0    2633     a49 mutex.o
>>>   12076    2632       0   14708    3974 base.o
>>>
>>> Patches applied:
>>>
>>>    text    data     bss     dec     hex filename
>>>   36870    4721     296   41887    a39f sched.o
>>>    2630      79       0    2709     a95 mutex.o
>>>   13011    2920       0   15931    3e3b base.o
>>>
>>> Indicating that the size cost of the patch proper is about
>>> 3 kilobytes and the procfs costs about another 1.2 kilobytes.
>>>
>>
>> hm.  That seems rather a lot.  I guess it's not a simple thing to do.
> 
> I suspect that a large part of that is the functions that set the caps 
> (i.e. the equivalents of set_user_nice()) one for soft and one for hard 
> caps.  The actual capping mechanisms are quite simple.

This contribution may not be as large as I thought.  Realizing that the
function to set soft caps and the function to set hard caps duplicate a
lot of code I've modified them to share code rather than duplicate.
I've also made the functions for getting caps inline and they should
just be optimized away to a field reference.  But the reduction in code
size is only about 285 bytes.

Before:
    text    data     bss     dec     hex filename
   32820    4913     672   38405    9605 kernel/sched.o

After:
    text    data     bss     dec     hex filename
   32535    4913     672   38120    94e8 kernel/sched.o

Noting that these values were less than those in the original mail, I've
also checked the size for when the patches are excluded.

    text    data     bss     dec     hex filename
   30061    4881     672   35614    8b1e kernel/sched.o

The numbers in the e-mail were from a different computer with gcc-4.0.2
installed while these are generated with gcc-4.1.1 (also that build
would not have had CONFIG_SCHED_SMT or CONFIG_SCHED_MC set).  But the
end result is that the cost is still of the order of 2.5 kilobytes.

A patch to make these changes is attached.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce


--------------020102010905040304070004
Content-Type: text/plain;
 name="simplify-get-set-caps-code"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="simplify-get-set-caps-code"

---
 include/linux/sched.h |   24 +++++++++++--
 kernel/sched.c        |   90 ++++++++++----------------------------------------
 2 files changed, 38 insertions(+), 76 deletions(-)

Index: MM-2.6.17-rc6-mm2/include/linux/sched.h
===================================================================
--- MM-2.6.17-rc6-mm2.orig/include/linux/sched.h	2006-06-19 13:57:18.000000000 +1000
+++ MM-2.6.17-rc6-mm2/include/linux/sched.h	2006-06-19 14:28:25.000000000 +1000
@@ -1022,11 +1022,27 @@ struct task_struct {
 };
 
 #ifdef CONFIG_CPU_RATE_CAPS
-unsigned int get_cpu_rate_cap(const struct task_struct *);
-int set_cpu_rate_cap(struct task_struct *, unsigned int);
+int set_cpu_rate_cap_low(struct task_struct *, unsigned int, int);
+
+static inline unsigned int get_cpu_rate_cap(const struct task_struct *p)
+{
+	return p->cpu_rate_cap;
+}
+
+static inline int set_cpu_rate_cap(struct task_struct *p, unsigned int newcap)
+{
+	return set_cpu_rate_cap_low(p, newcap, 0);
+}
 #ifdef CONFIG_CPU_RATE_HARD_CAPS
-unsigned int get_cpu_rate_hard_cap(const struct task_struct *);
-int set_cpu_rate_hard_cap(struct task_struct *, unsigned int);
+static inline unsigned int get_cpu_rate_hard_cap(const struct task_struct *p)
+{
+	return p->cpu_rate_hard_cap;
+}
+
+static inline int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int newcap)
+{
+	return set_cpu_rate_cap_low(p, newcap, 1);
+}
 #endif
 #endif
 
Index: MM-2.6.17-rc6-mm2/kernel/sched.c
===================================================================
--- MM-2.6.17-rc6-mm2.orig/kernel/sched.c	2006-06-19 13:57:18.000000000 +1000
+++ MM-2.6.17-rc6-mm2/kernel/sched.c	2006-06-19 14:28:25.000000000 +1000
@@ -4614,17 +4614,11 @@ out_unlock:
 }
 
 #ifdef CONFIG_CPU_RATE_CAPS
-unsigned int get_cpu_rate_cap(const struct task_struct *p)
-{
-	return p->cpu_rate_cap;
-}
-
-EXPORT_SYMBOL(get_cpu_rate_cap);
-
 /*
- * Require: 0 <= new_cap <= CPU_CAP_ONE
+ * Require: 0 <= new_cap <= CPU_CAP_ONE for hard == 0
+ *          1 <= new_cap <= CPU_CAP_ONE otherwise
  */
-int set_cpu_rate_cap(struct task_struct *p, unsigned int new_cap)
+int set_cpu_rate_cap_low(struct task_struct *p, unsigned int new_cap, int hard)
 {
 	int is_allowed;
 	unsigned long flags;
@@ -4634,13 +4628,21 @@ int set_cpu_rate_cap(struct task_struct 
 
 	if (new_cap > CPU_CAP_ONE)
 		return -EINVAL;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	if (hard && new_cap < 1)
+		return -EINVAL;
+#endif
 	is_allowed = capable(CAP_SYS_NICE);
 	/*
 	 * We have to be careful, if called from /proc code,
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
 	rq = task_rq_lock(p, &flags);
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	delta = new_cap - (hard ? p->cpu_rate_hard_cap : p->cpu_rate_cap);
+#else
 	delta = new_cap - p->cpu_rate_cap;
+#endif
 	if (!is_allowed) {
 		/*
 		 * Ordinary users can set/change caps on their own tasks
@@ -4656,7 +4658,12 @@ int set_cpu_rate_cap(struct task_struct 
 	 * set - but as expected it wont have any effect on scheduling until
 	 * the task becomes SCHED_NORMAL/SCHED_BATCH:
 	 */
-	p->cpu_rate_cap = new_cap;
+#ifdef CONFIG_CPU_RATE_HARD_CAPS
+	if (hard)
+		p->cpu_rate_hard_cap = new_cap;
+	else
+#endif
+		p->cpu_rate_cap = new_cap;
 
 	if (has_rt_policy(p))
 		goto out;
@@ -4680,68 +4687,7 @@ out:
 	return 0;
 }
 
-EXPORT_SYMBOL(set_cpu_rate_cap);
-
-#ifdef CONFIG_CPU_RATE_HARD_CAPS
-unsigned int get_cpu_rate_hard_cap(const struct task_struct *p)
-{
-	return p->cpu_rate_hard_cap;
-}
-
-EXPORT_SYMBOL(get_cpu_rate_hard_cap);
-
-/*
- * Require: 1 <= new_cap <= CPU_CAP_ONE
- */
-int set_cpu_rate_hard_cap(struct task_struct *p, unsigned int new_cap)
-{
-	int is_allowed;
-	unsigned long flags;
-	struct runqueue *rq;
-	int delta;
-
-	if (new_cap > CPU_CAP_ONE || new_cap < 1)
-		return -EINVAL;
-	is_allowed = capable(CAP_SYS_NICE);
-	/*
-	 * We have to be careful, if called from /proc code,
-	 * the task might be in the middle of scheduling on another CPU.
-	 */
-	rq = task_rq_lock(p, &flags);
-	delta = new_cap - p->cpu_rate_hard_cap;
-	if (!is_allowed) {
-		/*
-		 * Ordinary users can set/change caps on their own tasks
-		 * provided that the new setting is MORE constraining
-		 */
-		if (((current->euid != p->uid) && (current->uid != p->uid)) || (delta > 0)) {
-			task_rq_unlock(rq, &flags);
-			return -EPERM;
-		}
-	}
-	/*
-	 * The RT tasks don't have caps, but we still allow the caps to be
-	 * set - but as expected it wont have any effect on scheduling until
-	 * the task becomes SCHED_NORMAL/SCHED_BATCH:
-	 */
-	p->cpu_rate_hard_cap = new_cap;
-
-	if (has_rt_policy(p))
-		goto out;
-
-	if (p->array)
-		dec_raw_weighted_load(rq, p);
-	set_load_weight(p);
-	if (p->array)
-		inc_raw_weighted_load(rq, p);
-out:
-	task_rq_unlock(rq, &flags);
-
-	return 0;
-}
-
-EXPORT_SYMBOL(set_cpu_rate_hard_cap);
-#endif
+EXPORT_SYMBOL(set_cpu_rate_cap_low);
 #endif
 
 long sched_setaffinity(pid_t pid, cpumask_t new_mask)

--------------020102010905040304070004--
