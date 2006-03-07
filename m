Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWCGUlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWCGUlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbWCGUlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:41:37 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:41144 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751414AbWCGUlg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:41:36 -0500
Message-ID: <440DEF4D.F3385C28@tv-sign.ru>
Date: Tue, 07 Mar 2006 23:38:37 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
		<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
		<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
		<44074479.15D306EB@tv-sign.ru>
		<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
		<440CA459.6627024C@tv-sign.ru> <m1slpv58yd.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Oleg Nesterov <oleg@tv-sign.ru> writes:
> 
> > I think I have a really good idea.
> >
> > Forget about task ref for a moment. I thinks we can greatly
> > simplify the pids management. We don't PIDTYPE_MAX hash tables,
> > we need only one.
> >
> > The plan:
> >
> >       kill PIDTYPE_TGID
> >       (copy_process/unhash_process need a simple fix)
> 
> Worth doing.  But I think it is an independent problem.

Almost independent, but still we have to do it before we introduce
pid_head. Otherwise next_thread() will be broken, because ->pids[].next
could actually point to pid_head->tasks[].

> pid_head is decent but I am very tempted to call this struct pid.
> Especially if we start getting a lot of pointers to them a simple
> name that makes sense is useful.

Agreed, will rename.

> >       // alloc_pidmap() becomes static,
> >       // do_fork() calls this instead
> >       struct pid_head *alloc_pid(void)
> >       {
>
> Hmm.  I guess that works.  I'm tempted to still return just a pid_t.
> I guess I can't see how the struct pid_head, will be used.

Probably you are right.
 
> There may be another problem here as well.  I don't think we have a lock
> at this point that makes us safe to update the hash table.

Yes,

> If we want to kill the tasklist_lock we also want to add a lock
> to struct pid_head.  Otherwise I don't see how we can safely bump
> the count, above zero.  But using the tasklist_lock for the first
> version shouldn't be a problem.

... and yes. I think we can use pidmap_lock.

Also, find_pid() needs to be rcu safe. I'll try to show the code
tomorrow.

Oleg.
