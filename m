Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932365AbVHKTAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932365AbVHKTAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 15:00:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVHKTAi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 15:00:38 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:45553 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932365AbVHKTAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 15:00:37 -0400
Subject: Re: Need help in understanding x86 syscall
From: Steven Rostedt <rostedt@goodmis.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0508111412320.15505@chaos.analogic.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz>
	 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com>
	 <1123770661.17269.59.camel@localhost.localdomain>
	 <2cd57c90050811081374d7c4ef@mail.gmail.com>
	 <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com>
	 <1123775508.17269.64.camel@localhost.localdomain>
	 <1123777184.17269.67.camel@localhost.localdomain>
	 <2cd57c90050811093112a57982@mail.gmail.com>
	 <2cd57c9005081109597b18cc54@mail.gmail.com>
	 <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
	 <1123781187.17269.77.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com>
	 <1123783862.17269.89.camel@localhost.localdomain>
	 <Pine.LNX.4.61.0508111412320.15505@chaos.analogic.com>
Content-Type: text/plain; charset=ISO-8859-1
Organization: Kihon Technologies
Date: Thu, 11 Aug 2005 15:00:20 -0400
Message-Id: <1123786821.17269.108.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-11 at 14:21 -0400, linux-os (Dick Johnson) wrote:

> I'm not sure you can stop the CPU from clearing the interrupt
> bit in EFLAGS if you execute an interrupt. The interrupt handler
> may be supported by a trap-gate, but the event has already
> occurred. The documentation I have isn't clear on this at all.

>From the Intel document 25366513 "IA32 Intel Architecture's Software
Developer's Manual" Volume 1, page 145 (or 6-11) Section "Call and
Return Operation for Interrupt or Exception Handling Procedures".

A call to an interrupt or exception handler procedure is similar to a procedure call to another
protection level (see Section 6.3.6., "CALL and RET Operation Between Privilege Levels").
Here, the interrupt vector references one of two kinds of gates: an interrupt gate or a trap gate.
Interrupt and trap gates are similar to call gates in that they provide the following information:
·   access rights information
·   the segment selector for the code segment that contains the handler procedure
·   an offset into the code segment to the first instruction of the handler procedure
The difference between an interrupt gate and a trap gate is as follows. If an interrupt or exception
handler is called through an interrupt gate, the processor clears the interrupt enable (IF) flag in
the EFLAGS register to prevent subsequent interrupts from interfering with the execution of the
handler. When a handler is called through a trap gate, the state of the IF flag is not changed.


And in linux, the system call vector is handled with a trap gate, and
thus that is why the system_call in entry.S does not call sti. Although,
you are right, if I use sysenter, then it would call sysenter_entry
where it would need to enable interrupts again.

To prove my point.  All the libc syscalls seem to use "int 0x80", and
looking at the entry.S, it calls system_call directly.  Now to see what
sysenter would do I did the following changes:

Index: arch/i386/kernel/entry.S
===================================================================
--- arch/i386/kernel/entry.S    (revision 274)
+++ arch/i386/kernel/entry.S    (working copy)
@@ -196,6 +196,8 @@
  * Careful about security.
  */
        cmpl $__PAGE_OFFSET-3,%ebp
+       call sdr_func
+       jmp syscall_fault
        jae syscall_fault
 1:     movl (%ebp),%ebp
 .section __ex_table,"a"
Index: arch/i386/kernel/traps.c
===================================================================
--- arch/i386/kernel/traps.c    (revision 274)
+++ arch/i386/kernel/traps.c    (working copy)
@@ -1092,6 +1092,10 @@
 } while (0)


+void sdr_func(void)
+{
+       printk("hello from sdr_func\n");
+}


So my sysenter_entry in entry.S would call my function sdr_func which is
defined in traps.c as above.

Then I ran the following program:

int main()
{
        unsigned long a = 0x14;
        asm("push %%ecx;\npush %%edx;\nmov %%esp,%%ebp;\nsysenter"
                        ::"a"(a):"cx","dx","sp","bp");
        return 0;
}


And I did get my print in the console. So it seems that my system does
not use sysenter (even though the linux-gate.so seems to set this up),
but instead uses the "int 0x80", which in Linux does _not_ disable
interrupts.

I hope this clears things up for everyone. :-)

-- Steve



