Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbSALFmN>; Sat, 12 Jan 2002 00:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285017AbSALFmE>; Sat, 12 Jan 2002 00:42:04 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:58752 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S284987AbSALFls>; Sat, 12 Jan 2002 00:41:48 -0500
Date: Sat, 12 Jan 2002 00:45:28 -0500
To: linux-kernel@vger.kernel.org
Cc: andrea@suse.de
Subject: [PATCH] 1-2-3 GB 
Message-ID: <20020112004528.A159@earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Patch to have 1-3 GB of virtual memory and not show up as highmem:

Tested on uniprocessor Athlon with 1024 MB RAM and 1027 MB swap.
Caused no LTP (ltp-20020108) regressions.
Did a test like http://marc.theaimsgroup.com/?l=linux-kernel&m=101064072924424&w=2
This time the test completed in 51 minutes (11% faster) and I had setiathome running
the whole time and listened to 12 mp3s sampled at 128k.

dmesg|grep Mem
Memory: 1029848k/1048512k available (1054k kernel code, 18276k reserved, 260k data, 240k init, 0k highmem)

egrep '^CONFIG_HIGH|GB' /usr/src/linux/.config
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
# CONFIG_1GB is not set
CONFIG_2GB=y
# CONFIG_3GB is not set
# CONFIG_05GB is not set

uname -a
Linux rushmore 2.4.18pre2aa2-2g #2 Fri Jan 11 22:25:55 EST 2002 i686 unknown

Derived from:
htty://kernelnewbies.org/kernels/rh72/SOURCES/linux-2.4.2-vm-1-2-3-gbyte.patch
Some parts of the patch above are already in the mainline trees.

Patch below applies to 2.4.18pre2aa2:

diff -nur linux.aa2/Rules.make linux/Rules.make
--- linux.aa2/Rules.make        Tue Mar  6 22:31:01 2001
+++ linux/Rules.make    Fri Jan 11 22:00:57 2002
@@ -212,6 +212,7 @@
 #
 # Added the SMP separator to stop module accidents between uniprocessor
 # and SMP Intel boxes - AC - from bits by Michael Chastain
+# Added separator for different PAGE_OFFSET memory models - Ingo.
 #

 ifdef CONFIG_SMP
@@ -220,6 +221,22 @@
        genksyms_smp_prefix :=
 endif

+ifdef CONFIG_2GB
+ifdef CONFIG_SMP
+       genksyms_smp_prefix := -p smp_2gig_
+else
+       genksyms_smp_prefix := -p 2gig_
+endif
+endif
+
+ifdef CONFIG_3GB
+ifdef CONFIG_SMP
+       genksyms_smp_prefix := -p smp_3gig_
+else
+       genksyms_smp_prefix := -p 3gig_
+endif
+endif
+
 $(MODINCL)/%.ver: %.c
        @if [ ! -r $(MODINCL)/$*.stamp -o $(MODINCL)/$*.stamp -ot $< ]; then \
                echo '$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -E -D__GENKSYMS__ $<'; \
diff -nur linux.aa2/arch/i386/config.in linux/arch/i386/config.in
--- linux.aa2/arch/i386/config.in       Fri Jan 11 20:57:58 2002
+++ linux/arch/i386/config.in   Fri Jan 11 22:20:32 2002
@@ -169,7 +169,11 @@
 if [ "$CONFIG_HIGHMEM64G" = "y" ]; then
    define_bool CONFIG_X86_PAE y
 else
-   bool '3.5GB user address space' CONFIG_05GB
+   choice 'Maximum Virtual Memory' \
+       "3GB            CONFIG_1GB \
+        2GB            CONFIG_2GB \
+        1GB            CONFIG_3GB \
+        05GB           CONFIG_05GB" 3GB
 fi
 if [ "$CONFIG_NOHIGHMEM" = "y" ]; then
    define_bool CONFIG_NO_PAGE_VIRTUAL y
@@ -179,6 +183,7 @@
    bool 'HIGHMEM I/O support (EXPERIMENTAL)' CONFIG_HIGHIO
 fi

+
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
diff -nur linux.aa2/include/asm-i386/page_offset.h linux/include/asm-i386/page_offset.h
--- linux.aa2/include/asm-i386/page_offset.h    Fri Jan 11 20:57:58 2002
+++ linux/include/asm-i386/page_offset.h        Fri Jan 11 21:20:48 2002
@@ -1,6 +1,10 @@
 #include <linux/config.h>
-#ifndef CONFIG_05GB
-#define PAGE_OFFSET_RAW 0xC0000000
-#else
+#ifdef CONFIG_05GB
 #define PAGE_OFFSET_RAW 0xE0000000
+#elif defined(CONFIG_1GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#elif defined(CONFIG_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_3GB)
+#define PAGE_OFFSET_RAW 0x40000000
 #endif

-- 
Randy Hron

