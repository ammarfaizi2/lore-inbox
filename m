Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUB0MT5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261812AbUB0MT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:19:57 -0500
Received: from gate.crashing.org ([63.228.1.57]:46522 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261811AbUB0MTz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:19:55 -0500
Subject: [PATCH] ppc64 iommu rewrite part 2/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077883862.22213.365.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 23:11:02 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix /dev/mem idea of what is memory on ppc64

This add a hack to /dev/mem (along with the other ones
already there) to prevent mapping cacheable of the IO hole.

Without this, XFree blows up on machines with enough memory
to go past the IO hole. It also tries to prevent memory from
beeing mapped uncached. Cache paradoxes are evil and can
kill the CPU. 

The necessary page_is_ram() call was added by the previous
patch doing the proper IO hole accounting.

Ben.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/27 22:24:36+11:00 benh@kernel.crashing.org 
#   Fix /dev/mem mmap'ing choice of cacheable attribute on ppc64
#   (Fixes XFree on machines with an IO hole)
# 
# drivers/char/mem.c
#   2004/02/27 22:24:24+11:00 benh@kernel.crashing.org +8 -0
#   Fix /dev/mem mmap'ing choice of cacheable attribute on ppc64
#   (Fixes XFree on machines with an IO hole)
# 
diff -Nru a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c	Fri Feb 27 22:44:02 2004
+++ b/drivers/char/mem.c	Fri Feb 27 22:44:02 2004
@@ -67,6 +67,14 @@
 	 * On ia64, we ignore O_SYNC because we cannot tolerate memory attribute aliases.
 	 */
 	return !(efi_mem_attributes(addr) & EFI_MEMORY_WB);
+#elif defined(CONFIG_PPC64)
+	/* On PPC64, we always do non-cacheable access to the IO hole and
+	 * cacheable elsewhere. Cache paradox can checkstop the CPU and
+	 * the high_memory heuristic below is wrong on machines with memory
+	 * above the IO hole... Ah, and of course, XFree86 doesn't pass
+	 * O_SYNC when mapping us to tap IO space. Surprised ?
+	 */
+	return !page_is_ram(addr);
 #else
 	/*
 	 * Accessing memory above the top the kernel knows about or through a file pointer


