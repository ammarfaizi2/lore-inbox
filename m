Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTJ1BRb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 20:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263801AbTJ1BRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 20:17:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:18087 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263798AbTJ1BRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 20:17:30 -0500
Date: Mon, 27 Oct 2003 17:17:38 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Joe Korty <joe.korty@ccur.com>, Linus Torvalds <torvalds@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: gettimeofday resolution seriously degraded in test9
Message-Id: <20031027171738.1f962565.shemminger@osdl.org>
In-Reply-To: <1067300966.1118.378.camel@cog.beaverton.ibm.com>
References: <20031027234447.GA7417@rudolph.ccur.com>
	<1067300966.1118.378.camel@cog.beaverton.ibm.com>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arghh... the patch was being way more agressive than necessary.  
tickadj which limits NTP is always 1 (for HZ=1000) so NTP will change
at most 1 us per clock tick.  This meant we only had to stop time
for the last us of the interval.


diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	Mon Oct 27 17:13:22 2003
+++ b/arch/i386/kernel/time.c	Mon Oct 27 17:13:22 2003
@@ -110,8 +110,9 @@
 		 * so make sure not to go into next possible interval.
 		 * Better to lose some accuracy than have time go backwards..
 		 */
-		if (unlikely(time_adjust < 0) && usec > tickadj)
-			usec = tickadj;
+		if (unlikely(time_adjust < 0) && 
+		    unlikely(usec > tick_usec - tickadj)) 
+			usec = tick_usec - tickadj;
 
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
