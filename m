Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265961AbUAEWMh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265963AbUAEWMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:12:37 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:26346 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265961AbUAEWMe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:12:34 -0500
Subject: Re: [2.6.0-mm2] PM timer still has problems
From: john stultz <johnstul@us.ibm.com>
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031230204831.GA17344@hell.org.pl>
References: <20031230204831.GA17344@hell.org.pl>
Content-Type: text/plain
Message-Id: <1073340716.15645.96.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 05 Jan 2004 14:11:56 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-12-30 at 12:48, Karol Kozimor wrote:
> Hi,
> Booting with clock=pmtmr causes weird problems here (the system 
> complains that clock override failed and the bogomips loop produces bogus
> values). Below is the dmesg output as well as /proc/cpuinfo.
> I have CONFIG_X86_LOCAL_APIC=y and CONFIG_X86_PM_TIMER=y.
> 
> I don't really know whether this box (ASUS L3800C, more data at
> http://bugme.osdl.org/show_bug.cgi?id=1185) has a PM timer or not, but even
> if it doesn't, the code should account for that gracefully.
> I'll be happy to provide any additional info.

If the override boot option failed, its most likely your system doesn't
have an ACPI PM time source.  Instead it seems your system is having
trouble using the PIT as a time source (which seems not all that
uncommon unfortunately). 

I guess we can just re-call select_timer() without an override if the
override fails, that way you'll fall back to the default time source on
your system. Try the (compile tested) patch below and see if that helps.

Thanks for the feedback! 
-john


diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Mon Jan  5 14:09:26 2004
+++ b/arch/i386/kernel/timers/timer.c	Mon Jan  5 14:09:26 2004
@@ -43,21 +43,40 @@
 	cur_timer = &timer_pit;
 }
 
-/* iterates through the list of timers, returning the first 
- * one that initializes successfully.
+/* helper function to iterates through the list of timers, 
+ * returning the first one that initializes successfully.
  */
-struct timer_opts* select_timer(void)
+static struct timer_opts* pick_timer(char* override)
 {
 	int i = 0;
 	
 	/* find most preferred working timer */
 	while (timers[i]) {
 		if (timers[i]->init)
-			if (timers[i]->init(clock_override) == 0)
+			if (timers[i]->init(override) == 0)
 				return timers[i];
 		++i;
 	}
-		
-	panic("select_timer: Cannot find a suitable timer\n");
 	return NULL;
+}
+ 
+struct timer_opts* select_timer(void)
+{
+	struct timer_opts* ret;
+
+	/* pick the best time source*/
+	ret = pick_timer(clock_override);
+
+	/* if we didn't find anything, try without the override */
+	if (!ret && clock_override) {
+		printk("Warning: 'clock=%s' override failed.\n", clock_override);
+		ret = pick_timer(NULL);
+	}
+
+	/* if we still didn't find anything, we're ruined */
+	/* note that this won't happen, as the PIT always succeeds*/
+	if (!ret)
+		panic("select_timer: Cannot find a suitable timer\n");
+
+	return ret;
 }
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Mon Jan  5 14:09:26 2004
+++ b/arch/i386/kernel/timers/timer_pit.c	Mon Jan  5 14:09:26 2004
@@ -24,7 +24,7 @@
 {
  	/* check clock override */
  	if (override[0] && strncmp(override,"pit",3))
- 		printk(KERN_ERR "Warning: clock= override failed. Defaulting to PIT\n");
+ 		return -ENODEV;
  
 	count_p = LATCH;
 	return 0;


