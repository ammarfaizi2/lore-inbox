Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267890AbUI1Po0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267890AbUI1Po0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 11:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUI1Po0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 11:44:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62993 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267890AbUI1PoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 11:44:23 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: root@chaos.analogic.com, Stas Sergeev <stsp@aknet.ru>
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Tue, 28 Sep 2004 18:43:46 +0300
User-Agent: KMail/1.5.4
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <3BFF2F87096@vcnet.vc.cvut.cz> <4151DA79.7000804@aknet.ru> <Pine.LNX.4.53.0409221608420.1368@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.53.0409221608420.1368@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409281843.46401.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 September 2004 23:13, Richard B. Johnson wrote:
> Well DOSEMU uses VM-86 mode. That's how it works. It
> creates a virtual 8086 machine, complete with the
> required "DOS compatible" virtual BIOS environment.

You forgot DOS extenders which do not use VM86
but 32bit protected mode.
 
> I use it all the time because I write, amongst other things,
> the complete BIOS and startup code for many Intel based
> machines.
> 
> I run compilers, assemblers, linkers, and editors in that
> environment and it works.

The fact that those programs work fine does not automatically mean
that _other_ DOS programs will work.
 
> Sombody mentions a completely unrelated so-called Intel
> bug and next thing you know, there are patches to work-
> around the bug???
>
> The bug doesn't exist period.

Sorry, but it does exist. It is really obscure bug.
Please read on: 

> There is a "semi-official" bug in Intel CPUs,
> which is described here:
> http://www.intel.com/design/intarch/specupdt/27287402.PDF
> chapter "Specification Clarifications"
> section 4: "Use Of ESP In 16-Bit Code With 32-Bit Interrupt Handlers".
> 
> A short quote:
> "ISSUE: When a 32-bit IRET is used to return to another privilege level,
> and the old level uses a 4G stack (D/B bit in the segment register = 1),
> while the new level uses a 64k stack (D/B bit = 0), then only the 
> lower word of ESP is updated."
> 
> Which means that the higher word of ESP gets
> trashed. This bug beats dosemu rather badly,
> but there seem to be not much info about that
> bug available on the net.

IRET-to-lower-CPL-level stack frame:

+16 old_SS
+12 old_ESP
 +8 old_EFLAGS
 +4 old_CS
 +0 old_EIP <--- SS:ESP

> > If old_SS references 'small' data segment (16-bit one),
> > processor does not restore ESP from old_ESP.
> > It restores lower 16 bits only. Upper 16 bits are filled
> > with garbage (or just not modified at all?).
>
> Not modified at all, yes. That's why it is always
> greater than TASK_SIZE (0xc0000000) - it is still
> in a kernel space.
>
> > This works fine because processor uses SP, not ESP,
> > for subsequent push/pop/call/ret operations.
> > But if code uses full ESP, thinking that upper 16 bits are zero,
> > it will crash badly. Correct me if I'm wrong.
>
> That's correct. But you should note that the
> program not just "thinks" that the upper 16 bits
> are zero. It writes zero there itself, and a few
> instructions later - oops, it is no longer zero...
--
vda

