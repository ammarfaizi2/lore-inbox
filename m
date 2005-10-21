Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbVJUKPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbVJUKPk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 06:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbVJUKPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 06:15:40 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:52932 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932561AbVJUKPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 06:15:39 -0400
Date: Fri, 21 Oct 2005 12:16:01 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Felix Oxley <lkml@oxley.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
       Steven Rostedt <rostedt@goodmis.org>,
       Fernando Lopez-Lezcano <nando@ccrma.stanford.edu>
Subject: Re: 2.6.14-rc5-rt1
Message-ID: <20051021101601.GA11991@elte.hu>
References: <20051017160536.GA2107@elte.hu> <20051020195432.GA21903@elte.hu> <200510210033.49652.lkml@oxley.org> <200510211101.18391.lkml@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510211101.18391.lkml@oxley.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Felix Oxley <lkml@oxley.org> wrote:

> A second build error with make allyesconfig:

ah, indeed.

> Seems to be a probelm with definition ktimer_trace :
> 
> Signed-off-by: Felix Oxley <lkml@oxley.org>
> ---
> --- include/linux/ktimer.h		2005-10-21 00:20:03.000000000 +0100
> +++ include/linux/ktimer.h	 	2005-10-21 10:55:44.000000000 +0100
> @@ -141,7 +141,7 @@ extern int ktimer_interrupt(void);
>  #define KTIME_REALTIME_RES             CONFIG_HIGH_RES_RESOLUTION
>  #define KTIME_MONOTONIC_RES            CONFIG_HIGH_RES_RESOLUTION
> 
> -#define ktimer_trace(a,b)              trace_special((a).tv.sec,(a).tv.nsec,b)
> +#define ktimer_trace(a,b)              trace_special((a).tv_sec,(a).tv_nsec,b)

yeah. Btw., your fix is still not complete (it wont work with the scalar 
representation of ktime_t, on 64-bit platforms) - the full solution 
should be the patch below.

	Ingo

Index: linux/include/linux/ktimer.h
===================================================================
--- linux.orig/include/linux/ktimer.h
+++ linux/include/linux/ktimer.h
@@ -141,7 +141,7 @@ extern int ktimer_interrupt(void);
 #define KTIME_REALTIME_RES		CONFIG_HIGH_RES_RESOLUTION
 #define KTIME_MONOTONIC_RES		CONFIG_HIGH_RES_RESOLUTION
 
-#define ktimer_trace(a,b)		trace_special((a).tv.sec,(a).tv.nsec,b)
+#define ktimer_trace(a,b)		trace_special(ktime_get_high(a),ktime_get_low(a),b)
 
 #else
 
