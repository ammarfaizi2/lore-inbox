Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932083AbWEPPO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932083AbWEPPO0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932085AbWEPPOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:14:25 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:10454 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932083AbWEPPOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:14:24 -0400
Date: Tue, 16 May 2006 17:14:22 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 3/3] reliable stack trace support (i386)
Message-ID: <20060516151422.GD10760@elte.hu>
References: <4469FC41.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469FC41.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jan Beulich <jbeulich@novell.com> wrote:

> These are the i386-specific pieces to enable reliable stack traces. This is
> going to be even more useful once CFI annotations get added to he assembly
> code, namely to entry.S (a patch for that had been submitted several times).

> +#define UNW_PC(frame) (frame)->regs.eip
> +#define UNW_SP(frame) (frame)->regs.esp
> +#ifdef CONFIG_FRAME_POINTER
> +#define UNW_FP(frame) (frame)->regs.ebp
> +#define FRAME_RETADDR_OFFSET 4
> +#define FRAME_LINK_OFFSET 0
> +#define STACK_BOTTOM(tsk) (((tsk)->thread.esp0 - 1) & ~(THREAD_SIZE - 1))
> +#define STACK_TOP(tsk) ((tsk)->thread.esp0)
> +#endif

style: i'd suggest to improve readability by aligning these.

> +static inline void
> +arch_unw_init_blocked(struct unwind_frame_info *info)
> +{
> +	memset(&info->regs, 0, sizeof(info->regs));
> +	info->regs.eip = info->task->thread.eip;
> +	info->regs.xcs = __KERNEL_CS;
> +	__get_user(info->regs.ebp, (long *)info->task->thread.esp);
> +	info->regs.esp = info->task->thread.esp;
> +	info->regs.xss = __KERNEL_DS;
> +	info->regs.xds = __USER_DS;
> +	info->regs.xes = __USER_DS;

hm, arent you using this from within show_trace()? In that case we 
shouldnt do a __get_user() i think, we might be in an arbitrary context 
...

> +static inline int
> +arch_unw_user_mode(const struct unwind_frame_info *info)
> +{
> +#if 0 /* This can only work when selector register and EFLAGS saves/restores
> +         are properly annotated (and tracked in UNW_REGISTER_INFO). */
> +	return user_mode_vm(&info->regs);
> +#else
> +	return info->regs.eip < PAGE_OFFSET;
> +#endif

same here as for x86_64: is this condition safe? Userspace can provoke 
an EIP of >= PAGE_OFFSET by for example jumping to the vsyscall page.

	Ingo
