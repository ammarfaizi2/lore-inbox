Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbULHGTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbULHGTG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 01:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbULHGS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 01:18:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:35514 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261762AbULHGSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 01:18:42 -0500
Date: Tue, 7 Dec 2004 22:18:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@osdl.org>
Cc: dave@sr71.net, linux-kernel@vger.kernel.org,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: oops in proc_pid_stat() on task->real_parent?
Message-Id: <20041207221821.068568f4.akpm@osdl.org>
In-Reply-To: <20041207220753.E469@build.pdx.osdl.net>
References: <1102467332.19465.197.camel@localhost>
	<20041207220016.6917ee6f.akpm@osdl.org>
	<20041207220753.E469@build.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright <chrisw@osdl.org> wrote:
>
> * Andrew Morton (akpm@osdl.org) wrote:
> > yup, we fixed that one.
> 
> I thought the same thing, but this oops is from proc_pid_stat, not
> proc_pid_status.  The code is now in do_task_stat(), and the oops is
> within the orignal tasklist lock (instead of dropping and reaquiring the
> lock).  So, might be fixed, but if so, I think for a different reason.
> 

Ah, thanks.

I'm not sure that the holding of tasklist_lock is going to save us there. 
But then, Manfred recently did an audit, so I'm probably missing something.

Manfred, should we do this?

--- 25/fs/proc/array.c~do_task_stat-use-pid_alive	2004-12-07 22:17:01.378528576 -0800
+++ 25-akpm/fs/proc/array.c	2004-12-07 22:17:10.140196600 -0800
@@ -370,7 +370,7 @@ static int do_task_stat(struct task_stru
 			stime += task->signal->stime;
 		}
 	}
-	ppid = task->pid ? task->group_leader->real_parent->tgid : 0;
+	ppid = pid_alive(task) ? task->group_leader->real_parent->tgid : 0;
 	read_unlock(&tasklist_lock);
 
 	if (!whole || num_threads<2)
_

