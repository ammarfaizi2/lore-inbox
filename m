Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751303AbWESJ0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbWESJ0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 05:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbWESJ0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 05:26:04 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:17931 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751271AbWESJ0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 05:26:03 -0400
Subject: Re: [PATCH] Fix a NO_IDLE_HZ timer bug
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Zachary Amsden <zach@vmware.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, george@mvista.com,
       Xen-devel <xen-devel@lists.xensource.com>
In-Reply-To: <446CDDAE.1070908@vmware.com>
References: <446CDDAE.1070908@vmware.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 19 May 2006 11:26:04 +0200
Message-Id: <1148030764.5350.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-18 at 13:48 -0700, Zachary Amsden wrote:
> It also looks like s390 has another bug.  When compiling the 32-bit 
> kernel, doesn't this computation overflow:
> 
> arch/s390/kernel/time.c, stop_hz_timer:274
> 
>         /*
>          * This cpu is going really idle. Set up the clock comparator
>          * for the next event.
>          */
>         next = next_timer_interrupt();
>         do {
>                 seq = read_seqbegin_irqsave(&xtime_lock, flags);
>                 timer = (__u64)(next - jiffies) + jiffies_64;
>         } while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
> 
> 
> Since jiffies can advance between next_timer_interrupt and the read 
> under xtime lock, next-jiffies could be negative.  I would think you 
> want to cast that to signed long instead of __u64, but I'm not totally 
> qualified to talk about s390.

Seems like you are qualified to talk about s390 in this case. The
extension of (next - jiffies) to a 64 bit value needs to be done as a
signed extension, follow by a cast to u64. Blech. I think to cast next
and jiffies to u64 before subtracting them is cleaner. It takes a few
more cycles because we now do two 64 bit adds/subtracts but the code is
used for going idle so it doesn't matter. Patch attached, thanks Zach.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.

--

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

[patch] s390: next_timer_interrupt overflow in stop_hz_timer.

The 32 bit unsigned substraction (next - jiffies) in stop_hz_timer
can overflow if jiffies gets advanced between next_timer_interrupt
and the read under the xtime lock. The cast to a u64 then results
in a large value which causes the cpu to wait too long.
Fix this by casting next and jiffies independently to u64 before
subtracting them.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/time.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -urpN linux-2.6/arch/s390/kernel/time.c linux-2.6-patched/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	2006-05-16 09:44:29.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/time.c	2006-05-19 11:04:04.000000000 +0200
@@ -272,7 +272,7 @@ static inline void stop_hz_timer(void)
 	next = next_timer_interrupt();
 	do {
 		seq = read_seqbegin_irqsave(&xtime_lock, flags);
-		timer = (__u64)(next - jiffies) + jiffies_64;
+		timer = (__u64 next) - (__u64 jiffies) + jiffies_64;
 	} while (read_seqretry_irqrestore(&xtime_lock, seq, flags));
 	todval = -1ULL;
 	/* Be careful about overflows. */


