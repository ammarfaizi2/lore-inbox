Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269789AbUJGKt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269789AbUJGKt7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 06:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269790AbUJGKt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 06:49:59 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:31975 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269789AbUJGKtp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 06:49:45 -0400
Date: Thu, 7 Oct 2004 16:33:23 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] ps shows wrong ppid
Message-ID: <20041007110323.GA4503@in.ibm.com>
Reply-To: dino@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

/proc shows the wrong PID as parent in the following case

Process A creates Threads 1 & 2 (using pthread_create)
Thread 2 then forks and execs process B
getppid() for Process B shows Process A (rightly) as parent,
however /proc/B/status shows Thread 3 as PPid (incorrect)

Following patch has been tested and it works ok

Regards,

Dinakar

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ps.patch"

diff -Naurp linux-2.6.9-rc1-orig/fs/proc/array.c linux-2.6.9-rc1/fs/proc/array.c
--- linux-2.6.9-rc1-orig/fs/proc/array.c	2004-08-24 12:32:58.000000000 +0530
+++ linux-2.6.9-rc1/fs/proc/array.c	2004-10-07 15:33:05.465755672 +0530
@@ -169,7 +169,7 @@ static inline char * task_state(struct t
 		get_task_state(p),
 		(p->sleep_avg/1024)*100/(1020000000/1024),
 	       	p->tgid,
-		p->pid, p->pid ? p->real_parent->pid : 0,
+		p->pid, p->pid ? p->group_leader->real_parent->tgid : 0,
 		p->pid && p->ptrace ? p->parent->pid : 0,
 		p->uid, p->euid, p->suid, p->fsuid,
 		p->gid, p->egid, p->sgid, p->fsgid);

--ZGiS0Q5IWpPtfppv--
