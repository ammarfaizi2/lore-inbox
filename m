Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311026AbSCMTJ2>; Wed, 13 Mar 2002 14:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311030AbSCMTJW>; Wed, 13 Mar 2002 14:09:22 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:55782 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S311026AbSCMTJC>;
	Wed, 13 Mar 2002 14:09:02 -0500
Date: Wed, 13 Mar 2002 20:11:17 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Ingo Molnar <mingo@elte.hu>, "Maciej W. Rocycki" <macro@ds2.pg.gda.pl>
cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
        Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Subject: Severe IRQ problems on Foster (P4 Xeon) system
Message-ID: <Pine.LNX.4.33.0203131912140.1477-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ingo and Maciej, everybody,

I am contacting you as the Linux experts for (IO)-Apics.

We are currrently testing our new Foster (Pentium 4 Xeon with HT
technology) machines and facing really weird problems particularly
with the timer interrupt. The machine I am talking about has 2 physical,
i.e. 4 logical CPUs. It has 4 dual-port Intel Pro/100 network cards
built in.

** Before you read further: I cannot 100% exclude a hardware/BIOS
   error yet, but something Linux does must have to do with it **

First of all, we see that virtually 100% of all IRQs are handled by CPU 0.
I have seen this reported a number of times before. I guess it can become
a severe performance problem in IRQ-intensive situations.

But much worse, we encounter the following problem:

- sporadically the timer interrupt becomes disabled sometime after
  booting (typically around X startup).

- This is caused by a "junk" value that appears in the mask register
  of the master 8259a PIC (the system is working in ExtINT mode for timer
  IRQs.

- The system can be "healed" by rewriting the correct value into register
  0x21.

- We see with a bus logic analyzer that the junk value is read after the
  completely legal mask 0xfa was last written to the register.
  However according to my understanding that register should not be
  written after initialization, because IRQ are disabled through the
  APIC, not the 8259a?

- The junk value always appears after CPU 1 gets a timer interrupt.
  As stated above, this hardly happens at all, but CPU 1 seems to get
  2-6 timer interrupts during each boot. These are all consecutive,
  and starting with the second one the "junk" value is found in io-port
  0x21.

Here is an excerpt from my syslog demonstrating this (I put some printk's
in do_IRQ, printk is triggered if either a CPU other than 0 serves the
IRQ or if the value in port 0x21 != 0xfa, lines ending):

                                 jiffies | 0x21        desc->status|
                                         V   V                     V
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8931: fa, CPU 1 IRQ 0 status 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8931: fa, CPU 1 IRQ 0 stat 5
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8932: fa, CPU 1 IRQ 0 status 1  <==
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8932: 07, CPU 1 IRQ 0 stat 5    <==
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8934: 07, CPU 1 IRQ 0 status 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8934: 07, CPU 0 IRQ 0 stat 0    <==
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8935: 07, CPU 1 IRQ 0 stat 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8935: 07, CPU 1 IRQ 0 status 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8936: 07, CPU 1 IRQ 0 stat 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8936: 07, CPU 1 IRQ 0 status 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8937: 07, CPU 1 IRQ 0 stat 0
Mar 12 16:51:40 pdb0374c kernel: IRQ1: 8937: 07, CPU 0 IRQ 28 stat 0
Mar 12 16:51:40 pdb0374c last message repeated 42 times
[ no more timer interrupts below here ].

Lines ending in "status" represent entry in do_IRQ(), "stat" represents
exit from do_IRQ() (label "out:").

Where the <== arrows are, it seems that CPU 0 and 1 are executing the
timer IRQ in parallel (!). The entry to do_IRQ for CPU 0 is not listed
because my conditions for printk were not met.

Very strange, too: After the PIC is masked, we see 4(!) more timer
interrupts - where do they come from ?

My guess: We are in a situation where CPU 0 is overwhelmed by interrupts
from the 5 network interfaces in this machine. This leads to timer
interrupts "piling up", and eventually an interrupt is even delivered
to CPU 1. If this happens to occur simultaneously with CPU 0, we get
some sort of race condition.

Our PCI bus protocol analysis gives another hint:

It seems that the problem occurs in this code fragment from time.c:

#ifdef CONFIG_X86_IO_APIC
	if (timer_ack) {
		/*
		 * Subtle, when I/O APICs are used we have to ack timer IRQ
		 * manually to reset the IRR bit for do_slow_gettimeoffset().
		 * This will also deassert NMI lines for the watchdog if run
		 * on an 82489DX-based system.
		 */
		spin_lock(&i8259A_lock);
		outb(0x0c, 0x20);
		/* Ack the IRQ; AEOI will end it automatically. */   <==
		inb(0x20);
		spin_unlock(&i8259A_lock);
	}
#endif

The above fragment is executed ~50us after the last write of the (correct)
value 0xfa to port 0x21.

Where the <== arrow is, the analyzer clearly shows the outb (0x0c, 0x20)
operation. After that, we see strange cycles for ~70us (probably special
cycles for arbitration, definitely no valid data transfers). The very next bus
operation is a read on port 0x21 that reveals the junk value 0x07! The
inb(0x20) call is not captured in our protocol, it must occur long after
the error. (We saw normal execution of the above code fragment where
there is ~1us between the outb and inb, where it is >120us here).

That's our state of insight so far. Any hints are very welcome.

Martin

PS We were testing with RedHat's 2.4.9-21 and SuSE's 2.4.16 kernel.
   AFAICS, there are no significant changes between these and newer
   kernels wrt APIC handling. The error occurs only once in a few
   hours, so our testing possibilities are limited by time.
   And yes, we were using Intel's e100.o driver for the ethernet
   boards. But the driver is not to blame, the problem occurs even
   if no driver is loaded for the cards at all.

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





