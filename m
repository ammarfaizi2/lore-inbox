Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269404AbUJSKhw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269404AbUJSKhw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 06:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268305AbUJSKgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 06:36:23 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:54150 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269406AbUJSKUV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 06:20:21 -0400
Date: Tue, 19 Oct 2004 16:01:20 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: [PATCH] stat shows wrong ppid
Message-ID: <20041019103120.GA4490@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20041007110323.GA4503@in.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <20041007110323.GA4503@in.ibm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

One more place in fs/proc/array.c where ppid is wrong, which
I missed in my previous mail to lkml

Please apply

Regards,

Dinakar

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>


On Thu, Oct 07, 2004 at 04:33:23PM +0530, Dinakar Guniguntala wrote:
> Hi,
> 
> /proc shows the wrong PID as parent in the following case
> 
> Process A creates Threads 1 & 2 (using pthread_create)
> Thread 2 then forks and execs process B
> getppid() for Process B shows Process A (rightly) as parent,
> however /proc/B/status shows Thread 2 as PPid (incorrect)
> 
> Following patch has been tested and it works ok
> 
> Regards,
> 
> Dinakar
> 

--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="stat.patch"

diff -Naurp linux-2.6.9-rc3-mm2.orig/fs/proc/array.c linux-2.6.9-rc3-mm2/fs/proc/array.c
--- linux-2.6.9-rc3-mm2.orig/fs/proc/array.c	2004-10-19 15:05:58.259265024 +0530
+++ linux-2.6.9-rc3-mm2/fs/proc/array.c	2004-10-19 15:09:52.474658872 +0530
@@ -370,7 +370,7 @@ static int do_task_stat(struct task_stru
 			stime += task->signal->stime;
 		}
 	}
-	ppid = task->pid ? task->real_parent->pid : 0;
+	ppid = task->pid ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)

--7AUc2qLy4jB3hD7Z--
