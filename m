Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317364AbSFLEl6>; Wed, 12 Jun 2002 00:41:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317295AbSFLEl5>; Wed, 12 Jun 2002 00:41:57 -0400
Received: from ausmtp01.au.ibm.COM ([202.135.136.97]:52362 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP
	id <S317364AbSFLElv>; Wed, 12 Jun 2002 00:41:51 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Robert Love <rml@tech9.net>
Cc: Rusty Russell <rusty@rustcorp.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, k-suganuma@mvj.biglobe.ne.jp,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] 2.5.21 Nonlinear CPU support 
In-Reply-To: Your message of "11 Jun 2002 10:59:25 MST."
             <1023818365.21176.237.camel@sinai> 
Date: Wed, 12 Jun 2002 14:11:50 +1000
Message-Id: <E17HzU6-0003pY-00@wagner.rustcorp.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <1023818365.21176.237.camel@sinai> you write:
> On Tue, 2002-06-11 at 03:57, Anton Altaparmakov wrote:
> 
> > This is crazy! It means you are allocating 2MiB of memory instead of just 
> > 128kiB on a 2 CPU system, which will be about 99% of the SMP systems in 
> > use, at my guess. So your change is throwing away 1920kiB of kernel ram for
 
> > no reason at all. And that is just ntfs...
> >
> > CPU hot plugging is an extremely specialised corner case so can you please 
> > make it a config option and not get rid of smp_num_cpus? If people enable 
> > the option make smp_num_cpus be the same as NR_CPUS and if not leave it be 
> > as it is now.
> 
> I agree.  One can argue these rants are just for "micro optimizations"
> (although I disagree the size issue is "micro") but someone has to stay
> on top of these issues...
> 
> Hot swappable CPUs is incredibly specialized and corner-cased.

Not once the boot sequence is changed to plug CPUs in: then every SMP
box becomes "hot plug".

> It is by no means a solution, but I just posted a patch to configure
> NR_CPUS... so setting it to, say, 2 on your dual box should help you
> out.  On the converse, however, it introduces a default of 64 on 64-bit
> boxen so it compounds the problem for users who don't tweak the
> setting... something still needs to be done with the hotplug code.

Andrew Morton did as well.  Better would probably be to replace
CONFIG_SMP with CONFIG_NUM_CPUS (tested patch below, 'cept UP doesn't
seem to build anyway).  Note that NR_CPUS is in fact the ceiling of
smp_processor_id(), which on some architectures may mean that NR_CPUS
still has to be (say) 32 even if you only have 2 CPUs.

(Note to self: check each arch's Config.help for x86isms),
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/include/linux/threads.h working-2.5.21-numcpus/include/linux/threads.h
--- linux-2.5.21/include/linux/threads.h	Sat May 18 15:53:43 2002
+++ working-2.5.21-numcpus/include/linux/threads.h	Wed Jun 12 12:55:58 2002
@@ -7,12 +7,8 @@
  * The default limit for the nr of threads is now in
  * /proc/sys/kernel/threads-max.
  */
- 
-#ifdef CONFIG_SMP
-#define NR_CPUS	32		/* Max processors that can be running in SMP */
-#else
-#define NR_CPUS 1
-#endif
+
+#define NR_CPUS CONFIG_MAX_CPUS
 
 #define MIN_THREADS_LEFT_FOR_ROOT 4
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/Documentation/DocBook/kernel-locking.tmpl working-2.5.21-numcpus/Documentation/DocBook/kernel-locking.tmpl
--- linux-2.5.21/Documentation/DocBook/kernel-locking.tmpl	Fri Mar  8 14:49:09 2002
+++ working-2.5.21-numcpus/Documentation/DocBook/kernel-locking.tmpl	Wed Jun 12 13:33:57 2002
@@ -220,15 +220,15 @@
     <title>Locks and Uniprocessor Kernels</title>
 
     <para>
-      For kernels compiled without <symbol>CONFIG_SMP</symbol>, spinlocks 
+      For kernels compiled with <symbol>CONFIG_MAX_CPUS</symbol> set to 1, spinlocks 
       do not exist at all.  This is an excellent design decision: when
       no-one else can run at the same time, there is no reason to
       have a lock at all.
     </para>
 
     <para>
-      You should always test your locking code with <symbol>CONFIG_SMP</symbol>
-      enabled, even if you don't have an SMP test box, because it
+      You should always test your locking code with <symbol>CONFIG_MAX_CPUS</symbol>
+      set to 2 or more, even if you don't have an SMP test box, because it
       will still catch some (simple) kinds of deadlock.
     </para>
 
@@ -546,7 +546,7 @@
       Both of these are called deadlock, and as shown above, it can
       occur even with a single CPU (although not on UP compiles,
       since spinlocks vanish on kernel compiles with 
-      <symbol>CONFIG_SMP</symbol>=n. You'll still get data corruption 
+      <symbol>CONFIG_MAX_CPUS</symbol>=1. You'll still get data corruption 
       in the second example).
     </para>
 
@@ -1157,7 +1157,7 @@
     <glossdef>
      <para>
        Symmetric Multi-Processor: kernels compiled for multiple-CPU
-       machines.  (CONFIG_SMP=y).
+       machines.  (CONFIG_MAX_CPUS > 1).
      </para>
     </glossdef>
    </glossentry>
@@ -1200,7 +1200,7 @@
     <glossterm><acronym>UP</acronym></glossterm>
     <glossdef>
      <para>
-       Uni-Processor: Non-SMP.  (CONFIG_SMP=n).
+       Uni-Processor: Non-SMP.  (CONFIG_MAX_CPUS=1).
      </para>
     </glossdef>
    </glossentry>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/alpha/Config.help working-2.5.21-numcpus/arch/alpha/Config.help
--- linux-2.5.21/arch/alpha/Config.help	Thu Mar 21 14:14:37 2002
+++ working-2.5.21-numcpus/arch/alpha/Config.help	Wed Jun 12 13:25:23 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, enter
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_ALPHA
   The Alpha is a 64-bit general-purpose processor designed and
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/alpha/config.in working-2.5.21-numcpus/arch/alpha/config.in
--- linux-2.5.21/arch/alpha/config.in	Thu May 30 10:00:46 2002
+++ working-2.5.21-numcpus/arch/alpha/config.in	Wed Jun 12 13:37:29 2002
@@ -227,7 +227,11 @@
 	-o "$CONFIG_ALPHA_TITAN" = "y" -o "$CONFIG_ALPHA_GENERIC" = "y" \
 	-o "$CONFIG_ALPHA_SHARK" = "y" ]
 then
-	bool 'Symmetric multi-processing support' CONFIG_SMP
+	int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+	if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+		define_bool CONFIG_SMP y
+else
+	define_int CONFIG_MAX_CPUS 1
 fi
 
 if [ "$CONFIG_SMP" = "y" ]; then
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/Config.help working-2.5.21-numcpus/arch/i386/Config.help
--- linux-2.5.21/arch/i386/Config.help	Sat May 25 14:34:36 2002
+++ working-2.5.21-numcpus/arch/i386/Config.help	Wed Jun 12 13:23:03 2002
@@ -1,29 +1,25 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
-
-  If you say N here, the kernel will run on single and multiprocessor
-  machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
-  singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
+CONFIG_MAX_CPUS
+  You can enable support for systems with more than one CPU. If you have
+  a system with only one CPU, like most personal computers, say 1 for a
+  smaller, faster kernel.  If you have a system with more than one CPU,
+  enter the number of CPUs you have (each extra CPU supported uses a
+  little more memory).
 
-  Note that if you say Y here and choose architecture "586" or
+  Note that if you enter 2 or more here and choose architecture "586" or
   "Pentium" under "Processor family", the kernel will not work on 486
   architectures. Similarly, multiprocessor kernels for the "PPro"
   architecture may not work on all Pentium based boards.
 
-  People using multiprocessor machines who say Y here should also say
+  People using multiprocessor machines who say 2 or more here should also say
   Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  Management" code will be disabled if you say 2 or more here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/config.in working-2.5.21-numcpus/arch/i386/config.in
--- linux-2.5.21/arch/i386/config.in	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-numcpus/arch/i386/config.in	Wed Jun 12 13:37:39 2002
@@ -185,7 +185,10 @@
 
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+	define_bool CONFIG_SMP y
+fi
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/i386/kernel/i386_ksyms.c working-2.5.21-numcpus/arch/i386/kernel/i386_ksyms.c
--- linux-2.5.21/arch/i386/kernel/i386_ksyms.c	Thu May 30 10:00:47 2002
+++ working-2.5.21-numcpus/arch/i386/kernel/i386_ksyms.c	Wed Jun 12 13:51:29 2002
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/tty.h>
+#include <linux/spinlock.h>
 
 #include <asm/semaphore.h>
 #include <asm/processor.h>
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ia64/Config.help working-2.5.21-numcpus/arch/ia64/Config.help
--- linux-2.5.21/arch/ia64/Config.help	Thu May 30 10:00:47 2002
+++ working-2.5.21-numcpus/arch/ia64/Config.help	Wed Jun 12 13:26:26 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_IA64
   The Itanium is Intel's 64-bit successor to the 32-bit X86 line.  As
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ia64/config.in working-2.5.21-numcpus/arch/ia64/config.in
--- linux-2.5.21/arch/ia64/config.in	Thu May 30 10:00:47 2002
+++ working-2.5.21-numcpus/arch/ia64/config.in	Wed Jun 12 13:37:46 2002
@@ -89,7 +89,10 @@
 
 define_bool CONFIG_KCORE_ELF y	# On IA-64, we always want an ELF /proc/kcore.
 
-bool 'SMP support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+	define_bool CONFIG_SMP y
+fi
 bool 'Support running of Linux/x86 binaries' CONFIG_IA32_SUPPORT
 bool 'Performance monitor support' CONFIG_PERFMON
 tristate '/proc/pal support' CONFIG_IA64_PALINFO
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/mips/Config.help working-2.5.21-numcpus/arch/mips/Config.help
--- linux-2.5.21/arch/mips/Config.help	Thu Mar 21 14:14:41 2002
+++ working-2.5.21-numcpus/arch/mips/Config.help	Wed Jun 12 13:27:19 2002
@@ -1,30 +1,3 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
-
-  If you say N here, the kernel will run on single and multiprocessor
-  machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
-  singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
-
-  See also the <file:Documentation/smp.tex>,
-  <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
-  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-  <http://www.linuxdoc.org/docs.html#howto>.
-
-  If you don't know what to do here, say N.
-
 CONFIG_IDE
   If you say Y here, your kernel will be able to manage low cost mass
   storage units such as ATA/(E)IDE and ATAPI units. The most common
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/mips/config.in working-2.5.21-numcpus/arch/mips/config.in
--- linux-2.5.21/arch/mips/config.in	Tue Apr 23 11:39:33 2002
+++ working-2.5.21-numcpus/arch/mips/config.in	Wed Jun 12 12:50:53 2002
@@ -4,6 +4,7 @@
 #
 define_bool CONFIG_MIPS y
 define_bool CONFIG_SMP n
+define_bool CONFIG_NUM_CPUS 1
 
 mainmenu_name "Linux Kernel Configuration"
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/mips64/Config.help working-2.5.21-numcpus/arch/mips64/Config.help
--- linux-2.5.21/arch/mips64/Config.help	Thu Mar 21 14:14:41 2002
+++ working-2.5.21-numcpus/arch/mips64/Config.help	Wed Jun 12 13:27:35 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_IDE
   If you say Y here, your kernel will be able to manage low cost mass
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/mips64/config.in working-2.5.21-numcpus/arch/mips64/config.in
--- linux-2.5.21/arch/mips64/config.in	Tue Apr 23 11:39:33 2002
+++ working-2.5.21-numcpus/arch/mips64/config.in	Wed Jun 12 13:37:50 2002
@@ -19,8 +19,13 @@
    bool '  Mapped kernel support' CONFIG_MAPPED_KERNEL
    bool '  Kernel text replication support' CONFIG_REPLICATE_KTEXT
    bool '  Exception handler replication support' CONFIG_REPLICATE_EXHANDLERS
-   bool '  Multi-Processing support' CONFIG_SMP
+   int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+   if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+      define_bool CONFIG_SMP y
+   fi
    #bool '  IP27 XXL' CONFIG_SGI_SN0_XXL
+else
+   define_int CONFIG_MAX_CPUS 1
 fi
 endmenu
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/parisc/Config.help working-2.5.21-numcpus/arch/parisc/Config.help
--- linux-2.5.21/arch/parisc/Config.help	Thu Mar 21 14:14:41 2002
+++ working-2.5.21-numcpus/arch/parisc/Config.help	Wed Jun 12 13:27:50 2002
@@ -1,30 +1,3 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
-
-  If you say N here, the kernel will run on single and multiprocessor
-  machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
-  singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
-
-  See also the <file:Documentation/smp.tex>,
-  <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
-  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-  <http://www.linuxdoc.org/docs.html#howto>.
-
-  If you don't know what to do here, say N.
-
 CONFIG_PARISC
   The PA-RISC microprocessor is a RISC chip designed by
   Hewlett-Packard and used in their line of workstations.  The PA-RISC
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/parisc/config.in working-2.5.21-numcpus/arch/parisc/config.in
--- linux-2.5.21/arch/parisc/config.in	Wed Feb 20 17:57:02 2002
+++ working-2.5.21-numcpus/arch/parisc/config.in	Wed Jun 12 12:53:11 2002
@@ -16,6 +16,7 @@
 comment 'General options'
 
 # bool 'Symmetric multi-processing support' CONFIG_SMP
+define_int CONFIG_MAX_CPUS 1
 define_bool CONFIG_SMP n
 
 bool 'Kernel Debugger support' CONFIG_KWDB
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/Config.help working-2.5.21-numcpus/arch/ppc/Config.help
--- linux-2.5.21/arch/ppc/Config.help	Thu May 30 10:00:48 2002
+++ working-2.5.21-numcpus/arch/ppc/Config.help	Wed Jun 12 13:28:54 2002
@@ -1,25 +1,25 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, say N. If you have a system with more
-  than one CPU, say Y.  Note that the kernel does not currently
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs. Note that the kernel does not currently
   support SMP machines with 603/603e/603ev or PPC750 ("G3") processors
   since they have inadequate hardware support for multiprocessor
   operation.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on single-processor machines.
-  On a single-processor machine, the kernel will run faster if you say
-  N here.
+  you say 2 or more here, the kernel will run on many, but not all,
+  singleprocessor machines. On a singleprocessor machine, the kernel
+  will run faster if you say 1 here.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
   real-time or interactive events by allowing a low priority process to
   be preempted even if it is in kernel mode executing a system call.
-  Unfortunately the kernel code has some race conditions if both
-  CONFIG_SMP and CONFIG_PREEMPT are enabled, so this option is
+  Unfortunately the kernel code has some race conditions if 
+  CONFIG_MAX_CPUS is greater than one and CONFIG_PREEMPT is enabled, so this option is
   currently disabled if you are building an SMP kernel.
 
   Say Y here if you are building a kernel for a desktop, embedded
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc/config.in working-2.5.21-numcpus/arch/ppc/config.in
--- linux-2.5.21/arch/ppc/config.in	Thu May 30 10:00:49 2002
+++ working-2.5.21-numcpus/arch/ppc/config.in	Wed Jun 12 13:37:59 2002
@@ -169,7 +169,10 @@
    define_bool CONFIG_ALL_PPC n
 fi
 
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 if [ "$CONFIG_SMP" = "y" ]; then
    bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
 fi
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/ppc64/config.in working-2.5.21-numcpus/arch/ppc64/config.in
--- linux-2.5.21/arch/ppc64/config.in	Mon Jun  3 12:21:20 2002
+++ working-2.5.21-numcpus/arch/ppc64/config.in	Wed Jun 12 13:38:02 2002
@@ -18,7 +18,10 @@
 define_bool CONFIG_PPC y
 define_bool CONFIG_PPC64 y
 
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 if [ "$CONFIG_SMP" = "y" ]; then
   bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
   if [ "$CONFIG_PPC_PSERIES" = "y" ]; then
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/s390/Config.help working-2.5.21-numcpus/arch/s390/Config.help
--- linux-2.5.21/arch/s390/Config.help	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-numcpus/arch/s390/Config.help	Wed Jun 12 13:29:33 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_MATHEMU
   This option is required for IEEE compliant floating point arithmetic
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/s390/config.in working-2.5.21-numcpus/arch/s390/config.in
--- linux-2.5.21/arch/s390/config.in	Mon Jun 10 16:03:47 2002
+++ working-2.5.21-numcpus/arch/s390/config.in	Wed Jun 12 13:38:05 2002
@@ -18,7 +18,10 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 bool 'IEEE FPU emulation' CONFIG_MATHEMU
 endmenu
 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/s390x/Config.help working-2.5.21-numcpus/arch/s390x/Config.help
--- linux-2.5.21/arch/s390x/Config.help	Mon Jun 10 16:03:48 2002
+++ working-2.5.21-numcpus/arch/s390x/Config.help	Wed Jun 12 13:29:38 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_ISA
   Find out whether you have ISA slots on your motherboard.  ISA is the
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/s390x/config.in working-2.5.21-numcpus/arch/s390x/config.in
--- linux-2.5.21/arch/s390x/config.in	Mon Jun 10 16:03:48 2002
+++ working-2.5.21-numcpus/arch/s390x/config.in	Wed Jun 12 13:38:09 2002
@@ -18,7 +18,10 @@
 
 mainmenu_option next_comment
 comment 'Processor type and features'
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 bool 'Kernel support for 31 bit emulation' CONFIG_S390_SUPPORT
 if [ "$CONFIG_S390_SUPPORT" = "y" ]; then
   tristate 'Kernel support for 31 bit ELF binaries' CONFIG_BINFMT_ELF32 
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/sparc/Config.help working-2.5.21-numcpus/arch/sparc/Config.help
--- linux-2.5.21/arch/sparc/Config.help	Mon May  6 11:11:52 2002
+++ working-2.5.21-numcpus/arch/sparc/Config.help	Wed Jun 12 13:29:45 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_SPARC32
   SPARC is a family of RISC microprocessors designed and marketed by
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/sparc/config.in working-2.5.21-numcpus/arch/sparc/config.in
--- linux-2.5.21/arch/sparc/config.in	Mon May  6 11:11:52 2002
+++ working-2.5.21-numcpus/arch/sparc/config.in	Wed Jun 12 13:38:13 2002
@@ -15,7 +15,10 @@
 define_bool CONFIG_VT y
 define_bool CONFIG_VT_CONSOLE y
 
-bool 'Symmetric multi-processing support (does not work on sun4/sun4c)' CONFIG_SMP
+int 'Maximum CPUs to support (1-32) (must be 1 on sun4/sun4c)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 
 # Identify this as a Sparc32 build
 define_bool CONFIG_SPARC32 y
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/sparc64/Config.help working-2.5.21-numcpus/arch/sparc64/Config.help
--- linux-2.5.21/arch/sparc64/Config.help	Thu Mar 21 14:14:42 2002
+++ working-2.5.21-numcpus/arch/sparc64/Config.help	Wed Jun 12 13:30:01 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/sparc64/config.in working-2.5.21-numcpus/arch/sparc64/config.in
--- linux-2.5.21/arch/sparc64/config.in	Mon May  6 16:00:09 2002
+++ working-2.5.21-numcpus/arch/sparc64/config.in	Wed Jun 12 13:38:18 2002
@@ -14,7 +14,10 @@
 define_bool CONFIG_VT y
 define_bool CONFIG_VT_CONSOLE y
 
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 bool 'Preemptible kernel' CONFIG_PREEMPT
 
 # Identify this as a Sparc64 build
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/x86_64/Config.help working-2.5.21-numcpus/arch/x86_64/Config.help
--- linux-2.5.21/arch/x86_64/Config.help	Tue Apr 23 11:39:33 2002
+++ working-2.5.21-numcpus/arch/x86_64/Config.help	Wed Jun 12 13:30:16 2002
@@ -1,29 +1,20 @@
-CONFIG_SMP
-  This enables support for systems with more than one CPU. If you have
-  a system with only one CPU, like most personal computers, say N. If
-  you have a system with more than one CPU, say Y.
+CONFIG_MAX_CPUS
+  If you have a system with only one CPU, like most personal
+  computers, say 1. If you have a system with more than one CPU, say
+  the number of CPUs.
 
-  If you say N here, the kernel will run on single and multiprocessor
+  If you say 1 here, the kernel will run on single and multiprocessor
   machines, but will use only one CPU of a multiprocessor machine. If
-  you say Y here, the kernel will run on many, but not all,
+  you say 2 or more here, the kernel will run on many, but not all,
   singleprocessor machines. On a singleprocessor machine, the kernel
-  will run faster if you say N here.
-
-  Note that if you say Y here and choose architecture "586" or
-  "Pentium" under "Processor family", the kernel will not work on 486
-  architectures. Similarly, multiprocessor kernels for the "PPro"
-  architecture may not work on all Pentium based boards.
-
-  People using multiprocessor machines who say Y here should also say
-  Y to "Enhanced Real Time Clock Support", below. The "Advanced Power
-  Management" code will be disabled if you say Y here.
+  will run faster if you say 1 here.
 
   See also the <file:Documentation/smp.tex>,
   <file:Documentation/smp.txt>, <file:Documentation/i386/IO-APIC.txt>,
   <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
   <http://www.linuxdoc.org/docs.html#howto>.
 
-  If you don't know what to do here, say N.
+  If you don't know what to do here, say 1.
 
 CONFIG_X86
   This is Linux's home port.  Linux was originally native to the Intel
diff -urN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.5.21/arch/x86_64/config.in working-2.5.21-numcpus/arch/x86_64/config.in
--- linux-2.5.21/arch/x86_64/config.in	Mon May  6 16:00:09 2002
+++ working-2.5.21-numcpus/arch/x86_64/config.in	Wed Jun 12 13:38:21 2002
@@ -43,7 +43,10 @@
 
 #currently broken:
 #bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
-bool 'Symmetric multi-processing support' CONFIG_SMP
+int 'Maximum CPUs to support (1-32)' CONFIG_MAX_CPUS 1
+if [ "$CONFIG_MAX_CPUS" != "1" ]; then
+   define_bool CONFIG_SMP y
+fi
 bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" = "y" -a "$CONFIG_X86_CMPXCHG" = "y" ]; then
     define_bool CONFIG_HAVE_DEC_LOCK y
