Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVK1SEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVK1SEs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932149AbVK1SEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:04:48 -0500
Received: from 58x158x20x104.ap58.ftth.ucom.ne.jp ([58.158.20.104]:35509 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S932146AbVK1SEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:04:48 -0500
Subject: Re: [PATCH & RFC] kdump and stack overflows
From: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
In-Reply-To: <m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
References: <1133183463.2327.96.camel@localhost.localdomain>
	 <m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=83=87=E3=83=BC=E3=82=BF=E5=85=88=E7=AB=AF=E6=8A=80?=
	=?UTF-8?Q?=E8=A1=93=E6=A0=AA=E5=BC=8F=E4=BC=9A=E7=A4=BE?=
Date: Tue, 29 Nov 2005 03:00:14 +0900
Message-Id: <1133200815.2425.98.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-28 at 06:39 -0700, Eric W. Biederman wrote: 
> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:
> 
> > Hi,
> >
> > I have observed that kdump's reboot path to the second kernel is not
> > stack overflow safe.
> >
> > On the event of a stack overflow critical data that usually resides at
> > the bottom of the stack is likely to be stomped and, consequently, its
> > use should be avoided.
> >
> > In particular, in the i386 and IA64 architectures the macro
> > smp_processor_id ultimately makes use of the "cpu" member of struct
> > thread_info which resides at the bottom of the stack (see code snips
> > below). x86_64, on the other hand, is not affected by this problem
> > because it benefits from the PDA infrastructure.
> 
> I agree this is something that we should handle if we can.
> >
> > To circumvent this problem I suggest implementing
> > "safe_smp_processor_id()" (it already exists on x86_64) for i386 and
> > IA64 and use it as a replacement to smp_processor_id in the reboot path
> > to the dump capture kernel. A possible implementation for i386 is
> > attached below.
> >
> > I would appreciante comments on this.
> 
> The patch looks like a good one to express the idea, but it is a
> bad one to push upstream.
> 
> safe_smp_processor_id has a printk in it.
Sorry for the vestige of debugging code.

> mm/fault.c has related code that really should go into a separate
> patch.
> 
> For crash_nmi_callback I don't feel very comfortable about
> dropping the cpu parameter.  I suspect you want to move
> the call safe_smp_process_id to do_nmi (which is current
> calling smp_processor_id).  Basically the whole nmi path needs a stack
> overflow audit.
The reason behind dropping the cpu parameter in crash_nmi_callback was
to avoid the use of the much slower safe_smp_processor_id in do_nmi,
what would have an impact on all possible nmi handlers. This is ok with
crash_nmi_callback since it obviously isn't performance critical. But,
reconsidering the problem, one could argue that an nmi handler will
hardly ever be a fast path. I think I will move safe_smp_processor_id to
do_nmi as you suggested (sorry for thinking aloud).

Regarding the stack overflow audit of the nmi path, we have the problem
that both nmi_enter and nmi_exit in do_nmi (see code below) make heavy
use of "current" indirectly (specially through the kernel preemption
code).

fastcall void do_nmi(struct pt_regs * regs, long error_code)
{
        int cpu;

        nmi_enter();

        cpu = smp_processor_id();

#ifdef CONFIG_HOTPLUG_CPU
        if (!cpu_online(cpu)) {
                nmi_exit();
                return;
        }
#endif

        ++nmi_count(cpu);

        if (!rcu_dereference(nmi_callback)(regs, cpu))
                default_do_nmi(regs);

        nmi_exit();
}

> I believe we have a separate interrupt stack that
> should help but..
Yes, when using 4K stacks we have a separate interrupt stack that should
help, but I am afraid that crash dumping is about being paranoid.

I will split the previous patch as indicated below appropriately and
resend the parts in subsequent emails.

List of patches:

* safe_smp_processor_id: stack overflow safe implementation of
smp_processor_id
* crash: replace smp_processor_id with safe_smp_processor_id in
arch/i386/kernel/crash.c
* do_nmi: replace smp_processor_id with safe_smp_processor_id
   NOTE: this patch is still imcomplete. Once I audit the whole nmi path
I will prepare a new patch complementing this.
* fault: take stack overflows into account in do_page_fault

Regards,

Fernando

