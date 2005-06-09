Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVFIMtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVFIMtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 08:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261335AbVFIMtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 08:49:12 -0400
Received: from tron.kn.vutbr.cz ([147.229.191.152]:9223 "EHLO tron.kn.vutbr.cz")
	by vger.kernel.org with ESMTP id S262198AbVFIMsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 08:48:24 -0400
Message-ID: <42A83A85.6090503@stud.feec.vutbr.cz>
Date: Thu, 09 Jun 2005 14:48:05 +0200
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050603)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, "Eugeny S. Mints" <emints@ru.mvista.com>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.48-00
References: <20050608112801.GA31084@elte.hu> <42A73023.4040707@stud.feec.vutbr.cz> <20050609114510.GA10969@elte.hu> <42A8316E.6000104@stud.feec.vutbr.cz> <20050609121326.GB17414@elte.hu>
In-Reply-To: <20050609121326.GB17414@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------090808050600010805080202"
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  tested this incoming email. See other headers to know if the email
  has beed identified as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-4.2 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090808050600010805080202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Molnar wrote:
> indeed - new patch uploaded.

The attached patch against V0.7.48-04 replaces some more local_irq_* 
operation with their raw variants on x86_64. It should be the equivalent 
of your changes done for i386 in -V0.7.48-02.

Michal

--------------090808050600010805080202
Content-Type: text/plain;
 name="rt-x86_64-more-local_irqs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-x86_64-more-local_irqs.diff"

diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/io_apic.c linux-RT.mich/arch/x86_64/kernel/io_apic.c
--- linux-RT/arch/x86_64/kernel/io_apic.c	2005-06-09 14:16:53.563982208 +0200
+++ linux-RT.mich/arch/x86_64/kernel/io_apic.c	2005-06-09 14:22:20.326306784 +0200
@@ -1218,7 +1218,7 @@ static int __init timer_irq_works(void)
 {
 	unsigned long t1 = jiffies;
 
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Let ten ticks pass... */
 	mdelay((10 * 1000) / HZ);
 
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/nmi.c linux-RT.mich/arch/x86_64/kernel/nmi.c
--- linux-RT/arch/x86_64/kernel/nmi.c	2005-06-09 14:16:53.566981752 +0200
+++ linux-RT.mich/arch/x86_64/kernel/nmi.c	2005-06-09 14:25:17.092434248 +0200
@@ -128,7 +128,7 @@ void __init nmi_watchdog_default(void)
 static __init void nmi_cpu_busy(void *data)
 {
 	volatile int *endflag = data;
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Intentionally don't use cpu_relax here. This is
 	   to make sure that the performance counter really ticks,
 	   even if there is a simulator or similar that catches the
@@ -157,7 +157,7 @@ int __init check_nmi_watchdog (void)
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		counts[cpu] = cpu_pda[cpu].__nmi_count; 
-	local_irq_enable();
+	raw_local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
 	for (cpu = 0; cpu < NR_CPUS; cpu++) {
diff -Nurp -X linux-RT/Documentation/dontdiff linux-RT/arch/x86_64/kernel/reboot.c linux-RT.mich/arch/x86_64/kernel/reboot.c
--- linux-RT/arch/x86_64/kernel/reboot.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-RT.mich/arch/x86_64/kernel/reboot.c	2005-06-09 14:29:06.181607400 +0200
@@ -114,12 +114,12 @@ void machine_restart(char * __unused)
 #endif
 
 	if (!reboot_force) {
-		local_irq_disable();
+		raw_local_irq_disable();
 #ifndef CONFIG_SMP
 		disable_local_APIC();
 #endif
 		disable_IO_APIC();
-		local_irq_enable();
+		raw_local_irq_enable();
 	}
 	
 	/* Tell the BIOS if we want cold or warm reboot */

--------------090808050600010805080202--
