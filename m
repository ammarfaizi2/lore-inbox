Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261312AbSJUKFH>; Mon, 21 Oct 2002 06:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSJUKDI>; Mon, 21 Oct 2002 06:03:08 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:33351 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261307AbSJUKBg>; Mon, 21 Oct 2002 06:01:36 -0400
Date: Mon, 21 Oct 2002 03:16:01 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210211016.g9LAG1V21200@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org, yakker@aparity.com
Subject: [PATCH] 2.5.44: lkcd (7/9): dump configuration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to configure crash dumps in the
kernel, including optional compression mechanisms and loading
of network crash dump capabilities.

 arch/i386/config.in |    7 +++++++
 lib/Config.in       |    2 ++
 2 files changed, 9 insertions(+)

diff -Naur linux-2.5.44.orig/arch/i386/config.in linux-2.5.44.lkcd/arch/i386/config.in
--- linux-2.5.44.orig/arch/i386/config.in	Fri Oct 18 21:01:21 2002
+++ linux-2.5.44.lkcd/arch/i386/config.in	Sat Oct 19 12:39:15 2002
@@ -455,6 +455,13 @@
    dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
 fi
 
+tristate 'Crash dump support' CONFIG_CRASH_DUMP
+if [ "$CONFIG_CRASH_DUMP" != "n" ]; then
+   dep_tristate '  Crash dump block device driver' CONFIG_CRASH_DUMP_BLOCKDEV $CONFIG_CRASH_DUMP
+   dep_tristate '  Crash dump RLE compression' CONFIG_CRASH_DUMP_COMPRESS_RLE $CONFIG_CRASH_DUMP
+   dep_tristate '  Crash dump GZIP compression' CONFIG_CRASH_DUMP_COMPRESS_GZIP $CONFIG_CRASH_DUMP
+fi
+
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Check for stack overflows' CONFIG_DEBUG_STACKOVERFLOW
diff -Naur linux-2.5.44.orig/lib/Config.in linux-2.5.44.lkcd/lib/Config.in
--- linux-2.5.44.orig/lib/Config.in	Fri Oct 18 21:01:10 2002
+++ linux-2.5.44.lkcd/lib/Config.in	Sat Oct 19 12:39:15 2002
@@ -26,10 +26,12 @@
 fi
 
 if [ "$CONFIG_PPP_DEFLATE" = "y" -o \
+     "$CONFIG_CRASH_DUMP_COMPRESS_GZIP" = "y" -o \
      "$CONFIG_JFFS2_FS" = "y" ]; then
    define_tristate CONFIG_ZLIB_DEFLATE y
 else
   if [ "$CONFIG_PPP_DEFLATE" = "m" -o \
+       "$CONFIG_CRASH_DUMP_COMPRESS_GZIP" = "m" -o \
        "$CONFIG_JFFS2_FS" = "m" ]; then
      define_tristate CONFIG_ZLIB_DEFLATE m
   else
