Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWEPQDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWEPQDn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 12:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751834AbWEPQDm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 12:03:42 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:31442
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751832AbWEPQDl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 12:03:41 -0400
Message-Id: <446A142C.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Tue, 16 May 2006 18:04:28 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Andreas Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: Re: [PATCH 2/3] reliable stack trace support (x86-64)
References: <4469FC22.76E4.0078.0@novell.com> <20060516150918.GC10760@elte.hu>
In-Reply-To: <20060516150918.GC10760@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> Ingo Molnar <mingo@elte.hu> 16.05.06 17:09 >>>
>* Jan Beulich <jbeulich@novell.com> wrote:
>> +#define UNW_PC(frame) (frame)->regs.rip
>> +#define UNW_SP(frame) (frame)->regs.rsp
>> +#ifdef CONFIG_FRAME_POINTER
>> +#define UNW_FP(frame) (frame)->regs.rbp
>> +#define FRAME_RETADDR_OFFSET 8
>> +#define FRAME_LINK_OFFSET 0
>> +#define STACK_BOTTOM(tsk) (((tsk)->thread.rsp0 - 1) & ~(THREAD_SIZE - 1))
>> +#define STACK_TOP(tsk) ((tsk)->thread.rsp0)
>> +#endif
>
>style: align the defines.

If that's important...

>> +static inline int
>> +arch_unw_user_mode(const struct unwind_frame_info *info)
>> +{
>> +#if 0 /* This can only work when selector register saves/restores
>> +         are properly annotated (and tracked in UNW_REGISTER_INFO). */
>> +	return user_mode(&info->regs);
>> +#else
>> +	return (long)info->regs.rip >= 0;
>> +#endif
>> +}
>
>is this safe? Cannot userspace provide (long)rip < 0 by jumping to it?

You noted the comment, didn't you. This really should use user_mode(), but it can't as the unwind annotations don't
cover selector registers. Hence the initial CS/SS will always remain in place no matter how many unwinds you do.
But it's harmless for this function to return 'kernel mode' when in fact it might be user mode - nothing would crash
because of that, it might only lead to ill trailing entries on a stack dump.

Jan
