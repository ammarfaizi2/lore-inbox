Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUHWUGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUHWUGl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUHWUEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:04:39 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:16291 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S266566AbUHWSpo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:45:44 -0400
Subject: Re: 2.6.8.1-mm IRQ routing problems
From: Alexander Nyberg <alexn@telia.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Andrew Morton <akpm@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200408231016.36318.bjorn.helgaas@hp.com>
References: <1093088008.777.13.camel@boxen>
	 <20040822180911.22bbbc96.akpm@osdl.org> <1093264936.834.1.camel@boxen>
	 <200408231016.36318.bjorn.helgaas@hp.com>
Content-Type: text/plain
Message-Id: <1093286742.868.3.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 23 Aug 2004 20:45:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 18:16, Bjorn Helgaas wrote:
> On Monday 23 August 2004 6:42 am, Alexander Nyberg wrote:
> > On Mon, 2004-08-23 at 03:09, Andrew Morton wrote:
> > > Alexander Nyberg <alexn@telia.com> wrote:
> > > >
> > > > Using 2.6.8.1-mm3 I ran into some problems on x86_64. This
> > > > only happens when fsck runs at bootup because in my case
> > > > of the max-mount-count being reached (I use ext3). Booting 
> > > > with pci=routeirq makes problem go away.
> > > > 
> > > > Do I win the weird problem prize?
> > > 
> > > I think this was fixed in -mm4.  Please retest.
> > 
> > Still happens in -mm4.
> 
> Can you double-check this, and perhaps post the dmesg for the 2.6.8.1-mm4
> attempt?  It still looks very much like the problem Randy fixed here:
> 
>     http://marc.theaimsgroup.com/?l=linux-kernel&m=109313574928853&w=2
> 
> I just checked, and Randy's patch is indeed in 2.6.8.1-mm4.  If the oops
> still occurs there, it must be a different problem, and the dmesg might
> help diagnose it.
> 

Hi,

This fixes things for me.

Signed-off-by: Alexander Nyberg <alexn@telia.com>

--- linux-2.6.7/arch/x86_64/kernel/io_apic.c_orig	2004-08-23 18:32:10.000000000 +0200
+++ linux-2.6.7/arch/x86_64/kernel/io_apic.c	2004-08-23 20:42:33.236703256 +0200
@@ -80,7 +80,7 @@ int vector_irq[NR_VECTORS] = { [0 ... NR
  * shared ISA-space IRQs, so we have to support them. We are super
  * fast in the common case, and fast for shared ISA-space IRQs.
  */
-static void __init add_pin_to_irq(unsigned int irq, int apic, int pin)
+static void add_pin_to_irq(unsigned int irq, int apic, int pin)
 {
 	static int first_free_entry = NR_IRQS;
 	struct irq_pin_list *entry = irq_2_pin + irq;
@@ -656,11 +656,7 @@ static inline int IO_APIC_irq_trigger(in
 /* irq_vectors is indexed by the sum of all RTEs in all I/O APICs. */
 u8 irq_vector[NR_IRQ_VECTORS] = { FIRST_DEVICE_VECTOR , 0 };
 
-#ifdef CONFIG_PCI_MSI
 int assign_irq_vector(int irq)
-#else
-int __init assign_irq_vector(int irq)
-#endif
 {
 	static int current_vector = FIRST_DEVICE_VECTOR, offset = 0;
 





