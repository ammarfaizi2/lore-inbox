Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268695AbUHYUtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268695AbUHYUtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268702AbUHYUtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:49:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:40876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268695AbUHYUnB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:43:01 -0400
Date: Wed, 25 Aug 2004 13:41:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, thomas@undata.org
Subject: Re: [PATCH] Fix shared interrupt handling of SA_INTERRUPT and
 SA_SAMPLE_RANDOM
Message-Id: <20040825134112.5aefaf8e.akpm@osdl.org>
In-Reply-To: <s5hoekzfowc.wl@alsa2.suse.de>
References: <s5heklxhjbg.wl@alsa2.suse.de>
	<20040824204508.3b31449f.akpm@osdl.org>
	<s5hoekzfowc.wl@alsa2.suse.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai <tiwai@suse.de> wrote:
>
> Anyway, suppressing the unnecessary call of add_interrupt_randomness()
>  should be still valid.  The reduced patch is below.
> 
> 
>  Takashi
> 
>  --- linux-2.6.8.1/arch/i386/kernel/irq.c-dist	2004-08-25 13:13:05.153227112 +0200
>  +++ linux-2.6.8.1/arch/i386/kernel/irq.c	2004-08-25 13:13:34.760726088 +0200
>  @@ -220,14 +220,16 @@ asmlinkage int handle_IRQ_event(unsigned
>   		struct pt_regs *regs, struct irqaction *action)
>   {
>   	int status = 1;	/* Force the "do bottom halves" bit */
>  -	int retval = 0;
>  +	int ret, retval = 0;
>   
>   	if (!(action->flags & SA_INTERRUPT))
>   		local_irq_enable();
>   
>   	do {
>  -		status |= action->flags;
>  -		retval |= action->handler(irq, action->dev_id, regs);
>  +		ret = action->handler(irq, action->dev_id, regs);
>  +		if (ret)
>  +			status |= action->flags;
>  +		retval |= ret;
>   		action = action->next;
>   	} while (action);
>   	if (status & SA_SAMPLE_RANDOM)

Shouldn't that be `if (ret == IRQ_HANDLED)'?

Probably I'll need to pass this to lots of other architecture maintainers
to make the same change.  Please write a nice changelog so they understand
what your patch does.


