Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751212AbWEPPJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbWEPPJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751211AbWEPPJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:09:23 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24469 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751212AbWEPPJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:09:21 -0400
Date: Tue, 16 May 2006 17:09:18 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jan Beulich <jbeulich@novell.com>
Cc: Andreas Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [PATCH 2/3] reliable stack trace support (x86-64)
Message-ID: <20060516150918.GC10760@elte.hu>
References: <4469FC22.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4469FC22.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jan Beulich <jbeulich@novell.com> wrote:

> These are the x86_64-specific pieces to enable reliable stack traces. The
> only restriction with this is that it currently cannot unwind across the
> interrupt->normal stack boundary, as that transition is lacking proper
> annotation.

> +#define UNW_PC(frame) (frame)->regs.rip
> +#define UNW_SP(frame) (frame)->regs.rsp
> +#ifdef CONFIG_FRAME_POINTER
> +#define UNW_FP(frame) (frame)->regs.rbp
> +#define FRAME_RETADDR_OFFSET 8
> +#define FRAME_LINK_OFFSET 0
> +#define STACK_BOTTOM(tsk) (((tsk)->thread.rsp0 - 1) & ~(THREAD_SIZE - 1))
> +#define STACK_TOP(tsk) ((tsk)->thread.rsp0)
> +#endif

style: align the defines.

> +static inline int
> +arch_unw_user_mode(const struct unwind_frame_info *info)
> +{
> +#if 0 /* This can only work when selector register saves/restores
> +         are properly annotated (and tracked in UNW_REGISTER_INFO). */
> +	return user_mode(&info->regs);
> +#else
> +	return (long)info->regs.rip >= 0;
> +#endif
> +}

is this safe? Cannot userspace provide (long)rip < 0 by jumping to it?

	Ingo
