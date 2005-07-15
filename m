Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbVGOD2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbVGOD2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 23:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbVGOD2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 23:28:40 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:26224 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261820AbVGOD2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 23:28:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type;
        b=SNfwdW8QYnuoTPlNInK066cLolihoOy6PrPIRlFcuyi2F3ZckwZYmB6SjZCnPi4ufWEHC3dl4gViuQBTTLPJz404VmhNumiWiPkCsPvNQ1yoBykExN8+RRtEbLWF0YN44vzF/kNV32AzJGXWMs/gNaqG7tnaz3QkUyEQsdVhchc=
Message-ID: <42D731A4.40504@gmail.com>
Date: Fri, 15 Jul 2005 05:46:44 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Lee Revell <rlrevell@joe-job.com>, Chris Wedgwood <cw@f00f.org>,
       Andrew Morton <akpm@osdl.org>, "Brown, Len" <len.brown@intel.com>,
       dtor_core@ameritech.net, vojtech@suse.cz, david.lang@digitalinsight.com,
       davidsen@tmr.com, kernel@kolivas.org, linux-kernel@vger.kernel.org,
       mbligh@mbligh.org, diegocg@gmail.com, azarah@nosferatu.za.org,
       christoph@lameter.com
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com>  <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>  <20050713184227.GB2072@ucw.cz>  <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>  <1121282025.4435.70.camel@mindpipe>  <d120d50005071312322b5d4bff@mail.gmail.com>  <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>  <20050713211650.GA12127@taniwha.stupidest.org>  <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070104020202050305080209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070104020202050305080209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
> 
> On Thu, 14 Jul 2005, Lee Revell wrote:
> 
>>I don't think this will fly because we take a big performance hit by
>>calculating HZ at runtime.
> 
> 
> I think it might be an acceptable solution for a distribution that really 
> needed it, since it should be fairly simple. However, it's definitely not 
> the right solution.
> 
> HOWEVER. I bet that somebody who really really cares (hint hint) could
> easily make HZ be 1000, and then dynamically tweak the divisor at bootup
> to be either 1000, 250, or 100, and then increment "jiffies" by 1, 4 or
> 10.
> 
> My wild guess is that this is 20 lines of code, plus another 20 for 
> "setup", so that you can choose between 100/250/1000 Hz with a kernel 
> command line.
> 
> It wouldn't be "dynamic" at first - you'd just set it up at bootup, and 
> set a "jiffies_increment" variable, and change the
> 
> 	jiffies_64++;
> 
> into
> 
> 	jiffies_64 += jiffies_increment;
> 
> and you'd be done. 
> 
> Really. I dare you guys. First one to send me a tested patch gets a gold 
> star.
> 

I don't know if this will earn me that gold star or not, but it's what I 
have at this point.
It's buggy, that I know. setting kernel_hz (the new boot parameter) to 
250 causes my system clock to run at something like 4-5 times normal 
speed, and key repeat is all funny (super fast) and various other nasty 
things - however, it does build and it does boot (i386 only as that's 
all I have) and apart from the kernels notion of time being way off it 
does seem to be a step in the right direction.
Me never having looked at the kernels timer code before is most likely 
the explanation for the bugs - that and the fact that I didn't try to 
tackle the bogomips calculation at all...  Ohh, and it'll probably bee 
even more strange if you build the kernel with CONFIG_HZ set to anything 
other than 1000 - if this is what we want to do, then I guess CONFIG_HZ 
needs to go away completely and just always be 1000 and then people 
should use the boot option to modify if needed/wanted.

Anyway, is this somewhere along the lines of what you were thinking?

The patch is below, but I've also attached it since I suspect 
thunderbird will mangle it.


diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/time.c 
linux-2.6.13-rc3/arch/i386/kernel/time.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/time.c	2005-07-14 
20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/time.c	2005-07-15 
04:02:50.000000000 +0200
@@ -75,6 +75,7 @@ int pit_latch_buggy;              /* ext
  #include "do_timer.h"

  u64 jiffies_64 = INITIAL_JIFFIES;
+u16 jiffies_increment = 1;

  EXPORT_SYMBOL(jiffies_64);

@@ -481,3 +482,27 @@ void __init time_init(void)

  	time_init_hook();
  }
+
+static int __init jiffies_increment_setup(char *str)
+{
+	printk(KERN_NOTICE "setting up jiffies_increment : ");
+	if (str) {
+		printk("kernel_hz = %s, ", str);
+	} else {
+		printk("kernel_hz is unset, ");
+	}
+	if (!strncmp("100", str, 3)) {
+		jiffies_increment = 10;
+		printk("jiffies_increment set to 10, effective HZ will be 100\n");
+	} else if (!strncmp("250", str, 3)) {
+		jiffies_increment = 4;
+		printk("jiffies_increment set to 4, effective HZ will be 250\n");
+	} else {
+		jiffies_increment = 1;
+		printk("jiffies_increment set to 1, effective HZ will be 1000\n");
+	}
+
+	return 1;
+}
+
+__setup("kernel_hz=", jiffies_increment_setup);
diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_pm.c 
linux-2.6.13-rc3/arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_pm.c	2005-07-14 
20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/timers/timer_pm.c	2005-07-15 
02:59:39.000000000 +0200
@@ -176,7 +176,7 @@ static void mark_offset_pmtmr(void)

  	/* compensate for lost ticks */
  	if (lost >= 2)
-		jiffies_64 += lost - 1;
+		jiffies_64 += (lost * jiffies_increment) - 1;

  	/* don't calculate delay for first run,
  	   or if we've got less then a tick */
diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_tsc.c 
linux-2.6.13-rc3/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_tsc.c	2005-07-14 
20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/timers/timer_tsc.c	2005-07-15 
02:59:13.000000000 +0200
@@ -193,7 +193,7 @@ static void mark_offset_tsc_hpet(void)
  	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
  	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
  		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies_64 += lost_ticks;
+		jiffies_64 += lost_ticks * jiffies_increment;
  	}
  	hpet_last = hpet_current;

@@ -415,7 +415,7 @@ static void mark_offset_tsc(void)
  	lost = delta/(1000000/HZ);
  	delay = delta%(1000000/HZ);
  	if (lost >= 2) {
-		jiffies_64 += lost-1;
+		jiffies_64 += (lost * jiffies_increment) - 1;

  		/* sanity check to ensure we're not always losing ticks */
  		if (lost_count++ > 100) {
@@ -448,7 +448,7 @@ static void mark_offset_tsc(void)
  	 * usec delta is > 90% # of usecs/tick)
  	 */
  	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
+		jiffies_64 += jiffies_increment;
  }

  static int __init init_tsc(char* override)
diff -upr linux-2.6.13-rc3-orig/include/linux/jiffies.h 
linux-2.6.13-rc3/include/linux/jiffies.h
--- linux-2.6.13-rc3-orig/include/linux/jiffies.h	2005-06-17 
21:48:29.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/jiffies.h	2005-07-15 
03:42:57.000000000 +0200
@@ -83,6 +83,7 @@
   */
  extern u64 __jiffy_data jiffies_64;
  extern unsigned long volatile __jiffy_data jiffies;
+extern u16 jiffies_increment;

  #if (BITS_PER_LONG < 64)
  u64 get_jiffies_64(void);
diff -upr linux-2.6.13-rc3-orig/kernel/timer.c 
linux-2.6.13-rc3/kernel/timer.c
--- linux-2.6.13-rc3-orig/kernel/timer.c	2005-07-14 20:34:24.000000000 +0200
+++ linux-2.6.13-rc3/kernel/timer.c	2005-07-15 02:55:45.000000000 +0200
@@ -948,7 +948,7 @@ static inline void update_times(void)

  void do_timer(struct pt_regs *regs)
  {
-	jiffies_64++;
+	jiffies_64 += jiffies_increment;
  	update_times();
  }



-- 
Jesper Juhl


--------------070104020202050305080209
Content-Type: text/x-patch;
 name="jiffies_interval.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="jiffies_interval.patch"

diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/time.c linux-2.6.13-rc3/arch/i386/kernel/time.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/time.c	2005-07-14 20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/time.c	2005-07-15 04:02:50.000000000 +0200
@@ -75,6 +75,7 @@ int pit_latch_buggy;              /* ext
 #include "do_timer.h"
 
 u64 jiffies_64 = INITIAL_JIFFIES;
+u16 jiffies_increment = 1;
 
 EXPORT_SYMBOL(jiffies_64);
 
@@ -481,3 +482,27 @@ void __init time_init(void)
 
 	time_init_hook();
 }
+
+static int __init jiffies_increment_setup(char *str)
+{
+	printk(KERN_NOTICE "setting up jiffies_increment : ");
+	if (str) {
+		printk("kernel_hz = %s, ", str);
+	} else {
+		printk("kernel_hz is unset, ");
+	}
+	if (!strncmp("100", str, 3)) {
+		jiffies_increment = 10;
+		printk("jiffies_increment set to 10, effective HZ will be 100\n");
+	} else if (!strncmp("250", str, 3)) {
+		jiffies_increment = 4;
+		printk("jiffies_increment set to 4, effective HZ will be 250\n");
+	} else {
+		jiffies_increment = 1;
+		printk("jiffies_increment set to 1, effective HZ will be 1000\n");
+	}
+
+	return 1;
+}
+
+__setup("kernel_hz=", jiffies_increment_setup);
diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_pm.c linux-2.6.13-rc3/arch/i386/kernel/timers/timer_pm.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_pm.c	2005-07-14 20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/timers/timer_pm.c	2005-07-15 02:59:39.000000000 +0200
@@ -176,7 +176,7 @@ static void mark_offset_pmtmr(void)
 
 	/* compensate for lost ticks */
 	if (lost >= 2)
-		jiffies_64 += lost - 1;
+		jiffies_64 += (lost * jiffies_increment) - 1;
 
 	/* don't calculate delay for first run,
 	   or if we've got less then a tick */
diff -upr linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_tsc.c linux-2.6.13-rc3/arch/i386/kernel/timers/timer_tsc.c
--- linux-2.6.13-rc3-orig/arch/i386/kernel/timers/timer_tsc.c	2005-07-14 20:33:35.000000000 +0200
+++ linux-2.6.13-rc3/arch/i386/kernel/timers/timer_tsc.c	2005-07-15 02:59:13.000000000 +0200
@@ -193,7 +193,7 @@ static void mark_offset_tsc_hpet(void)
 	offset = hpet_readl(HPET_T0_CMP) - hpet_tick;
 	if (unlikely(((offset - hpet_last) > hpet_tick) && (hpet_last != 0))) {
 		int lost_ticks = (offset - hpet_last) / hpet_tick;
-		jiffies_64 += lost_ticks;
+		jiffies_64 += lost_ticks * jiffies_increment;
 	}
 	hpet_last = hpet_current;
 
@@ -415,7 +415,7 @@ static void mark_offset_tsc(void)
 	lost = delta/(1000000/HZ);
 	delay = delta%(1000000/HZ);
 	if (lost >= 2) {
-		jiffies_64 += lost-1;
+		jiffies_64 += (lost * jiffies_increment) - 1;
 
 		/* sanity check to ensure we're not always losing ticks */
 		if (lost_count++ > 100) {
@@ -448,7 +448,7 @@ static void mark_offset_tsc(void)
 	 * usec delta is > 90% # of usecs/tick)
 	 */
 	if (lost && abs(delay - delay_at_last_interrupt) > (900000/HZ))
-		jiffies_64++;
+		jiffies_64 += jiffies_increment;
 }
 
 static int __init init_tsc(char* override)
diff -upr linux-2.6.13-rc3-orig/include/linux/jiffies.h linux-2.6.13-rc3/include/linux/jiffies.h
--- linux-2.6.13-rc3-orig/include/linux/jiffies.h	2005-06-17 21:48:29.000000000 +0200
+++ linux-2.6.13-rc3/include/linux/jiffies.h	2005-07-15 03:42:57.000000000 +0200
@@ -83,6 +83,7 @@
  */
 extern u64 __jiffy_data jiffies_64;
 extern unsigned long volatile __jiffy_data jiffies;
+extern u16 jiffies_increment;
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void);
diff -upr linux-2.6.13-rc3-orig/kernel/timer.c linux-2.6.13-rc3/kernel/timer.c
--- linux-2.6.13-rc3-orig/kernel/timer.c	2005-07-14 20:34:24.000000000 +0200
+++ linux-2.6.13-rc3/kernel/timer.c	2005-07-15 02:55:45.000000000 +0200
@@ -948,7 +948,7 @@ static inline void update_times(void)
 
 void do_timer(struct pt_regs *regs)
 {
-	jiffies_64++;
+	jiffies_64 += jiffies_increment;
 	update_times();
 }
 

--------------070104020202050305080209--
