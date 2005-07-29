Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVG2FP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVG2FP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVG2FP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:15:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:29343 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262357AbVG2FP4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:15:56 -0400
Date: Thu, 28 Jul 2005 22:14:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@sgi.com>
Cc: george@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI watch dog notify patch
Message-Id: <20050728221440.5a16d401.akpm@osdl.org>
In-Reply-To: <7911.1122613744@kao2.melbourne.sgi.com>
References: <42E9ADB8.1010501@mvista.com>
	<7911.1122613744@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@sgi.com> wrote:
>
> >I had though that too, but it does not allow recovery (i.e. lets reset 
>  >the watchdog and try again).
> 
>  die_nmi() returns to nmi_watchdog_tick(), nmi_watchdog_tick does the
>  reset and continues.  Patch below.
> 
>  >Hmm.. just looked at traps.c.  Seems die_nmi is NOT called from the nmi 
>  >trap, only from the watchdog.  Also, there is a notify in the path to 
>  >the other nmi stuff.
> 
>  I was looking at unknown_nmi_panic_callback(), which also calls
>  die_nmi().
> 
>  traps.c already has several notify_die() calls, nmi.c has none.  It is
>  cleaner to keep all the notification in traps.c, with this small change
>  to nmi.c to cope with die_nmi() returning.
> 
>  Index: linux/arch/i386/kernel/nmi.c
>  ===================================================================
>  --- linux.orig/arch/i386/kernel/nmi.c	2005-07-28 17:22:06.735038510 +1000
>  +++ linux/arch/i386/kernel/nmi.c	2005-07-29 15:19:00.371196596 +1000
>  @@ -494,8 +494,10 @@ void nmi_watchdog_tick (struct pt_regs *
>   		 * wait a few IRQs (5 seconds) before doing the oops ...
>   		 */
>   		alert_counter[cpu]++;
>  -		if (alert_counter[cpu] == 5*nmi_hz)
>  +		if (alert_counter[cpu] == 5*nmi_hz) {
>   			die_nmi(regs, "NMI Watchdog detected LOCKUP");
>  +			alert_counter[cpu] = 0;
>  +		}
>   	} else {
>   		last_irq_sums[cpu] = sum;
>   		alert_counter[cpu] = 0;

That all makes sense - let's go that way?
