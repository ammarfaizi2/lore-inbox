Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbWDGTtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbWDGTtw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932451AbWDGTtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:49:52 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:57229 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932431AbWDGTtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:49:51 -0400
Date: Sat, 8 Apr 2006 03:46:53 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-ID: <20060407234653.GB11460@oleg>
References: <20060406220403.GA205@oleg> <m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06, Eric W. Biederman wrote:
> 
> Ack.  The evils of de_thread!

Yes, just noticed another thing,

[PATCH] task-make-task-list-manipulations-rcu-safe-fix-fix

We shoudn't decrement process_counts if de_thread() unhashed the task.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- MM/kernel/exit.c~	2006-04-06 23:01:37.000000000 +0400
+++ MM/kernel/exit.c	2006-04-08 03:35:24.000000000 +0400
@@ -56,9 +56,10 @@ static void __unhash_process(struct task
 		detach_pid(p, PIDTYPE_SID);
 
 		/* see de_thread()->list_replace_rcu() */
-		if (likely(p->tasks.prev != LIST_POISON2))
+		if (likely(p->tasks.prev != LIST_POISON2)) {
 			list_del_rcu(&p->tasks);
-		__get_cpu_var(process_counts)--;
+			__get_cpu_var(process_counts)--;
+		}
 	}
 	list_del_rcu(&p->thread_group);
 	remove_parent(p);

