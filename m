Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbVDRNSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbVDRNSe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 09:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVDRNSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 09:18:34 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:27602 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262071AbVDRNSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 09:18:18 -0400
Message-ID: <1560607.1113828722139.SLOX.WebMail.wwwrun@exchange.deltacomputer.de>
Date: Mon, 18 Apr 2005 14:52:02 +0200 (CEST)
From: Oliver Weihe <o.weihe@deltacomputer.de>
To: linux-kernel@vger.kernel.org
Subject: [2.6 PATCH] include/linux/jiffies.h cputime miscalculation
Cc: trivial@rustcorp.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3 (normal)
X-Mailer: SuSE Linux Openexchange Server 4 - WebMail (Build 2.3826)
X-Operating-System: Linux 2.4.21-241-smp i386 (JVM 1.3.1_04)
Organization: Delta Computer Products GmbH
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:62e2eaa30f0557f14c09a5fa777a0a78
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

static inline clock_t jiffies_to_clock_t(long x)
uses a signed long as input (jiffies) while the return value of
static inline unsigned long clock_t_to_jiffies(unsigned long x)
is an unsigned long.

As long as x is <= 0x7FFFFFFF everything is fine in jiffies_to_clock_t()
but when x is >= 0x80000000 the return value of the function is
miscalculated.

I've noticed this while watching the stats of long running processes
(/proc/<PID>/stat) on i386 machines. Up to ~35785 minutes of consumed
CPU-time for a process it's ok but only one minute later there's a huge
jump in the reported CPU-time to ~319786 minutes.

With the Patch you can get straight up to ~71571 minutes of CPU time
until
you'll restart at 0 (jiffies 32bit wrap around from (2**32)-1 to 0)

For non-i386 you may get other periods of time until the overflow
happens.

Signed-off-by: Oliver Weihe <o.weihe@deltacomputer.de>

Patch based on 2.6.11.7

--- include/linux/jiffies.h.orig 2005-04-18 14:57:42.000000000 +0200
+++ include/linux/jiffies.h     2005-04-18 14:58:05.000000000 +0200
@@ -380,7 +380,7 @@ jiffies_to_timeval(const unsigned long j
 /*
  * Convert jiffies/jiffies_64 to clock_t and back.
  */
-static inline clock_t jiffies_to_clock_t(long x)
+static inline clock_t jiffies_to_clock_t(unsigned long x)
 {
 #if (TICK_NSEC % (NSEC_PER_SEC / USER_HZ)) == 0
        return x / (HZ / USER_HZ);

