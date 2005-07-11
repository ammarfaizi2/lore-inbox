Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVGKMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVGKMTO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbVGKMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:19:14 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:42141 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261644AbVGKMTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:19:13 -0400
Message-ID: <42D26604.66A75939@tv-sign.ru>
Date: Mon, 11 Jul 2005 16:28:52 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC][PATCH] i386: Per node IDT
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
>
> --- linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	3 Jul 2005 13:20:43 -0000	1.1.1.1
> +++ linux-2.6.13-rc1-mm1/arch/i386/kernel/entry.S	10 Jul 2005 22:33:37 -0000
> -
> +/* Build the IRQ entry stubs */
>  vector=0
> -ENTRY(irq_entries_start)
> +	.align IRQ_STUB_SIZE,0x90
> +ENTRY(interrupt)
>  .rept NR_IRQS
>  	ALIGN
> -1:	pushl $vector-256
> +	pushl $vector
>  	jmp common_interrupt
>
>  [...snip...]
>
> --- linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	3 Jul 2005 13:20:43 -0000	1.1.1.1
> +++ linux-2.6.13-rc1-mm1/arch/i386/kernel/irq.c	4 Jul 2005 21:39:56 -0000
> @@ -53,8 +53,7 @@ static union irq_ctx *softirq_ctx[NR_CPU
>   */
>  fastcall unsigned int do_IRQ(struct pt_regs *regs)
>  {	
> -	/* high bits used in ret_from_ code */
> -	int irq = regs->orig_eax & 0xff;
> +	int irq = regs->orig_eax;

Could you explain this change? I think it breaks do_signal/handle_signal,
they check orig_eax >= 0 to handle -ERESTARTSYS:

	/* Are we from a system call? */
	if (regs->orig_eax >= 0) {
		/* If so, check system call restarting.. */
		switch (regs->eax) {
		        case -ERESTART_RESTARTBLOCK:
			case -ERESTARTNOHAND:

Oleg.
