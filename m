Return-Path: <linux-kernel-owner+w=401wt.eu-S932672AbWLNLjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932672AbWLNLjt (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 06:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbWLNLjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 06:39:49 -0500
Received: from smtp1.belwue.de ([129.143.2.12]:39084 "EHLO smtp1.belwue.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932674AbWLNLjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 06:39:47 -0500
Date: Thu, 14 Dec 2006 12:38:08 +0100 (CET)
From: Karsten Weiss <K.Weiss@science-computing.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Cc: Chris Wedgwood <cw@f00f.org>,
       Christoph Anton Mitterer <calestyo@scientia.net>,
       linux-kernel@vger.kernel.org, Erik Andersen <andersen@codepoet.org>,
       Andi Kleen <ak@suse.de>
Subject: [PATCH] Re: data corruption with nvidia chipsets and IDE/SATA drives
 // memory hole mapping related bug?!
In-Reply-To: <20061214092208.GB6674@rhun.haifa.ibm.com>
Message-ID: <Pine.LNX.4.61.0612141215590.17792@palpatine.science-computing.de>
References: <Pine.LNX.4.64.0612021202000.2981@addx.localnet>
 <Pine.LNX.4.61.0612111001240.23470@palpatine.science-computing.de>
 <458051FD.1060900@scientia.net> <20061213195345.GA16112@tuatara.stupidest.org>
 <Pine.LNX.4.61.0612132100060.6688@palpatine.science-computing.de>
 <20061214092208.GB6674@rhun.haifa.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006, Muli Ben-Yehuda wrote:

> On Wed, Dec 13, 2006 at 09:34:16PM +0100, Karsten Weiss wrote:
> 
> > BTW: It would be really great if this area of the kernel would get some 
> > more and better documentation. The information at 
> > linux-2.6/Documentation/x86_64/boot_options.txt is very terse. I had to 
> > read the code to get a *rough* idea what all the "iommu=" options 
> > actually do and how they interact.
> 
> Patches happily accepted :-)

Well, you asked for it. :-) So here's my little contribution. Please 
*double* *check*!

(BTW: I would like to know what "DAC" and "SAC" means in this context)

===

From: Karsten Weiss <K.Weiss@science-computing.de>

Patch summary:

- Better explanation of some of the iommu kernel parameter options.
- "32MB<<order" instead of "32MB^order".
- Mention the default "order".
- SWIOTLB config help text
- removed the duplication of the iommu kernel parameter documentation.
- mention Documentation/x86_64/boot-options.txt in 
  Documentation/kernel-parameters.txt
- list the four existing PCI DMA mapping implementations of arch x86_64

Signed-off-by: Karsten Weiss <knweiss@science-computing.de>

---

--- linux-2.6.19/arch/x86_64/kernel/pci-dma.c.original	2006-12-14 11:15:38.348598021 +0100
+++ linux-2.6.19/arch/x86_64/kernel/pci-dma.c	2006-12-14 12:14:48.176967312 +0100
@@ -223,30 +223,10 @@
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-/* iommu=[size][,noagp][,off][,force][,noforce][,leak][,memaper[=order]][,merge]
-         [,forcesac][,fullflush][,nomerge][,biomerge]
-   size  set size of iommu (in bytes)
-   noagp don't initialize the AGP driver and use full aperture.
-   off   don't use the IOMMU
-   leak  turn on simple iommu leak tracing (only when CONFIG_IOMMU_LEAK is on)
-   memaper[=order] allocate an own aperture over RAM with size 32MB^order.
-   noforce don't force IOMMU usage. Default.
-   force  Force IOMMU.
-   merge  Do lazy merging. This may improve performance on some block devices.
-          Implies force (experimental)
-   biomerge Do merging at the BIO layer. This is more efficient than merge,
-            but should be only done with very big IOMMUs. Implies merge,force.
-   nomerge Don't do SG merging.
-   forcesac For SAC mode for masks <40bits  (experimental)
-   fullflush Flush IOMMU on each allocation (default)
-   nofullflush Don't use IOMMU fullflush
-   allowed  overwrite iommu off workarounds for specific chipsets.
-   soft	 Use software bounce buffering (default for Intel machines)
-   noaperture Don't touch the aperture for AGP.
-   allowdac Allow DMA >4GB
-   nodac    Forbid DMA >4GB
-   panic    Force panic when IOMMU overflows
-*/
+/*
+ * See <Documentation/x86_64/boot-options.txt> for the iommu kernel parameter
+ * documentation.
+ */
 __init int iommu_setup(char *p)
 {
 	iommu_merge = 1;
--- linux-2.6.19/arch/x86_64/Kconfig.original	2006-12-14 11:37:35.832142506 +0100
+++ linux-2.6.19/arch/x86_64/Kconfig	2006-12-14 11:47:24.346056710 +0100
@@ -431,8 +431,8 @@
 	  on systems with more than 3GB. This is usually needed for USB,
 	  sound, many IDE/SATA chipsets and some other devices.
 	  Provides a driver for the AMD Athlon64/Opteron/Turion/Sempron GART
-	  based IOMMU and a software bounce buffer based IOMMU used on Intel
-	  systems and as fallback.
+	  based hardware IOMMU and a software bounce buffer based IOMMU used
+	  on Intel systems and as fallback.
 	  The code is only active when needed (enough memory and limited
 	  device) unless CONFIG_IOMMU_DEBUG or iommu=force is specified
 	  too.
@@ -458,6 +458,11 @@
 # need this always selected by IOMMU for the VIA workaround
 config SWIOTLB
 	bool
+	help
+	  Support for a software bounce buffer based IOMMU used on Intel
+	  systems which don't have a hardware IOMMU. Using this code
+	  PCI devices with 32bit memory access only are able to be
+	  used on systems with more than 3 GB.
 
 config X86_MCE
 	bool "Machine check support" if EMBEDDED
--- linux-2.6.19/Documentation/x86_64/boot-options.txt.original	2006-12-14 11:11:32.099300994 +0100
+++ linux-2.6.19/Documentation/x86_64/boot-options.txt	2006-12-14 12:10:24.028009890 +0100
@@ -180,35 +180,66 @@
   pci=lastbus=NUMBER	       Scan upto NUMBER busses, no matter what the mptable says.
   pci=noacpi		Don't use ACPI to set up PCI interrupt routing.
 
-IOMMU
+IOMMU (input/output memory management unit)
+
+ Currently four x86_64 PCI DMA mapping implementations exist:
+
+   1. <arch/x86_64/kernel/pci-nommu.c>: use no hardware/software IOMMU at all
+      (e.g. because you have < 3 GB memory).
+      Kernel boot message: "PCI-DMA: Disabling IOMMU"
+
+   2. <arch/x86_64/kernel/pci-gart.c>: AMD GART based hardware IOMMU.
+      Kernel boot message: "PCI-DMA: using GART IOMMU"
+
+   3. <arch/x86_64/kernel/pci-swiotlb.c> : Software IOMMU implementation. Used
+      e.g. if there is no hardware IOMMU in the system and it is need because
+      you have >3GB memory or told the kernel to us it (iommu=soft))
+      Kernel boot message: "PCI-DMA: Using software bounce buffering
+      for IO (SWIOTLB)"
+
+   4. <arch/x86_64/pci-calgary.c> : IBM Calgary hardware IOMMU. Used in IBM
+      pSeries and xSeries servers. This hardware IOMMU supports DMA address
+      mapping with memory protection, etc.
+      Kernel boot message: "PCI-DMA: Using Calgary IOMMU" 
 
  iommu=[size][,noagp][,off][,force][,noforce][,leak][,memaper[=order]][,merge]
          [,forcesac][,fullflush][,nomerge][,noaperture]
-   size  set size of iommu (in bytes)
-   noagp don't initialize the AGP driver and use full aperture.
-   off   don't use the IOMMU
-   leak  turn on simple iommu leak tracing (only when CONFIG_IOMMU_LEAK is on)
-   memaper[=order] allocate an own aperture over RAM with size 32MB^order.
-   noforce don't force IOMMU usage. Default.
-   force  Force IOMMU.
-   merge  Do SG merging. Implies force (experimental)
-   nomerge Don't do SG merging.
-   forcesac For SAC mode for masks <40bits  (experimental)
-   fullflush Flush IOMMU on each allocation (default)
-   nofullflush Don't use IOMMU fullflush
-   allowed  overwrite iommu off workarounds for specific chipsets.
-   soft	 Use software bounce buffering (default for Intel machines)
-   noaperture Don't touch the aperture for AGP.
-   allowdac Allow DMA >4GB
-	    When off all DMA over >4GB is forced through an IOMMU or bounce
-	    buffering.
-   nodac    Forbid DMA >4GB
-   panic    Always panic when IOMMU overflows
+   size             set size of IOMMU (in bytes)
+   noagp            don't initialize the AGP driver and use full aperture.
+   off              don't initialize and use any kind of IOMMU.
+   leak             turn on simple iommu leak tracing (only when
+                    CONFIG_IOMMU_LEAK is on)
+   memaper[=order]  allocate an own aperture over RAM with size 32MB<<order.
+                    (default: order=1, i.e. 64MB)
+   noforce          don't force hardware IOMMU usage when it is not needed.
+                    (default).
+   force            Force the use of the hardware IOMMU even when it is
+                    not actually needed (e.g. because < 3 GB memory).
+   merge            Do scather-gather (SG) merging. Implies force (experimental)
+   nomerge          Don't do scather-gather (SG) merging.
+   forcesac         For SAC mode for masks <40bits  (experimental)
+   fullflush        Flush AMD GART based hardware IOMMU on each allocation
+                    (default)
+   nofullflush      Don't use IOMMU fullflush
+   allowed          overwrite iommu off workarounds for specific chipsets.
+   soft             Use software bounce buffering (SWIOTLB) (default for Intel
+                    machines). This can be used to prevent the usage
+                    of a available hardware IOMMU.
+   noaperture       Ask the AMD GART based hardware IOMMU driver not to 
+                    touch the aperture for AGP.
+   allowdac         Allow DMA >4GB
+                    When off all DMA over >4GB is forced through an IOMMU or
+                    bounce buffering.
+   nodac            Forbid DMA >4GB
+   panic            Always panic when IOMMU overflows
 
   swiotlb=pages[,force]
+   pages            Prereserve that many 128K pages for the software IO bounce
+                    buffering.
+   force            Force all IO through the software TLB.
 
-  pages  Prereserve that many 128K pages for the software IO bounce buffering.
-  force  Force all IO through the software TLB.
+  Settings for the IBM Calgary hardware IOMMU currently found in IBM
+  pSeries and xSeries machines:
 
   calgary=[64k,128k,256k,512k,1M,2M,4M,8M]
   calgary=[translate_empty_slots]
--- linux-2.6.19/Documentation/kernel-parameters.txt.original	2006-12-14 11:03:46.584429749 +0100
+++ linux-2.6.19/Documentation/kernel-parameters.txt	2006-12-14 11:11:22.172025378 +0100
@@ -104,6 +104,9 @@
 Do not modify the syntax of boot loader parameters without extreme
 need or coordination with <Documentation/i386/boot.txt>.
 
+There are also arch-specific kernel-parameters not documented here.
+See for example <Documentation/x86_64/boot-options.txt>.
+
 Note that ALL kernel parameters listed below are CASE SENSITIVE, and that
 a trailing = on the name of any parameter states that that parameter will
 be entered as an environment variable, whereas its absence indicates that

-- 
__________________________________________creating IT solutions
Dipl.-Inf. Karsten Weiss               science + computing ag
phone:    +49 7071 9457 452            Hagellocher Weg 73
teamline: +49 7071 9457 681            72070 Tuebingen, Germany
email:    knweiss@science-computing.de www.science-computing.de

