Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVGSLLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVGSLLN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 07:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261963AbVGSLLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 07:11:13 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:16479 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261961AbVGSLLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 07:11:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.de;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Message-Id;
  b=12gPlAheHUb6XBa9SSE1qA8h/bDUl3HDJTxAfK86wV4ADmHeQScsJ9yRMMeCGOXa4vWkOXdurimGBZQgFJwM++CUGzYxxhHBdUXPiAzKurZOlZ/bjGSeVGE4jG/EGYExqiwXv0J1VQp+eTdi9tk1/GC4CROGfc0TxkcA7zFTqYw=  ;
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Realtime Preemption, 2.6.12, Beginners Guide?
Date: Tue, 19 Jul 2005 13:14:23 +0200
User-Agent: KMail/1.8.1
Cc: "K.R. Foley" <kr@cybsft.com>, Chuck Harding <charding@llnl.gov>,
       William Weston <weston@sysex.net>,
       Linux Kernel Discussion List <linux-kernel@vger.kernel.org>,
       Gene Heskett <gene.heskett@verizon.net>
References: <200507061257.36738.s0348365@sms.ed.ac.uk> <20050716171537.GB16235@elte.hu> <200507171407.20373.annabellesgarden@yahoo.de>
In-Reply-To: <200507171407.20373.annabellesgarden@yahoo.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_QCO3C1yQ7QLko0w"
Message-Id: <200507191314.24093.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_QCO3C1yQ7QLko0w
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Sonntag, 17. Juli 2005 14:07 schrieb Karsten Wiese:
> Am Samstag, 16. Juli 2005 19:15 schrieb Ingo Molnar:
> > 
> > * Karsten Wiese <annabellesgarden@yahoo.de> wrote:
> > 
> > > Have I corrected the other path of ioapic early initialization, which 
> > > had lacked virtual-address setup before ioapic_data[ioapic] was to be 
> > > filled in -51-28? Please test attached patch on top of -51-29 or 
> > > later. Also on Systems that liked -51-28.
> > 
> > thanks - i've applied it to my tree and have released the -51-31 patch.  
> > It looks good on my testboxes.
> > 
> Found another error:
> the ioapic cache isn't fully initialized in -51-31's ioapic_cache_init().
> <snip>
> 
and another: some NULL-pointers are used in -51-31 instead of ioapic_data[0].
Please apply attached patch on top of -51-31. It includes yesterday's fix.

    Karsten

--Boundary-00=_QCO3C1yQ7QLko0w
Content-Type: text/x-diff;
  charset="utf-8";
  name="io_apic-RT-51-31.2"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-51-31.2"

--- linux-2.6.12-RT-51-31/arch/i386/kernel/io_apic.c	2005-07-17 12:40:35.000000000 +0200
+++ linux-2.6.12-RT/arch/i386/kernel/io_apic.c	2005-07-19 12:53:00.000000000 +0200
@@ -158,7 +158,7 @@
 static void __init ioapic_cache_init(struct ioapic_data_struct *ioapic)
 {
 	int reg;
-	for (reg = 0; reg < (ioapic->nr_registers + 10); reg++)
+	for (reg = 0; reg < (0x10 + 2 * ioapic->nr_registers); reg++)
 		ioapic->cached_val[reg] = __raw_io_apic_read(ioapic, reg);
 }
 # endif
@@ -1396,8 +1396,8 @@
 	 * Add it to the IO-APIC irq-routing table:
 	 */
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11+2*pin, *(((int *)&entry)+1));
-	io_apic_write(0, 0x10+2*pin, *(((int *)&entry)+0));
+	io_apic_write(ioapic_data[0], 0x11+2*pin, *(((int *)&entry)+1));
+	io_apic_write(ioapic_data[0], 0x10+2*pin, *(((int *)&entry)+0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	enable_8259A_irq(0);
@@ -2087,25 +2087,25 @@
  * races.
  */
 static struct hw_interrupt_type ioapic_edge_type = {
-	.typename 	= "IO-APIC-edge",
+	.typename	= "IO-APIC-edge",
 	.startup 	= startup_edge_ioapic,
 	.shutdown 	= shutdown_edge_ioapic,
 	.enable 	= enable_edge_ioapic,
 	.disable 	= disable_edge_ioapic,
 	.ack 		= ack_edge_ioapic,
 	.end 		= end_edge_ioapic,
-	.set_affinity 	= set_ioapic_affinity,
+	.set_affinity	= set_ioapic_affinity,
 };
 
 static struct hw_interrupt_type ioapic_level_type = {
-	.typename 	= "IO-APIC-level",
+	.typename	= "IO-APIC-level",
 	.startup 	= startup_level_ioapic,
 	.shutdown 	= shutdown_level_ioapic,
 	.enable 	= enable_level_ioapic,
 	.disable 	= disable_level_ioapic,
 	.ack 		= mask_and_ack_level_ioapic,
 	.end 		= end_level_ioapic,
-	.set_affinity 	= set_ioapic_affinity,
+	.set_affinity	= set_ioapic_affinity,
 };
 
 static inline void init_IO_APIC_traps(void)
@@ -2169,13 +2169,13 @@
 static void end_lapic_irq (unsigned int i) { /* nothing */ }
 
 static struct hw_interrupt_type lapic_irq_type = {
-	.typename 	= "local-APIC-edge",
-	.startup 	= NULL, /* startup_irq() not used for IRQ0 */
-	.shutdown 	= NULL, /* shutdown_irq() not used for IRQ0 */
-	.enable 	= enable_lapic_irq,
-	.disable 	= disable_lapic_irq,
-	.ack 		= ack_lapic_irq,
-	.end 		= end_lapic_irq
+	.typename	= "local-APIC-edge",
+	.startup	= NULL, /* startup_irq() not used for IRQ0 */
+	.shutdown	= NULL, /* shutdown_irq() not used for IRQ0 */
+	.enable		= enable_lapic_irq,
+	.disable	= disable_lapic_irq,
+	.ack		= ack_lapic_irq,
+	.end		= end_lapic_irq
 };
 
 static void setup_nmi (void)
@@ -2209,16 +2209,17 @@
 	struct IO_APIC_route_entry entry0, entry1;
 	unsigned char save_control, save_freq_select;
 	unsigned long flags;
+	struct ioapic_data_struct *ioapic0 = ioapic_data[0];
 
 	pin = find_isa_irq_pin(8, mp_INT);
 	if (pin == -1)
 		return;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	*(((int *)&entry0) + 1) = io_apic_read(0, 0x11 + 2 * pin);
-	*(((int *)&entry0) + 0) = io_apic_read(0, 0x10 + 2 * pin);
+	*(((int *)&entry0) + 1) = io_apic_read(ioapic0, 0x11 + 2 * pin);
+	*(((int *)&entry0) + 0) = io_apic_read(ioapic0, 0x10 + 2 * pin);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(ioapic0, pin);
 
 	memset(&entry1, 0, sizeof(entry1));
 
@@ -2231,8 +2232,8 @@
 	entry1.vector = 0;
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
+	io_apic_write(ioapic0, 0x11 + 2 * pin, *(((int *)&entry1) + 1));
+	io_apic_write(ioapic0, 0x10 + 2 * pin, *(((int *)&entry1) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 
 	save_control = CMOS_READ(RTC_CONTROL);
@@ -2250,11 +2251,11 @@
 
 	CMOS_WRITE(save_control, RTC_CONTROL);
 	CMOS_WRITE(save_freq_select, RTC_FREQ_SELECT);
-	clear_IO_APIC_pin(0, pin);
+	clear_IO_APIC_pin(ioapic0, pin);
 
 	spin_lock_irqsave(&ioapic_lock, flags);
-	io_apic_write(0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
-	io_apic_write(0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
+	io_apic_write(ioapic0, 0x11 + 2 * pin, *(((int *)&entry0) + 1));
+	io_apic_write(ioapic0, 0x10 + 2 * pin, *(((int *)&entry0) + 0));
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
 
@@ -2268,6 +2269,7 @@
 {
 	int pin1, pin2;
 	int vector;
+	struct ioapic_data_struct *ioapic0 = ioapic_data[0];
 
 	/*
 	 * get/set the timer IRQ vector:
@@ -2309,7 +2311,7 @@
 			}
 			return;
 		}
-		clear_IO_APIC_pin(0, pin1);
+		clear_IO_APIC_pin(ioapic0, pin1);
 		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
 	}
 
@@ -2334,7 +2336,7 @@
 		/*
 		 * Cleanup, just in case ...
 		 */
-		clear_IO_APIC_pin(0, pin2);
+		clear_IO_APIC_pin(ioapic0, pin2);
 	}
 	printk(" failed.\n");
 

--Boundary-00=_QCO3C1yQ7QLko0w--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
