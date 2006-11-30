Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967957AbWK3XCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967957AbWK3XCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 18:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967949AbWK3XBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 18:01:49 -0500
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:19870 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S967944AbWK3XBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 18:01:41 -0500
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.19 08/10] Keep the __init functions after initialization
To: linux-kernel@vger.kernel.org
Date: Thu, 30 Nov 2006 23:01:23 +0000
Message-ID: <20061130230123.5469.80984.stgit@localhost.localdomain>
In-Reply-To: <20061130225219.5469.2453.stgit@localhost.localdomain>
References: <20061130225219.5469.2453.stgit@localhost.localdomain>
User-Agent: StGIT/0.11
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the CONFIG_DEBUG_KEEP_INIT option which preserves the
.init.text section after initialization. Memory leaks happening during this
phase can be more easily tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 include/linux/init.h |    5 +++++
 lib/Kconfig.debug    |   12 ++++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 5eb5d24..d9e92aa 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -40,8 +40,13 @@
 
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
index 2dda93b..e747478 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -226,6 +226,18 @@ config DEBUG_MEMLEAK_REPORTS_NR
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
