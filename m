Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262311AbUKQNNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262311AbUKQNNv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 08:13:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbUKQNNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 08:13:50 -0500
Received: from [32.97.182.141] ([32.97.182.141]:57308 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262311AbUKQNNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 08:13:18 -0500
Date: Wed, 17 Nov 2004 18:45:52 +0530
From: Prasanna S Panchamukhi <prasanna@in.ibm.com>
To: Stas Sergeev <stsp@aknet.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] kprobes: dont steal interrupts from vm86
Message-ID: <20041117131552.GA11053@in.ibm.com>
Reply-To: prasanna@in.ibm.com
References: <20041109130407.6d7faf10.akpm@osdl.org> <20041110104914.GA3825@in.ibm.com> <4192638C.6040007@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <4192638C.6040007@aknet.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

> 
> Prasanna S Panchamukhi wrote:
> >>With kprobes enabled, vm86 doesn't feel
> >>good. The problem is that kprobes steal
> >>the interrupts (mainly int3 I think) from
> >>it for no good reason.
> >If the int3 is not registered through kprobes,
> >kprobes handler does not handle it and it falls through the
> >normal int3 handler AFAIK.
> I was considering this, but I convinced
> myself that checking the VM flag is good
> in any case, because, as I presume, you
> never need the interrupts from v86. Or do
> you?
> If there is a bug in kprobes, it would be
> good to fix either, but I just think it
> will not make my patch completely useless.
> 
Yes, there is a small bug in kprobes. Kprobes int3 handler
was returning wrong value. Please check out if the patch
attached with this mail fixes your problem.

Please let me know if you have any issues.

Thanks
Prasanna

-- 
Prasanna S Panchamukhi
Linux Technology Center
India Software Labs, IBM Bangalore
Ph: 91-80-25044636
<prasanna@in.ibm.com>

--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="kprobes-vm86-interrupt-miss.patch"


This patch fixes the problem reported by Stas Sergeev, that kprobes steals
the virtual-8086 exceptions. This fix modifies kprobe_handler() to return 0 when in
virtual-8086 mode.


---

 linux-2.6.10-rc2-prasanna/arch/i386/kernel/kprobes.c |    4 ++++
 1 files changed, 4 insertions(+)

diff -puN arch/i386/kernel/kprobes.c~kprobes-vm86-interrupt-miss arch/i386/kernel/kprobes.c
--- linux-2.6.10-rc2/arch/i386/kernel/kprobes.c~kprobes-vm86-interrupt-miss	2004-11-17 18:30:11.000000000 +0530
+++ linux-2.6.10-rc2-prasanna/arch/i386/kernel/kprobes.c	2004-11-17 18:38:20.000000000 +0530
@@ -117,6 +117,10 @@ static inline int kprobe_handler(struct 
 	p = get_kprobe(addr);
 	if (!p) {
 		unlock_kprobes();
+		if (regs->eflags & VM_MASK)
+		/*we are in virtual-8086 mode, return 0*/
+			goto no_kprobe;
+
 		if (*addr != BREAKPOINT_INSTRUCTION) {
 			/*
 			 * The breakpoint instruction was removed right

_

--jRHKVT23PllUwdXP--
