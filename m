Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964871AbVKGROF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964871AbVKGROF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVKGROE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:14:04 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:27048 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S964871AbVKGROD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:14:03 -0500
Message-ID: <436F9CB1.9F6BCC20@tv-sign.ru>
Date: Mon, 07 Nov 2005 21:28:01 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru> <20051104200801.GA16092@us.ibm.com> <436CDEAC.A7D56A94@tv-sign.ru> <20051105232027.GA20178@us.ibm.com> <436DF0A6.342717A6@tv-sign.ru> <20051106225926.GC22876@us.ibm.com> <436F5402.137182CF@tv-sign.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov wrote:
> 
> When group leader exits it goes into TASK_ZOMBIE state (if it is not the
> only one thread in the same group).

Just to clarify, single-thread process can go to TASK_ZOMBIE state too,
of course. But group leader can't be released (by itself or via sys_wait4)
while there are other threads in the same group.

> So, I think send_group_sigqueue() should do:
> 
>         read_lock(tasklist_lock);
> 
>         if (!tsk->signal) {
>                 // Can happen only if de_thread did release_task(tsk)
>                 // while switching to new leader.
>                 // We can't figure out the new leader, but it does not
>                 // matter - we should drop the signal anyway.
>                 unlock(tasklist);
>                 return;

No, I was wrong. This is not enough. This 'tsk' can be already freed!
sys_timer_create() bumps tsk->usage only when the signal is sent via
send_sigqueue(), it does not do get_task_struct(leader) when the signal
is not thread specific, but goes to the thread group.

Oleg.
