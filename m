Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbTHYBOs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 21:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261292AbTHYBOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 21:14:48 -0400
Received: from coffee.creativecontingencies.com ([210.8.121.66]:19933 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S261241AbTHYBOp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 21:14:45 -0400
Message-Id: <5.1.0.14.2.20030825110731.00bd1248@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 25 Aug 2003 11:13:03 +1000
To: Thomas Schlichter <schlicht@uni-mannheim.de>
From: Peter Lieverdink <cafuego@cc.com.au>
Subject: Re: 2.6.0-test4: ACPI breaks IDE/USB
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308242344.50883.schlicht@uni-mannheim.de>
References: <3F492601.7090405@comcast.net>
 <1061613751.897.12.camel@kahlua>
 <3F478636.3060002@cox.net>
 <3F492601.7090405@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Your patch works beautifully. 'acpi=nopci' previously caused IDE to work 
fine, but made the kernel not detect USB and network devices. With your 
patch it sees all peripherals AND acpi is available for the cpu. I wonder 
if it would be accepted into the kernel as a patch to workaround buggy acpi 
bioses.

Thanks heaps!

- Peter.
--
At 23:44 24/08/2003 +0200, you wrote:
>Am Sunday 24 August 2003 22:54 schrieb David van Hoose:
> > Kevin P. Fleming wrote:
> > > Peter Lieverdink wrote:
> > >> When I enable ACPI on 2.6.0-test4 (also on 2.6.0-test3-*), the kernel no
> > >> longer recognises my IDE controller and drops down to PIO mode for
> > >> harddisk access. Additionally, USB devices don't get detected.
> > >
> > > I'm running -test4 here with ACPI and have no trouble with USB devices.
> >
> > I'm running test4 here with ACPI and have no USB following a call trace
> > with "IRQ 20: nobody cared". ACPI seems to make odd reports. I've been
> > having this problem since 2.5.70'ish. Posted numerous times, but nobody
> > seems to care about it. I also have a PS/2 mouse detection when I have
> > no mice attached to my system.
> >
> > >> The system is an Athlon 2400+ on a Gibabyte GA-7VAXP mainboard. (KT400)
> > >
> > > My system is an Athlon 1000 on an MSI KT266-based board.
> >
> > I have a Pentium 4 2.53 GHz on a Asus P4S8X mainboard.
> >
> > -David
> >
> > PS. dmesg is attached with ACPI debug and USB debug enabled.
>
>I had similar problems with my Epox 8K9A (KT400) Board.
>
>If I wanted to use my USB ports I had to boot wiht 'acpi=off'. But with the
>patch attached it is possible for me to boot with 'pci=noacpi'. It has the
>advantage that ACPI stays enabled...
>
>You are free to give it a try...
>
>   Thomas
>--- linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c.orig Sat Aug 23 
>01:59:02 2003
>+++ linux-2.6.0-test4/arch/i386/kernel/acpi/boot.c      Sat Aug 23 
>16:39:57 2003
>@@ -41,6 +41,7 @@
>  #define PREFIX                 "ACPI: "
>
>  extern int acpi_disabled;
>+extern int acpi_irq;
>  extern int acpi_ht;
>
>  int acpi_lapic = 0;
>@@ -407,7 +408,7 @@
>         * If MPS is present, it will handle them,
>         * otherwise the system will stay in PIC mode
>         */
>-       if (acpi_disabled) {
>+       if (acpi_disabled || !acpi_irq) {
>                 return 1;
>          }
>
>@@ -450,14 +451,13 @@
>         acpi_irq_model = ACPI_IRQ_MODEL_IOAPIC;
>
>         acpi_ioapic = 1;
>-#endif /*CONFIG_X86_IO_APIC*/
>
>  #ifdef CONFIG_X86_LOCAL_APIC
>-       if (acpi_lapic && acpi_ioapic) {
>-               smp_found_config = 1;
>-               clustered_apic_check();
>-       }
>+       smp_found_config = 1;
>+       clustered_apic_check();
>  #endif
>+
>+#endif /*CONFIG_X86_IO_APIC*/
>
>         return 0;
>  }
>--- linux-2.6.0-test4/arch/i386/kernel/setup.c.orig     Sat Aug 23 
>01:55:38 2003
>+++ linux-2.6.0-test4/arch/i386/kernel/setup.c  Sat Aug 23 16:34:21 2003
>@@ -71,6 +71,7 @@
>  EXPORT_SYMBOL(acpi_disabled);
>
>  #ifdef CONFIG_ACPI_BOOT
>+       int acpi_irq __initdata = 1;    /* enable IRQ */
>         int acpi_ht __initdata = 1;     /* enable HT */
>  #endif
>
>@@ -542,6 +543,11 @@
>                 else if (!memcmp(from, "acpi=ht", 7)) {
>                         acpi_ht = 1;
>                         if (!acpi_force) acpi_disabled = 1;
>+               }
>+
>+               /* "pci=noacpi" disables ACPI interrupt routing */
>+               else if (!memcmp(from, "pci=noacpi", 10)) {
>+                       acpi_irq = 0;
>                 }
>
>  #ifdef CONFIG_X86_LOCAL_APIC

