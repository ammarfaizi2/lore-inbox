Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262669AbTKDWFl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTKDWFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:05:41 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57833 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262669AbTKDWFR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:05:17 -0500
Subject: Re: ACPI PM-Timer rev.2 [Was: Re: ACPI PM-Timer [Was: Re:
	[RFC][PATCH] must fix lists]]
From: john stultz <johnstul@us.ibm.com>
To: Dominik Brodowski <linux@brodo.de>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, albert@users.sourceforge.net
In-Reply-To: <20031027230113.GA701@brodo.de>
References: <3F94C833.8040204@cyberone.com.au>
	 <1066943359.6102.14.camel@dhcp23.swansea.linux.org.uk>
	 <20031023172323.A10588@osdlab.pdx.osdl.net>
	 <1067113087.10272.4.camel@dhcp23.swansea.linux.org.uk>
	 <3F9D1557.4050404@cyberone.com.au> <20031027182416.GA3905@brodo.de>
	 <1067280154.1113.334.camel@cog.beaverton.ibm.com>
	 <20031027184908.GA4240@brodo.de>
	 <1067281639.1122.358.camel@cog.beaverton.ibm.com>
	 <20031027230113.GA701@brodo.de>
Content-Type: text/plain
Organization: 
Message-Id: <1067983399.11432.102.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 04 Nov 2003 14:03:20 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-10-27 at 15:01, Dominik Brodowski wrote:
> On Mon, Oct 27, 2003 at 11:07:19AM -0800, john stultz wrote:
> > Ah, OK. Well, I'd prefer the manual ACPI parsing personally, but having
> > tried and failed to implement it once myself, I'd more prefer not to do
> > it myself. ;)
> 
> Here it is, and it is soooo much nicer than my previous implementation. It
> lacks the "lost-ticks compensation" and math cleanup John is working on, but
> otherwise:

Finally, here are my fixes to Dominik's patch (meant to send these out
last week, but got swamped). Basically it cleans up some of the math,
adds lost-tick compensation and monotonic_clock, fixes up a bit of the
ACPI table mapping, and moves the config option under the ACPI menu. Oh
yea, and it compiles, too ;)

Works well for me, but needs more testing. 

Applies on top of Dominik's ACPI PM-timer rev.2 patch.
http://www.ussg.iu.edu/hypermail/linux/kernel/0310.3/0669.html

Many thanks to Dominik for the great work and getting this started. 
-john


diff -Nru a/Documentation/kernel-parameters.txt
b/Documentation/kernel-parameters.txt
--- a/Documentation/kernel-parameters.txt	Tue Nov  4 13:30:42 2003
+++ b/Documentation/kernel-parameters.txt	Tue Nov  4 13:30:42 2003
@@ -214,7 +214,7 @@
 			Forces specified timesource (if avaliable) to be used
 			when calculating gettimeofday(). If specicified timesource
 			is not avalible, it defaults to PIT. 
-			Format: { pit | tsc | cyclone | ... }
+			Format: { pit | tsc | cyclone | pmtmr }
 
 	hpet=		[IA-32,HPET] option to disable HPET and use PIT.
 			Format: disable
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Tue Nov  4 13:30:42 2003
+++ b/arch/i386/Kconfig	Tue Nov  4 13:30:42 2003
@@ -411,24 +411,6 @@
 config HPET_EMULATE_RTC
 	def_bool HPET_TIMER && RTC=y
 
-config X86_PM_TIMER
-	bool "Power Management Timer Support"
-	depends on (!X86_VISWS && !X86_VISWS) && EXPERIMENTAL
-	default n
-	help
-	  The Power Management Timer is available on all ACPI-capable,
-	  in most cases even if ACPI is unusable or blacklisted.
-
-	  This timing source is not affected by powermanagement features
-	  like aggressive processor idling, throttling, frequency and/or
-	  voltage scaling, unlike the commonly used Time Stamp Counter 
-	  (TSC) timing source.
-
-	  So, if you see messages like 'Losing too many ticks!' in the 
-	  kernel logs, and/or you are using a this on a notebook which
-	  does not yet have an HPET (see above), you should say "Y" 
-	  here. Otherwise, say "N".
-
 config SMP
 	bool "Symmetric multi-processing support"
 	---help---
diff -Nru a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
--- a/arch/i386/kernel/acpi/boot.c	Tue Nov  4 13:30:42 2003
+++ b/arch/i386/kernel/acpi/boot.c	Tue Nov  4 13:30:42 2003
@@ -319,15 +319,19 @@
 }
 #endif
 
-/* detect the location of the ACPI PM Timer
+/* detect the location of the ACPI PM Timer */
 #ifdef CONFIG_X86_PM_TIMER
 extern u32 pmtmr_ioport;
 
 static int __init acpi_parse_fadt(unsigned long phys, unsigned long
size)
 {
-	struct fadt_descriptor_rev2 *fadt;
+	struct fadt_descriptor_rev2 *fadt =0;
 
-	fadt = __va(phys);
+	fadt = (struct fadt_descriptor_rev2*) __acpi_map_table(phys,size);
+	if(!fadt) {
+		printk(KERN_WARNING PREFIX "Unable to map FADT\n");
+		return 0;
+	}
 
 	if (fadt->revision >= FADT2_REVISION_ID) {
 		/* FADT rev. 2 */
diff -Nru a/arch/i386/kernel/timers/timer_pm.c
b/arch/i386/kernel/timers/timer_pm.c
--- a/arch/i386/kernel/timers/timer_pm.c	Tue Nov  4 13:30:42 2003
+++ b/arch/i386/kernel/timers/timer_pm.c	Tue Nov  4 13:30:42 2003
@@ -30,7 +30,12 @@
 
 /* value of the Power timer at last timer interrupt */
 static u32 offset_tick;
+static u32 offset_delay;
 
+static unsigned long long monotonic_base;
+static seqlock_t monotonic_lock = SEQLOCK_UNLOCKED;
+
+#define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
 static int init_pmtmr(char* override)
 {
@@ -62,23 +67,88 @@
 	return -ENODEV;
 }
 
+static inline u32 cyc2us(u32 cycles)
+{
+	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
+	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
+	 *
+	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can 
+	 * easily be multiplied with 286 (=0x11E) without having to fear
+	 * u32 overflows.
+	 */
+	cycles *= 286;
+	return (cycles >> 10);
+}
 
 /*
  * this gets called during each timer interrupt
  */
 static void mark_offset_pmtmr(void)
 {
+	u32 lost, delta, last_offset;
+	static int first_run = 1;
+	last_offset = offset_tick;
+
+	write_seqlock(&monotonic_lock);
+
 	offset_tick = inl(pmtmr_ioport);
-	offset_tick &= 0xFFFFFF; /* limit it to 24 bits */
+	offset_tick &= ACPI_PM_MASK; /* limit it to 24 bits */
+
+	/* calculate tick interval */
+	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
+
+	/* convert to usecs */
+	delta = offset_delay + cyc2us(delta);
+
+	/* convert to ticks */
+	lost = delta/(USEC_PER_SEC/HZ);
+	offset_delay = delta%(USEC_PER_SEC/HZ);
+
+	/* update the monotonic base value */
+	monotonic_base += delta; 
+	write_sequnlock(&monotonic_lock);
+
+
+	/* compensate for lost ticks */
+	if (lost >= 2)
+		jiffies += lost - 1;
+
+	/* don't calculate delay for first run, 
+	   or if we've got less then a tick */
+	if (first_run || (lost < 1)) {
+		first_run = 0;
+		offset_delay = 0;
+	}
+
 	return;
 }
 
 
 static unsigned long long monotonic_clock_pmtmr(void)
 {
-	return 0;
-}
+	u32 last_offset, this_offset;
+	unsigned long long base, ret;
+	unsigned seq;
+
 
+	/* atomically read monotonic base & last_offset */
+	do {
+		seq = read_seqbegin(&monotonic_lock);
+		last_offset = offset_tick;
+		base = monotonic_base;
+	} while (read_seqretry(&monotonic_lock, seq));
+
+
+	/* Read the cyclone counter */
+
+	this_offset =  inl(pmtmr_ioport) & ACPI_PM_MASK;
+	
+
+	/* convert to nanoseconds */
+	ret = base + ((this_offset - last_offset) & ACPI_PM_MASK);
+	ret = cyc2us(ret)*1000;
+	return ret;
+}
 
 /*
  * copied from delay_pit
@@ -106,21 +176,10 @@
 
 	offset = offset_tick;
 	now = inl(pmtmr_ioport);
-	now &= 0xFFFFFF;
-	if (likely(offset < now))
-		delta = now - offset;
-	else if (offset > now)
-		delta = (0xFFFFFF - offset) + now;
+	now &= ACPI_PM_MASK;
+	delta = (now - offset)&ACPI_PM_MASK;
 
-	/* The Power Management Timer ticks at 3.579545 ticks per microsecond.
-	 * 1 / PM_TIMER_FREQUENCY == 0.27936511 =~ 286/1024 [error: 0.024%]
-	 *
-	 * Even with HZ = 100, delta is at maximum 35796 ticks, so it can 
-	 * easily be multiplied with 286 (=0x11E) without having to fear
-	 * u32 overflows.
-	 */
-	delta *= 286;
-	return (unsigned long) (delta >> 10);
+	return (unsigned long) offset_delay + cyc2us(delta);
 }
 
 
diff -Nru a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
--- a/drivers/acpi/Kconfig	Tue Nov  4 13:30:42 2003
+++ b/drivers/acpi/Kconfig	Tue Nov  4 13:30:42 2003
@@ -269,5 +269,24 @@
 	  particular, many Toshiba laptops require this for correct operation
 	  of the AC module.
 
+config X86_PM_TIMER
+	bool "Power Management Timer Support"
+	depends on X86 && ACPI
+	depends on ACPI_BOOT && EXPERIMENTAL
+	default n
+	help
+	  The Power Management Timer is available on all ACPI-capable,
+	  in most cases even if ACPI is unusable or blacklisted.
+
+	  This timing source is not affected by powermanagement features
+	  like aggressive processor idling, throttling, frequency and/or
+	  voltage scaling, unlike the commonly used Time Stamp Counter 
+	  (TSC) timing source.
+
+	  So, if you see messages like 'Losing too many ticks!' in the 
+	  kernel logs, and/or you are using a this on a notebook which
+	  does not yet have an HPET (see above), you should say "Y" 
+	  here.
+
 endmenu
 



