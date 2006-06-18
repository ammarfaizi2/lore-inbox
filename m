Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWFRQfU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWFRQfU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 12:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbWFRQfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 12:35:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41826 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932243AbWFRQfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 12:35:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dcY0ttIJVB/NkOdpyTqPYmHW9WppLrswk0MeX4oxTDFRqbBy4H26gKLWaCepjGHe6bEm9VIdHZgTDD1qODAmrnJommsoFhHREvaKW04q/kt4P/HeL2wGYmyrduppzTic3Af1XMM+m3EbeMXKp2Ixd6pGcQ8QDUhqM3YefR5olZU=
Message-ID: <449580CA.2060704@gmail.com>
Date: Sun, 18 Jun 2006 18:35:22 +0200
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: tglx@timesys.com
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCHSET] Announce: High-res timers, tickless/dyntick and dynamic
 HZ
References: <1150643426.27073.17.camel@localhost.localdomain>
In-Reply-To: <1150643426.27073.17.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thomas Gleixner napisa³(a):
> We are pleased to announce the 2.6.17 based release of our high-res 
> timers kernel feature, upon which we based a tickless kernel (dyntick) 
> implementation and a 'dynamic HZ' feature as well:
> 
> http://www.tglx.de/projects/hrtimers/2.6.17/
> 
[snip]

I get a lot of

WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/sound/pci/ac97/snd-ac97-codec.ko needs unknown symbol msecs_to_jiffies
WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/net/skge.ko needs unknown symbol jiffies_to_msecs
WARNING: /lib/modules/2.6.17-hrt-dyntick1/kernel/drivers/cpufreq/cpufreq_ondemand.ko needs unknown symbol jiffies_to_usecs
etc...

warnings.

Here is fix small fix.

Regards,
Michal

--
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/

diff -uprN -X linux-work/Documentation/dontdiff linux-work-clean/kernel/time.c linux-work/kernel/time.c
--- linux-work-clean/kernel/time.c	2006-06-18 18:16:29.000000000 +0200
+++ linux-work/kernel/time.c	2006-06-18 18:25:42.000000000 +0200
@@ -660,6 +660,8 @@ unsigned int jiffies_to_msecs(const unsi
 #endif
 }

+EXPORT_SYMBOL(jiffies_to_msecs);
+
 unsigned int jiffies_to_usecs(const unsigned long j)
 {
 #if HZ <= USEC_PER_SEC && !(USEC_PER_SEC % HZ)
@@ -671,6 +673,8 @@ unsigned int jiffies_to_usecs(const unsi
 #endif
 }

+EXPORT_SYMBOL(jiffies_to_usecs);
+
 /*
  * When we convert to jiffies then we interpret incoming values
  * the following way:
@@ -724,6 +728,9 @@ unsigned long msecs_to_jiffies(const uns
 	return (m * HZ + MSEC_PER_SEC - 1) / MSEC_PER_SEC;
 #endif
 }
+
+EXPORT_SYMBOL(msecs_to_jiffies);
+
 unsigned long usecs_to_jiffies(const unsigned int u)
 {
 	if (u > jiffies_to_usecs(MAX_JIFFY_OFFSET))
@@ -737,6 +744,8 @@ unsigned long usecs_to_jiffies(const uns
 #endif
 }

+EXPORT_SYMBOL(usecs_to_jiffies);
+
 /*
  * The TICK_NSEC - 1 rounds up the value to the next resolution.  Note
  * that a remainder subtract here would not do the right thing as the
@@ -830,6 +839,8 @@ clock_t jiffies_to_clock_t(long x)
 #endif
 }

+EXPORT_SYMBOL(jiffies_to_clock_t);
+
 unsigned long clock_t_to_jiffies(unsigned long x)
 {
 #if (HZ % USER_HZ)==0
@@ -850,6 +861,8 @@ unsigned long clock_t_to_jiffies(unsigne
 #endif
 }

+EXPORT_SYMBOL(clock_t_to_jiffies);
+
 u64 jiffies_64_to_clock_t(u64 x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
