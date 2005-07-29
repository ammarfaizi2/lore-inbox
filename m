Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbVG2FJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVG2FJd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbVG2FJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:09:33 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:49616 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262361AbVG2FJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:09:27 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: george@mvista.com
cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NMI watch dog notify patch 
In-reply-to: Your message of "Thu, 28 Jul 2005 21:16:56 MST."
             <42E9ADB8.1010501@mvista.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Jul 2005 15:09:04 +1000
Message-ID: <7911.1122613744@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2005 21:16:56 -0700, 
George Anzinger <george@mvista.com> wrote:
>Keith Owens wrote:
>> On Thu, 28 Jul 2005 13:31:58 -0700, 
>> George Anzinger <george@mvista.com> wrote:
>> 
>>>I have been doing some work on kgdb to pull a few of it "fingers" out of 
>>>various places in the kernel.  This is the final location where we have 
>>>a kgdb intercept not covered by a notify.
>> 
>> 
>> I like the idea, but the hook should be in die_nmi(), not in the
>> watchdog, using the reason that is already passed into die_nmi.
>> die_nmi() is also called for a real NMI.
>> 
>I had though that too, but it does not allow recovery (i.e. lets reset 
>the watchdog and try again).

die_nmi() returns to nmi_watchdog_tick(), nmi_watchdog_tick does the
reset and continues.  Patch below.

>Hmm.. just looked at traps.c.  Seems die_nmi is NOT called from the nmi 
>trap, only from the watchdog.  Also, there is a notify in the path to 
>the other nmi stuff.

I was looking at unknown_nmi_panic_callback(), which also calls
die_nmi().

traps.c already has several notify_die() calls, nmi.c has none.  It is
cleaner to keep all the notification in traps.c, with this small change
to nmi.c to cope with die_nmi() returning.

Index: linux/arch/i386/kernel/nmi.c
===================================================================
--- linux.orig/arch/i386/kernel/nmi.c	2005-07-28 17:22:06.735038510 +1000
+++ linux/arch/i386/kernel/nmi.c	2005-07-29 15:19:00.371196596 +1000
@@ -494,8 +494,10 @@ void nmi_watchdog_tick (struct pt_regs *
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz)
+		if (alert_counter[cpu] == 5*nmi_hz) {
 			die_nmi(regs, "NMI Watchdog detected LOCKUP");
+			alert_counter[cpu] = 0;
+		}
 	} else {
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;

