Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263425AbUCTOko (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263427AbUCTOko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:40:44 -0500
Received: from gizmo10ps.bigpond.com ([144.140.71.20]:10180 "HELO
	gizmo10ps.bigpond.com") by vger.kernel.org with SMTP
	id S263425AbUCTOki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:40:38 -0500
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: linux-kernel@vger.kernel.org
Subject: apic timer interrupt re-entrancy on UP - waste of cpu time or worse?
Date: Sun, 21 Mar 2004 00:42:42 +1000
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403210042.42086.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2.4.26 (1000 HZ patched) I added code to the apic timer
interrupt to see if it tried to re-enter itself prior to completion.

I remember hooking an oscilloscope into this area of code late last year
looking for the cause of nforce2 lockups and seeing function take up to 0.5ms
on occasion.

--------------new code start--------
static int apic_timer_busy;
-------------end code fragment--------

void smp_apic_timer_interrupt(struct pt_regs * regs)
{
	int cpu = smp_processor_id();
	/*
	 * the NMI deadlock-detector uses this.
	 */
	apic_timer_irqs[cpu]++;
	/*
	 * NOTE! We'd better ACK the irq immediately,
	 * because timer handling can be slow.
	 */
	ack_APIC_irq();
	
	--------------new code start--------
	/* stop re-entrancy - too busy to handle properly*/
	preempt_disable();
	if( apic_timer_busy ) {/* non-reentrant? */
		printk( KERN_INFO "APIC TIMER WARNING: Attempted Re-entrant, Bailing!\n");
		preempt_enable();
		return;
	}
	apic_timer_busy++;
	preempt_enable();
	--------------end code fragment--------

	/*
	 * update_process_times() expects us to have done irq_enter().
	 * Besides, if we don't timer interrupts ignore the global
	 * interrupt lock, which is the WrongThing (tm) to do.
	 */
	irq_enter(cpu, 0);
	smp_local_timer_interrupt(regs);
	irq_exit(cpu, 0);
	if (softirq_pending(cpu))
		do_softirq();

	-------------new code start--------
	apic_timer_busy--;
	-------------end code fragment---------

}

I observe the following in log.
i810_audio: AC'97 codec 0, DAC map configured, total channels = 6
i810_audio: setting clocking to 48648
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
APIC TIMER WARNING: Attempted Re-entrant, Bailing!
0: nvidia: loading NVIDIA Linux x86 nvidia.o Kernel Module  1.0-4496  Wed Jul 16 19:03:09 PDT 2003
0: NVRM: AGPGART: unable to retrieve symbol table
Linux video capture interface: v1.00

I have also seen messages after serial module load.
Appears with preempt on or off.
I am not submitting the above code for consideration as a patch nor am I 
claiming it as the correct way to handle the issue.

I just think it may be worthy of discussion given postings lately regarding
early interrupt acknowledgement and preempt's capability of preventing lengthy
tasks from running to completion.

For starters from my observations the timing at which the messages
print roughly seem to correlate with my nforce2 lockups points during boot when
my machines are unpatched for it. Helps explain why lockups are rare on 100HZ.

Ross.

