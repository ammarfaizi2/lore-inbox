Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265199AbSJRP42>; Fri, 18 Oct 2002 11:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265200AbSJRP41>; Fri, 18 Oct 2002 11:56:27 -0400
Received: from host194.steeleye.com ([66.206.164.34]:43022 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S265199AbSJRP4Y>; Fri, 18 Oct 2002 11:56:24 -0400
Message-Id: <200210181602.g9IG2KV03174@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: greg@kroah.com
cc: linux-kernel@vger.kernel.org
Subject: x86 timer clean ups
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_-17302488820"
Date: Fri, 18 Oct 2002 11:02:20 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_-17302488820
Content-Type: text/plain; charset=us-ascii

Hi Greg,

I need a flag for the TSC stuff that allows me to turn it off completely (the 
voyagers run CPUs from physically different clocks, and TSC drift causes huge 
jitters in this case).

How about two compile options:

CONFIG_X86_TSC meaning check for TSC and use it if it's OK
CONFIG_X86_PIT meaning use the PIT timer if the TSC isn't OK (or isn't wanted)

That way, arch's that know the TSC is OK in every case have

CONFIG_X86_TSC y
CONFIG_X86_PIT n

Arches that aren't sure if the TSC will be OK or not have

CONFIG_X86_TSC y
CONFIG_X86_PIT y

and arches that really don't want it at all have

CONFIG_X86_TSC n
CONFIG_X86_PIT y

The attached patch does all this. (I've also put it up on bkbits at 
http://linux-voyager.bkbits.net/timer-2.5).

James

P.S. what about this CONFIG_X86_CYCLONE thing?  It doesn't seem to be hooked 
into the timer infrastructure, should it be?



--==_Exmh_-17302488820
Content-Type: text/plain ; name="tmp.diff"; charset=us-ascii
Content-Description: tmp.diff
Content-Disposition: attachment; filename="tmp.diff"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.806   -> 1.809  
#	arch/i386/kernel/timers/Makefile	1.2     -> 1.3    
#	 arch/i386/config.in	1.59    -> 1.60   
#	arch/i386/kernel/timers/timer.c	1.3     -> 1.4    
#	arch/i386/kernel/timers/timer_pit.c	1.3.1.1 -> 1.6    
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/18	jejb@mulgrave.(none)	1.807
# Merge mulgrave.(none):/home/jejb/BK/timer-2.5
# into mulgrave.(none):/home/jejb/BK/timer-new-2.5
# --------------------------------------------
# 02/10/18	jejb@mulgrave.(none)	1.808
# [timer_pit.c] remove duplicate asm/mpspec.h include
# --------------------------------------------
# 02/10/18	jejb@mulgrave.(none)	1.809
# [x86 timers] make timer type compile time configurable
# --------------------------------------------
#
diff -Nru a/arch/i386/config.in b/arch/i386/config.in
--- a/arch/i386/config.in	Fri Oct 18 10:45:42 2002
+++ b/arch/i386/config.in	Fri Oct 18 10:45:42 2002
@@ -43,6 +43,7 @@
    define_bool CONFIG_RWSEM_XCHGADD_ALGORITHM n
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
+   define_bool CONFIG_X86_PIT y
 else
    define_bool CONFIG_X86_WP_WORKS_OK y
    define_bool CONFIG_X86_INVLPG y
@@ -59,6 +60,7 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
+   define_bool CONFIG_X86_PIT y
 fi
 if [ "$CONFIG_M586" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
@@ -66,12 +68,14 @@
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
+   define bool CONFIG_X86_PIT y
 fi
 if [ "$CONFIG_M586TSC" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 5
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_x86_PIT y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
 fi
@@ -80,6 +84,7 @@
    define_bool CONFIG_X86_USE_STRING_486 y
    define_bool CONFIG_X86_ALIGNMENT_16 y
    define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_PIT y
    define_bool CONFIG_X86_GOOD_APIC y
    define_bool CONFIG_X86_PPRO_FENCE y
    define_bool CONFIG_X86_F00F_BUG y
diff -Nru a/arch/i386/kernel/timers/Makefile b/arch/i386/kernel/timers/Makefile
--- a/arch/i386/kernel/timers/Makefile	Fri Oct 18 10:45:42 2002
+++ b/arch/i386/kernel/timers/Makefile	Fri Oct 18 10:45:42 2002
@@ -4,8 +4,8 @@
 
 obj-y := timer.o
 
-obj-y += timer_tsc.o
-obj-y += timer_pit.o
-obj-$(CONFIG_X86_CYCLONE)   += timer_cyclone.o
+obj-$(CONFIG_X86_TSC)		+= timer_tsc.o
+obj-$(CONFIG_X86_PIT)		+= timer_pit.o
+obj-$(CONFIG_X86_CYCLONE)	+= timer_cyclone.o
 
 include $(TOPDIR)/Rules.make
diff -Nru a/arch/i386/kernel/timers/timer.c b/arch/i386/kernel/timers/timer.c
--- a/arch/i386/kernel/timers/timer.c	Fri Oct 18 10:45:42 2002
+++ b/arch/i386/kernel/timers/timer.c	Fri Oct 18 10:45:42 2002
@@ -7,8 +7,10 @@
 
 /* list of timers, ordered by preference, NULL terminated */
 static struct timer_opts* timers[] = {
+#ifdef CONFIG_X86_TSC
 	&timer_tsc,
-#ifndef CONFIG_X86_TSC
+#endif
+#ifdef CONFIG_X86_PIT
 	&timer_pit,
 #endif
 	NULL,
diff -Nru a/arch/i386/kernel/timers/timer_pit.c b/arch/i386/kernel/timers/timer_pit.c
--- a/arch/i386/kernel/timers/timer_pit.c	Fri Oct 18 10:45:42 2002
+++ b/arch/i386/kernel/timers/timer_pit.c	Fri Oct 18 10:45:42 2002
@@ -8,7 +8,9 @@
 #include <linux/device.h>
 #include <asm/mpspec.h>
 #include <asm/timer.h>
+#include <asm/smp.h>
 #include <asm/io.h>
+#include <asm/arch_hooks.h>
 
 extern spinlock_t i8259A_lock;
 extern spinlock_t i8253_lock;

--==_Exmh_-17302488820--


