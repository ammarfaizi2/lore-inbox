Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWDKGIZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWDKGIZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 02:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbWDKGIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 02:08:25 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:695 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932141AbWDKGIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 02:08:24 -0400
Date: Tue, 11 Apr 2006 14:05:27 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Message-ID: <20060411100527.GA112@oleg>
References: <20060406220403.GA205@oleg> <m1acay1fbh.fsf@ebiederm.dsl.xmission.com> <20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org> <20060407155619.18f3c5ec.akpm@osdl.org> <m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg> <m1y7yddo75.fsf_-_@ebiederm.dsl.xmission.com> <m1u091dnry.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1u091dnry.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10, Eric W. Biederman wrote:
>
> I believe this is 2.6.17 material as the bug is present in
> 2.6.17-rc1 and the fix is simple.
>
> ...
>
> +		list_del_init(&leader->tasks);

I beleive this is ok for 2.6.17-rc1, but this breaks lockless
for_each_process/while_each_thread (I am talking about -mm tree).

Andrew, could you please drop these ones:

	task-make-task-list-manipulations-rcu-safe-fix.patch
	task-make-task-list-manipulations-rcu-safe-fix-fix.patch

Then we need this "patch" for de_thread:

-		list_add_tail_rcu(&current->tasks, &init_task.tasks);
+		list_replace_rcu(&leader->tasks, &current->tasks);
 ...
-		list_del_init(&leader->tasks);

Currently I don't know how the code looks in -mm tree, I lost the plot.

Oleg.

