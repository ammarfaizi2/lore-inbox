Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWJQUx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWJQUx7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 16:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWJQUxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 16:53:39 -0400
Received: from cap31-3-82-227-199-249.fbx.proxad.net ([82.227.199.249]:43437
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750717AbWJQUxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 16:53:35 -0400
From: Cedric Le Goater <clg@fr.ibm.com>
Message-Id: <20061017205316.916962000@localhost.localdomain>
References: <20061017203004.555659000@localhost.localdomain>
User-Agent: quilt/0.45-1
Date: Tue, 17 Oct 2006 22:30:10 +0200
To: linux-kernel@vger.kernel.org
Cc: Kirill Korotaev <dev@openvz.org>, Cedric Le Goater <clg@fr.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Herbert Poetzl <herbert@13thfloor.at>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, Andrew Morton <akpm@osdl.org>
Subject: [patch -mm 6/7] use current->nsproxy->pid_ns
Content-Disposition: inline; filename=pid-namespace-use-pid_ns.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Cedric Le Goater <clg@fr.ibm.com>
Cc: Kirill Korotaev <dev@openvz.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>
---
 fs/proc/proc_misc.c |    2 +-
 kernel/pid.c        |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

Index: 2.6.19-rc2-mm1/fs/proc/proc_misc.c
===================================================================
--- 2.6.19-rc2-mm1.orig/fs/proc/proc_misc.c
+++ 2.6.19-rc2-mm1/fs/proc/proc_misc.c
@@ -92,7 +92,7 @@ static int loadavg_read_proc(char *page,
 		LOAD_INT(a), LOAD_FRAC(a),
 		LOAD_INT(b), LOAD_FRAC(b),
 		LOAD_INT(c), LOAD_FRAC(c),
-		nr_running(), nr_threads, init_pid_ns.last_pid);
+		nr_running(), nr_threads, current->nsproxy->pid_ns->last_pid);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
Index: 2.6.19-rc2-mm1/kernel/pid.c
===================================================================
--- 2.6.19-rc2-mm1.orig/kernel/pid.c
+++ 2.6.19-rc2-mm1/kernel/pid.c
@@ -196,7 +196,7 @@ fastcall void free_pid(struct pid *pid)
 	hlist_del_rcu(&pid->pid_chain);
 	spin_unlock_irqrestore(&pidmap_lock, flags);
 
-	free_pidmap(&init_pid_ns, pid->nr);
+	free_pidmap(current->nsproxy->pid_ns, pid->nr);
 	call_rcu(&pid->rcu, delayed_put_pid);
 }
 
@@ -210,7 +210,7 @@ struct pid *alloc_pid(void)
 	if (!pid)
 		goto out;
 
-	nr = alloc_pidmap(&init_pid_ns);
+	nr = alloc_pidmap(current->nsproxy->pid_ns);
 	if (nr < 0)
 		goto out_free;
 
@@ -353,7 +353,7 @@ struct pid *find_ge_pid(int nr)
 		pid = find_pid(nr);
 		if (pid)
 			break;
-		nr = next_pidmap(&init_pid_ns, nr);
+		nr = next_pidmap(current->nsproxy->pid_ns, nr);
 	} while (nr > 0);
 
 	return pid;

--
