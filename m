Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVG2U7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVG2U7G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 16:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVG2U7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 16:59:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40687 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262286AbVG2U5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 16:57:20 -0400
Message-ID: <42EA97BB.8020001@mvista.com>
Date: Fri, 29 Jul 2005 13:55:23 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
References: <42E9ADB8.1010501@mvista.com>	<7911.1122613744@kao2.melbourne.sgi.com> <20050728221440.5a16d401.akpm@osdl.org>
In-Reply-To: <20050728221440.5a16d401.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------090608030002040804010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------090608030002040804010101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Keith Owens <kaos@sgi.com> wrote:
> 
>>>I had though that too, but it does not allow recovery (i.e. lets reset 
>>
>> >the watchdog and try again).
>>
>> die_nmi() returns to nmi_watchdog_tick(), nmi_watchdog_tick does the
>> reset and continues.  Patch below.
>>
>> >Hmm.. just looked at traps.c.  Seems die_nmi is NOT called from the nmi 
>> >trap, only from the watchdog.  Also, there is a notify in the path to 
>> >the other nmi stuff.
>>
>> I was looking at unknown_nmi_panic_callback(), which also calls
>> die_nmi().
>>
>> traps.c already has several notify_die() calls, nmi.c has none.  It is
>> cleaner to keep all the notification in traps.c, with this small change
>> to nmi.c to cope with die_nmi() returning.
>>
>> Index: linux/arch/i386/kernel/nmi.c
>> ===================================================================
>> --- linux.orig/arch/i386/kernel/nmi.c	2005-07-28 17:22:06.735038510 +1000
>> +++ linux/arch/i386/kernel/nmi.c	2005-07-29 15:19:00.371196596 +1000
>> @@ -494,8 +494,10 @@ void nmi_watchdog_tick (struct pt_regs *
>>  		 * wait a few IRQs (5 seconds) before doing the oops ...
>>  		 */
>>  		alert_counter[cpu]++;
>> -		if (alert_counter[cpu] == 5*nmi_hz)
>> +		if (alert_counter[cpu] == 5*nmi_hz) {
>>  			die_nmi(regs, "NMI Watchdog detected LOCKUP");
>> +			alert_counter[cpu] = 0;
>> +		}
>>  	} else {
>>  		last_irq_sums[cpu] = sum;
>>  		alert_counter[cpu] = 0;
> 
> 
> That all makes sense - let's go that way?

Looks good to me.  Trimed a bit more fat too.  Here is the complete patch.
> -
-
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------090608030002040804010101
Content-Type: text/plain;
 name="nmi-notify.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nmi-notify.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Enhancement 
Description:

	This patch adds a notify to the die_nmi notify that the system
	is about to be taken down.  If the notify is handled with a
	NOTIFY_STOP return, the system is given a new lease on life.

	We also change the nmi watchdog to carry on if die_nmi returns.

	This give debug code a chance to a) catch watchdog timeouts and
	b) possibly allow the system to continue, realizing that 
	the time out may be due to debugger activities such as single 
	stepping which is usually done with "other" cpus held.

Signed-off-by: George Anzinger<george@mvista.com>

 nmi.c   |    5 ++++-
 traps.c |    4 ++++
 2 files changed, 8 insertions(+), 1 deletion(-)

Index: linux-2.6.13-rc/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.13-rc.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.13-rc/arch/i386/kernel/nmi.c
@@ -495,8 +495,11 @@ void nmi_watchdog_tick (struct pt_regs *
 		 */
 		alert_counter[cpu]++;
 		if (alert_counter[cpu] == 5*nmi_hz)
+			/*
+			 * die_nmi will return ONLY if NOTIFY_STOP happens..
+			 */
 			die_nmi(regs, "NMI Watchdog detected LOCKUP");
-	} else {
+
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
 	}
Index: linux-2.6.13-rc/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.13-rc.orig/arch/i386/kernel/traps.c
+++ linux-2.6.13-rc/arch/i386/kernel/traps.c
@@ -555,6 +555,10 @@ static DEFINE_SPINLOCK(nmi_print_lock);
 
 void die_nmi (struct pt_regs *regs, const char *msg)
 {
+	if (notify_die(DIE_NMIWATCHDOG, "nmi_watchdog", regs, 
+		       0, 0, SIGINT) == NOTIFY_STOP)
+		return;
+
 	spin_lock(&nmi_print_lock);
 	/*
 	* We are in trouble anyway, lets at least try

--------------090608030002040804010101--
