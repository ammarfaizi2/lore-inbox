Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261801AbSJDWxd>; Fri, 4 Oct 2002 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbSJDWxd>; Fri, 4 Oct 2002 18:53:33 -0400
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:35659 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261801AbSJDWtu>; Fri, 4 Oct 2002 18:49:50 -0400
Date: Fri, 4 Oct 2002 16:03:48 -0700
From: "Matt D. Robinson" <yakker@aparity.com>
Message-Id: <200210042303.g94N3mp10053@nakedeye.aparity.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.40: lkcd (8/9): dump configuration
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the ability to configure crash dumps in the
kernel, including optional compression mechanisms and loading
of network crash dump capabilities.

diff -urN -X /home/bharata/dontdiff linux-2.5.40/arch/i386/config.in linux-2.5.40+lkcd/arch/i386/config.in
--- linux-2.5.40/arch/i386/config.in	Tue Oct  1 12:36:28 2002
+++ linux-2.5.40+lkcd/arch/i386/config.in	Thu Oct  3 07:17:15 2002
@@ -443,6 +443,13 @@
    dep_bool 'Software Suspend (EXPERIMENTAL)' CONFIG_SOFTWARE_SUSPEND $CONFIG_PM
 fi
 
+tristate 'Linux Kernel Crash Dump (LKCD) Support' CONFIG_DUMP
+if [ "$CONFIG_DUMP" != "n" ]; then
+   dep_tristate '  LKCD Block Device Driver' CONFIG_DUMP_BLOCKDEV $CONFIG_DUMP
+   dep_tristate '  LKCD RLE compression' CONFIG_DUMP_COMPRESS_RLE $CONFIG_DUMP
+   dep_tristate '  LKCD GZIP compression' CONFIG_DUMP_COMPRESS_GZIP $CONFIG_DUMP
+fi
+
 bool 'Kernel debugging' CONFIG_DEBUG_KERNEL
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
diff -urN -X /home/bharata/dontdiff linux-2.5.40/lib/Config.in linux-2.5.40+lkcd/lib/Config.in
--- linux-2.5.40/lib/Config.in	Tue Oct  1 12:36:17 2002
+++ linux-2.5.40+lkcd/lib/Config.in	Thu Oct  3 07:17:15 2002
@@ -26,10 +26,12 @@
 fi
 
 if [ "$CONFIG_PPP_DEFLATE" = "y" -o \
+     "$CONFIG_DUMP_COMPRESS_GZIP" = "y" -o \
      "$CONFIG_JFFS2_FS" = "y" ]; then
    define_tristate CONFIG_ZLIB_DEFLATE y
 else
   if [ "$CONFIG_PPP_DEFLATE" = "m" -o \
+       "$CONFIG_DUMP_COMPRESS_GZIP" = "m" -o \
        "$CONFIG_JFFS2_FS" = "m" ]; then
      define_tristate CONFIG_ZLIB_DEFLATE m
   else
