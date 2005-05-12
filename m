Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261175AbVELGoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261175AbVELGoU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 02:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVELGoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 02:44:20 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:43690 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S261175AbVELGoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 02:44:01 -0400
Message-ID: <4282FB27.6090801@sw.ru>
Date: Thu, 12 May 2005 10:43:51 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
CC: seife@suse.de, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Software suspend and recalc sigpending bug fix
References: <428222CF.3070002@sw.ru> <20050511180411.GB1866@elf.ucw.cz>
In-Reply-To: <20050511180411.GB1866@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch fixes recalc_sigpending() to work correctly
>>with tasks which are being freezed. The problem is that
>>freeze_processes() sets PF_FREEZE and TIF_SIGPENDING
>>flags on tasks, but recalc_sigpending() called from
>>e.g. sys_rt_sigtimedwait or any other kernel place
>>will clear TIF_SIGPENDING due to no pending signals queued
>>and the tasks won't be freezed until it recieves a real signal
>>or freezed_processes() fail due to timeout.
>>
>>Signed-Off-By: Kirill Korotaev <dev@sw.ru>
>>Signed-Off-By: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
> 
> 
> This should fix our problems with mysqld, right? Yes, patch looks good
> (modulo missing whitespace around &)). I'll apply it to my tree. (Or
> andrew, if you prefer, just take it...

Another cleanup idea in swsusp: it would be nice if all such checks for 
PF_FREEZE were wrapped in inline function 
is_task_freezing()/any_thing_else, to make freeze code disappear when 
CONFIG_PM/CONFIG_SOFTWARE_SUSPEND is off...

Kirill

> 								Pavel
> 
> 
>>--- ./kernel/signal.c.freezesigrec	2005-05-10 16:10:40.000000000 +0400
>>+++ ./kernel/signal.c	2005-05-10 18:10:08.000000000 +0400
>>@@ -212,6 +212,7 @@ static inline int has_pending_signals(si
>> fastcall void recalc_sigpending_tsk(struct task_struct *t)
>> {
>> 	if (t->signal->group_stop_count > 0 ||
>>+	    (t->flags&PF_FREEZE) ||
>> 	    PENDING(&t->pending, &t->blocked) ||
>> 	    PENDING(&t->signal->shared_pending, &t->blocked))
>> 		set_tsk_thread_flag(t, TIF_SIGPENDING);
> 
> 
> 


