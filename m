Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266995AbRHBCQx>; Wed, 1 Aug 2001 22:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRHBCQo>; Wed, 1 Aug 2001 22:16:44 -0400
Received: from quattro.sventech.com ([205.252.248.110]:12559 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S266995AbRHBCQc>; Wed, 1 Aug 2001 22:16:32 -0400
Date: Wed, 1 Aug 2001 22:16:41 -0400
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
        "Nadav Har'El" <nyh@math.technion.ac.il>, linux-kernel@vger.kernel.org,
        agmon@techunix.technion.ac.il
Subject: Re: SMP possible with AMD CPUs?
Message-ID: <20010801221640.H784@sventech.com>
In-Reply-To: <Pine.LNX.4.33.0108011318120.19875-100000@twin.uoregon.edu> <E15S6NY-00086O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E15S6NY-00086O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 02, 2001 at 01:30:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 02, 2001, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > the combination of the athlon mp and the amd 761 chipset will do
> > multiprocessor support without trouble... you will want to use 2.4 becuase
> > lots of devices on the boards  aren't supported by 2.2...
> 
> Athlon SMP will actually not always work with 2.2. Quite a few folks
> reported problems and patches for 2.2.20pre fixes that and broke other
> stuff so got reverted.
> 
> 2.4 seems to do the job nicely

I sent you a new patch which fixes the problem.

Here's the original with the new patch as well.

JE


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="athlon-smp-1.patch"

Index: linux/arch/i386/kernel/io_apic.c
diff -u linux/arch/i386/kernel/io_apic.c:1.2.12.2 linux/arch/i386/kernel/io_apic.c:1.2.12.3
--- linux/arch/i386/kernel/io_apic.c:1.2.12.2	Thu Sep 28 01:20:08 2000
+++ linux/arch/i386/kernel/io_apic.c	Tue Apr  3 15:37:29 2001
@@ -205,8 +205,6 @@
  * We disable IO-APIC IRQs by setting their 'destination CPU mask' to
  * zero. Trick by Ramesh Nalluri.
  */
-DO_ACTION( disable, 1, &= 0x00ffffff, io_apic_sync(entry->apic))/* destination = 0x00 */
-DO_ACTION( enable,  1, |= 0xff000000, )				/* destination = 0xff */
 DO_ACTION( mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
 DO_ACTION( unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
 
@@ -649,7 +647,7 @@
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = 1;			/* logical delivery */
 		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 0;	/* but no route */
+		entry.dest.logical.logical_dest = 0xff;	/* but no route */
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {
@@ -1066,13 +1064,10 @@
 static void enable_edge_ioapic_irq(unsigned int irq)
 {
 	self_IPI(irq);
-	enable_IO_APIC_irq(irq);
+	unmask_IO_APIC_irq(irq);
 }
 
-static void disable_edge_ioapic_irq(unsigned int irq)
-{
-	disable_IO_APIC_irq(irq);
-}
+static void disable_edge_ioapic_irq(unsigned int irq) { /* nothing */ }
 
 /*
  * Starting up a edge-triggered IO-APIC interrupt is
@@ -1298,7 +1293,7 @@
 #endif
 	pin1 = find_timer_pin(mp_INT);
 	pin2 = find_timer_pin(mp_ExtINT);
-	enable_IO_APIC_irq(0);
+	unmask_IO_APIC_irq(0);
 	if (!timer_irq_works()) {
 
 		if (pin1 != -1)

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="athlon-smp-2.patch"

Index: linux/arch/i386/kernel/io_apic.c
diff -u linux/arch/i386/kernel/io_apic.c:1.2.12.3 linux/arch/i386/kernel/io_apic.c:1.2.12.4
--- linux/arch/i386/kernel/io_apic.c:1.2.12.3	Tue Apr  3 15:37:29 2001
+++ linux/arch/i386/kernel/io_apic.c	Thu May 17 10:30:20 2001
@@ -204,6 +204,8 @@
 /*
  * We disable IO-APIC IRQs by setting their 'destination CPU mask' to
  * zero. Trick by Ramesh Nalluri.
+ * Not anymore. This causes problems on some IO-APIC's, notably AMD 760MP's
+ * So we do it a more 2.4 kind of way now which should be safer -jerdfelt
  */
 DO_ACTION( mask,    0, |= 0x00010000, io_apic_sync(entry->apic))/* mask = 1 */
 DO_ACTION( unmask,  0, &= 0xfffeffff, )				/* mask = 0 */
@@ -646,8 +648,8 @@
 
 		entry.delivery_mode = dest_LowestPrio;
 		entry.dest_mode = 1;			/* logical delivery */
-		entry.mask = 0;				/* enable IRQ */
-		entry.dest.logical.logical_dest = 0xff;	/* but no route */
+		entry.mask = 1;				/* disable IRQ */
+		entry.dest.logical.logical_dest = 0xff;
 
 		idx = find_irq_entry(apic,pin,mp_INT);
 		if (idx == -1) {

--AhhlLboLdkugWU4S--
