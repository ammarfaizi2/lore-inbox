Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSKMPWs>; Wed, 13 Nov 2002 10:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbSKMPWs>; Wed, 13 Nov 2002 10:22:48 -0500
Received: from house.arach.net.au ([203.30.44.68]:33034 "HELO
	house.arach.net.au") by vger.kernel.org with SMTP
	id <S261950AbSKMPWp> convert rfc822-to-8bit; Wed, 13 Nov 2002 10:22:45 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Beau Kuiper <rugger@arach.net.au>
To: linux-kernel@vger.kernel.org
Subject: PATCH: Pusedo-random pid generation (not really serious)
Date: Wed, 13 Nov 2002 23:30:36 +0800
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211132330.36139.rugger@arach.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Earlier today, I had just got home, and I decided that "I just had to check my 
email".

So, away I go, booting up my linux system. I start X, and KDE gleefully comes 
to life. Then I hit my email button (Kmail), only to discover that Kmail 
thinks its still running, for the third time this week. (Kmail has a lock 
file where it stores its running PID, and it gets left behind on an abnormal 
shutdown, like Ctrl-Alt-Backspace, or the reboot command while it is running)

So, instead of doing the obvious thing, adding a command the remove the lock 
file when I log in, I decide to do it the hard way by adding pusedo-random 
pid generation into the kernel.

This patch isn't designed to add security and/or unpredictability into pid 
creation. It simply is trying to avoid using the same pids all the time, 
which confused programs that used lock files.

The linear random number generator here has a period of 2^31, and statisticly, 
its pretty ok.

Decription:

1) Patch replaces get_pid with my version.
2) get_pid() returns 1 on first illiteration
3) get_pid() on second and further illiteration, seeds itself using the system 
time, and then generates pids using a simple linear random number generator.

Bugs:

1) Does not detect out of pid situation. This is not a problem on default 
kernel configurations, since only 2048 threads can exist at any one time on 
the default configuration.
2) Probably other subtle things I haven't noticed yet :-)

Since I know that this will NEVER make it into a standard kernel, I simply 
post it for people who might find it useful. People like me, who use Kmail 
and are not very particular about shutting down carefully 8-)

Just apply the patch to kernel/fork.c and watch the pretty pids.

Have Fun
Beau Kuiper
rugger@arach.net.au

--- linux-orig/kernel/fork.c	Wed Nov 13 22:10:18 2002
+++ linux/kernel/fork.c	Wed Nov 13 23:17:31 2002
@@ -83,6 +83,29 @@
 /* Protects next_safe and last_pid. */
 spinlock_t lastpid_lock = SPIN_LOCK_UNLOCKED;
 
+// beaus magic random pid generator
+
+static unsigned int pid_make_next(unsigned int last)
+{
+	unsigned short num;
+	
+	// second pass through, seed from system time
+	if (last == 1)
+	{
+		struct timeval now;
+		
+		do_gettimeofday(&now);
+		last = now.tv_sec & 0x7FFFFFFE;
+	}
+		
+	last = (last * 16807) % 0x7FFFFFFE;
+
+	// first pass through, return 1 for init.
+	if (last == 0)
+		last = 1;
+	return last;
+}
+
 static int get_pid(unsigned long flags)
 {
 	static int next_safe = PID_MAX;
@@ -93,50 +116,39 @@
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
-	beginpid = last_pid;
-	if((++last_pid) & 0xffff8000) {
-		last_pid = 300;		/* Skip daemons etc. */
-		goto inside;
-	}
-	if(last_pid >= next_safe) {
-inside:
-		next_safe = PID_MAX;
-		read_lock(&tasklist_lock);
-	repeat:
-		for_each_task(p) {
-			if(p->pid == last_pid	||
-			   p->pgrp == last_pid	||
-			   p->tgid == last_pid	||
-			   p->session == last_pid) {
-				if(++last_pid >= next_safe) {
-					if(last_pid & 0xffff8000)
-						last_pid = 300;
-					next_safe = PID_MAX;
-				}
-				if(unlikely(last_pid == beginpid))
+
+	// stir for next pid
+		
+	last_pid = pid_make_next(last_pid);
+
+	read_lock(&tasklist_lock);
+
+	pid = last_pid & 0x7FFF;
+	if (pid == 0)
+		pid++;
+
+repeat:
+	for_each_task(p) {
+		if(p->pid == pid	||
+		   p->pgrp == pid	||
+		   p->tgid == pid	||
+		   p->session == pid) {
+			last_pid = pid_make_next(last_pid);
+			pid = last_pid & 0x7FFF;
+			// TODO: add code to find when we run out of pids.
+/*				if(unlikely(last_pid == beginpid))
 					goto nomorepids;
-				goto repeat;
-			}
-			if(p->pid > last_pid && next_safe > p->pid)
-				next_safe = p->pid;
-			if(p->pgrp > last_pid && next_safe > p->pgrp)
-				next_safe = p->pgrp;
-			if(p->tgid > last_pid && next_safe > p->tgid)
-				next_safe = p->tgid;
-			if(p->session > last_pid && next_safe > p->session)
-				next_safe = p->session;
+*/
+			if (pid == 0)
+				pid++;
+			goto repeat;
 		}
-		read_unlock(&tasklist_lock);
 	}
-	pid = last_pid;
+
+	spin_unlock(&tasklist_lock);
 	spin_unlock(&lastpid_lock);
 
 	return pid;
-
-nomorepids:
-	read_unlock(&tasklist_lock);
-	spin_unlock(&lastpid_lock);
-	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)


