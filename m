Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751366AbVIYNQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751366AbVIYNQz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 09:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIYNQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 09:16:55 -0400
Received: from quark.didntduck.org ([69.55.226.66]:64454 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id S1751366AbVIYNQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 09:16:54 -0400
Message-ID: <4336A332.9010906@didntduck.org>
Date: Sun, 25 Sep 2005 09:16:34 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6-5 (X11/20050818)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@rameria.de>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Use .incbin for config_data.gz
References: <43359B28.1040007@didntduck.org> <200509251213.56437.ioe-lkml@rameria.de>
In-Reply-To: <200509251213.56437.ioe-lkml@rameria.de>
Content-Type: multipart/mixed;
 boundary="------------080503030406020308060200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080503030406020308060200
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ingo Oeser wrote:
> Hi Brian,
> 
> On Saturday 24 September 2005 20:30, Brian Gerst wrote:
> 
>>Instead of creating config_data.h, use .incbin in inline assembly to
>>directly include config_data.gz.
> 
> 
> Good idea, but please make this .rodata instead of .data,
> since this isn't going to be modified.
> 
> Regards
> 
> Ingo Oeser
> 

New patch putting the config data in .rodata.


--------------080503030406020308060200
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
+".section .rodata, \"a\"\n"
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

--------------080503030406020308060200--
