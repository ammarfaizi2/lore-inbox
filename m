Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWBSXzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWBSXzf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 18:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWBSXzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 18:55:35 -0500
Received: from proof.pobox.com ([207.106.133.28]:15047 "EHLO proof.pobox.com")
	by vger.kernel.org with ESMTP id S932455AbWBSXze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 18:55:34 -0500
Date: Sun, 19 Feb 2006 17:58:26 -0600
From: Nathan Lynch <ntl@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: i386 cpu hotplug bug - instant reboot when onlining secondary
Message-ID: <20060219235826.GF3293@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi-

On a dual P3 Xeon machine, offlining and then onlining a cpu makes the
box instantly reboot.  I've been seeing this throughout the 2.6.16-rc
series, but wasn't able to collect more information until now.  Not
sure when this last worked, unfortunately.

With the debugging patch below, I get this on serial console:

[17179681.704000] CPU 1 is now offline
[17179686.908000] Booting processor 1/1 eip 3000
[17179686.912000] CPU 1 irqstacks, hard=78383000 soft=7837b000
[17179686.920000] Setting warm reset code and vector.
[17179686.924000] 1.
[17179686.924000] 2.
[17179686.928000] 3.
[17179686.928000] Asserting INIT.
[17179686.932000] Waiting for send to finish...
[17179686.936000] +<7>Deasserting INIT.
[17179686.952000] Waiting for send to finish...
[17179686.956000] +<7>#startup loops: 2.
[17179686.960000] Sending STARTUP #1.
[17179686.960000] After apic_write.
[17179686.964000] Doing apic_write_around for target chip...
[17179686.972000] Doing apic_write_around to kick the second...

Any suggestions?


diff --git a/arch/i386/kernel/smpboot.c b/arch/i386/kernel/smpboot.c
index fb00ab7..85aff00 100644
--- a/arch/i386/kernel/smpboot.c
+++ b/arch/i386/kernel/smpboot.c
@@ -801,10 +801,12 @@ wakeup_secondary_cpu(int phys_apicid, un
 		 */
 
 		/* Target chip */
+		Dprintk("Doing apic_write_around for target chip...\n");
 		apic_write_around(APIC_ICR2, SET_APIC_DEST_FIELD(phys_apicid));
 
 		/* Boot on the stack */
 		/* Kick the second */
+		Dprintk("Doing apic_write_around to kick the second...\n");
 		apic_write_around(APIC_ICR, APIC_DM_STARTUP
 					| (start_eip >> 12));
 
diff --git a/include/asm-i386/apic.h b/include/asm-i386/apic.h
index d30b857..2c8dcfa 100644
--- a/include/asm-i386/apic.h
+++ b/include/asm-i386/apic.h
@@ -8,7 +8,7 @@
 #include <asm/processor.h>
 #include <asm/system.h>
 
-#define Dprintk(x...)
+#define Dprintk(fmt,arg...) printk(KERN_DEBUG fmt,##arg)
 
 /*
  * Debugging macros
