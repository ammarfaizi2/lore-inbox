Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWBFUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWBFUDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWBFUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:03:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:28032 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932351AbWBFUDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:03:23 -0500
To: <linux-kernel@vger.kernel.org>
Cc: <vserver@list.linux-vserver.org>, Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Kirill Korotaev <dev@sw.ru>, Greg <gkurz@fr.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: [RFC][PATCH 15/20] posix-timers: Update posix timers to work with
 pspaces.
References: <m11wygnvlp.fsf@ebiederm.dsl.xmission.com>
	<m1vevsmgvz.fsf@ebiederm.dsl.xmission.com>
	<m1lkwomgoj.fsf_-_@ebiederm.dsl.xmission.com>
	<m1fymwmgk0.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqxkmgcv.fsf_-_@ebiederm.dsl.xmission.com>
	<m17j88mg8l.fsf_-_@ebiederm.dsl.xmission.com>
	<m13biwmg4p.fsf_-_@ebiederm.dsl.xmission.com>
	<m1y80ol1gh.fsf_-_@ebiederm.dsl.xmission.com>
	<m1u0bcl1ai.fsf_-_@ebiederm.dsl.xmission.com>
	<m1psm0l170.fsf_-_@ebiederm.dsl.xmission.com>
	<m1lkwol133.fsf_-_@ebiederm.dsl.xmission.com>
	<m1hd7cl0yp.fsf_-_@ebiederm.dsl.xmission.com>
	<m1d5i0l0ua.fsf_-_@ebiederm.dsl.xmission.com>
	<m18xsol0p9.fsf_-_@ebiederm.dsl.xmission.com>
	<m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 06 Feb 2006 13:00:47 -0700
In-Reply-To: <m14q3cl0mk.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Mon, 06 Feb 2006 12:59:15 -0700")
Message-ID: <m1zml4jlzk.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 kernel/posix-cpu-timers.c |    9 +++++----
 kernel/posix-timers.c     |    4 +++-
 2 files changed, 8 insertions(+), 5 deletions(-)

90b04f2eeb0fd42309ed68dad92e1b7bb4d2fba6
diff --git a/kernel/posix-cpu-timers.c b/kernel/posix-cpu-timers.c
index 520f6c5..9eda08a 100644
--- a/kernel/posix-cpu-timers.c
+++ b/kernel/posix-cpu-timers.c
@@ -3,6 +3,7 @@
  */
 
 #include <linux/sched.h>
+#include <linux/pspace.h>
 #include <linux/posix-timers.h>
 #include <asm/uaccess.h>
 #include <linux/errno.h>
@@ -20,7 +21,7 @@ static int check_clock(const clockid_t w
 		return 0;
 
 	read_lock(&tasklist_lock);
-	p = find_task_by_pid(pid);
+	p = find_task_by_pid(current->pspace, pid);
 	if (!p || (CPUCLOCK_PERTHREAD(which_clock) ?
 		   p->tgid != current->tgid : p->tgid != pid)) {
 		error = -EINVAL;
@@ -292,7 +293,7 @@ int posix_cpu_clock_get(const clockid_t 
 		 */
 		struct task_struct *p;
 		read_lock(&tasklist_lock);
-		p = find_task_by_pid(pid);
+		p = find_task_by_pid(current->pspace, pid);
 		if (p) {
 			if (CPUCLOCK_PERTHREAD(which_clock)) {
 				if (p->tgid == current->tgid) {
@@ -336,7 +337,7 @@ int posix_cpu_timer_create(struct k_itim
 		if (pid == 0) {
 			p = current;
 		} else {
-			p = find_task_by_pid(pid);
+			p = find_task_by_pid(current->pspace, pid);
 			if (p && p->tgid != current->tgid)
 				p = NULL;
 		}
@@ -344,7 +345,7 @@ int posix_cpu_timer_create(struct k_itim
 		if (pid == 0) {
 			p = current->group_leader;
 		} else {
-			p = find_task_by_pid(pid);
+			p = find_task_by_pid(current->pspace, pid);
 			if (p && p->tgid != pid)
 				p = NULL;
 		}
diff --git a/kernel/posix-timers.c b/kernel/posix-timers.c
index 216f574..5f6775c 100644
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -35,6 +35,7 @@
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/pspace.h>
 
 #include <asm/uaccess.h>
 #include <asm/semaphore.h>
@@ -365,7 +366,8 @@ static struct task_struct * good_sigeven
 	struct task_struct *rtn = current->group_leader;
 
 	if ((event->sigev_notify & SIGEV_THREAD_ID ) &&
-		(!(rtn = find_task_by_pid(event->sigev_notify_thread_id)) ||
+		(!(rtn = find_task_by_pid(current->pspace, 
+					event->sigev_notify_thread_id)) ||
 		 rtn->tgid != current->tgid ||
 		 (event->sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_SIGNAL))
 		return NULL;
-- 
1.1.5.g3480

