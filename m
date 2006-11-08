Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161716AbWKHTWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161716AbWKHTWm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161719AbWKHTWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:22:42 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:2609 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1161716AbWKHTWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:22:41 -0500
Message-ID: <45522E7F.2050503@mvista.com>
Date: Wed, 08 Nov 2006 11:22:39 -0800
From: Kevin Hilman <khilman@mvista.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: john cooper <john.cooper@third-harmonic.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rt7: rollover with 32-bit cycles_t
References: <4551348B.6070604@mvista.com> <45513BB6.4010308@third-harmonic.com>
In-Reply-To: <45513BB6.4010308@third-harmonic.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

john cooper wrote:
> Kevin Hilman wrote:
>> On ARM, I'm noticing the 'bug' message from check_critical_timing()
>> where two calls to get_cycles() are compared and the 2nd is assumed to
>> be >= the first.
>>
>> This isn't properly handling the case of rollover which occurs
>> relatively often with fast hardware clocks and 32-bit cycle counters.
>>
>> Is this really a bug?  If the get_cycles() can be assumed to run between
>> 0 and (cycles_t)~0, using the right unsigned math could get a proper
>> delta even in the rollover case.  Is this a safe assumption?
> 
> I was concerned about that as well back when I was getting the
> instrumentation functional on the pxa270 as the rollover could
> be as short as ~8s which wasn't really long enough for test
> validation.  However there is a /64 prescaler on that ARM core
> (and others) which can function as a bandaid and extend the range
> to ~8minutes.
> 
> I wasn't able to convince myself in a quick read of the code if
> roll over was being detected/corrected (though it certainly may).
> But even if not the only requirement needed to do so would be to
> assure any two consecutive data points logged per CPU were spaced
> apart less than the counter's wrap interval.  Given the periodic
> events being logged in the normal course of operation this condition
> would certainly be met.

Looking closer, given the assumptions you stated, I'm pretty convinced
that that check and 'bug' is unncessary in the normal case.  The delta
generated with unsigned math is correct.

However, it seems this check is more intended to check for
broken/backward-running clocks.  In which case, time_after() or
equivalent should be used.

Here's a patch to use time_after() in the 32-bit case, but we probably
really need time_after() macros which can handle 32- or 64-bit types.


Index: linux-2.6.18/kernel/latency_trace.c
===================================================================
--- linux-2.6.18.orig/kernel/latency_trace.c
+++ linux-2.6.18/kernel/latency_trace.c
@@ -1609,8 +1609,14 @@ check_critical_timing(int cpu, struct cp
 	 * is fair to be reported):
 	 */
 	T2 = get_cycles();
-	if (T2 < T1)
+
+	/* check for buggy clocks, handling wrap for 32-bit clocks */
+	if (TYPE_EQUAL(cycles_t, unsigned long)) {
+		if (time_after(T1, T2))
+			printk("bug: %08x < %08x!\n", T2, T1);
+	} else if (T2 < T1)
 		printk("bug: %016Lx < %016Lx!\n", T2, T1);
+	
 	delta = T2-T0;

 	latency = cycles_to_usecs(delta);



