Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289811AbSA2S0M>; Tue, 29 Jan 2002 13:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289795AbSA2SZx>; Tue, 29 Jan 2002 13:25:53 -0500
Received: from quasar.osc.edu ([192.148.249.15]:24002 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S289796AbSA2SZh>;
	Tue, 29 Jan 2002 13:25:37 -0500
Date: Tue, 29 Jan 2002 13:25:32 -0500
From: Pete Wyckoff <pw@osc.edu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] typo in i386 machine check code
Message-ID: <20020129132532.B10960@osc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Our old PIII Xeons are dying, as shown by more frequent panics
due to bad hardware:

    kernel: CPU 3: Machine Check Exception: 0000000000000007 
    kernel: Bank 0: b678600022000800 at 3678600022000800 

The part after the "at" is supposed to be the memory address which
was being accessed when the fault was detected.  Instead the code
prints out the status field again (with the high bit removed for
no apparent reason).

Patch is against 2.5.2.

		-- Pete

--- linux/arch/i386/kernel/bluesmoke.c.orig	Tue Jan 29 12:04:46 2002
+++ linux/arch/i386/kernel/bluesmoke.c	Tue Jan 29 12:04:48 2002
@@ -40,21 +40,21 @@ static void intel_machine_check(struct p
 			high&=~(1<<31);
 			if(high&(1<<27))
 			{
 				rdmsr(MSR_IA32_MC0_MISC+i*4, alow, ahigh);
 				printk("[%08x%08x]", alow, ahigh);
 			}
 			if(high&(1<<26))
 			{
 				rdmsr(MSR_IA32_MC0_ADDR+i*4, alow, ahigh);
 				printk(" at %08x%08x", 
-					high, low);
+					ahigh, alow);
 			}
 			printk("\n");
 			/* Clear it */
 			wrmsr(MSR_IA32_MC0_STATUS+i*4, 0UL, 0UL);
 			/* Serialize */
 			wmb();
 		}
 	}
 	
 	if(recover&2)
