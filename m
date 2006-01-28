Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422807AbWA1CWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422807AbWA1CWx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 21:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422806AbWA1CWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 21:22:52 -0500
Received: from mail.kroah.org ([69.55.234.183]:33722 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1422804AbWA1CW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 21:22:27 -0500
Date: Fri, 27 Jan 2006 18:21:12 -0800
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       davem@davemloft.net, richm@oldelvet.org.uk
Subject: [patch 07/12] Fix timekeeping on sparc64 ultra-IIe machines
Message-ID: <20060128022112.GH17001@kroah.com>
References: <20060128020629.908825000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sparc64-fix-timekeeping-on-ultra-IIe-machines.patch"
In-Reply-To: <20060128022023.GA17001@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15.2 -stable review patch.  If anyone has any objections, please let 
us know.

------------------

From: Richard Mortimer <richm@oldelvet.org.uk>

[SPARC64]: Eliminate race condition reading Hummingbird STICK register

Ensure a consistent value is read from the STICK register by ensuring
that both high and low are read without high changing due to a roll
over of the low register.

Various Debian/SPARC users (myself include) have noticed problems with
Hummingbird based systems. The symptoms are that the system time is
seen to jump forward 3 days, 6 hours, 11 minutes give or take a few
seconds. In many cases the system then hangs some time afterwards.

I've spotted a race condition in the code to read the STICK register.
I could not work out why 3d, 6h, 11m is important but guess that it is
due to the 2^32 jump of STICK (forwards on one read and then the next
read will seem to be backwards) during a timer interrupt. I'm guessing
that a change of -2^32 will get converted to a large unsigned
increment after the arithmetic manipulation between STICK,
nanoseconds, jiffies etc.

I did a test where I modified __hbird_read_stick to artificially
inject rollover faults forcefully every few seconds. With this I saw
the clock jump over 6 times in 12 hours compared to once every month
or so.

Signed-off-by: Richard Mortimer <richm@oldelvet.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/sparc64/kernel/time.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- linux-2.6.15.1.orig/arch/sparc64/kernel/time.c
+++ linux-2.6.15.1/arch/sparc64/kernel/time.c
@@ -280,9 +280,9 @@ static struct sparc64_tick_ops stick_ope
  * Since STICK is constantly updating, we have to access it carefully.
  *
  * The sequence we use to read is:
- * 1) read low
- * 2) read high
- * 3) read low again, if it rolled over increment high by 1
+ * 1) read high
+ * 2) read low
+ * 3) read high again, if it rolled re-read both low and high again.
  *
  * Writing STICK safely is also tricky:
  * 1) write low to zero
@@ -295,18 +295,18 @@ static struct sparc64_tick_ops stick_ope
 static unsigned long __hbird_read_stick(void)
 {
 	unsigned long ret, tmp1, tmp2, tmp3;
-	unsigned long addr = HBIRD_STICK_ADDR;
+	unsigned long addr = HBIRD_STICK_ADDR+8;
 
-	__asm__ __volatile__("ldxa	[%1] %5, %2\n\t"
-			     "add	%1, 0x8, %1\n\t"
-			     "ldxa	[%1] %5, %3\n\t"
+	__asm__ __volatile__("ldxa	[%1] %5, %2\n"
+			     "1:\n\t"
 			     "sub	%1, 0x8, %1\n\t"
+			     "ldxa	[%1] %5, %3\n\t"
+			     "add	%1, 0x8, %1\n\t"
 			     "ldxa	[%1] %5, %4\n\t"
 			     "cmp	%4, %2\n\t"
-			     "blu,a,pn	%%xcc, 1f\n\t"
-			     " add	%3, 1, %3\n"
-			     "1:\n\t"
-			     "sllx	%3, 32, %3\n\t"
+			     "bne,a,pn	%%xcc, 1b\n\t"
+			     " mov	%4, %2\n\t"
+			     "sllx	%4, 32, %4\n\t"
 			     "or	%3, %4, %0\n\t"
 			     : "=&r" (ret), "=&r" (addr),
 			       "=&r" (tmp1), "=&r" (tmp2), "=&r" (tmp3)

--
