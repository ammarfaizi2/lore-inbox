Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264354AbTLEUSQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 15:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264356AbTLEUSQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 15:18:16 -0500
Received: from postfix3-1.free.fr ([213.228.0.44]:45793 "EHLO
	postfix3-1.free.fr") by vger.kernel.org with ESMTP id S264354AbTLEUSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 15:18:11 -0500
Date: Fri, 5 Dec 2003 21:18:12 +0100
From: cheuche+lkml@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re: Catching NForce2 lockup with NMI watchdog
Message-ID: <20031205201812.GA10538@localnet>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCB9B7AA2CAB7F418919D7B59EE45BAF49F877@mail-sc-6.nvidia.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 11:11:39AM -0800, Allen Martin wrote:
> 
> Likely the root of the problem has to do with the way the Linux kernel is
> using the ACPI methods to setup the interrupts which is different from win
> 9x/2k/XP.  I can help track this down, unfortunately so far I've been unable
> to reproduce the hangs on any of the boards I have.
> 
With a little patch in arch/i386/kernel/mpparse.c in the acpi section, I
managed to get the timer interrupt back on IO-APIC-edge, maybe the nmi
watchdog could work with the ioapic then ?

With the patch, the interrupt flood on IRQ7 I reported on the nvidia2 
lockups thread also disappeared, but then I noticed something odd when
there is ide activity :
With amd74xx/nforce driver, I can almost instantly hang the machine
(nothing new there), but with the generic ide driver and the IO load a
cat /dev/hda > /dev/null can do, timer interrupts don't seem to get
through easily. I first thought the box freezed but I realized the
software cursor was blinking *very* slowly. In fact 1 second for the
kernel took about 12 seconds. Stopping the IO load on ide and
everything seems back to normal.

There may be something wrong with the timer using apic and the
amd/nforce ide driver does not handle this situation that should not
occur and juste freezes. This is pure speculation of course.

I looked in mpparse.c because this is where I noticed the difference
about the timer interrupt setup with apic between 2.4.22 and 2.4.23.
However it is in the path of ACPI source interrupt override, maybe the
modification I made just overrides the override (sigh).

*Disclaimer*
The modification is certainly not the proper fix, does a wrong thing,
but it shows an interesting behavior, especially it fixed the
interrupt flood on IRQ7 I and some others are able to see.

Here the little patch of arch/i386/kernel/mpparse.c I used :

--- mpparse.c.old       2003-12-05 14:42:10.000000000 +0100
+++ mpparse.c   2003-12-05 14:43:41.000000000 +0100
@@ -962,7 +962,8 @@
	*/
	for (i = 0; i < mp_irq_entries; i++) {
		if ((mp_irqs[i].mpc_dstapic == intsrc.mpc_dstapic)
-			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)) {
+			&& (mp_irqs[i].mpc_srcbusirq == intsrc.mpc_srcbusirq)
+			&& (mp_irqs[i].mpc_irqtype == intsrc.mpc_irqtype)) {
			mp_irqs[i] = intsrc;
			found = 1;
			break;



I hope this helps,

Mathieu
