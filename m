Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbVG1Uiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbVG1Uiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261664AbVG1UgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:36:25 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:27899 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262040AbVG1Udy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:33:54 -0400
Message-ID: <42E940BE.3020908@mvista.com>
Date: Thu, 28 Jul 2005 13:31:58 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] NMI watch dog notify patch
Content-Type: multipart/mixed;
 boundary="------------090304050303070407020405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------090304050303070407020405
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,
I have been doing some work on kgdb to pull a few of it "fingers" out of 
various places in the kernel.  This is the final location where we have 
a kgdb intercept not covered by a notify.

On a related issue, I feel very queasy with sending nmi interrupts and 
non-nmi events to the same notify code.  Would you be open to a patch to 
create a seperate notify list for nmi events?


-
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------090304050303070407020405
Content-Type: text/plain;
 name="nmi-notify.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi-notify.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Enhancement 
Description:
	This patch adds a notify to the nmi watchdog to notify that
	the system is about to be taken down by the watchdog.  If the
	notify is handled with a NOTIFY_STOP return, the system is
	given a new lease on life.

	This give debug code a chance to a) catch watchdog timeouts and
	b) possibly allow the system to continue, realizing that 
	the time out may be due to debugger activities such as single 
	stepping which is usually done with "other" cpus held.

Signed-off-by: George Anzinger<george@mvista.com>

 nmi.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

Index: linux-2.6.13-rc/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.13-rc.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.13-rc/arch/i386/kernel/nmi.c
@@ -26,11 +26,13 @@
 #include <linux/nmi.h>
 #include <linux/sysdev.h>
 #include <linux/sysctl.h>
+#include <linux/notifier.h>
 
 #include <asm/smp.h>
 #include <asm/mtrr.h>
 #include <asm/mpspec.h>
 #include <asm/nmi.h>
+#include <asm/kdebug.h>
 
 #include "mach_traps.h"
 
@@ -494,8 +496,15 @@ void nmi_watchdog_tick (struct pt_regs *
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz)
-			die_nmi(regs, "NMI Watchdog detected LOCKUP");
+		if (alert_counter[cpu] == 5*nmi_hz) {
+			if (notify_die(DIE_NMIWATCHDOG, "nmi_ipi_watchdog", 
+				       regs, 0, 0, SIGINT) == NOTIFY_STOP) {
+				last_irq_sums[cpu] = sum;
+				alert_counter[cpu] = 0;
+			} else {
+				die_nmi(regs, "NMI Watchdog detected LOCKUP");
+			}
+		}
 	} else {
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
@@ -555,7 +564,7 @@ int proc_unknown_nmi_panic(ctl_table *ta
 			return -EBUSY;
 		} else {
 			set_nmi_callback(unknown_nmi_panic_callback);
-		}
+		} 
 	} else {
 		release_lapic_nmi();
 		unset_nmi_callback();

--------------090304050303070407020405--
