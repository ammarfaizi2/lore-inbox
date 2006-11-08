Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWKHTt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWKHTt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWKHTt0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:49:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:46759 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422701AbWKHTtY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:49:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qcmfGs7I6qrif7i6d948KR2Zy1ZjxIvTaFTorIhbbG0iTZiRchDy1gDbSVTlDQ6hVQMgjf/hSv/iz7NMPalUFwEhp3Vlq0ZVta6RGmqgsGspK+QJZtz3jTL1YOSzG/kwtUesHqP/C27GyX6hCGDFk+YDKag67iwzhGQVmErSBV8=
Date: Wed, 8 Nov 2006 20:49:08 +0100
From: Miguel Ojeda Sandonis <maxextreme@gmail.com>
To: davem@davemloft.net
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 dcache] drivers: add LCD support
Message-Id: <20061108204908.8def2283.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David, as akpm suggested, may this patch will solve the dcache aliasing problem?

I will give you a introduction:

The user mmaped page (got by __get_free_page()) is cfag12864b_buffer.

The kernel only access it for reading at the same function 1 or 2 times:

  1º memcmp() it against the cache, so we can tell if we must update the screen
  2º if true, memcpy() the buffer to the cache buffer

So, if we want the kernel to know the last state of the data, we should call
flush_dcache_page() just once before we access it, right?

The relevant code:

	flush_dcache_page(virt_to_page(cfag12864b_buffer));
	if (memcmp(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE)) {
		memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);

		/***... update using cfag12864b_cache ...***/
	}

You know, I can't test this stuff ;) so please review and check if it is right.

Thanks you.
---

 - remove the "depends on x86" as it is portable again

 - memcpy() buffer to cache, then update from cache, not buffer,
   This way we only read the mmapped buffer 2 times.

 - add a flush_dcache_page() to flush the user mmaped page so
   the kernel has the last written data before accessing it.

 drivers/auxdisplay/Kconfig      |    1 -
 drivers/auxdisplay/cfag12864b.c |    9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

drivers-add-lcd-support-dcache.patch
Signed-off-by: Miguel Ojeda Sandonis <maxextreme@gmail.com>
---
diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
index 8d41f72..ee30c48 100644
--- a/drivers/auxdisplay/Kconfig
+++ b/drivers/auxdisplay/Kconfig
@@ -64,7 +64,6 @@ config KS0108_DELAY
 
 config CFAG12864B
 	tristate "CFAG12864B LCD"
-	depends on X86
 	depends on KS0108
 	default n
 	---help---
diff --git a/drivers/auxdisplay/cfag12864b.c b/drivers/auxdisplay/cfag12864b.c
index 7b3c9ab..a654d54 100644
--- a/drivers/auxdisplay/cfag12864b.c
+++ b/drivers/auxdisplay/cfag12864b.c
@@ -37,7 +37,7 @@
 #include <linux/workqueue.h>
 #include <linux/ks0108.h>
 #include <linux/cfag12864b.h>
-
+#include <asm/cacheflush.h>
 
 #define CFAG12864B_NAME "cfag12864b"
 
@@ -272,7 +272,10 @@ static void cfag12864b_update(void *arg)
 	unsigned char c;
 	unsigned short i, j, k, b;
 
+	flush_dcache_page(virt_to_page(cfag12864b_buffer));
 	if (memcmp(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE)) {
+		memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);
+
 		for (i = 0; i < CFAG12864B_CONTROLLERS; i++) {
 			cfag12864b_controller(i);
 			cfag12864b_nop();
@@ -283,7 +286,7 @@ static void cfag12864b_update(void *arg)
 				cfag12864b_nop();
 				for (k = 0; k < CFAG12864B_ADDRESSES; k++) {
 					for (c = 0, b = 0; b < 8; b++)
-						if (cfag12864b_buffer
+						if (cfag12864b_cache
 							[i * CFAG12864B_ADDRESSES / 8
 							+ k / 8 + (j * 8 + b) *
 							CFAG12864B_WIDTH / 8]
@@ -293,8 +296,6 @@ static void cfag12864b_update(void *arg)
 				}
 			}
 		}
-
-		memcpy(cfag12864b_cache, cfag12864b_buffer, CFAG12864B_SIZE);
 	}
 
 	if (cfag12864b_updating)
