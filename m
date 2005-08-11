Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932219AbVHKPv4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932219AbVHKPv4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 11:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbVHKPvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 11:51:55 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40392 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932219AbVHKPvz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 11:51:55 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, linux-kernel@vger.kernel.org,
       Ukil a <ukil_a@yahoo.com>, 7eggert@gmx.de
In-Reply-To: <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 11:51:48 -0400
Message-Id: <1123775508.17269.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 11:28 -0400, linux-os (Dick Johnson) wrote:
> On Thu, 11 Aug 2005, Coywolf Qi Hunt wrote:
> 
> > On 8/11/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> >> On Thu, 2005-08-11 at 10:04 -0400, linux-os (Dick Johnson) wrote:
> >>> Every interrupt software, or hardware, results in the branched
> >>> procedure being executed with the interrupts OFF. That's why
> >>> one of the first instructions in the kernel entry for a syscall
> >>> is 'sti' to turn them back on. Look at entry.S, line 182. This
> >>> occurs any time a trap occurs as well (Page 26-168, i486
> >>> Programmer's reference manual). FYI, this is helpful when
> >>> designing/debugging complex interrupt-service routines since
> >>> you can execute the interrupt with a software 'INT' instruction
> >>> (with the correct offset from the IRQ you are using). The software
> >>> doesn't 'know' where the interrupt came from, HW or SW.
> >>
> >> I'm looking at 2.6.13-rc6-git1 line 182 of entry.S and I don't see it.
> >> Must be a different kernel.
> >>
> >> According to the documentation that I was looking at, a trap in x86 does
> >> _not_ turn off interrupts.
> >>
> > ...
> >>
> >> I don't see a sti here.
> >
> 
> Search for sysenter_entry. This is where the stack is switched
> to the kernel stack. Then the code falls through past the
> next label, sysenter_past_esp. The very next instruction
> after the kernel stack has been set is 'sti'. Clear as day.

I just applied the following to one of my kernels:

-- arch/i386/kernel/entry.S    (revision 274)
+++ arch/i386/kernel/entry.S    (working copy)
@@ -184,6 +184,7 @@
 ENTRY(sysenter_entry)
        movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
+       ud2
        sti
        pushl $(__USER_DS)
        pushl %ebp

And booted it.  The system is up and running, so I really don't think
that the sysenter_entry is used for system calls.  

Not so "Clear as day"!

-- Steve


