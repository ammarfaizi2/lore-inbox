Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752489AbWCGMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbWCGMIu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752490AbWCGMIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:08:50 -0500
Received: from c-14c1e455.43-25-64736c10.cust.bredbandsbolaget.se ([85.228.193.20]:28111
	"HELO styx.klippanlan.net") by vger.kernel.org with SMTP
	id S1752489AbWCGMIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:08:49 -0500
Message-ID: <002b01c641df$e0d49b20$072011ac@majestix>
From: "PaNiC" <panic@klippanlan.net>
To: <jzb@aexorsyst.com>
Cc: <linux-kernel@vger.kernel.org>
References: <001501c64119$6d8e7bc0$072011ac@majestix> <200603060933.57036.jzb@aexorsyst.com>
Subject: Re: Problem: NIC transmit timeouts
Date: Tue, 7 Mar 2006 13:08:42 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your reply.
I have an idea what you're talking about, but no more i'm afraid.
I'm no programmer and i don't know how to try what you suggested.
What i did try was applying some patches manually that i found in the 
mailing list archives.

This is one of them:

--- drivers/net/sunhme.c.~1~ Sun Aug 11 18:37:34 2002
+++ drivers/net/sunhme.c Sun Aug 11 18:38:17 2002
@@ -1640,6 +1640,7 @@
  HMD((", enable global interrupts, "));
  hme_write32(hp, gregs + GREG_IMASK,
       (GREG_IMASK_GOTFRAME | GREG_IMASK_RCNTEXP |
+ GREG_IMASK_TXALL |
        GREG_IMASK_SENTFRAME | GREG_IMASK_TXPERR));

  /* Set the transmit ring buffer size. */
@@ -2125,8 +2126,8 @@
   happy_meal_mif_interrupt(hp);
  }

- if (happy_status & GREG_STAT_TXALL) {
- HMD(("TXALL "));
+ if (happy_status & GREG_STAT_HOSTTOTX) {
+ HMD(("HOSTTOTX "));
   happy_meal_tx(hp);
  }

@@ -2155,7 +2156,7 @@

   if (!(happy_status & (GREG_STAT_ERRORS |
           GREG_STAT_MIFIRQ |
- GREG_STAT_TXALL |
+ GREG_STAT_HOSTTOTX |
           GREG_STAT_RXTOHOST)))
    continue;

@@ -2172,8 +2173,8 @@
    happy_meal_mif_interrupt(hp);
   }

- if (happy_status & GREG_STAT_TXALL) {
- HMD(("TXALL "));
+ if (happy_status & GREG_STAT_HOSTTOTX) {
+ HMD(("HOSTTOTX "));
    happy_meal_tx(hp);
   }

The other just put a "udelay(1)" on line 1999 of sunhme.c.
With the udelay(1) it seemed like after a reboot it would take longer 
for the timeout to happen. The other made no difference.

Very thankful for your time.
Jonas



----- Original Message ----- 
From: "John Z. Bohach" <jzb@aexorsyst.com>
To: "PaNiC" <panic@klippanlan.net>; <linux-kernel@vger.kernel.org>
Sent: Monday, March 06, 2006 6:33 PM
Subject: Re: Problem: NIC transmit timeouts


> On Monday 06 March 2006 04:28, PaNiC wrote:
>> 1. The problem is that the outbound interface in a Sun Enterprise 250
>> running maquerade gets transmit timeouts frequently.
>>
>> 2. I get the error "NETDEV WATCHDOG: eth0: transmit timed out" and a
>> couple of seconds later the     interface jumps back up again. This
>
> I can't say what the cause of your particular NETDEV WATCHDOG timeout 
> may
> be, but I had the same problem, and I root-caused it to the host bus 
> <--> PCI bridge
> configuration.  In particular, the multi-transaction timeout register 
> in the bridge
> wasn't programmed, and heavy PCI traffic would cause aborts.  Also, 
> the
> ICH configuration register had to be programmed according to the 
> manufacturer's
> recommendations.
>
> This was on Intel h/w, and the registers to which I refer are
> proprietary, so its a bit difficult to know what values to program 
> where,
> but it might give you a place to start.  On the other hand, some 
> people have
> reported issues with their device driver causing some timeouts, but 
> your symptoms
> seem to more closely resemble what I was seeing than those folks who 
> had
> s/w issues.
>
> Regards,
> John
>
>
> 


