Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261565AbSJMNkc>; Sun, 13 Oct 2002 09:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261566AbSJMNkc>; Sun, 13 Oct 2002 09:40:32 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6916 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261565AbSJMNkb>; Sun, 13 Oct 2002 09:40:31 -0400
Date: Sun, 13 Oct 2002 09:38:21 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re:Benchmark results from resp1 trivial response time test
In-Reply-To: <20021013115743.11384.qmail@linuxmail.org>
Message-ID: <Pine.LNX.3.96.1021013092837.545A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Oct 2002, Paolo Ciarrocchi wrote:

> Hi David,
  thanks for the quick results, but it's Bill...

> I think your benchmark is very intersting.
> Here goes my results:

> It seems that 2.5.42-mm2 is the "winner".

> Comments ?

This mirrors my results, which is encouraging. The -mm2 patch seems to
improve performance under write pressure quite a bit. I am attaching Con
Kolivas' patch to 41-mm2 in case you missed it, as you can note from the
results on the website, it improves things beyond -mm2. If you decide to
run this version I'd like to see the result. I believe I had to use the
"-l" patch option to ignore blank mismatches to get this to work, and I've
cleaned up another mailing funny as well. 


--- linux-2.5.41/mm/vmscan.c    2002-10-11 09:11:20.000000000 +1000
+++ linux-2.5.41-new/mm/vmscan.c 2002-10-11 00:51:06.000000000 +1000
@@ -44,7 +44,8 @@
 /*
  * From 0 .. 100.  Higher means more swappy.
  */
-int vm_swappiness = 50;
+int vm_swappiness = 0;
+int vm_swap_feedback;
 static long total_memory;

 #ifdef ARCH_HAS_PREFETCH
@@ -587,7 +588,18 @@
         * A 100% value of vm_swappiness will override this algorithm almost
         * altogether.
         */
-       swap_tendency = mapped_ratio / 2 + distress + vm_swappiness;
+       swap_tendency = mapped_ratio / 2 + distress;
+
+        vm_swap_feedback = (swap_tendency - 50)/10;
+        vm_swappiness += vm_swap_feedback;
+        if (vm_swappiness < 0){
+               vm_swappiness = 0;
+       }
+       else
+       if (vm_swappiness > 100){
+               vm_swappiness = 100;
+       }
+        swap_tendency += vm_swappiness;

        /*
         * Well that all made sense.  Now for some magic numbers.  Use the


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

