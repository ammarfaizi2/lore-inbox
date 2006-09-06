Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbWIFWiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbWIFWiO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964778AbWIFWhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:37:55 -0400
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:8136 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964786AbWIFWhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:37:38 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc6 08/10] Keep the __init functions after initialization
Date: Wed, 06 Sep 2006 23:37:35 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060906223734.21550.23139.stgit@localhost.localdomain>
In-Reply-To: <20060906223536.21550.55411.stgit@localhost.localdomain>
References: <20060906223536.21550.55411.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the CONFIG_DEBUG_KEEP_INIT option which preserves the
.init.text section after initialization. Memory leaks happening during this
phase can be more easily tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 include/linux/init.h |    5 +++++
 lib/Kconfig.debug    |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 6667785..4b2df24 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -40,8 +40,13 @@ #include <linux/compiler.h>
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
+#ifdef CONFIG_DEBUG_KEEP_INIT
+#define __init
+#define __initdata
+#else
 #define __init		__attribute__ ((__section__ (".init.text")))
 #define __initdata	__attribute__ ((__section__ (".init.data")))
+#endif
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
 
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1786cb5..b36ac64 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -195,6 +195,18 @@ config DEBUG_MEMLEAK_REPORTS_NR
 	  reading the /sys/kernel/debug/memleak file could lead to
 	  some soft-locks.
 
+config DEBUG_KEEP_INIT
+	bool "Do not free the __init code/data"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  This option moves the __init code/data out of the
+	  .init.text/.init.data sections. It is useful for identifying
+	  memory leaks happening during the kernel or modules
+	  initialization.
+
+	  If unsure, say N.
+
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
 	depends on DEBUG_KERNEL && PREEMPT && TRACE_IRQFLAGS_SUPPORT
