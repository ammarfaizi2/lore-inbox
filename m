Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131985AbRCYOIx>; Sun, 25 Mar 2001 09:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131986AbRCYOIn>; Sun, 25 Mar 2001 09:08:43 -0500
Received: from [195.63.194.11] ([195.63.194.11]:16655 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S131985AbRCYOI2>; Sun, 25 Mar 2001 09:08:28 -0500
Message-ID: <3ABDF8A6.7580BD7D@evision-ventures.com>
Date: Sun, 25 Mar 2001 15:54:46 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "James A. Sutherland" <jas88@cam.ac.uk>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] OOM handling
In-Reply-To: <E14gVQf-00056B-00@the-village.bc.nu> <3ABB9CF2.E7715667@evision-ventures.com>
Content-Type: multipart/mixed;
 boundary="------------8B0CCE6C164FD137CC11317E"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------8B0CCE6C164FD137CC11317E
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Martin Dalecki wrote:
> 
> I have a constructive proposal:
> 
> It would make much sense to make the oom killer
> leave not just root processes alone but processes belonging to a UID
> lower
> then a certain value as well (500). This would be:
> 
> 1. Easly managable by the admin. Just let oracle/www and analogous users
>    have a UID lower then let's say 500.
> 
> 2. In full compliance with the port trick done by TCP/IP (ports < 1024
> vers other)
> 
> 3. It wouldn't need any addition of new interface (no jebanoje gawno in
> /proc in addition()
> 
> 4. Really simple to implement/document understand.
> 
> 5. Be the same way as Solaris does similiar things.
> 
> ...
> 
> Damn: I will let my chess club alone toady and will just code it down
> NOW.
> 
> Spec:
> 
> 1. Processes with a UID < 100 are immune to OOM killers.
> 2. Processes with a UID >= 100 && < 500 are hard for the OOM killer to
> take on.
> 3. Processes with a UID >= 500 are easy targets.
> 
> Let me introduce a new terminology in full analogy to "fire walls"
> routers and therabouts:
> 
> Processes of category 1. are called captains (oficerzy)
> Processes of category 2. are called corporals (porucznicy)
> Processes of category 2. are called privates (¿o³nierze)

OK I just did it. as I already told I have "stress tested it" by 
installing the Orcale insternet application server suide
on a hoplessly underequipped box ("only" 128MByte RMA).
The assorted patch is attached. 

Since I'm one day late up to my promise to provide this
patch it's actually fascinating that already 4 people (in esp. not
newbees requesting a new /proc entry for everything)
for reassurance that I will indeed implement it... Well 
this kind of "high" and "eager" feadback seems for me to indicate 
that there is very serious desire for it. And then of course I
just have to ask our people working with DB's here at work as well :-).

Ah... and of course I think this patch can already go directly 
into the official kernel. The quality of code should permit 
it. I would esp. request Rik van Riel to have a closer look
at it...
--------------8B0CCE6C164FD137CC11317E
Content-Type: text/plain; charset=us-ascii;
 name="oom.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oom.diff"

diff -urN linux/mm/oom_kill.c linux-new/mm/oom_kill.c
--- linux/mm/oom_kill.c	Tue Nov 14 19:56:46 2000
+++ linux-new/mm/oom_kill.c	Sun Mar 25 17:17:34 2001
@@ -1,18 +1,64 @@
 /*
  *  linux/mm/oom_kill.c
- * 
+ *
  *  Copyright (C)  1998,2000  Rik van Riel
  *	Thanks go out to Claus Fischer for some serious inspiration and
  *	for goading me into coding this file...
  *
- *  The routines in this file are used to kill a process when
- *  we're seriously out of memory. This gets called from kswapd()
- *  in linux/mm/vmscan.c when we really run out of memory.
- *
- *  Since we won't call these routines often (on a well-configured
- *  machine) this file will double as a 'coding guide' and a signpost
- *  for newbie kernel hackers. It features several pointers to major
- *  kernel subsystems and hints as to where to find out what things do.
+ *  Sat Mar 24 22:07:15 CET 2001 Marcin Dalecki <dalecki@evision-ventures.com>:
+ *
+ *	Replaced the original algorith with something reasonably, predictable
+ *	and managable. I will call this "Stalins Eviction".
+ */
+
+/*
+ *  The routines in this file are used to kill a process when the system is
+ *  entierly out of memmory (both: RAM and swap).  This gets called from
+ *  kswapd() in linux/mm/vmscan.c when we are in total starvation due to the
+ *  fact, that the only thing the system is busy at, is to try to allocate some
+ *  physical memmory page, where there are no pages anymore left. In such it
+ *  does make perfect sense to kill some offending process, just to make the
+ *  system go on and survive.
+ *
+ *  IT IS A LAST RESORT!
+ *
+ *  ALLERT: In contrast to popular beleve the invention of the mechanism
+ *  presented here IS IMPORTANT for system security reasons. It is preventing
+ *  one border corner of an easy DNS attack in case the sysadmin didn't take
+ *  other measures, which he either overworked or incompetent as he is usually
+ *  doesn't.
+ *
+ *  Basically the eviction goes on as follows:
+ *
+ *  1. Normal interactive user processes are the first candidates for a shoot.
+ *  We consider all users with a UID >= 500 as normal interactive users.
+ *
+ *  2. If there are no processes started by a normal interactive user, we aim
+ *  at the processes from nonessential processes (for the "live" of the system
+ *  as a whole).  We consider users with a UID >= 100 and < 500 as essential
+ *  service user.
+ *
+ *  3. If this still isn't the case we start to shut down the system components
+ *  peace by peace... (UID < 100).
+ *
+ *  In fact the heuristics used to determine, at which of the process classes
+ *  to aim first, are a bit more sophisticated, If you wan't those details
+ *  please read the code below. It does (hopefully so) speak for itself.
+ *
+ *  As an example: If you are running a big Linux box, which is mainly deployed
+ *  as an oracle server, but where normal interactive human users can log on as
+ *  well, then you should run oracle server with a UID < 500 and >= 100. Then
+ *  dumb ass loosers starting 100 netscape and 500 emacs sessions, won't be
+ *  able anylonger to kill the essential oracle service.
+ *
+ *  The introduction of this additional UID semantics shouldn't affect any
+ *  present systems. (Read: It won't make anything worser in comparision to
+ *  previous versions of the Linux kernel.) However every single distributor of
+ *  "enterprise grade" applications for Linux SHOULD take a note on this.
+ *
+ *  regards:
+ *
+ *		Marcin Dalecki
  */
 
 #include <linux/mm.h>
@@ -23,125 +69,141 @@
 
 /* #define DEBUG */
 
-/**
- * int_sqrt - oom_kill.c internal function, rough approximation to sqrt
- * @x: integer of which to calculate the sqrt
- * 
- * A very rough approximation to the sqrt() function.
- */
-static unsigned int int_sqrt(unsigned int x)
-{
-	unsigned int out = x;
-	while (x & ~(unsigned int)1) x >>=2, out >>=1;
-	if (x) out -= out >> 2;
-	return (out ? out : 1);
-}	
-
-/**
- * oom_badness - calculate a numeric value for how bad this task has been
- * @p: task struct of which task we should calculate
- *
- * The formula used is relatively simple and documented inline in the
- * function. The main rationale is that we want to select a good task
- * to kill when we run out of memory.
- *
- * Good in this context means that:
- * 1) we lose the minimum amount of work done
- * 2) we recover a large amount of memory
- * 3) we don't kill anything innocent of eating tons of memory
- * 4) we want to kill the minimum amount of processes (one)
- * 5) we try to kill the process the user expects us to kill, this
- *    algorithm has been meticulously tuned to meet the priniciple
- *    of least surprise ... (be careful when you change it)
- */
+#define CPU_FACTOR 32
+#define AGE_FACTOR 256
 
-static int badness(struct task_struct *p)
+enum uid_class {
+	normal,
+	service,
+	system,
+	immune
+};
+
+static int determine_uid_class(struct task_struct *p)
 {
-	int points, cpu_time, run_time;
+	int uid;
+	int uid_class = system;
 
-	if (!p->mm)
-		return 0;
-	/*
-	 * The memory size of the process is the basis for the badness.
+	/* This makes processes started by for example suexec be better killing
+	 * candidates then root's processes themself.
 	 */
-	points = p->mm->total_vm;
+	uid = p->uid;
+	if (p->euid > p->uid)
+		uid = p->euid;
 
-	/*
-	 * CPU time is in seconds and run time is in minutes. There is no
-	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	/* This is implementing the intendid semantics of different user id
+	 * value ranges.
 	 */
-	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	if (uid < 100)
+		uid_class = system;
+	else if (uid < 500)
+		uid_class = service;
+	else
+		uid_class = normal;
 
-	points /= int_sqrt(cpu_time);
-	points /= int_sqrt(int_sqrt(run_time));
-
-	/*
-	 * Niced processes are most likely less important, so double
-	 * their badness points.
-	 */
-	if (p->nice > 0)
-		points *= 2;
 
-	/*
-	 * Superuser processes are usually more important, so we make it
+	/* Superuser processes are usually more important, so we make it
 	 * less likely that we kill those.
 	 */
-	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
-				p->uid == 0 || p->euid == 0)
-		points /= 4;
+	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN))
+		uid_class = system;
 
-	/*
-	 * We don't want to kill a process with direct hardware access.
+	/* We don't want to kill a process with direct hardware access.
 	 * Not only could that mess up the hardware, but usually users
 	 * tend to only have this flag set on applications they think
 	 * of as important.
 	 */
 	if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
-		points /= 4;
-#ifdef DEBUG
-	printk(KERN_DEBUG "OOMkill: task %d (%s) got %d points\n",
-	p->pid, p->comm, points);
-#endif
-	return points;
+		uid_class = system;
+
+	return uid_class;
+}
+
+static int calculate_penalty(struct task_struct *p)
+{
+	int cpu_penalty = 0;
+	int age_penalty = 0;
+
+
+	/* Now we calculate the penalty due to the cpu usage.  NOTE: This is
+	 * not safe against jiffie wraps.
+	 */
+	{
+		int run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+
+		if (run_time > 0) {
+			cpu_penalty = (CPU_FACTOR * run_time) /
+				((p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3) + run_time);
+		} else
+			cpu_penalty = CPU_FACTOR;
+	}
+
+	/* Let's make older processes more important then newer ones.
+	 * This is not safe against jiffie wraps, delibrately so.
+	 */
+	if (p->start_time > 0)
+		age_penalty = AGE_FACTOR * p->start_time / jiffies;
+	else
+		age_penalty = 0;
+
+	/* OK this should be sufficient, we don't want to make things more
+	 * complicated then needed. In esp. since there is no easy and portable
+	 * way to determine the total amount of memmory pages present, we don't
+	 * take this into account here.
+	 *
+	 * Let us worry about more detailed heuristics here, only if there will
+	 * be still many people reporting serious problems on linux-kernel.
+	 */
+
+	return cpu_penalty + age_penalty;
 }
 
 /*
- * Simple selection loop. We chose the process with the highest
- * number of 'points'. We need the locks to make sure that the
- * list of task structs doesn't change while we look the other way.
- *
- * (not docbooked, we don't want this one cluttering up the manual)
+ * Simple selection loop. We chose the process with the highest penalty.
  */
-static struct task_struct * select_bad_process(void)
+static struct task_struct * select_process(void)
 {
-	int maxpoints = 0;
-	struct task_struct *p = NULL;
-	struct task_struct *chosen = NULL;
-
-	read_lock(&tasklist_lock);
-	for_each_task(p) {
-		if (p->pid) {
-			int points = badness(p);
-			if (points > maxpoints) {
-				chosen = p;
-				maxpoints = points;
+	enum uid_class i;
+	struct task_struct *choice = NULL;
+
+	for (i = normal; i != immune; ++i) {
+		int maxpenalty = 0;
+		struct task_struct *p = NULL;
+
+		/* The locks make sure that the list of task structs doesn't
+		 * change while we look at it.
+		 */
+
+		read_lock(&tasklist_lock);
+		for_each_task(p) {
+			if (!p->mm)
+				continue;
+
+			if (i != determine_uid_class(p))
+				continue;
+
+			if (p->pid) {
+				int penalty = calculate_penalty(p);
+
+				if (penalty > maxpenalty) {
+					choice = p;
+					maxpenalty = penalty;
+				}
 			}
 		}
+		read_unlock(&tasklist_lock);
+
+		if (choice != NULL)
+			break;
 	}
-	read_unlock(&tasklist_lock);
-	return chosen;
+
+	return choice;
 }
 
-/**
- * oom_kill - kill the "best" process when we run out of memory
- *
+/*
  * If we run out of memory, we have the choice between either
  * killing a random task (bad), letting the system crash (worse)
- * OR try to be smart about which process to kill. Note that we
- * don't have to be perfect here, we just have to be good.
+ * OR try to be smart about which process to kill.
  *
  * We must be careful though to never send SIGKILL a process with
  * CAP_SYS_RAW_IO set, send SIGTERM instead (but it's unlikely that
@@ -149,14 +211,12 @@
  */
 void oom_kill(void)
 {
+	struct task_struct *p = select_process();
 
-	struct task_struct *p = select_bad_process();
-
-	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (p == NULL)
 		panic("Out of memory and no killable processes...\n");
 
-	printk(KERN_ERR "Out of Memory: Killed process %d (%s).\n", p->pid, p->comm);
+	printk(KERN_ERR "Out of memory: killed process %d (%s).\n", p->pid, p->comm);
 
 	/*
 	 * We give our sacrificial lamb high priority and access to
@@ -180,14 +240,14 @@
 	 */
 	current->policy |= SCHED_YIELD;
 	schedule();
+
 	return;
 }
 
-/**
- * out_of_memory - is the system out of memory?
+/** out_of_memory - is the system out of memory?
  *
- * Returns 0 if there is still enough memory left,
- * 1 when we are out of memory (otherwise).
+ * Returns 0 if there is still enough memory left, 1 when we are out of memory
+ * (otherwise).
  */
 int out_of_memory(void)
 {

--------------8B0CCE6C164FD137CC11317E--

