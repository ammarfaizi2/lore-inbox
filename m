Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261214AbVF2Or3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261214AbVF2Or3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 10:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVF2Or3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 10:47:29 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:54174 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261214AbVF2OrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 10:47:08 -0400
From: Karsten Wiese <annabellesgarden@yahoo.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: Real-Time Preemption, -RT-2.6.12-final-V0.7.50-24
Date: Wed, 29 Jun 2005 16:48:16 +0200
User-Agent: KMail/1.8.1
Cc: William Weston <weston@sysex.net>, linux-kernel@vger.kernel.org
References: <200506281927.43959.annabellesgarden@yahoo.de> <20050629070058.GA15987@elte.hu> <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org>
In-Reply-To: <Pine.LNX.4.58.0506290159050.12101@echo.lysdexia.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_wSrwCjL462Re7T8"
Message-Id: <200506291648.16601.annabellesgarden@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_wSrwCjL462Re7T8
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Am Mittwoch, 29. Juni 2005 11:15 schrieb William Weston:
> On Wed, 29 Jun 2005, Ingo Molnar wrote:
> 
> > > [...] but i think i'm going to revert that, it's causing too many 
> > > problems all around.
> > 
> > reverted it and this enabled the removal of the extra ->disable() you 
> > noticed - this should further speed up the IOAPIC code. These changes 
> > are in the -50-34 kernel i just uploaded.
> 
> -50-34 fixed the wakeup latency regression I was seeing on my Athlon box
> with -50-33, and seems a bit more responsive than -50-25.  Max wakeup
> latency is back down to 14us (from 39us), even while running JACK (xrun
> free) and two instances of burnK7.  Overall system response is probably
> the best I've seen with the RT kernels ;-}
> 
attached patch for io_apic.c lets
1. gcc 3.4.3 optimize io_apic access a little better.
2. CONFIG_X86_UP_IOAPIC_FAST work here.
   Didn't check, if it really speeds up things.

Karsten




--Boundary-00=_wSrwCjL462Re7T8
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="io_apic-RT-50-35.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="io_apic-RT-50-35.diff"

--- arch/i386/kernel/io_apic.c-50-33	2005-06-29 16:27:40.000000000 +0200
+++ arch/i386/kernel/io_apic.c	2005-06-29 16:27:40.000000000 +0200
@@ -138,14 +138,22 @@
 /*
  * Cache register values:
  */
-static unsigned int io_apic_cache[MAX_IO_APICS][MAX_IOAPIC_CACHE]
+static struct {
+	unsigned int reg;
+	unsigned int val[MAX_IOAPIC_CACHE];
+} io_apic_cache[MAX_IO_APICS]
 		____cacheline_aligned_in_smp;
 #endif
 
 inline unsigned int __raw_io_apic_read(unsigned int apic, unsigned int reg)
 {
-	*IO_APIC_BASE(apic) = reg;
-	return *(IO_APIC_BASE(apic)+4);
+	volatile unsigned int *io_apic;
+	io_apic = IO_APIC_BASE(apic);
+#ifdef IOAPIC_CACHE
+	io_apic_cache[apic].reg = reg;
+#endif
+	io_apic[0] = reg;
+	return io_apic[4];
 }
 
 unsigned int raw_io_apic_read(unsigned int apic, unsigned int reg)
@@ -153,7 +161,7 @@
 	unsigned int val = __raw_io_apic_read(apic, reg);
 
 #ifdef IOAPIC_CACHE
-	io_apic_cache[apic][reg] = val;
+	io_apic_cache[apic].val[reg] = val;
 #endif
 	return val;
 }
@@ -172,14 +180,17 @@
 		}
 		return __raw_io_apic_read(apic, reg);
 	}
-	if (io_apic_cache[apic][reg] && !sis_apic_bug)
-		return io_apic_cache[apic][reg];
+	if (io_apic_cache[apic].val[reg] && !sis_apic_bug) {
+		io_apic_cache[apic].reg = -1;
+		return io_apic_cache[apic].val[reg];
+	}
 #endif
 	return raw_io_apic_read(apic, reg);
 }
 
 void io_apic_write(unsigned int apic, unsigned int reg, unsigned int val)
 {
+	volatile unsigned int *io_apic;
 #ifdef IOAPIC_CACHE
 	if (unlikely(reg >= MAX_IOAPIC_CACHE)) {
 		static int once = 1;
@@ -191,10 +202,14 @@
 			dump_stack();
 		}
 	} else
-		io_apic_cache[apic][reg] = val;
+		io_apic_cache[apic].val[reg] = val;
 #endif
-	*IO_APIC_BASE(apic) = reg;
-	*(IO_APIC_BASE(apic)+4) = val;
+	io_apic = IO_APIC_BASE(apic);
+#ifdef IOAPIC_CACHE
+	io_apic_cache[apic].reg = reg;
+#endif
+	io_apic[0] = reg;
+	io_apic[4] = val;
 }
 
 /*
@@ -214,34 +229,42 @@
  */
 void io_apic_modify(unsigned int apic, unsigned int reg, unsigned int val)
 {
+	volatile unsigned int *io_apic;
 #ifdef IOAPIC_CACHE
-	io_apic_cache[apic][reg] = val;
+	io_apic_cache[apic].val[reg] = val;
 #endif
-	if (unlikely(sis_apic_bug))
-		*IO_APIC_BASE(apic) = reg;
-	*(IO_APIC_BASE(apic)+4) = val;
+	io_apic = IO_APIC_BASE(apic);
+#ifdef IOAPIC_CACHE
+	if (io_apic_cache[apic].reg != reg || sis_apic_bug) {
+		io_apic_cache[apic].reg = reg;
+#else
+	if (unlikely(sis_apic_bug)) {
+#endif
+		io_apic[0] = reg;
+	}
+	io_apic[4] = val;
 #ifndef IOAPIC_POSTFLUSH
 	if (unlikely(sis_apic_bug))
 #endif
 		/*
 		 * Force POST flush by reading:
  		 */
-		val = *(IO_APIC_BASE(apic)+4);
+		val = io_apic[4];
 }
 
 static void __modify_IO_APIC_irq (unsigned int irq, unsigned long enable, unsigned long disable)
 {
 	struct irq_pin_list *entry = irq_2_pin + irq;
-	unsigned int pin, reg;
+	unsigned int pin, val;
 
 	for (;;) {
 		pin = entry->pin;
 		if (pin == -1)
 			break;
-		reg = io_apic_read(entry->apic, 0x10 + pin*2);
-		reg &= ~disable;
-		reg |= enable;
-		io_apic_modify(entry->apic, 0x10 + pin*2, reg);
+		val = io_apic_read(entry->apic, 0x10 + pin*2);
+		val &= ~disable;
+		val |= enable;
+		io_apic_modify(entry->apic, 0x10 + pin*2, val);
 		if (!entry->next)
 			break;
 		entry = irq_2_pin + entry->next;
@@ -306,9 +329,13 @@
 {
 	int apic, pin;
 
-	for (apic = 0; apic < nr_ioapics; apic++)
+	for (apic = 0; apic < nr_ioapics; apic++) {
+#ifdef IOAPIC_CACHE
+		io_apic_cache[apic].reg = -1;
+#endif
 		for (pin = 0; pin < nr_ioapic_registers[apic]; pin++)
 			clear_IO_APIC_pin(apic, pin);
+	}
 }
 
 static void set_ioapic_affinity_irq(unsigned int irq, cpumask_t cpumask)

--Boundary-00=_wSrwCjL462Re7T8--

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de
