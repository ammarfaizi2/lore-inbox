Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbWCEEid@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbWCEEid (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 23:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbWCEEid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 23:38:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:28886 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751102AbWCEEid (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 23:38:33 -0500
Date: Sat, 4 Mar 2006 23:38:00 -0500
From: Dave Jones <davej@redhat.com>
To: Shinichi Kudo <randomshinichi4869@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA C3 (Ezra C5C) Crashes with longhaul Freq scaling
Message-ID: <20060305043800.GA2253@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Shinichi Kudo <randomshinichi4869@gmail.com>,
	linux-kernel@vger.kernel.org
References: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8be2e100603040646k7f40e8eai391eb914040cb8f8@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2006 at 10:46:11PM +0800, Shinichi Kudo wrote:
 > After compiling my own kernels from 2.6.11 to 2.6.14, I found that
 > only the Ubuntu official kernel didn't lock up hard after 2 hours or
 > so. Why? Because it didn't provide the frequency scaling driver
 > longhaul.ko for my VIA C3 CPU. WIthout longhaul frequency scaling, my
 > laptop is rock stable.
 > 
 > According to http://tinyurl.com/k7wlw , this has been going on since kernel 2.4!

2.4 never officially had cpufreq.

 > In http://tinyurl.com/oxetd Dave Jones says,
 > Version 2 of longhaul is the same as v1, but adds voltage scaling.
 >  12  *   Present in Samuel 2 (steppings 1-7 only) (C5B), and Ezra (C5C)
 > 
 > Output of cat /proc/cpuinfo included.
 > Output of dmesg also included.
 > 
 > As you can see, dmesg says the kernel detected a Ezra C5C version of
 > VIA C3. However, it also goes on to say, only longhaul v1 supported.
 > What's with that?

v2 is v1+voltage scaling. As the driver doesn't do voltage scaling,
there's no difference.

 > Does that have anything to do with the laptop
 > locking?

No. It's to do with the way frequency scaling is implemented on those CPUs.
It's very tempremental.  If there's any (for eg) IDE DMA that occurs
during a frequency transition, everything goes bang a short time later.
There's an ugly patch below that was submitted, which fixes it for
some people, but as it's a) ide specific, and b) completely the
wrong place to do this and c) racy,  I never merged it to mainline.

I'm hopeful that future generations of their CPUs will behave
in the same manner of other implementations that other x86 vendors
have invented, where we don't need such hacks.

 > Please, somebody fix this frequency scaling issue!

I'm actually contemplating marking it CONFIG_BROKEN in mainline,
as there's not a great deal we can do to make it work without
significant infrastructure to quiesce DMA.

		Dave

>From patch by: Ken Staton <ken_staton@agilent.com>

--- linux-2.6.11/arch/i386/kernel/cpu/cpufreq/longhaul.c~	2005-05-24 01:51:51.000000000 -0400
+++ linux-2.6.11/arch/i386/kernel/cpu/cpufreq/longhaul.c	2005-05-24 01:52:07.000000000 -0400
@@ -30,6 +30,8 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/pci.h>
+#include <linux/ide.h>
+#include <linux/delay.h>
 
 #include <asm/msr.h>
 #include <asm/timex.h>
@@ -91,6 +91,25 @@ static char *print_speed(int speed)
 }
 #endif
 
+static void ide_idle(void)
+ {
+	int i;
+	ide_hwif_t *hwif = ide_hwifs;
+	ide_drive_t *drive;
+
+	i = 0;
+	do {
+		drive = &hwif->drives[i];
+		i++;
+		if (strncmp(drive->name,"hd",2) == 0) {
+			while (drive->waiting_for_dma)
+			udelay(10);
+		} else {
+			i = 0;
+		}
+	} while (i != 0);
+}	
+
 
 static unsigned int calc_speed(int mult)
 {
@@ -146,6 +165,7 @@ static void do_powersaver(union msr_long
 	longhaul->bits.RevisionKey = 0;
 
 	preempt_disable();
+	ide_idle();	/* avoid ide timeouts when bus master off */
 	local_irq_save(flags);
 
 	/*


-- 
http://www.codemonkey.org.uk
