Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUFWO3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUFWO3j (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 10:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUFWO3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 10:29:39 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:62621
	"EHLO voidhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S265211AbUFWO3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 10:29:17 -0400
Date: Wed, 23 Jun 2004 15:28:56 +0100
From: Andy Whitcroft <apw@shadowen.org>
Message-Id: <200406231428.i5NESu5V023376@voidhawk.shadowen.org>
To: akpm@osdl.org, apw@shadowen.org
Subject: Re: [PATCH] consolidate in kernel configuration
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040622111559.1fa0dc99.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Andy, this needs rework for top-level-Makefile changes which Linus recently
> merged.

Apologies should have checked -bk before posting.  Here is an
updated patch against linux-2.6.7-bk6.

-apw

=== 8< ===
Being able to recover the configuration from a kernel is very
useful and it would be nice to default this option to Yes.
Currently, to have the config available both from the image (using
extract-ikconfig) and via /proc we keep two copies of the original
.config in the kernel.  One in plain text and one gzip compressed.
This is not optimal.

This patch removes the plain text version of the configuration and
updates the extraction tools to locate and use the gzip'd version
of the file.  This has the added bonus of providing us with the
exact same results in both cases, the original .config; including
the comments.

Revision: $Rev: 274 $

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

---

diff -upN reference/kernel/Makefile current/kernel/Makefile
--- reference/kernel/Makefile	2004-06-23 14:31:33.000000000 +0100
+++ current/kernel/Makefile	2004-06-23 14:36:43.000000000 +0100
@@ -33,23 +33,7 @@ ifneq ($(CONFIG_IA64),y)
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
-# configs.o uses generated files - dependecies must be listed explicitly
-$(obj)/configs.o: $(obj)/ikconfig.h
-
-ifdef CONFIG_IKCONFIG_PROC
 $(obj)/configs.o: $(obj)/config_data.h
-endif
-
-# ikconfig.h contains all the selected config entries - generated
-# from top-level Makefile and .config. Info from ikconfig.h can
-# be extracted from the kernel binary.
-
-quiet_cmd_ikconfig = IKCFG   $@
-      cmd_ikconfig = $(CONFIG_SHELL) $< .config $(srctree)/Makefile > $@
-
-targets += ikconfig.h
-$(obj)/ikconfig.h: scripts/mkconfigs .config $(srctree)/Makefile FORCE
-	$(call if_changed,ikconfig)
 
 # config_data.h contains the same information as ikconfig.h but gzipped.
 # Info from config_data can be extracted from /proc/config*
@@ -58,7 +42,7 @@ $(obj)/config_data.gz: .config FORCE
 	$(call if_changed,gzip)
 
 quiet_cmd_ikconfiggz = IKCFG   $@
-      cmd_ikconfiggz = cat $< | scripts/bin2c kernel_config_data > $@
+      cmd_ikconfiggz = (echo "const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
 targets += config_data.h
 $(obj)/config_data.h: $(obj)/config_data.gz FORCE
 	$(call if_changed,ikconfiggz)
diff -upN reference/kernel/configs.c current/kernel/configs.c
--- reference/kernel/configs.c	2004-06-18 19:48:47.000000000 +0100
+++ current/kernel/configs.c	2004-06-23 14:36:43.000000000 +0100
@@ -34,13 +34,26 @@
 /**************************************************/
 /* the actual current config file                 */
 
-/* This one is for extraction from the kernel binary file image. */
-#include "ikconfig.h"
+/*
+ * Define kernel_config_data and kernel_config_data_size, which contains the
+ * wrapped and compressed configuration file.  The file is first compressed
+ * with gzip and then bounded by two eight byte magic numbers to allow
+ * extraction from a binary kernel image:
+ *
+ *   IKCFG_ST
+ *   <image>
+ *   IKCFG_ED
+ */
+#define MAGIC_START	"IKCFG_ST"
+#define MAGIC_END	"IKCFG_ED"
+#include "config_data.h"
 
-#ifdef CONFIG_IKCONFIG_PROC
 
-/* This is the data that can be read from /proc/config.gz. */
-#include "config_data.h"
+#define MAGIC_SIZE (sizeof(MAGIC_START) - 1)
+#define kernel_config_data_size \
+	(sizeof(kernel_config_data) - 1 - MAGIC_SIZE * 2)
+
+#ifdef CONFIG_IKCONFIG_PROC
 
 /**************************************************/
 /* globals and useful constants                   */
@@ -58,7 +71,7 @@ ikconfig_read_current(struct file *file,
 		return 0;
 
 	count = min(len, (size_t)(kernel_config_data_size - pos));
-	if(copy_to_user(buf, kernel_config_data + pos, count))
+	if (copy_to_user(buf, kernel_config_data + MAGIC_SIZE + pos, count))
 		return -EFAULT;
 
 	*offset += count;
diff -upN reference/scripts/extract-ikconfig current/scripts/extract-ikconfig
--- reference/scripts/extract-ikconfig	2004-01-09 06:59:45.000000000 +0000
+++ current/scripts/extract-ikconfig	2004-06-23 14:36:43.000000000 +0100
@@ -1,9 +1,31 @@
-#! /bin/bash 
+#!/bin/sh
 # extracts .config info from a [b]zImage file
 # uses: binoffset (new), dd, zcat, strings, grep
 # $arg1 is [b]zImage filename
 
-TMPFILE=""
+binoffset="./scripts/binoffset"
+
+IKCFG_ST="0x49 0x4b 0x43 0x46 0x47 0x5f 0x53 0x54"
+IKCFG_ED="0x49 0x4b 0x43 0x46 0x47 0x5f 0x45 0x44"
+function dump_config {
+    typeset file="$1"
+
+    start=`$binoffset $file $IKCFG_ST 2>/dev/null`
+    [ "$?" != "0" ] && start="-1"
+    if [ "$start" -eq "-1" ]; then
+	return
+    fi
+    end=`$binoffset $file $IKCFG_ED 2>/dev/null`
+
+    let start="$start + 8"
+    let size="$end - $start"
+
+    head --bytes="$end" "$file" | tail --bytes="$size" | zcat
+
+    clean_up
+    exit 0
+}
+
 
 usage()
 {
@@ -12,8 +34,7 @@ usage()
 
 clean_up()
 {
-	if [ -z $ISCOMP ]
-	then
+	if [ "$TMPFILE" != "" ]; then
 		rm -f $TMPFILE
 	fi
 }
@@ -21,46 +42,36 @@ clean_up()
 if [ $# -lt 1 ]
 then
 	usage
-	exit
+	exit 1
 fi
 
-image=$1
+TMPFILE="/tmp/ikconfig-$$"
+image="$1"
 
-# There are two gzip headers, as well as arches which don't compress their
-# kernel.
-GZHDR="0x1f 0x8b 0x08 0x00"
-if [ `binoffset $image $GZHDR >/dev/null 2>&1 ; echo $?` -ne 0 ]
-then
-	GZHDR="0x1f 0x8b 0x08 0x08"
-	if [ `binoffset $image $GZHDR >/dev/null 2>&1 ; echo $?` -ne 0 ]
-	then
-		ISCOMP=0
-	fi
-fi
+# vmlinux: Attempt to dump the configuration from the file directly
+dump_config "$image"
 
-PID=$$
+GZHDR1="0x1f 0x8b 0x08 0x00"
+GZHDR2="0x1f 0x8b 0x08 0x08"
 
-# Extract and uncompress the kernel image if necessary
-if [ -z $ISCOMP ]
-then
-	TMPFILE="/tmp/`basename $image`.vmlin.$PID"
-	dd if=$image bs=1 skip=`binoffset $image $GZHDR` 2> /dev/null | zcat > $TMPFILE
-else
-	TMPFILE=$image
+# vmlinux.gz: Check for a compressed images
+off=`$binoffset "$image" $GZHDR1 2>/dev/null`
+[ "$?" != "0" ] && off="-1"
+if [ "$off" -eq "-1" ]; then
+	off=`$binoffset "$image" $GZHDR2 2>/dev/null`
+	[ "$?" != "0" ] && off="-1"
 fi
-
-# Look for strings.
-strings $TMPFILE | grep "CONFIG_BEGIN=n" > /dev/null
-if [ $? -eq 0 ]
-then
-	strings $TMPFILE | awk "/CONFIG_BEGIN=n/,/CONFIG_END=n/" > $image.oldconfig.$PID
-else
-	echo "ERROR: Unable to extract kernel configuration information."
-	echo "       This kernel image may not have the config info."
-	clean_up
-	exit 1
+if [ "$off" -eq "0" ]; then
+	zcat <"$image" >"$TMPFILE"
+	dump_config "$TMPFILE"
+elif [ "$off" -ne "-1" ]; then
+	(dd ibs="$off" skip=1 count=0 && dd bs=512k) <"$image" 2>/dev/null | \
+		zcat >"$TMPFILE"
+	dump_config "$TMPFILE"
 fi
 
-echo "Kernel configuration written to $image.oldconfig.$PID"
+echo "ERROR: Unable to extract kernel configuration information."
+echo "       This kernel image may not have the config info."
+
 clean_up
-exit 0
+exit 1
