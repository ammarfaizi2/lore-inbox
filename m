Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264066AbTGAWYK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 18:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264067AbTGAWYK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 18:24:10 -0400
Received: from web13808.mail.yahoo.com ([216.136.175.18]:23314 "HELO
	web13808.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264066AbTGAWYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 18:24:06 -0400
Message-ID: <20030701223829.45433.qmail@web13808.mail.yahoo.com>
Date: Tue, 1 Jul 2003 15:38:29 -0700 (PDT)
From: "M.L.PrasannaK.R." <mlpkr@yahoo.com>
Subject: balance_irq()'s move() hang in machine_restart()
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ingo,

The method suggested at the following link does not work.
   http://www.ussg.iu.edu/hypermail/linux/kernel/0304.1/0558.html

smp_call-function(stop_this_cpu, NULL, 1, 1) will never return from
the for loop.

Source from http://lxr.linux.no/source/arch/i386/kernel/smp.c#L569
569 static void stop_this_cpu (void * dummy)
570 {
571         /*
572          * Remove this CPU:
573          */
574         clear_bit(smp_processor_id(), &cpu_online_map);
575         __cli();
576         disable_local_APIC();
577         if (cpu_data[smp_processor_id()].hlt_works_ok)
578                 for(;;) __asm__("hlt");
579         for(;;)      
580}

The following fix seemed to break this infinite loop. Is this proper?

---linux.saved/arch/i386/kernel/io_apic.c Thu Jun 26 05:37:25 2003
+++ linux/arch/i386/kernel/io_apic.c    Thu Jun 26 05:39:15 2003
@@ -228,6 +228,10 @@
                if (unlikely(cpu == curr_cpu))
                        search_idle = 0;
 inside:
+               if (unlikely(smp_num_cpus == 1)) {
+                       return curr_cpu;
+               }
+
                if (direction == 1) {
                        cpu++;
                        if (cpu >= smp_num_cpus)


Thanks,
Prasanna.


__________________________________
Do you Yahoo!?
SBC Yahoo! DSL - Now only $29.95 per month!
http://sbc.yahoo.com
