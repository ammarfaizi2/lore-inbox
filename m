Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUFCGxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUFCGxu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 02:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUFCGxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 02:53:50 -0400
Received: from fw.osdl.org ([65.172.181.6]:62089 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261252AbUFCGxr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 02:53:47 -0400
Date: Wed, 2 Jun 2004 23:53:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, vojtech@suse.cz
Subject: Re: [RFC] Changing SysRq - show registers handling
Message-Id: <20040602235306.1e6dd3fb.akpm@osdl.org>
In-Reply-To: <200406030134.04121.dtor_core@ameritech.net>
References: <200406030134.04121.dtor_core@ameritech.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dtor_core@ameritech.net> wrote:
>
> Currently SysRq "show registers" command dumps registers and the call
>  trace from keyboard interrupt context when SysRq-P. For that struct pt_regs *
>  has to be dragged throughout entire input and USB systems. Other than passing
>  this pointer to SysRq handler these systems has no interest in it, it is
>  completely foreign piece of data for them and I would like to get rid of it.
> 
>  I am suggesting slightly changing semantics of SysRq-P handling - instread
>  of dumping registers and call trace immediately it will simply post a request
>  for this information to be dumped. When next HW interrupt arrives and is
>  handled, before running softirqs then current stack trace will be printed.
>  This approach adds small overhead to the HW interrupt handling routine as the
>  condition has to be checked with every interrupt but I expect it to be
>  negligible as it is only check and conditional jump that is almost never
>  taken. The code should be hot in cache so branch prediction should work just
>  fine.

Makes sense I guess.

There have been other times when I've needed access to the registers from
within hard IRQ.  But I forget the reason.

It would be more general, although a little slower to do:

DEFINE_PER_CPU(global_irq_regs);

do_IRQ(...)
{
	...
	struct pt_regs **cpu_regs_slot = __get_cpu_var(global_irq_regs);
	struct pt_regs *save = *cpu_regs_slot;
	*cpu_regs_slot = &regs;
	...
	*cpu_regs_slot = save;
}

And to teach the sysrq code to grab *__get_cpu_var(global_irq_regs).

Note that global_irq_regs is only valid if in_interrupt().  The sysrq
handler can be called from process context via /proc/sysrq-trigger and
should bale out if !in_interrupt().

+static inline void sysrq_show_registes(struct pt_regs *pt_regs)

typo.
