Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261314AbVHAXAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbVHAXAf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVHAXAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:00:35 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26614 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261318AbVHAXA2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:00:28 -0400
Message-ID: <42EEA910.5060902@mvista.com>
Date: Mon, 01 Aug 2005 15:58:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
References: <12270.1122693891@ocs3.ocs.com.au>
In-Reply-To: <12270.1122693891@ocs3.ocs.com.au>
Content-Type: multipart/mixed;
 boundary="------------080901070804000000030800"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080901070804000000030800
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Keith Owens wrote:
> On Fri, 29 Jul 2005 13:55:23 -0700, 
> George Anzinger <george@mvista.com> wrote:
> 
>>	This patch adds a notify to the die_nmi notify that the system
>>	is about to be taken down.  If the notify is handled with a
>>	NOTIFY_STOP return, the system is given a new lease on life.
>>
>>void die_nmi (struct pt_regs *regs, const char *msg)
>>{
>>+	if (notify_die(DIE_NMIWATCHDOG, "nmi_watchdog", regs, 
>>+		       0, 0, SIGINT) == NOTIFY_STOP)
>>+		return;
>>+
>>	spin_lock(&nmi_print_lock);
>>	/*
>>	* We are in trouble anyway, lets at least try
> 
> 
> Minor nitpick.  die_nmi() already gets a message passed in to
> distinguish between different types of nmi.  Pass that message to
> notify_die(), on the off chance that the notified routines can use that
> difference.

Excellent idea!
> 
> Also your patch adds a trailing whitespace on the call to notify_die().
> 
Fixed.

This should do it.
-
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------080901070804000000030800
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
+	if (notify_die(DIE_NMIWATCHDOG, msg, regs, 0, 0, SIGINT) ==
+	    NOTIFY_STOP)
+		return;
+
 	spin_lock(&nmi_print_lock);
 	/*
 	* We are in trouble anyway, lets at least try

--------------080901070804000000030800--
