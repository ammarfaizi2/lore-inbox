Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWEPPW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWEPPW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 11:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932089AbWEPPW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 11:22:26 -0400
Received: from mail.suse.de ([195.135.220.2]:24728 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932090AbWEPPWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 11:22:25 -0400
From: Andi Kleen <ak@suse.de>
To: discuss@x86-64.org
Subject: Re: [discuss] Re: [PATCH 3/3] reliable stack trace support (i386)
Date: Tue, 16 May 2006 17:20:41 +0200
User-Agent: KMail/1.9.1
Cc: Ingo Molnar <mingo@elte.hu>, Jan Beulich <jbeulich@novell.com>,
       linux-kernel@vger.kernel.org
References: <4469FC41.76E4.0078.0@novell.com> <20060516151422.GD10760@elte.hu>
In-Reply-To: <20060516151422.GD10760@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605161720.42128.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > +static inline void
> > +arch_unw_init_blocked(struct unwind_frame_info *info)
> > +{
> > +	memset(&info->regs, 0, sizeof(info->regs));
> > +	info->regs.eip = info->task->thread.eip;
> > +	info->regs.xcs = __KERNEL_CS;
> > +	__get_user(info->regs.ebp, (long *)info->task->thread.esp);
> > +	info->regs.esp = info->task->thread.esp;
> > +	info->regs.xss = __KERNEL_DS;
> > +	info->regs.xds = __USER_DS;
> > +	info->regs.xes = __USER_DS;
> 
> hm, arent you using this from within show_trace()? In that case we 
> shouldnt do a __get_user() i think, we might be in an arbitrary context 

Should be ok. We already do this in some parts of oopsing and the page fault handler 
can handle it as long as there is an exception entry (which is there for this case)

> ...
> 
> > +static inline int
> > +arch_unw_user_mode(const struct unwind_frame_info *info)
> > +{
> > +#if 0 /* This can only work when selector register and EFLAGS saves/restores
> > +         are properly annotated (and tracked in UNW_REGISTER_INFO). */
> > +	return user_mode_vm(&info->regs);
> > +#else
> > +	return info->regs.eip < PAGE_OFFSET;
> > +#endif
> 
> same here as for x86_64: is this condition safe? Userspace can provoke 
> an EIP of >= PAGE_OFFSET by for example jumping to the vsyscall page.

Good point, it's probably not. Especially since we already have a user_mode() macro

-Andi
