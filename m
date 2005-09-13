Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVIMJT7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVIMJT7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbVIMJT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:19:59 -0400
Received: from orion.tat.physik.uni-tuebingen.de ([134.2.170.108]:216 "EHLO
	orion.tat.physik.uni-tuebingen.de") by vger.kernel.org with ESMTP
	id S1751185AbVIMJT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:19:59 -0400
Date: Tue, 13 Sep 2005 11:07:55 +0200
From: Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
To: linux-kernel@vger.kernel.org
Cc: ulrich.windl@rz.uni-regensburg.de, john stultz <johnstul@us.ibm.com>,
       Harald Koenig <koenig@tat.physik.uni-tuebingen.de>
Subject: RFC: time_adj for HZ==250 in kernel/timer.c ?
Message-ID: <20050913090755.GA11601@turtle.tat.physik.uni-tuebingen.de>
References: <20050902122311.GA26608@turtle.tat.physik.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050902122311.GA26608@turtle.tat.physik.uni-tuebingen.de>
X-fingerprint: 3B CD 5A A9 73 44 DD 04  A0 4E A0 34 20 7B 1E 38
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello linux-kernel, hi Ulrich,

first: as I'm not subscribed to linix-kernel list, please send answers with CC: PM.  thanks!


playing with the openSUSE 10.0 beta-test I slipped over problems with procinfo etc.
so I noticed that at least suse/novell again changed the scheduler frequency HZ
from 1000 to 250.  which led me to the following question,  for which I got no
commets from SUSE so far, and since it's not a suse-only issue anyway... 
 

the linux kernel for suse 10.0 will run with HZ==250 by default (9.x used HZ==1000).

        harald:~ # cat /proc/version
        Linux version 2.6.13-8-default (geeko@buildhost) (gcc version 4.0.2 20050901 (prerelease) (SUSE Linux)) #1 Tue Sep 6 12:59:22 UTC 2005

for HZ==100 and HZ==1000 there is special code in kernel/timer.c to 
adjust the value of time_adj  because HZ isn't a power of two and
clock stuff uses some binary shift operations instead of divides
(and 100!=128 or 1000!=1024).

what about having a similar special case for the new HZ==250 too ??
using 250 instead of 256 (SHIFT_HZ==8), which is an error of 2.4 %,
identical to 1000 vs. 1024.

any feelings or comments about the following patch ?

-------------------------------------------------------------------------------
--- kernel/timer.c~     2005-08-22 22:50:27.000000000 +0200
+++ kernel/timer.c      2005-08-31 15:12:57.801644750 +0200
@@ -752,7 +752,7 @@
     else
        time_adj += (time_adj >> 2) + (time_adj >> 5);
 #endif
-#if HZ == 1000
+#if HZ == 1000 || HZ == 250
     /* Compensate for (HZ==1000) != (1 << SHIFT_HZ).
      * Add 1.5625% and 0.78125% to get 1023.4375; => only 0.05% error (p. 14)
      */
-------------------------------------------------------------------------------


or maybe (just in case...:) even

#if HZ == 1000 || HZ == 500 || HZ == 250

most likely this specific compensation should be correct 
for any integet multiple of 125, isn't it ?

similarly, the "HZ == 100" compensation should be ok for HZ==25/50/200/400/800 too
according to include/linux/jiffies.h.


comments ?

Harald
-- 
"I hope to die                                      ___       _____
before I *have* to use Microsoft Word.",           0--,|    /OOOOOOO\
Donald E. Knuth, 02-Oct-2001 in Tuebingen.        <_/  /  /OOOOOOOOOOO\
                                                    \  \/OOOOOOOOOOOOOOO\
                                                      \ OOOOOOOOOOOOOOOOO|//
Harald Koenig,                                         \/\/\/\/\/\/\/\/\/
Inst.f.Theoret.Astrophysik                              //  /     \\  \
koenig@tat.physik.uni-tuebingen.de                     ^^^^^       ^^^^^
