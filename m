Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262318AbVFJAxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262318AbVFJAxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 20:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262335AbVFJAxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 20:53:38 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:8182 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262318AbVFJAxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 20:53:15 -0400
Message-ID: <42A8E369.8080504@mvista.com>
Date: Thu, 09 Jun 2005 17:48:41 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Parag Warudkar <kernel-stuff@comcast.net>
CC: Dominik Brodowski <linux@dominikbrodowski.net>,
       john stultz <johnstul@us.ibm.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       David Mosberger <davidm@hpl.hp.com>, Andrew Morton <akpm@osdl.org>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [PATCH 3/4] new timeofday x86-64 arch specific changes (v. B1)
References: <060220051827.15835.429F4FA6000DF9D700003DDB220588617200009A9B9CD3040A029D0A05@comcast.net> <1117812275.3674.2.camel@leatherman> <20050605170511.GC12338@dominikbrodowski.de> <200506052304.35298.kernel-stuff@comcast.net>
In-Reply-To: <200506052304.35298.kernel-stuff@comcast.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar wrote:
> On Sunday 05 June 2005 13:05, Dominik Brodowski wrote:
> 
>>IIRC (from the comment above) several chipsets suffer from this
>>inconsistency, namely the widely used PIIX4(E) and ICH(4 only? or also
>>other ICH-ones?). Therefore, we'd need at least some sort of boot-time
>>check to decide which method to use... and based on the method, we can
>>adjust the priority maybe?
> 
> 
> To begin with, will the simple proof-of-concept patch like below work? (It 
> tests the chipset read in the same do{}while loop - if the loop executes only 
> once, it considers the chipset good - in which case it executes the faster 
> read_pmtmr_fast function.) Or does it need wider testing under different 
> circumstances to conclude that chipset is good?
> 
> I tested the patch under Virtual PC which emulates a PIIX4 chipset. Test 
> passes there, meaning the do {}while  loop executes only once.

As I understand the problem it is that the counter is, sometimes, read while it 
is is rippling the carry up to the higher bits.  This will only happen if the 
read is done just as the hardware is bumping the count and even then only if 
there is a carry.  Exactly where in the carry sequency this happens is likely 
just a guess.

In the HRT patch I take care of this by testing the read against a prior read 
(up to 1/HZ away).  If the number is bigger and to too much bigger, I just do 
one read.  Here is the full routine:

quick_get_cpuctr(void)
{
	static  unsigned long last_read = 0;
	static  int qgc_max = 0;
	int i;

	unsigned long rd_delta, rd_ans, rd = inl(acpi_pm_tmr_address);

	/*
	 * This will be REALLY big if ever we move backward in time...
	 */
	rd_delta = (rd - last_read) & SIZE_MASK;
	last_read = rd;

	rd_ans =  (rd - last_update) & SIZE_MASK;

	if (likely((rd_ans < (arch_cycles_per_jiffy << 1)) &&
		   (rd_delta < (arch_cycles_per_jiffy << 1))))
		return rd_ans;

	for (i = 0; i < 10; i++) {
		rd = inl(acpi_pm_tmr_address);
		rd_delta = (rd - last_read) & SIZE_MASK;
		last_read = rd;
		if (unlikely(i > qgc_max))
			qgc_max = i;
		/*
		 * On my test machine (800MHZ dual PIII) this is always
		 * seven.  Seems long, but we will give it some slack...
		 * We note that rd_delta (and all the vars) unsigned so
		 * a backward movement will show as a really big number.
		 */
		if (likely(rd_delta < 20))
			return (rd - last_update) & SIZE_MASK;
	}
	return (rd - last_update) & SIZE_MASK;
}
George
-- 
> 
> Parag
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6-orig/arch/i386/kernel/timers/timer_pm.c	2005-03-02 02:37:48.000000000 -0500
> +++ linux-2.6.12-rc5/arch/i386/kernel/timers/timer_pm.c	2005-06-05 23:01:15.000000000 -0400
> @@ -35,6 +35,10 @@
>   * in arch/i386/acpi/boot.c */
>  u32 pmtmr_ioport = 0;
>  
> +struct pmtmr_rd_func {
> +	u32 (*read_pmtmr) (void);
> +}pmtmr_rd_func;
> +
>  
>  /* value of the Power timer at last timer interrupt */
>  static u32 offset_tick;
> @@ -45,6 +49,11 @@
>  
>  #define ACPI_PM_MASK 0xFFFFFF /* limit it to 24 bits */
>  
> +static inline u32 read_pmtmr_fast(void)
> +{
> +	return inl(pmtmr_ioport);
> +}
> +
>  /*helper function to safely read acpi pm timesource*/
>  static inline u32 read_pmtmr(void)
>  {
> @@ -76,14 +85,14 @@
>  	unsigned long count, delta;
>  
>  	mach_prepare_counter();
> -	value1 = read_pmtmr();
> +	value1 = pmtmr_rd_func.read_pmtmr();
>  	mach_countup(&count);
> -	value2 = read_pmtmr();
> +	value2 = pmtmr_rd_func.read_pmtmr();
>  	delta = (value2 - value1) & ACPI_PM_MASK;
>  
>  	/* Check that the PMTMR delta is within 5% of what we expect */
> -	if (delta < (PMTMR_EXPECTED_RATE * 19) / 20 ||
> -	    delta > (PMTMR_EXPECTED_RATE * 21) / 20) {
> +	if (delta < (PMTMR_EXPECTED_RATE * 18) / 20 ||
> +	    delta > (PMTMR_EXPECTED_RATE * 22) / 20) {
>  		printk(KERN_INFO "PM-Timer running at invalid rate: %lu%% of normal - aborting.\n", 100UL * delta / PMTMR_EXPECTED_RATE);
>  		return -1;
>  	}
> @@ -95,9 +104,16 @@
>  static int init_pmtmr(char* override)
>  {
>  	u32 value1, value2;
> -	unsigned int i;
> +	u32 v1=0,v2=0,v3=0;
> +	unsigned int i, loop_cnt=0;
>  
> - 	if (override[0] && strncmp(override,"pmtmr",5))
> +	/* Use slower but probably more correct read function by
> +	 * default. This is overriden with a fast one if it is
> +	 * suitable to do so below.
> +	 */
> +	pmtmr_rd_func.read_pmtmr = read_pmtmr;
> + 	
> +	if (override[0] && strncmp(override,"pmtmr",5))
>  		return -ENODEV;
>  
>  	if (!pmtmr_ioport)
> @@ -106,9 +122,32 @@
>  	/* we use the TSC for delay_pmtmr, so make sure it exists */
>  	if (!cpu_has_tsc)
>  		return -ENODEV;
> +	/* It has been reported that because of various broken
> +	 * chipsets (ICH4, PIIX4 and PIIX4E) where the ACPI PM time
> +	 * source is not latched, so you must read it multiple
> +	 * times to insure a safe value is read.
> +	 */
> +	do {
> +		v1 = inl(pmtmr_ioport);
> +		v2 = inl(pmtmr_ioport);
> +		v3 = inl(pmtmr_ioport);
> +		loop_cnt++;
> +	} while ((v1 > v2 && v1 < v3) || (v2 > v3 && v2 < v1)
> +			|| (v3 > v1 && v3 < v2));
> +	
> +	if(loop_cnt == 1) { 
> +		/*We have a good chipset*/
> +		printk(KERN_INFO "PM Timer: Chipset passes port read test\n");
> +		pmtmr_rd_func.read_pmtmr = read_pmtmr_fast;
> +	}
> +	
> +	else {
> +		printk(KERN_INFO "PM Timer: Chipset fails port read test:");
> +	 	printk(KERN_INFO "Working around it.");
> +	}
>  
>  	/* "verify" this timing source */
> -	value1 = read_pmtmr();
> +	value1 = pmtmr_rd_func.read_pmtmr();
>  	for (i = 0; i < 10000; i++) {
>  		value2 = read_pmtmr();
>  		if (value2 == value1)
> @@ -156,7 +195,7 @@
>  
>  	write_seqlock(&monotonic_lock);
>  
> -	offset_tick = read_pmtmr();
> +	offset_tick = pmtmr_rd_func.read_pmtmr();
>  
>  	/* calculate tick interval */
>  	delta = (offset_tick - last_offset) & ACPI_PM_MASK;
> @@ -202,7 +241,7 @@
>  	} while (read_seqretry(&monotonic_lock, seq));
>  
>  	/* Read the pmtmr */
> -	this_offset =  read_pmtmr();
> +	this_offset =  pmtmr_rd_func.read_pmtmr();
>  
>  	/* convert to nanoseconds */
>  	ret = (this_offset - last_offset) & ACPI_PM_MASK;
> @@ -232,7 +271,7 @@
>  	u32 now, offset, delta = 0;
>  
>  	offset = offset_tick;
> -	now = read_pmtmr();
> +	now = pmtmr_rd_func.read_pmtmr();
>  	delta = (now - offset)&ACPI_PM_MASK;
>  
>  	return (unsigned long) offset_delay + cyc2us(delta);

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
