Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964894AbVJZUUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964894AbVJZUUT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 16:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbVJZUUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 16:20:19 -0400
Received: from serv01.siteground.net ([70.85.91.68]:29613 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964894AbVJZUUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 16:20:17 -0400
Date: Wed, 26 Oct 2005 13:20:17 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>
Subject: Re: [discuss] [rfc] x86_64: Kconfig changes for NUMA
Message-ID: <20051026202017.GA3841@localhost.localdomain>
References: <20051026070956.GA3561@localhost.localdomain> <200510261646.26331.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510261646.26331.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2005 at 04:46:25PM +0200, Andi Kleen wrote:
> On Wednesday 26 October 2005 09:09, Ravikiran G Thirumalai wrote:
> 
> > 
> > 1. Makes NUMA a config option like other arches
> > 2. Makes topology detection options like K8_NUMA dependent on NUMA
> > 3. Choosing ACPI NUMA detection can be done from the standard 
> >    "Processor type and features" menu 
> > Comments?
> 
> It's in principle ok except that I don't like the dependencies and
> defaults. K8_NUMA shouldn't be dependent on !M_PSC. And the defaults
> should be just dropped.

Well K8_NUMA will never be needed for EM64T, so I put in that
dependency...I kept defaults because they were there earlier ...I can
take out that too...

How's this?

Thanks,
Kiran

--

On x86_64 arches, there is no way to choose ACPI_NUMA without having to choose
K8_NUMA.  CONFIG_K8_NUMA is not needed for Intel EM64T NUMA boxes.  It also 
looks odd if you have to select ACPI_NUMA from the power management menu.  
This patch fixes those oddities.  Patch does the following:

1. Makes NUMA a config option like other arches
2. Makes topology detection options like K8_NUMA dependent on NUMA
3. Choosing ACPI NUMA detection can be done from the standard 
   "Processor type and features" menu

Signed-off-by: Ravikiran Thirumalai <kiran@scalex86.org>
Signed-off-by: Shai Fultheim <shai@scalex86.org>

Index: linux-2.6.14-rc5/arch/x86_64/Kconfig
===================================================================
--- linux-2.6.14-rc5.orig/arch/x86_64/Kconfig	2005-10-25 15:13:10.000000000 -0700
+++ linux-2.6.14-rc5/arch/x86_64/Kconfig	2005-10-26 12:13:03.000000000 -0700
@@ -226,22 +226,37 @@
 
 source "kernel/Kconfig.preempt"
 
-config K8_NUMA
-       bool "K8 NUMA support"
-       select NUMA
+config NUMA
+       bool "Non Uniform Memory Access (NUMA) Support"
        depends on SMP
        help
-	  Enable NUMA (Non Unified Memory Architecture) support for
-	  AMD Opteron Multiprocessor systems. The kernel will try to allocate
-	  memory used by a CPU on the local memory controller of the CPU
-	  and add some more NUMA awareness to the kernel.
-	  This code is recommended on all multiprocessor Opteron systems
-	  and normally doesn't hurt on others.
+	 Enable NUMA (Non Uniform Memory Access) support. The kernel 
+	 will try to allocate memory used by a CPU on the local memory 
+	 controller of the CPU and add some more NUMA awareness to the kernel.
+	 This code is recommended on all multiprocessor Opteron systems.
+	 If the system is EM64T, you should say N unless your system is EM64T 
+	 NUMA. 
+
+config K8_NUMA
+       bool "K8 NUMA detection"
+       depends on NUMA 
+       help
+	 Enable K8 NUMA node topology detection.  You should say Y here if
+	 you have a multi processor AMD K8 system.    
+
+# Dummy CONFIG option to select ACPI_NUMA from drivers/acpi/Kconfig.
+
+config X86_64_ACPI_NUMA
+       bool "ACPI NUMA detection"
+       depends on NUMA
+       select ACPI 
+       select ACPI_NUMA
+       help
+	 Enable ACPI SRAT based node topology detection.
 
 config NUMA_EMU
-	bool "NUMA emulation support"
-	select NUMA
-	depends on SMP
+	bool "NUMA emulation"
+	depends on NUMA
 	help
 	  Enable NUMA emulation. A flat machine will be split
 	  into virtual nodes when booted with "numa=fake=N", where N is the
@@ -252,9 +267,6 @@
        depends on NUMA
        default y
 
-config NUMA
-       bool
-       default n
 
 config ARCH_DISCONTIGMEM_ENABLE
 	def_bool y
Index: linux-2.6.14-rc5/arch/x86_64/defconfig
===================================================================
--- linux-2.6.14-rc5.orig/arch/x86_64/defconfig	2005-10-25 15:13:10.000000000 -0700
+++ linux-2.6.14-rc5/arch/x86_64/defconfig	2005-10-26 12:14:49.000000000 -0700
@@ -94,6 +94,7 @@
 # CONFIG_PREEMPT is not set
 CONFIG_PREEMPT_BKL=y
 CONFIG_K8_NUMA=y
+CONFIG_X86_64_ACPI_NUMA=y
 # CONFIG_NUMA_EMU is not set
 CONFIG_ARCH_DISCONTIGMEM_ENABLE=y
 CONFIG_NUMA=y
