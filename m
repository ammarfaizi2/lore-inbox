Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbVJQIYN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbVJQIYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 04:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJQIYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 04:24:13 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:1275 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932201AbVJQIYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 04:24:12 -0400
Date: Mon, 17 Oct 2005 04:24:00 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: liyu <liyu@ccoss.com.cn>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] one question about 'current' in scheduler_tick() 
In-Reply-To: <43535B35.5020603@ccoss.com.cn>
Message-ID: <Pine.LNX.4.58.0510170416090.5859@localhost.localdomain>
References: <43535B35.5020603@ccoss.com.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liyu (once again :-)

On Mon, 17 Oct 2005, liyu wrote:

> Hi, All.
>
>     I found scheduler_tick() use current macro to get task_struct of
> current task.
>
>     I seen scheduler_tick() is called every timer interrupt at most
> time. In this
> case, I think scheduler_tick() is in interrupt context (enter kernel by
> interrupt),

Yes, scheduler_tick is called from interrupt context.

> So I have a hunch that there have not thread_info which it need in
> kernel stack. But
> It seem it can work perfectly.

Although it is said that you can't access user memory from an interrupt
context, the reasons are simple.  One, most user memory access can
schedule, and an interrupt service routine must not schedule. Also, an
interrupt service routine can happen on any thread, so you can't be sure
what thread is there.

But, when an interrupt goes off, whatever thread is running is still
there.  The thread's context _is_ still there.  The changing to the
interrupt stack takes special care to make sure that current still works.
So a copy of the thread_info is also done. Look in the do_IRQ in
arch/i386/kernel/irq.c and search for 4KSTACKS.  You will see there the
copying of thread_info.

>
>     I can not understand this. Would any expert like explain clearly for
> it ?
>

Hope this helps,

-- Steve

