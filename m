Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWFKLXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWFKLXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 07:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWFKLW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 07:22:28 -0400
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:64082 "EHLO
	mtaout01-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751199AbWFKLWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 07:22:14 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.17-rc6 9/9] Keep the __init functions after initialization
Date: Sun, 11 Jun 2006 12:22:10 +0100
To: linux-kernel@vger.kernel.org
Message-Id: <20060611112210.8641.51560.stgit@localhost.localdomain>
In-Reply-To: <20060611111815.8641.7879.stgit@localhost.localdomain>
References: <20060611111815.8641.7879.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch adds the CONFIG_DEBUG_KEEP_INIT option which preserves the
.init.text section after initialization. Memory leaks happening during this
phase can be more easily tracked.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---

 include/linux/init.h |    4 ++++
 lib/Kconfig.debug    |   10 ++++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 93dcbe1..198edb5 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -41,7 +41,11 @@ #include <linux/compiler.h>
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
+#ifdef CONFIG_DEBUG_KEEP_INIT
+#define __init
+#else
 #define __init		__attribute__ ((__section__ (".init.text")))
+#endif
 #define __initdata	__attribute__ ((__section__ (".init.data")))
 #define __exitdata	__attribute__ ((__section__(".exit.data")))
 #define __exit_call	__attribute_used__ __attribute__ ((__section__ (".exitcall.exit")))
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 36e001b..54b3d0d 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -154,6 +154,16 @@ config DEBUG_MEMLEAK_ORPHAN_FREEING
 	  information displayed allow an easier identification of
 	  false positives.
 
+config DEBUG_KEEP_INIT
+	bool "Do not free the __init functions"
+	default n
+	depends on DEBUG_MEMLEAK
+	help
+	  This option moves the __init functions out of the .init.text
+	  section and therefore they are no longer freed after the
+	  kernel initialization. It is useful for identifying memory
+	  leaks happening during the kernel or modules initialization.
+
 config DEBUG_MEMLEAK_TEST
 	tristate "Test the kernel memory leak detector"
 	default n
