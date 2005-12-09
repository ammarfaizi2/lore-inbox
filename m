Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVLIQeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVLIQeE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVLIQeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:34:04 -0500
Received: from zproxy.gmail.com ([64.233.162.201]:60636 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932352AbVLIQeB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:34:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X3PtltxGSaDV26oFSQH89H6cSgbyFkSe4jJ/4ampmzGfKsbb1auDCvO5xDmVzj0DDaXldNtWOGxcvYkiTBb8zbtLoCqcp9PTo4fUwV4Vbwj2gk+xlxPH8JBKI7s6g4u1d9BzE+mZRPxt4Gryj7ETdKybf3ZSRE7r/+b/VyAtHzA=
Message-ID: <8783be660512090834l40b5c051p6c58676bccc834fc@mail.gmail.com>
Date: Fri, 9 Dec 2005 11:34:00 -0500
From: Ross Biro <ross.biro@gmail.com>
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH 2.6.14] X86_64 delay resolution
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On x86_64 smp systems, we noticed that the amount of time udelay would
spin for varied from cpu to cpu.  In our test case, udelay(10) would
only delay for 9.7us on some cpus while on others it would delay for
the full 10us.  We tracked the problem down to an unnecessary attempt
to avoid arithmetic overflow.  Here's a fix complete with an overly
verbose comment.

--- ../linux-2.6.14/arch/x86_64/lib/delay.c     2005-10-27
20:02:08.000000000 -0400
+++ arch/x86_64/lib/delay.c     2005-12-09 11:21:33.000000000 -0500
@@ -37,9 +37,16 @@
        while((now-bclock) < loops);
 }

+/*
+ * We should be able to do this multiplication with out overflowing
provided the
+ * cpu is running at less than about 128 GHz.  xloops < 20000 * 0x10c6.
+ * loops_per_jiffy * HZ <= cpu_clock_speed.  So if the cpu clock speed
+ * < 2^64/(20000 * 0x10c6) = 2^64/ 51E6CC0 < 2^64/2^27 = 2^37 = 128G we
+ * will not overflow the calculation.
+ */
  inline void __const_udelay(unsigned long xloops)
 {
-       __delay(((xloops *
cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32) * HZ);
+       __delay(((xloops * HZ *
cpu_data[raw_smp_processor_id()].loops_per_jiffy) >> 32));
 }

This patch is against 2.6.15-rc5-git1, but the code in question hasn't
changed for quite a while, so it should apply cleanly to most later
2.6 kernels.

Since it's possible, although unlikely, that some device drivers
depend on the lack of resolution of the timer, the conservative thing
to do would be to apply this fix to the -mm kernels and let it sit for
a bit.

We only found this because we made another change that might have
impacted udelay, so we tested udelay to make sure it was still working
properly.  In particular, I'm not aware of any problems that can be
traced to udelay or ndelay having a resolution of HZ/2^32 seconds.

    Ross
