Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267872AbUJDJVS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267872AbUJDJVS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 05:21:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267882AbUJDJVS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 05:21:18 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:5607 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S267872AbUJDJVO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 05:21:14 -0400
Message-ID: <416117A1.25DE5FCE@tv-sign.ru>
Date: Mon, 04 Oct 2004 13:28:01 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dev@sw.ru, torvalds@osdl.org
Subject: Re: [PATCH] alternate stack dump fix.
References: <41602238.A828A852@tv-sign.ru>
		<20041003100603.6429acdd.akpm@osdl.org>
		<41610845.E03B482D@tv-sign.ru> <20041004012731.2634bff8.akpm@osdl.org>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> In that case I'm not understanding you.  Are you saying that your patch
> fixes the same problem as that which Kirill's patch fixed?

It seems to me, yes.

Here the pseudo code for CONFIG_FRAME_POINTER:

int valid_stack_ptr(struct thread_info *tinfo, void *p)
{
	return	p > (void *)tinfo &&
		p < (void *)tinfo + THREAD_SIZE - 3;
}

long print_context_stack(thread_info *tinfo, long *stack, long ebp)
{
	while (valid_stack_ptr(tinfo, ebp))
	{
		print_symbol("%s", *(ebp+4));
		ebp = *(unsigned long *)ebp;
	}

	return ebp;
}

void show_trace(struct task_struct *task, unsigned long * stack)
{
	while (1) {
		struct thread_info *context = (struct thread_info *)
			((unsigned long)stack & (~(THREAD_SIZE - 1)));

		ebp = print_context_stack(context, stack, ebp);

		stack = (unsigned long*)context->previous_esp;
		if (!stack)
			break;
		printk(" =======================\n");
	}
}

show_trace() now does not use task argument in the main
loop. Instead, it converts stack to thread_info* context,
and passes it to print_context_stack() and (implicitly)
to valid_stack_ptr().

valid_stack_ptr() does not care now whether or not it is
irq stack, it just does bounds checking.

Please note, i simply deleted this printk("Stack pointer is garbage"),
it can be restored, if neccessary.

Did i miss something?

> That wasn't at all clear from your earlier comments.

Yes, sorry.

Oleg.
