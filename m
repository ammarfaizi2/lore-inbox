Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316992AbSFFP1D>; Thu, 6 Jun 2002 11:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316993AbSFFP1C>; Thu, 6 Jun 2002 11:27:02 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:59128 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316992AbSFFP1A>; Thu, 6 Jun 2002 11:27:00 -0400
Subject: Re: [patch] CONFIG_NR_CPUS
From: Robert Love <rml@tech9.net>
To: "David S. Miller" <davem@redhat.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <20020606.031520.08940800.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jun 2002 08:26:52 -0700
Message-Id: <1023377213.13787.2.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-06-06 at 03:15, David S. Miller wrote:
 
> Nice.  While you're at it can you fix the value on 64-bit
> platforms when CONFIG_NR_CPUS is not specified?  (it should
> be 64, not 32)

I agree, this is good.  I often am toying with some debugging aid that
is an array of NR_CPUS and waste a lot of memory with NR_CPUS stuck at
32... no reason my kernels should not be set to 2 or whatever I need.

I have attached a patch that is Andrew's + your request, Dave.  Since
what really determines the maximum number of CPUs is the size of
unsigned long, I used that.  Cool?

	Robert Love

diff -urN linux-2.5.20/arch/i386/Config.help linux/arch/i386/Config.help
--- linux-2.5.20/arch/i386/Config.help	Sun Jun  2 18:44:41 2002
+++ linux/arch/i386/Config.help	Thu Jun  6 07:58:58 2002
@@ -25,6 +25,14 @@
 
   If you don't know what to do here, say N.
 
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  mimimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
   real-time or interactive events by allowing a low priority process to
diff -urN linux-2.5.20/arch/i386/config.in linux/arch/i386/config.in
--- linux-2.5.20/arch/i386/config.in	Sun Jun  2 18:44:46 2002
+++ linux/arch/i386/config.in	Thu Jun  6 07:58:58 2002
@@ -185,8 +185,8 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
 bool 'Preemptible Kernel' CONFIG_PREEMPT
+bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
    dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFIG_X86_UP_APIC
@@ -197,6 +197,7 @@
       define_bool CONFIG_X86_IO_APIC y
    fi
 else
+   int  'Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
 
diff -urN linux-2.5.20/arch/i386/kernel/smpboot.c linux/arch/i386/kernel/smpboot.c
--- linux-2.5.20/arch/i386/kernel/smpboot.c	Sun Jun  2 18:44:49 2002
+++ linux/arch/i386/kernel/smpboot.c	Thu Jun  6 07:58:58 2002
@@ -54,7 +54,7 @@
 static int smp_b_stepping;
 
 /* Setup configured maximum number of CPUs to activate */
-static int max_cpus = -1;
+static int max_cpus = NR_CPUS;
 
 /* Total count of live CPUs */
 int smp_num_cpus = 1;
@@ -1145,7 +1145,7 @@
 
 		if (!(phys_cpu_present_map & (1 << bit)))
 			continue;
-		if ((max_cpus >= 0) && (max_cpus <= cpucount+1))
+		if (max_cpus <= cpucount+1)
 			continue;
 
 		do_boot_cpu(apicid);
diff -urN linux-2.5.20/include/linux/threads.h linux/include/linux/threads.h
--- linux-2.5.20/include/linux/threads.h	Sun Jun  2 18:44:39 2002
+++ linux/include/linux/threads.h	Thu Jun  6 08:01:29 2002
@@ -7,11 +7,18 @@
  * The default limit for the nr of threads is now in
  * /proc/sys/kernel/threads-max.
  */
- 
+
+/* Max processors that can be running in SMP */
 #ifdef CONFIG_SMP
-#define NR_CPUS	32		/* Max processors that can be running in SMP */
+
+#ifdef CONFIG_NR_CPUS
+#define NR_CPUS	CONFIG_NR_CPUS
+#else
+#define NR_CPUS	(sizeof(unsigned long) * 8)
+#endif
+
 #else
-#define NR_CPUS 1
+#define NR_CPUS	1
 #endif
 
 #define MIN_THREADS_LEFT_FOR_ROOT 4

