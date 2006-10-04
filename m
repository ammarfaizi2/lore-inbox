Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161511AbWJDQCd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161511AbWJDQCd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161515AbWJDQCd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:02:33 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51847 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161511AbWJDQCc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:02:32 -0400
Date: Wed, 4 Oct 2006 09:02:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>,
       Jim Gettys <jg@laptop.org>, John Stultz <johnstul@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
Subject: Re: [patch] clockevents: drivers for i386, fix #2
Message-Id: <20061004090205.9c29f5bf.akpm@osdl.org>
In-Reply-To: <1159960776.1386.244.camel@localhost.localdomain>
References: <20061001225720.115967000@cruncher.tec.linutronix.de>
	<20061002210053.16e5d23c.akpm@osdl.org>
	<20061003084729.GA24961@elte.hu>
	<20061003103503.GA6350@elte.hu>
	<20061003203620.d85df9c6.akpm@osdl.org>
	<20061004064620.GA22364@elte.hu>
	<20061004003228.98ec3b39.akpm@osdl.org>
	<20061004075540.GA31415@elte.hu>
	<20061004011544.d49308de.akpm@osdl.org>
	<20061004105315.GA24940@elte.hu>
	<1159960776.1386.244.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 04 Oct 2006 13:19:35 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2006-10-04 at 12:53 +0200, Ingo Molnar wrote:
> > there's one material difference we just found: in the !hres case we'll 
> > do the timer IRQ handling mostly from the lapic vector - while in 
> > mainline we do it from the irq0 vector. So, how does your 
> > /proc/interrupts look like? How frequently does LOC increase, and how 
> > frequently does IRQ 0 increase?

sony:/home/akpm> cat /proc/interrupts ; sleep 1 ; cat /proc/interrupts
           CPU0       
  0:      39256   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  8:          1   IO-APIC-edge      rtc
  9:        160   IO-APIC-fasteoi   acpi
 11:          3   IO-APIC-edge      sonypi
 12:        107   IO-APIC-edge      i8042
 14:          5   IO-APIC-edge      libata
 15:          0   IO-APIC-edge      libata
 16:          1   IO-APIC-fasteoi   yenta, uhci_hcd:usb4
 17:        246   IO-APIC-fasteoi   ohci1394, eth0
 18:       5759   IO-APIC-fasteoi   libata
 19:          3   IO-APIC-fasteoi   ipw2200
 20:        710   IO-APIC-fasteoi   HDA Intel, uhci_hcd:usb3
 21:          2   IO-APIC-fasteoi   ehci_hcd:usb1
 22:          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb5
NMI:          0 
LOC:       3131 
ERR:          0
MIS:          0
           CPU0       
  0:      39519   IO-APIC-edge      timer
  1:          8   IO-APIC-edge      i8042
  8:          1   IO-APIC-edge      rtc
  9:        160   IO-APIC-fasteoi   acpi
 11:          3   IO-APIC-edge      sonypi
 12:        107   IO-APIC-edge      i8042
 14:          5   IO-APIC-edge      libata
 15:          0   IO-APIC-edge      libata
 16:          1   IO-APIC-fasteoi   yenta, uhci_hcd:usb4
 17:        248   IO-APIC-fasteoi   ohci1394, eth0
 18:       5759   IO-APIC-fasteoi   libata
 19:          3   IO-APIC-fasteoi   ipw2200
 20:        715   IO-APIC-fasteoi   HDA Intel, uhci_hcd:usb3
 21:          2   IO-APIC-fasteoi   ehci_hcd:usb1
 22:          0   IO-APIC-fasteoi   uhci_hcd:usb2, uhci_hcd:usb5
NMI:          0 
LOC:       3134 
ERR:          0
MIS:          0

> > (meanwhile we'll fix and restore things so that it matches mainline 
> > behavior.)
> 
> Andrew, does the patch below fix your problem ?
> 
> You should see the same weird behaviour when you run a plain -mm3 with
> CONFIG_SMP=y on that box. This moves update_process_times() to the lapic
> too.
> 	tglx
> 
> 
> Index: linux-2.6.18-mm3/arch/i386/kernel/apic.c
> ===================================================================
> --- linux-2.6.18-mm3.orig/arch/i386/kernel/apic.c	2006-10-04 13:02:35.000000000 +0200
> +++ linux-2.6.18-mm3/arch/i386/kernel/apic.c	2006-10-04 12:59:06.000000000 +0200
> @@ -84,7 +84,9 @@ static void lapic_timer_setup(enum clock
>  static struct clock_event_device lapic_clockevent = {
>  	.name = "lapic",
>  	.capabilities = CLOCK_CAP_NEXTEVT | CLOCK_CAP_PROFILE
> +#ifdef CONFIG_SMP
>  			| CLOCK_CAP_UPDATE,
> +#endif
>  	.shift = 32,
>  	.set_mode = lapic_timer_setup,
>  	.set_next_event = lapic_next_event,

that (after a tweak to make it compile) fixes it.   What's it do?

