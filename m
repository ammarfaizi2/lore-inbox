Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSE3WuW>; Thu, 30 May 2002 18:50:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316906AbSE3WuV>; Thu, 30 May 2002 18:50:21 -0400
Received: from jalon.able.es ([212.97.163.2]:43972 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316905AbSE3WuU>;
	Thu, 30 May 2002 18:50:20 -0400
Date: Fri, 31 May 2002 00:50:15 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 cpu selection (first hack)
Message-ID: <20020530225015.GA1829@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

After reading all the posts in the lista about this and thinking a bit,
here is the first attempt (just a try of the general aspect) of a new
cpu selection scheme. This post is mainly to see if I really understood
the scenario.

There were two ways to do this:

- Define a min/max cpu selecion. Both are a kbuild's 'choice'.
  Problems: it generates a ton of symbols of the kind of CPU_MIN_INTEL_PENTIUM
  or CPU_MAX_AMD_ATHLON. And you have to limit the 'max' choice to be
  bigger than the first. This brings two problems: limiting the choices
  on a 'choice' based on one other, and defining an 'order' in processors,
  even between architectures.

- Make all and every cpu a checkbox, so you just say 'I want my kernel to
  support this and that CPU'. This kills the problem of the ordering, and
  adds one other advantage: you do not need to support intermediate CPUs,
  like 'i want my kernel to run ok on pentium-mmx (my firewall) and on
  p4 (my desktop). I will never run it on a PII, so do not include the
  hacks for PII'. And of course, 'If I run my p-mmx capable on a friend's
  PII and it eats his drive and burns his TV set, it is only _my_ fault'.

Patch follows, comments are welcome. Next step is to begin to order the logic,
but I wanted to ask first about this.

diff -ruN linux-2.4.19-pre9/arch/i386/config.in linux-2.4.19-pre9-cpu/arch/i386/config.in
--- linux-2.4.19-pre9/arch/i386/config.in	2002-05-29 01:18:23.000000000 +0200
+++ linux-2.4.19-pre9-cpu/arch/i386/config.in	2002-05-30 23:38:06.000000000 +0200
@@ -26,6 +26,12 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
+bool 'New CPU selection scheme' CONFIG_CPU_SELECTION_NEW
+
+# CPUConfig
+if [ "$CONFIG_CPU_SELECTION_NEW" = "y" ]; then
+	source arch/i386/CPUConfig.in
+else
 choice 'Processor family' \
 	"386					CONFIG_M386 \
 	 486					CONFIG_M486 \
@@ -163,6 +169,7 @@
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
    define_bool CONFIG_X86_OOSTORE y
 fi
+fi
 
 bool 'Machine Check Exception' CONFIG_X86_MCE
 
diff -ruN linux-2.4.19-pre9/arch/i386/CPUConfig.in linux-2.4.19-pre9-cpu/arch/i386/CPUConfig.in
--- linux-2.4.19-pre9/arch/i386/CPUConfig.in	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.4.19-pre9-cpu/arch/i386/CPUConfig.in	2002-05-31 00:28:31.000000000 +0200
@@ -0,0 +1,40 @@
+mainmenu_option next_comment
+comment 'CPU selection'
+
+comment 'Generic x86 CPUs'
+bool 'Generic support' CONFIG_VENDOR_GENERIC
+if [ "$CONFIG_VENDOR_GENERIC" = "y" ]; then
+
+	bool '386'	CONFIG_CPU_GENERIC_386
+	bool '486'	CONFIG_CPU_GENERIC_486
+	bool '586'	CONFIG_CPU_GENERIC_586
+	bool '686'	CONFIG_CPU_GENERIC_686
+
+else
+
+comment 'Intel CPUs'
+bool 'Intel support' CONFIG_VENDOR_INTEL
+if [ "$CONFIG_VENDOR_INTEL" = "y" ]; then
+	bool '386' CONFIG_CPU_INTEL_386
+	bool '486' CONFIG_CPU_INTEL_486
+	bool 'Pentium' CONFIG_CPU_INTEL_PENTIUM
+	bool 'PentiumMMX' CONFIG_CPU_INTEL_PENTIUMMMX
+	bool 'PentiumPro' CONFIG_CPU_INTEL_PENTIUMPRO
+	bool 'PentiumII/Celeron' CONFIG_CPU_INTEL_PENTIUM2
+	bool 'PentiumIII/Celeron(Coppermine)' CONFIG_CPU_INTEL_PENTIUM3
+	bool 'Pentium4' CONFIG_CPU_INTEL_PENTIUM4
+fi
+comment 'AMD CPUs'
+bool 'AMD support' CONFIG_VENDOR_AMD
+if [ "$CONFIG_VENDOR_AMD" = "y" ]; then
+	bool '386' CONFIG_CPU_AMD_386
+	bool '486' CONFIG_CPU_AMD_486
+	bool 'K5' CONFIG_CPU_AMD_K5
+	bool 'K6/K6II/K6III' CONFIG_CPU_AMD_K6
+	bool 'K7' CONFIG_CPU_AMD_K7
+	bool 'Athlon/Duron' CONFIG_CPU_AMD_ATHLON
+fi
+
+fi
+
+endmenu


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre9-jam1 #1 SMP jue may 30 00:48:49 CEST 2002 i686
