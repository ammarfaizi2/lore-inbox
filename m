Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262055AbULHHjC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbULHHjC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 02:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbULHHhU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 02:37:20 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:36543 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262065AbULHHaS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 02:30:18 -0500
Date: Wed, 8 Dec 2004 13:16:05 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <dave@sr71.net>,
       linux-kernel@vger.kernel.org
Subject: Re: oops in proc_pid_stat() on task->real_parent?
Message-ID: <20041208074605.GA4495@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1102467332.19465.197.camel@localhost> <20041207220016.6917ee6f.akpm@osdl.org> <20041207220753.E469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <20041207220753.E469@build.pdx.osdl.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 07, 2004 at 10:07:55PM -0800, Chris Wright wrote:
> * Andrew Morton (akpm@osdl.org) wrote:
> > yup, we fixed that one.
> 
> I thought the same thing, but this oops is from proc_pid_stat, not
> proc_pid_status.  The code is now in do_task_stat(), and the oops is
> within the orignal tasklist lock (instead of dropping and reaquiring the
> lock).  So, might be fixed, but if so, I think for a different reason.
> 
> thanks,
> -chris

hmmm they were two places that I had changed to reflect the parent.

This should fix it?

Signed-off-by: Dinakar Guniguntala <dino@in.ibm.com>



--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ps_stat-2.patch"

diff -Naurp linux-2.6.10-rc2.orig/fs/proc/array.c linux-2.6.10-rc2/fs/proc/array.c
--- linux-2.6.10-rc2.orig/fs/proc/array.c	2004-11-15 06:57:52.000000000 +0530
+++ linux-2.6.10-rc2/fs/proc/array.c	2004-12-08 12:54:40.000000000 +0530
@@ -370,7 +370,7 @@ static int do_task_stat(struct task_stru
 			stime += task->signal->stime;
 		}
 	}
-	ppid = task->pid ? task->group_leader->real_parent->tgid : 0;
+	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)

--6TrnltStXW4iwmi0--
