Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292466AbSCGW1b>; Thu, 7 Mar 2002 17:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292923AbSCGW1T>; Thu, 7 Mar 2002 17:27:19 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:41648 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S310556AbSCGW0d>;
	Thu, 7 Mar 2002 17:26:33 -0500
Subject: [PATCH] Fix for get_pid hang
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1015539061.16836.10.camel@plars.austin.ibm.com>
In-Reply-To: <200203072045.PAA08386@egenera.com> 
	<1015539061.16836.10.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 16:25:24 -0600
Message-Id: <1015539925.16835.22.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, this time with the patch for real. :)

On Thu, 2002-03-07 at 16:11, Paul Larson wrote:
> On Thu, 2002-03-07 at 14:45, Patrick O'Rourke wrote:
> > It is possible on large memory systems that the default process limits
> > can exceed PID_MAX.  This will allow a non-root user to consume all pids
> > resulting in the kernel to basically hang in get_pid().
> > 
>   
> > +	/* don't let threads go beyond PID_MAX */
> > +	if (max_threads > PID_MAX) {
> > +		max_threads = PID_MAX;
> > +	}
> > +
> The problem with this approach is that it doesn't take into account
> pgrp, tgids, etc... I submitted the following patch a couple of weeks
> ago that fixes the problem a better way.
> 
> Thanks,
> Paul Larson

Marcelo, any chance of getting this accepted into the next 2.4.19-pre? 
It is obviously a bug that is afecting several others as well.  I think
the LSE team is looking at some performance enhancements to get_pid, but
from what I've seen so far they will be working on top of this bug fix. 
I just verified that the patch still applies cleanly against
2.4.19-pre2.

Thanks,
Paul Larson

diff -Naur linux-2.4.18-rc2/kernel/fork.c linux-getpid/kernel/fork.c
--- linux-2.4.18-rc2/kernel/fork.c	Wed Feb 20 09:54:39 2002
+++ linux-getpid/kernel/fork.c	Fri Feb 22 15:52:52 2002
@@ -20,6 +20,7 @@
 #include <linux/vmalloc.h>
 #include <linux/completion.h>
 #include <linux/personality.h>
+#include <linux/compiler.h>
 
 #include <asm/pgtable.h>
 #include <asm/pgalloc.h>
@@ -85,12 +86,13 @@
 {
 	static int next_safe = PID_MAX;
 	struct task_struct *p;
-	int pid;
+	int pid, beginpid;
 
 	if (flags & CLONE_PID)
 		return current->pid;
 
 	spin_lock(&lastpid_lock);
+	beginpid = last_pid;
 	if((++last_pid) & 0xffff8000) {
 		last_pid = 300;		/* Skip daemons etc. */
 		goto inside;
@@ -110,12 +112,16 @@
 						last_pid = 300;
 					next_safe = PID_MAX;
 				}
+				if(unlikely(last_pid == beginpid))
+					goto nomorepids;
 				goto repeat;
 			}
 			if(p->pid > last_pid && next_safe > p->pid)
 				next_safe = p->pid;
 			if(p->pgrp > last_pid && next_safe > p->pgrp)
 				next_safe = p->pgrp;
+			if(p->tgid > last_pid && next_safe > p->tgid)
+				next_safe = p->tgid;
 			if(p->session > last_pid && next_safe > p->session)
 				next_safe = p->session;
 		}
@@ -125,6 +131,11 @@
 	spin_unlock(&lastpid_lock);
 
 	return pid;
+
+nomorepids:
+	read_unlock(&tasklist_lock);
+	spin_unlock(&lastpid_lock);
+	return 0;
 }
 
 static inline int dup_mmap(struct mm_struct * mm)
@@ -620,6 +631,8 @@
 
 	copy_flags(clone_flags, p);
 	p->pid = get_pid(clone_flags);
+	if (p->pid == 0 && current->pid != 0)
+		goto bad_fork_cleanup;
 
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;

