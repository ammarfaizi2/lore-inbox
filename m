Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbTFLAZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 20:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbTFLAZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 20:25:27 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:24535 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264635AbTFLAZ0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 20:25:26 -0400
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
From: john stultz <johnstul@us.ibm.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: Andi Kleen <ak@suse.de>, vojtech@suse.cz, discuss@x86-64.org,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com>
	 <20030611191815.GA30411@wotan.suse.de>
	 <1055361411.17154.83.camel@serpentine.internal.keyresearch.com>
	 <1055362249.17154.86.camel@serpentine.internal.keyresearch.com>
	 <1055366609.18643.63.camel@w-jstultz2.beaverton.ibm.com>
	 <1055367412.17154.100.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055378035.18643.95.camel@w-jstultz2.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 11 Jun 2003 17:33:55 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-11 at 14:36, Bryan O'Sullivan wrote:
> On Wed, 2003-06-11 at 14:23, john stultz wrote:
> 
> > Hmmm. Thats likely part to blame for the lost-ticks code not working. I
> > believe tick_usec is calculated USER_HZ rather then HZ, so you'll be off
> > by an order of magnitude. I ran into the exact same problem. 
> 
> Unlikely.  On my systems, the offset values are off by three orders of
> magnitude, and are always negative.  There's a more basic error
> somewhere before that test.

Actually it was related. Right before the lines I quoted you subtract
tick_usec from the offset calculation. Since tick_usec is 10,000 rather
then 1,000, offset goes negative and bad stuff ensues.

This patch applies on top of Bryan's patch, and solves the major time
inconsistencies I was seeing earlier. I don't like that I still have to
have the sanity check on offset to ensure it doesn't go negative
(frequently I get offsets of -1), and that along with the fact that I'm
seeing a steady drift forward on every kernel I've run (2.4/2.5) makes
me think that the timer interrupt frequency may be a bit higher then we
intend. Might just be the dev hardware I'm running on, though.

I'm also got some cleanup changes I'd like to make, but I'll wait until
after things work to polish that stuff up. 

Let me know if you have any issues with this patch. 

thanks
-john

diff -Nru a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
--- a/arch/x86_64/kernel/time.c	Wed Jun 11 17:28:07 2003
+++ b/arch/x86_64/kernel/time.c	Wed Jun 11 17:28:07 2003
@@ -254,11 +254,14 @@
 		vxtime.last = offset;
 	} else {
 		offset = (((tsc - vxtime.last_tsc) *
-			   vxtime.tsc_quot) >> 32) - tick_usec;
+			   vxtime.tsc_quot) >> 32) - (USEC_PER_SEC/HZ);
+		/* sanity check on offset */
+		if(offset < 0)
+			offset = 0;
 
-		if (offset > tick_usec) {
-			lost = offset / tick_usec;
-			offset %= tick_usec;
+		if (offset > (USEC_PER_SEC/HZ)) {
+			lost = offset / (USEC_PER_SEC/HZ);
+			offset %= (USEC_PER_SEC/HZ);
 		}
 
 		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
@@ -275,10 +278,7 @@
 			       "tick(s)! (rip %016lx)\n",
 			       (offset - vxtime.last) / hpet_tick - 1,
 			       regs->rip);
-		// XXX The accounting of lost ticks is way off right
-		// now. -bos
-
-		// jiffies += lost;
+		jiffies += lost;
 	}
 
 /*



