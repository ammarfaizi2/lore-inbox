Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269491AbUICA7J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269491AbUICA7J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 20:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUICA5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:57:33 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42976 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S269491AbUICAzM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:55:12 -0400
Subject: [PATCH] fix target_cpus() for summit subarch
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, James <jamesclv@us.ibm.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Patricia Gaughen <gone@us.ibm.com>
Content-Type: text/plain
Message-Id: <1094172887.14662.403.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 02 Sep 2004 17:54:47 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been hunting down a bug affecting IBM x440/x445 systems where the
floppy driver would get spurious interrupts and would not initialize
properly. 

After digging James Cleverdon and Bill Irwin pointed out that
target_cpus() is routing the interrupts to the clustered apic broadcast
mask using destFixed deliver mode. This was causing multiple interrupts
to show up, breaking the floppy init code. 

This fix simply changes the delivery mode to dest_LowestPrio and
initially routes interrupts to the first cpu to resolve this issue.

Please consider for inclusion into your tree.

thanks
-john

linux-2.6.9-rc1_summit-target-cpus-fix_A2.patch
===============================================
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	2004-09-02 17:46:06 -07:00
+++ b/include/asm-i386/mach-summit/mach_apic.h	2004-09-02 17:46:06 -07:00
@@ -19,11 +19,15 @@
 
 static inline cpumask_t target_cpus(void)
 {
-	return CPU_MASK_ALL;
+	/* CPU_MASK_ALL (0xff) has undefined behaviour with
+	 * dest_LowestPrio mode logical clustered apic interrupt routing
+	 * Just start on cpu 0.  IRQ balancing will spread load
+	 */
+	return cpumask_of_cpu(0);
 } 
 #define TARGET_CPUS	(target_cpus())
 
-#define INT_DELIVERY_MODE (dest_Fixed)
+#define INT_DELIVERY_MODE (dest_LowestPrio)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)


