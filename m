Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTDQUmk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 16:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDQUmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 16:42:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:13542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262656AbTDQUmc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 16:42:32 -0400
Date: Thu, 17 Apr 2003 13:53:48 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Ottavio Campana <ottavio@campana.vi.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: noapic and usb, linux 2.4.20
Message-Id: <20030417135348.7d274fa8.rddunlap@osdl.org>
In-Reply-To: <20030417200506.GA20466@campana.vi.it>
References: <20030417200506.GA20466@campana.vi.it>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Apr 2003 22:05:06 +0200 Ottavio Campana <ottavio@campana.vi.it> wrote:

| I'm trying to  have usb working on my  pc, based on a dual  athlon and a
| motherboard GA-7DPXDW with linux 2.4.20 with  the patch for xfs from sgi
| and the patch for the sensors.
| 
| I was reading the linux-usb faq and I found: 
| > Sometimes a  BIOS fix will be  available for your motherboard,  and in
| > other cases  a more recent  kernel will have a  Linux fix. You  may be
| > able to  work around this  by passing the  noapic boot option  to your
| > kernel,  or (when  you're using  an add-in  PCI card)  moving the  USB
| > adapter to some  other PCI slot. If you're using  a current kernel and
| > BIOS,  report this  problem  to the  Linux-kernel  mailing list,  with
| > details about your motherboard and BIOS.
| 
| So I'm  writing hoping  to be  helpful. Usb  works, but  I have  to pass
| noapic to  the kernel.  Otherwise I get  "device not  accepting address"
| when I plug a device in the usb port. The motherboard has been bought in
| september. I remember the older mobos  had the southbridge b1, which had
| a faulty usb. My mobo has got the southbridge b2, which works.
| 
| Is there anything useful I can do?
| 
| Can you please explain me what "noapic" does? I think it changes the way
| interrupts are  handled, but I'm  not sure. Do  I miss something  when I
| pass noapic to the kernel?

It tells the kernel not to use the IO APIC and APIC devices for interrupt
routing, so the kernel drops back to the legacy PC interrupt controller
devices instead.  A small SMP machine (or UP with IO APIC(s)) would
usually only have one IO APIC, which typically has 24 interrupt lines,
while the PIC (Programmable Interrupt Controller) device has 8 interrupt lines,
and a current/modern system has 2 of those.  Thus using "noapic" (typically)
reduces the number of available device interrupt lines from 24 to 15 (15 since
8 PIC2 interrupt lines feed into one of the PIC1 interrupt lines, called
cascading) [all this for a low-end/small SMP system].

Having more interrupt lines allows interrupts to be non-shared.
Shared interrupts usually work OK (with some restrictions), but they
always cause a little bit more device driver overhead because for any one
shared interrupt, all of its device drivers are called whenever that
interrupt occurs, so that they can determine if they need to handle their
device(s).

I don't know of any measurements that have been done with apic vs. noapic.
My opinion is that in some heavy workloads it would be possible to see
some small differences in the results.  In a desktop workload, you wouldn't
see any differences.

As far as USB interrupt routing with APIC support, there was a patch a
few days ago on the acpi-devel mailing list that might fix the problem.
It's in this archive:
http://sourceforge.net/mailarchive/forum.php?thread_id=1976718&forum_id=6102

You can try it and see if it helps you.

(I can forward it to you if you need it that way.)

Please let us know how it goes.

--
~Randy
