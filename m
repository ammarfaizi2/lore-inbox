Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266013AbUHaBHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbUHaBHN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 21:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUHaBHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 21:07:13 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:31637 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266013AbUHaBHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 21:07:11 -0400
Subject: Re: [RFC][PATCH] fix target_cpus() for summit subarch
From: john stultz <johnstul@us.ibm.com>
To: James <jamesclv@us.ibm.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       lkml <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>
In-Reply-To: <200408301424.54418.jamesclv@us.ibm.com>
References: <1093652688.14662.16.camel@cog.beaverton.ibm.com>
	 <79750000.1093673866@[10.10.2.4]>
	 <1093888987.14662.69.camel@cog.beaverton.ibm.com>
	 <200408301424.54418.jamesclv@us.ibm.com>
Content-Type: text/plain
Message-Id: <1093914395.14662.127.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 30 Aug 2004 18:06:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 14:24, James Cleverdon wrote:
> I'm fine with changing the delivery mode to dest_LowestPrio.  However, 
> someone changed the default destination mask that target_cpus() returns 
> from XAPIC_DEST_CPUS_MASK (0F) to APIC_ALL_CPUS (FF).  The latter value 
> is a bad idea.  I'm unaware of anyone's hardware that will correctly 
> arbitrate dest_LowestPrio among all CPUs of all clusters.  (Please 
> correct me if I'm wrong.)  By chance, FF mostly works on IBM Summit 
> (EXA) chips, but we can't rely on that in the future.

Ok, here is the corrected patch. Ran it through LTP for awhile and
tested a few hotplug USB devices. 

If there are no other comments, I'll submit this to Andrew later this
week.

thanks


linux-2.6.9-rc1_summit-target-cpus-fix_A1
-----------------------------------------
diff -Nru a/include/asm-i386/mach-summit/mach_apic.h b/include/asm-i386/mach-summit/mach_apic.h
--- a/include/asm-i386/mach-summit/mach_apic.h	2004-08-30 17:33:02 -07:00
+++ b/include/asm-i386/mach-summit/mach_apic.h	2004-08-30 17:33:02 -07:00
@@ -19,11 +19,15 @@
 
 static inline cpumask_t target_cpus(void)
 {
-	return CPU_MASK_ALL;
+	/* CPU_MASK_ALL (0xff) has undefined behaviour with
+	 * logical clustered apic interrupt routing.
+	 * Just start on cpu 0.  IRQ balancing will spread load 
+	 */
+	return cpumask_of_cpu(0);
 } 
 #define TARGET_CPUS	(target_cpus())
 
-#define INT_DELIVERY_MODE (dest_Fixed)
+#define INT_DELIVERY_MODE (dest_LowestPrio)
 #define INT_DEST_MODE 1     /* logical delivery broadcast to all procs */
 
 static inline unsigned long check_apicid_used(physid_mask_t bitmap, int apicid)


