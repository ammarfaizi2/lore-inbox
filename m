Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVCaGYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVCaGYp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 01:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262510AbVCaGY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 01:24:28 -0500
Received: from everest.sosdg.org ([66.93.203.161]:12267 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S262501AbVCaGV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 01:21:59 -0500
Message-ID: <424B966B.9020408@lovecn.org>
Date: Thu, 31 Mar 2005 14:19:23 +0800
From: Coywolf Qi Hunt <coywolf@lovecn.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
References: <20050328044217.GA6362@everest.sosdg.org> <20050330151226.6bfbd96e.akpm@osdl.org>
In-Reply-To: <20050330151226.6bfbd96e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Broken-Reverse-DNS: no host name for for IP address 218.24.164.184
X-Scan-Signature: fa603f730e672a4362e95b772227f8ba
X-SA-Exim-Connect-IP: 218.24.164.184
X-SA-Exim-Mail-From: coywolf@lovecn.org
Subject: Re: [patch] oom lca -- fork bombing killer
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
	*  4.0 RCVD_IN_AHBL_CNKR RBL: AHBL: sender is listed in the AHBL China/Korea blocks
	*      [218.24.164.184 listed in cnkrbl.ahbl.org]
X-SA-Exim-Version: 4.2 (built Sun, 13 Feb 2005 18:23:43 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Coywolf Qi Hunt <coywolf@sosdg.org> wrote:
> 
>>
>>			Linux OOM LCA (Least Common Ancestor) Patch
>>
>>...
>>
>>--- 2.6.12-rc1-mm3/include/linux/sched.h	2005-03-26 13:21:11.000000000 +0800
>>+++ 2.6.12-rc1-mm3-cy/include/linux/sched.h	2005-03-28 10:18:24.000000000 +0800
>>@@ -656,11 +656,7 @@ struct task_struct {
>> 	unsigned did_exec:1;
>> 	pid_t pid;
>> 	pid_t tgid;
>>-	/* 
>>-	 * pointers to (original) parent process, youngest child, younger sibling,
>>-	 * older sibling, respectively.  (p->father can be replaced with 
>>-	 * p->parent->pid)
>>-	 */
>>+
>> 	struct task_struct *real_parent; /* real parent process (when being debugged) */
>> 	struct task_struct *parent;	/* parent process */
>> 	/*
>>@@ -669,6 +665,9 @@ struct task_struct {
>> 	 */
>> 	struct list_head children;	/* list of my children */
>> 	struct list_head sibling;	/* linkage in my parent's children list */
>>+	struct task_struct *bio_parent;	
>>+	struct list_head bio_children;
>>+	struct list_head bio_sibling;
>> 	struct task_struct *group_leader;	/* threadgroup leader */
>> 
>> 	/* PID/PID hash table linkage. */
> 
> 
> Well that was a bit cruel - it would have been better to fix up the comment
> rather than deleting it.  And to have documented the newly-added fields.

There used to have struct task_struct *p_opptr, *p_pptr, *p_cptr, *p_ysptr, *p_osptr;
They've all disappeared in 2.6. That comment is about that.

> 
> (The bio_* names remind me of fs/bio.c.  Maybe rename them to initial_*?)

biological parent, bio_parent. It makes sense, so basically.

> 
> 
> 
>>@@ -1068,7 +1067,6 @@ extern void exit_itimers(struct signal_s
>> 
>> extern NORET_TYPE void do_group_exit(int);
>> 
>>-extern void reparent_to_init(void);
> 
> 
> OK, but the reparent_to_init() cleanup should be a separate patch, please.
> 
> 
>> static inline void reparent_thread(task_t *p, task_t *father, int traced)
>>@@ -590,6 +596,7 @@ static inline void reparent_thread(task_
>> static inline void forget_original_parent(struct task_struct * father,
>> 					  struct list_head *to_release)
>> {
>>+	extern struct task_struct *last_chosen_parent;
> 
> 
> This declaration should be in a header file.
> 
> 
>>+
>>+	list_for_each_safe(_p, _n,  &father->bio_children) {
>>+		p = list_entry(_p, struct task_struct, bio_sibling);
>>+		list_del_init(&p->bio_sibling);
>>+		p->bio_parent = father->bio_parent;
>>+		list_add_tail(&p->bio_sibling, &(p->bio_parent)->bio_children);
>>+	}
> 
> 
> This big list walk on the exit path might be unpopular from a performance
> and latency POV.

There are already two other list walks. This one isn't much bigger.
It's unavoidable in normal process exits. But it could be avoided during oom killing by always killing leaves.

> 
> 
>> /*
>>+ * LCA: Least Common Ancestor
>>+ *
>>+ * Returns NULL if no LCA (LCA is init_task)
>>+ *
>>+ * I prefer to use task_t for function parameters, and
>>+ * struct task_struct elsewhere.  -- coywolf
>>+ */
> 
> 
> Most other people prefer to not use the typedef...
> 
> 
>>+static struct task_struct * find_lca(task_t *p1, task_t *p2)
>>+{
>>+	struct task_struct *tsk1, *tsk2;
>>+
>>+	for (tsk1 = p1; tsk1 != &init_task; tsk1 = tsk1->bio_parent) {
>>+		for (tsk2 = p2; tsk2 != &init_task; tsk2 = tsk2->bio_parent)
>>+			if (tsk1 == tsk2)
>>+				return tsk1;
>>+	}
>>+
>>+	return NULL;
>>+}
> 
> 
> eep.  That's an O(n^2) search?  What does it do with 50000 tasks?

Two levels 50000 loops cost 4.6 seconds on my 2.4G celeron.
Yes, I'll improve it to O(n).

> 
> 
>>-	struct task_struct *c;
>>-	struct list_head *tsk;
>>+	if (list_empty(&p->bio_children)) {
>>+		mmput(mm);
>>+		__oom_kill_task(p);
>>+		return 1;
>>+	}
>> 
>>-	/* Try to kill a child first */
>>-	list_for_each(tsk, &p->children) {
>>-		c = list_entry(tsk, struct task_struct, sibling);
>>-		if (c->mm == p->mm)
>>-			continue;
>>-		mm = oom_kill_task(c);
>>-		if (mm)
>>-			return mm;
>>+	/* Kill all descendants */
>>+	for_each_process(q) {
>>+		if (q->pid > 1) {
>>+			if (test_tsk_thread_flag(q, TIF_MEMDIE) ||
>>+				(q->flags & PF_EXITING) || (q->flags & PF_DEAD))
>>+				continue;
>>+			if (is_ancestor(p, q))
>>+				__oom_kill_task(q);
>>+		}
>> 	}
> 
> 
> That's O(n^2) too.
> 

I'm working on it. It'll be O(n), and no extra memory allocations even.

The biggest problem is when swapping is on, it doesn't help much.
Swapping needs similiar control too. Let's do things one by one.


		Coywolf

