Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277527AbRJER6m>; Fri, 5 Oct 2001 13:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277531AbRJER6c>; Fri, 5 Oct 2001 13:58:32 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5801 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S277527AbRJER6O>;
	Fri, 5 Oct 2001 13:58:14 -0400
Date: Fri, 05 Oct 2001 10:54:02 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: =?ISO-8859-1?Q?Dieter_N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        Olaf Zaplinski <o.zaplinski@mediascape.de>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.11-pre4
Message-ID: <1551862685.1002279242@mbligh.des.sequent.com>
In-Reply-To: <1546529396.1002273909@mbligh.des.sequent.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Odd. Compiles for me with and without SMP support turned on.

My fault. I'd tested this on SMP and Uniproc, but not uniproc with
IO apic support. Try this patch:

--- smp.h.old	Fri Oct  5 10:46:40 2001
+++ smp.h	Fri Oct  5 10:48:37 2001
@@ -31,9 +31,20 @@
 #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 # endif
 #else
+# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 # define TARGET_CPUS 0x01
 #endif
 
+#ifndef clustered_apic_mode
+ #ifdef CONFIG_MULTIQUAD
+  #define clustered_apic_mode (1)
+  #define esr_disable (1)
+ #else /* !CONFIG_MULTIQUAD */
+  #define clustered_apic_mode (0)
+  #define esr_disable (0)
+ #endif /* CONFIG_MULTIQUAD */
+#endif 
+
 #ifdef CONFIG_SMP
 #ifndef ASSEMBLY
 
@@ -76,16 +87,6 @@
 extern volatile int physical_apicid_to_cpu[MAX_APICID];
 extern volatile int cpu_to_logical_apicid[NR_CPUS];
 extern volatile int logical_apicid_to_cpu[MAX_APICID];
-
-#ifndef clustered_apic_mode
- #ifdef CONFIG_MULTIQUAD
-  #define clustered_apic_mode (1)
-  #define esr_disable (1)
- #else /* !CONFIG_MULTIQUAD */
-  #define clustered_apic_mode (0)
-  #define esr_disable (0)
- #endif /* CONFIG_MULTIQUAD */
-#endif 
 
 /*
  * General functions that each host system must provide.

