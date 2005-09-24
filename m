Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbVIXSaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbVIXSaX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 14:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbVIXSaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 14:30:22 -0400
Received: from quark.didntduck.org ([69.55.226.66]:15341 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S932225AbVIXSaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 14:30:21 -0400
Message-ID: <43359B28.1040007@didntduck.org>
Date: Sat, 24 Sep 2005 14:30:00 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] Use .incbin for config_data.gz
Content-Type: multipart/mixed;
 boundary="------------050907060904010305090505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050907060904010305090505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Instead of creating config_data.h, use .incbin in inline assembly to
directly include config_data.gz.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

--------------050907060904010305090505
Content-Type: text/plain;
 name="0002-Use-.incbin-for-config_data.gz.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0002-Use-.incbin-for-config_data.gz.txt"

Subject: [PATCH] Use .incbin for config_data.gz

Instead of creating config_data.h, use .incbin in inline assembly to
directly include config_data.gz.

Signed-off-by: Brian Gerst <bgerst@didntduck.org>

---

 kernel/Makefile  |    9 +--------
 kernel/configs.c |   18 +++++++++++++-----
 2 files changed, 14 insertions(+), 13 deletions(-)

5674a0222370187dbe3401cb7a380c491a13f167
diff --git a/kernel/Makefile b/kernel/Makefile
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -41,16 +41,9 @@ ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_P
 CFLAGS_sched.o := $(PROFILING) -fno-omit-frame-pointer
 endif
 
-$(obj)/configs.o: $(obj)/config_data.h
+$(obj)/configs.o: $(obj)/config_data.gz
 
-# config_data.h contains the same information as ikconfig.h but gzipped.
 # Info from config_data can be extracted from /proc/config*
 targets += config_data.gz
 $(obj)/config_data.gz: .config FORCE
 	$(call if_changed,gzip)
-
-quiet_cmd_ikconfiggz = IKCFG   $@
-      cmd_ikconfiggz = (echo "static const char kernel_config_data[] = MAGIC_START"; cat $< | scripts/bin2c; echo "MAGIC_END;") > $@
-targets += config_data.h
-$(obj)/config_data.h: $(obj)/config_data.gz FORCE
-	$(call if_changed,ikconfiggz)
diff --git a/kernel/configs.c b/kernel/configs.c
--- a/kernel/configs.c
+++ b/kernel/configs.c
@@ -46,12 +46,20 @@
  */
 #define MAGIC_START	"IKCFG_ST"
 #define MAGIC_END	"IKCFG_ED"
-#include "config_data.h"
 
+asm(
+".data\n"
+"	.ascii \"" MAGIC_START "\"\n"
+"kernel_config_data:\n"
+"	.incbin \"kernel/config_data.gz\"\n"
+"kernel_config_data_end:\n"
+"	.ascii \"" MAGIC_END "\"\n"
+".previous\n"
+);
 
-#define MAGIC_SIZE (sizeof(MAGIC_START) - 1)
-#define kernel_config_data_size \
-	(sizeof(kernel_config_data) - 1 - MAGIC_SIZE * 2)
+extern const char kernel_config_data[], kernel_config_data_end[];
+
+#define kernel_config_data_size (kernel_config_data_end - kernel_config_data)
 
 #ifdef CONFIG_IKCONFIG_PROC
 
@@ -69,7 +77,7 @@ ikconfig_read_current(struct file *file,
 		return 0;
 
 	count = min(len, (size_t)(kernel_config_data_size - pos));
-	if (copy_to_user(buf, kernel_config_data + MAGIC_SIZE + pos, count))
+	if (copy_to_user(buf, kernel_config_data + pos, count))
 		return -EFAULT;
 
 	*offset += count;

--------------050907060904010305090505--
