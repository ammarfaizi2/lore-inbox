Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932314AbVJYTZQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932314AbVJYTZQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 15:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932315AbVJYTZP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 15:25:15 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:33765 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932314AbVJYTZN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 15:25:13 -0400
Subject: Re: 2.6.14-rc5-rt6  -- False NMI lockup detects
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20051025142848.GA7642@elte.hu>
References: <1130250219.21118.11.camel@localhost.localdomain>
	 <20051025142848.GA7642@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Tue, 25 Oct 2005 15:24:52 -0400
Message-Id: <1130268292.21118.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-25 at 16:28 +0200, Ingo Molnar wrote:
> * Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > Hi Ingo and Thomas,
> > 
> > On some of my machines, I've been experiencing false NMI lockups.  
> > This usually happens on slower machines, and taking a look into this, 
> > it seems to be due to a short time where no processes are using 
> > timers, and the ktimer interrupts aren't needed. So the APIC timer, 
> > which now is used only for the ktimers, has a five second pause, and 
> > causes the NMI to go off.  The NMI uses the apic timer to determine 
> > lockups.
> 
> this would be a bug - the jiffy tick should be processed every 1 msec, 
> regardless of whether there are any ktimers pending. (in the future we 
> want to use a special ktimer for the jiffy tick, but that's not 
> implemented yet.)
> 

Isn't the jiffy tick implemented with the PIT when possible? So the apic
is only used when a timer is needed.  Also note that this "lockup"
happens on boot up while things are being initialized, so not many
things may be using the timer.

Also, the machine doesn't lock up.  It continues happily along at normal
speed.  It's only a 366 MHz machine.

At my customer's site (which I'm no longer at), my test machine (2GHz)
never showed this, but an equal machine that my customer had showed this
on every boot up.  The only difference between the two machines was the
other one had a 1GHz processor. These were both running on modified -rt
kernels.


> > So, I added a more generic method. This only works for x86 for now, 
> > but it has a #ifdef to keep other archs working until it implements 
> > this as well.  I added a nmi_irq_incr which is called by __do_IRQ in 
> > the generic code.  This is what is used in the NMI code to determine 
> > if the CPU has locked up.  This way we don't have to worry about what 
> > resource we are using for timers.
> 
> this will be useful for tickless stuff - but right now 'no APIC timer 
> irq for 5 seconds' is a 'must not happen'.
> 

I added the following patch:

Index: rt_linux_ernie/arch/i386/kernel/nmi.c
===================================================================
--- rt_linux_ernie.orig/arch/i386/kernel/nmi.c	2005-10-25 12:58:18.000000000 -0400
+++ rt_linux_ernie/arch/i386/kernel/nmi.c	2005-10-25 14:52:38.000000000 -0400
@@ -538,6 +538,8 @@
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
+		if (alert_counter[cpu] && !(alert_counter[cpu] % (nmi_hz)))
+			early_printk("nmi: jiffies=%ld\n",jiffies);
 		if (alert_counter[cpu] && !(alert_counter[cpu] % (5*nmi_hz))) {
 			int i;
 

And this is my output:

Adding 554200k swap on /dev/hda5.  Priority:-1 extents:1 across:554200k
EXT3 FS on hda1, internal journal
nmi: jiffies=-289143
nmi: jiffies=-272171
nmi: jiffies=-270269
nmi: jiffies=-268754
nmi: jiffies=-267630
NMI watchdog detected lockup on CPU#0 (50000/50000)

>>>> my comments

The above shows that the jiffies are incrementing. So what reason would
the apic timer be going off?  Also, this is just a UP machine.

<<<< end my comments

Pid: 1378, comm:                uname
EIP: 0060:[<c01f5592>] CPU: 0
EIP is at clear_user+0x32/0x50
 EFLAGS: 00010202    Not tainted  (2.6.14-rc5-rt6)
EAX: 00000000 EBX: 00000000 ECX: 0000009c EDX: 00000000
ESI: fffffff2 EDI: b7f10d90 EBP: cf055e28 DS: 007b ES: 007b
CR0: 8005003b CR2: b7f10750 CR3: 0f7d8000 CR4: 00000690
 [<c01010ba>] show_regs+0x14a/0x174 (36)
 [<c010ff13>] nmi_watchdog_tick+0x1a3/0x230 (56)
 [<c0104b2b>] default_do_nmi+0x6b/0x160 (52)
 [<c0104c5a>] do_nmi+0x2a/0x30 (20)
 [<c0103a46>] nmi_stack_correct+0x1d/0x22 (68)
 [<c018e813>] padzero+0x33/0x40 (16)
 [<c018eecd>] load_elf_interp+0x22d/0x2e0 (72)
 [<c018fca5>] load_elf_binary+0xb85/0xd30 (188)
 [<c016d70a>] search_binary_handler+0xaa/0x2b0 (44)
 [<c016da99>] do_execve+0x189/0x230 (36)
 [<c0101a92>] sys_execve+0x42/0xa0 (40)
 [<c0102f01>] syscall_call+0x7/0xb (-8116)
NMI Watchdog detected LOCKUP on CPU0, eip c01f5592, registers:
Modules linked in:
CPU:    0
EIP:    0060:[<c01f5592>]    Not tainted VLI
EFLAGS: 00010202   (2.6.14-rc5-rt6)
EIP is at clear_user+0x32/0x50
eax: 00000000   ebx: 00000000   ecx: 0000009c   edx: 00000000
esi: fffffff2   edi: b7f10d90   ebp: cf055e28   esp: cf055e20
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process uname (pid: 1378, threadinfo=cf054000 task=cfed9150 stack_left=7660 wor)Stack: cfc25120 cfc25594 cf055e38 c018e813 b7f10750 000008b0 cf055e80 c018eecd
       b7f10750 b7f0fcc0 cfc25080 00000003 00000812 00015cc0 cfc25060 b7efa000
       00000001 b7f107f8 00000006 cfc25088 b7f10750 cfc25560 0804b2ec cec5d720
Call Trace:
 [<c0103d3b>] show_stack+0xab/0xf0 (28)
 [<c0103f1a>] show_registers+0x17a/0x230 (56)
 [<c0104a6e>] die_nmi+0x9e/0xf0 (52)
 [<c010ff37>] nmi_watchdog_tick+0x1c7/0x230 (56)
 [<c0104b2b>] default_do_nmi+0x6b/0x160 (52)
 [<c0104c5a>] do_nmi+0x2a/0x30 (20)
 [<c0103a46>] nmi_stack_correct+0x1d/0x22 (68)
 [<c018e813>] padzero+0x33/0x40 (16)
 [<c018eecd>] load_elf_interp+0x22d/0x2e0 (72)
 [<c018fca5>] load_elf_binary+0xb85/0xd30 (188)
 [<c016d70a>] search_binary_handler+0xaa/0x2b0 (44)
 [<c016da99>] do_execve+0x189/0x230 (36)
 [<c0101a92>] sys_execve+0x42/0xa0 (40)
 [<c0102f01>] syscall_call+0x7/0xb (-8116)
Code: 7c 24 04 8b 7d 08 89 1c 24 8b 4d 0c a1 48 e4 33 c0 89 fb 01 cb 19 d2 39 5
console shuts up ...

-- Steve


