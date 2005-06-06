Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261167AbVFFDJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261167AbVFFDJn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 23:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVFFDJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 23:09:43 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:30849 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261167AbVFFDJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 23:09:31 -0400
X-Comment: AT&T Maillennium special handling code - c
From: Parag Warudkar <kernel-stuff@comcast.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
Date: Sun, 5 Jun 2005 23:04:34 -0400
User-Agent: KMail/1.8
Cc: john stultz <johnstul@us.ibm.com>, Nishanth Aravamudan <nacc@us.ibm.com>,
       Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <1117812275.3674.2.camel@leatherman> <20050605170511.GC12338@dominikbrodowski.de>
In-Reply-To: <20050605170511.GC12338@dominikbrodowski.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_D17oCjEJVI5ufVT"
Message-Id: <200506052304.35298.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_D17oCjEJVI5ufVT
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 05 June 2005 13:05, Dominik Brodowski wrote:
> IIRC (from the comment above) several chipsets suffer from this
> inconsistency, namely the widely used PIIX4(E) and ICH(4 only? or also
> other ICH-ones?). Therefore, we'd need at least some sort of boot-time
> check to decide which method to use... and based on the method, we can
> adjust the priority maybe?

To begin with, will the simple proof-of-concept patch like below work? (It 
tests the chipset read in the same do{}while loop - if the loop executes only 
once, it considers the chipset good - in which case it executes the faster 
read_pmtmr_fast function.) Or does it need wider testing under different 
circumstances to conclude that chipset is good?

I tested the patch under Virtual PC which emulates a PIIX4 chipset. Test 
passes there, meaning the do {}while  loop executes only once.

Parag

--Boundary-00=_D17oCjEJVI5ufVT
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="timer_pm.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="timer_pm.c.patch"

--- linux-2.6-orig/arch/i386/kernel/timers/timer_pm.c	2005-03-02 02:37:48.000000000 -0500
+++ linux-2.6.12-rc5/arch/i386/kernel/timers/timer_pm.c	2005-06-05 23:01:15.000000000 -0400
@@ -35,6 +35,10 @@
  * in arch/i386/acpi/boot.c */
 u32 pmtmr_ioport = 0;
 
+struct pmtmr_rd_func {
+	u32 (*read_pmtmr) (void);
+}pmtmr_rd_func;
+
 
 /* value of the Power timer at last timer interrupt */
 static u32 offset_tick;
@@ -45,6 +49,11 @@
 
 #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
 
+static inline u32 read_pmtmr_fast(void)
+{
+	return inl(pmtmr_ioport);
+}
+
 /*helper function to safely read acpi pm timesource*/
 static inline u32 read_pmtmr(void)
 {
@@ -76,14 +85,14 @@
 	unsigned long count, delta;
 
 	mach_prepare_counter();
-	value1 = read_pmtmr();
+	value1 = pmtmr_rd_func.read_pmtmr();
 	mach_countup(&count);
-	value2 = read_pmtmr();
+	value2 = pmtmr_rd_func.read_pmtmr();
 	delta = (value2 - value1) & ACPI_PM_MASK;
 
 	/* Check that the PMTMR delta is within 5% of what we expect */
-	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
-	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
+	if (delta < (PMTMR_EXPECTED_RATE * 18) / 20 ||
+	    delta > (PMTMR_EXPECTED_RATE * 22) / 20) {
 		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
 		return -1;
 	}
@@ -95,9 +104,16 @@
 static int init_pmtmr(char* override)
 {
 	u32 value1, value2;
-	unsigned int i;
+	u32 v1=0,v2=0,v3=0;
+	unsigned int i, loop_cnt=0;
 
- 	if (override[0] && strncmp(override,"pmtmr",5))
+	/* Use slower but probably more correct read function by
+	 * default. This is overriden with a fast one if it is
+	 * suitable to do so below.
+	 */
+	pmtmr_rd_func.read_pmtmr = read_pmtmr;
+ 	
+	if (override[0] && strncmp(override,"pmtmr",5))
 		return -ENODEV;
 
 	if (!pmtmr_ioport)
@@ -106,9 +122,32 @@
 	/* we use the TSC for delay_pmtmr, so make sure it exists */
 	if (!cpu_has_tsc)
 		return -ENODEV;
+	/* It has been reported that because of various broken
+	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
+	 * source is not latched, so you must read it multiple
+	 * times to insure a safe value is read.
+	 */
+	do {
+		v1 = inl(pmtmr_ioport);
+		v2 = inl(pmtmr_ioport);
+		v3 = inl(pmtmr_ioport);
+		loop_cnt++;
+	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
+			|| (v3 > v1 && v3 < v2));
+	
+	if(loop_cnt == 1) { 
+		/*We have a good chipset*/
+		printk(KERN_INFO "PM Timer: Chipset passes port read test\n");
+		pmtmr_rd_func.read_pmtmr = read_pmtmr_fast;
+	}
+	
+	else {
+		printk(KERN_INFO "PM Timer: Chipset fails port read test:");
+	 	printk(KERN_INFO "Working around it.");
+	}
 
 	/* "verify" this timing source */
-	value1 = read_pmtmr();
+	value1 = pmtmr_rd_func.read_pmtmr();
 	for (i = 0; i < 10000; i++) {
 		value2 = read_pmtmr();
 		if (value2 == value1)
@@ -156,7 +195,7 @@
 
 	write_seqlock(&monotonic_lock);
 
-	offset_tick = read_pmtmr();
+	offset_tick = pmtmr_rd_func.read_pmtmr();
 
 	/* calculate tick interval */
 	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
@@ -202,7 +241,7 @@
 	} while (read_seqretry(&monotonic_lock, seq));
 
 	/* Read the pmtmr */
-	this_offset =  read_pmtmr();
+	this_offset =  pmtmr_rd_func.read_pmtmr();
 
 	/* convert to nanoseconds */
 	ret = (this_offset - last_offset) & ACPI_PM_MASK;
@@ -232,7 +271,7 @@
 	u32 now, offset, delta = 0;
 
 	offset = offset_tick;
-	now = read_pmtmr();
+	now = pmtmr_rd_func.read_pmtmr();
 	delta = (now - offset)&ACPI_PM_MASK;
 
 	return (unsigned long) offset_delay + cyc2us(delta);

--Boundary-00=_D17oCjEJVI5ufVT--
