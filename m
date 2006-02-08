Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030299AbWBHRLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030299AbWBHRLn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbWBHRLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:11:43 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:47841 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1030299AbWBHRLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:11:42 -0500
Message-ID: <43EA386B.D1A20AEB@tv-sign.ru>
Date: Wed, 08 Feb 2006 21:28:59 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork:  Allow init to become a session leader.
References: <m1acd196hr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> With the bug fixes from killing session == 0 and pgrp == 0 we
> have essentially made pid == 1 a session leader.  However reading
> through the code I can see nothing, that sets the session->leader
> flag.  In fact we actively clear it in all cases during clone.
> And setsid will fail to set it because the session == 1 and
> process group == 1 already exist.
> 
> So this patch forces the session leader flag and for good measure
> the pgrp, session and tty of init as well.
> 
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1179,9 +1179,16 @@ static task_t *copy_process(unsigned lon
>                 attach_pid(p, PIDTYPE_PID, p->pid);
>                 attach_pid(p, PIDTYPE_TGID, p->tgid);
>                 if (thread_group_leader(p)) {
> -                       p->signal->tty = current->signal->tty;
> -                       p->signal->pgrp = process_group(current);
> -                       p->signal->session = current->signal->session;
> +                       if (unlikely(p->pid == 1)) {
> +                               p->signal->tty = NULL;
> +                               p->signal->leader = 1;
> +                               p->signal->pgrp = 1;
> +                               p->signal->session = 1;

Isn't it enough to just set current->signal->leader = 1
in init/main.c:init() ? This process was already forked
with (1,1) special pids and ->tty == NULL.

Oleg.
