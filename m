Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030385AbWBHRal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030385AbWBHRal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 12:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030382AbWBHRal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 12:30:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62621 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030385AbWBHRak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 12:30:40 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fork:  Allow init to become a session leader.
References: <m1acd196hr.fsf@ebiederm.dsl.xmission.com>
	<43EA386B.D1A20AEB@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Feb 2006 10:29:55 -0700
In-Reply-To: <43EA386B.D1A20AEB@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 08 Feb 2006 21:28:59 +0300")
Message-ID: <m1ek2d7o8c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> "Eric W. Biederman" wrote:
>> 
>> With the bug fixes from killing session == 0 and pgrp == 0 we
>> have essentially made pid == 1 a session leader.  However reading
>> through the code I can see nothing, that sets the session->leader
>> flag.  In fact we actively clear it in all cases during clone.
>> And setsid will fail to set it because the session == 1 and
>> process group == 1 already exist.
>> 
>> So this patch forces the session leader flag and for good measure
>> the pgrp, session and tty of init as well.
>> 
>> --- a/kernel/fork.c
>> +++ b/kernel/fork.c
>> @@ -1179,9 +1179,16 @@ static task_t *copy_process(unsigned lon
>>                 attach_pid(p, PIDTYPE_PID, p->pid);
>>                 attach_pid(p, PIDTYPE_TGID, p->tgid);
>>                 if (thread_group_leader(p)) {
>> -                       p->signal->tty = current->signal->tty;
>> -                       p->signal->pgrp = process_group(current);
>> -                       p->signal->session = current->signal->session;
>> +                       if (unlikely(p->pid == 1)) {
>> +                               p->signal->tty = NULL;
>> +                               p->signal->leader = 1;
>> +                               p->signal->pgrp = 1;
>> +                               p->signal->session = 1;
>
> Isn't it enough to just set current->signal->leader = 1
> in init/main.c:init() ? This process was already forked
> with (1,1) special pids and ->tty == NULL.

At the moment yes.  Being explicit can help readability.

This allows us the opportunity to leave the unhashed idle task as
(0,0) and more interesting to me, if we ever fork another process with
pid == 1 in a different process id namespace we do need to do all of
this.

Eric
