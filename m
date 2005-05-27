Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262496AbVE0QjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262496AbVE0QjU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 12:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVE0QjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 12:39:20 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:2536 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S262503AbVE0QjF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 12:39:05 -0400
Message-ID: <42974F08.1C89CF2A@tv-sign.ru>
Date: Fri, 27 May 2005 20:47:04 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: john cooper <john.cooper@timesys.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: RT and Cascade interrupts
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
>
>  rpc_delete_timer(struct rpc_task *task)
>  {
> -	if (test_and_clear_bit(RPC_TASK_HAS_TIMER, &task->tk_runstate)) {
> +	if (task->tk_timer.base) {
>  		del_singleshot_timer_sync(&task->tk_timer);
>  		dprintk("RPC: %4d deleting timer\n", task->tk_pid);
>  	}

I know nothing about rpc, but this looks completely wrong to me.

Please don't use the ->base directly, use timer_pending(). This
field is never NULL in -mm tree.

Next, timer_pending() == 0 does not mean that del_timer_sync() is
not needed, it may be running on the other CPU.

Looking at the code for the first time, I can guess that RPC_TASK_HAS_TIMER
was invented to indicate when it is safe not to wait for timer
completition. This bit is cleared after ->tk_timeout_fn call in
the timer's handler. After that rpc_run_timer will not touch *task.

Oleg.
