Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318196AbSHIIsi>; Fri, 9 Aug 2002 04:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318197AbSHIIsi>; Fri, 9 Aug 2002 04:48:38 -0400
Received: from daffy.thegoop.com ([206.58.79.242]:38919 "EHLO
	daffy.thegoop.com") by vger.kernel.org with ESMTP
	id <S318196AbSHIIsh>; Fri, 9 Aug 2002 04:48:37 -0400
Date: Fri, 9 Aug 2002 01:52:34 -0700
From: David Bronaugh <dbronaugh@linuxboxen.org>
To: linux-kernel@vger.kernel.org
Subject: Patch to enable K6-2 and K6-3 processor optimizations
Message-Id: <20020809015234.2010ebac.dbronaugh@linuxboxen.org>
Organization: Independent
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Well, I said I was new to this; forgot to include the patch, and what kernel version it was against.

It's against 2.4.19, but doesn't really change much, so should apply to most kernel revisions.

Patch follows: 

diff -Naur -X dontdiff linux/arch/i386/Makefile linux-2.4/arch/i386/Makefile
--- linux/arch/i386/Makefile    2001-04-12 12:20:31.000000000 -0700
+++ linux-2.4/arch/i386/Makefile        2002-08-09 01:16:40.000000000 -0700
@@ -62,6 +62,16 @@
 CFLAGS += $(shell if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi)
 endif
 
+ifdef CONFIG_MK6_2
+CFLAGS += $(shell if $(CC) -march=k6-2 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6-2"; else if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi; fi)
+endif
+
+ifdef CONFIG_MK6_3
+CFLAGS += $(shell if $(CC) -march=k6-3 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6-3"; else if $(CC) -march=k6 -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=k6"; else echo "-march=i586"; fi; fi)
+endif
+
+
+
 ifdef CONFIG_MK7
 CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi) 
 endif
diff -Naur -X dontdiff linux/arch/i386/config.in linux-2.4/arch/i386/config.in
--- linux/arch/i386/config.in   2002-08-09 01:21:03.000000000 -0700
+++ linux-2.4/arch/i386/config.in       2002-08-09 01:11:39.000000000 -0700
@@ -35,7 +35,9 @@
         Pentium-Pro/Celeron/Pentium-II         CONFIG_M686 \
         Pentium-III/Celeron(Coppermine)        CONFIG_MPENTIUMIII \
         Pentium-4                              CONFIG_MPENTIUM4 \
-        K6/K6-II/K6-III                        CONFIG_MK6 \
+        K6                                     CONFIG_MK6 \
+        K6-II                                  CONFIG_MK6_2 \
+        K6-III                                 CONFIG_MK6_3 \
         Athlon/Duron/K7                        CONFIG_MK7 \
         Elan                                   CONFIG_MELAN \
         Crusoe                                 CONFIG_MCRUSOE \
@@ -119,6 +121,20 @@
    define_bool CONFIG_X86_TSC y
    define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
 fi
+# Since I don't know whether CONFIG_X86_USE_3DNOW means 3dnowext or not, I'm playing it safe
+if [ "$CONFIG_MK6_2" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_TSC y
+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+fi
+if [ "$CONFIG_MK6_3" = "y" ]; then
+   define_int  CONFIG_X86_L1_CACHE_SHIFT 5
+   define_bool CONFIG_X86_ALIGNMENT_16 y
+   define_bool CONFIG_X86_TSC y

+   define_bool CONFIG_X86_USE_PPRO_CHECKSUM y
+   define_bool CONFIG_X86_USE_3DNOW y
+fi
 if [ "$CONFIG_MK7" = "y" ]; then
    define_int  CONFIG_X86_L1_CACHE_SHIFT 6
    define_bool CONFIG_X86_TSC y
