Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWDKGty@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWDKGty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWDKGtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:49:53 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:48575 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932278AbWDKGtx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:49:53 -0400
Date: Tue, 11 Apr 2006 14:47:00 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: ebiederm@xmission.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Message-ID: <20060411104700.GA1051@oleg>
References: <m1acay1fbh.fsf@ebiederm.dsl.xmission.com> <20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org> <20060407155619.18f3c5ec.akpm@osdl.org> <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg> <m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com> <m1u091dnry.fsf@ebiederm.dsl.xmission.com> <20060411100527.GA112@oleg> <20060410222324.7b9daeef.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060410222324.7b9daeef.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Andrew Morton wrote:
>
> Oleg Nesterov <oleg@tv-sign.ru> wrote:
> >
> >  Currently I don't know how the code looks in -mm tree,
> 
> http://www.zip.com.au/~akpm/linux/patches/stuff/x.bz2 is -mm-as-of-now.

Thanks. Here is the patch:

[PATCH] de_thread: fix lockless do_each_thread

We should keep the value of old_leader->tasks.next in de_thread,
otherwise we can't do for_each_process/do_each_thread without
tasklist_lock held.

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- mm/fs/exec.c~	2006-04-11 14:31:18.000000000 +0400
+++ mm/fs/exec.c	2006-04-11 14:35:23.000000000 +0400
@@ -725,7 +725,7 @@ static int de_thread(struct task_struct 
 		attach_pid(current, PIDTYPE_PID,  current->pid);
 		attach_pid(current, PIDTYPE_PGID, current->signal->pgrp);
 		attach_pid(current, PIDTYPE_SID,  current->signal->session);
-		list_add_tail_rcu(&current->tasks, &init_task.tasks);
+		list_replace_rcu(&leader->tasks, &current->tasks);
 
 		current->parent = current->real_parent = leader->real_parent;
 		leader->parent = leader->real_parent = child_reaper;
@@ -735,7 +735,6 @@ static int de_thread(struct task_struct 
 		/* Reduce leader to a thread */
 		detach_pid(leader, PIDTYPE_PGID);
 		detach_pid(leader, PIDTYPE_SID);
-		list_del_init(&leader->tasks);
 
 		add_parent(current);
 		add_parent(leader);

