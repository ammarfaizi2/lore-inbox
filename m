Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWAJM5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWAJM5D (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 07:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932207AbWAJM5D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 07:57:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44561 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S932107AbWAJM46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 07:56:58 -0500
Date: Tue, 10 Jan 2006 13:58:53 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: 2G memory split
Message-ID: <20060110125852.GA3389@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It does annoy me that any 1G i386 machine will end up with 1/8th of the
memory as highmem. A patch like this one has been used in various places
since the early 2.4 days at least, is there a reason why it isn't merged
yet? Note I just hacked this one up, but similar patches abound I'm
sure. Bugs are mine.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index d849c68..0b2457b 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -444,6 +464,24 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	depends on NOHIGHMEM
+	prompt "Memory split"
+	default DEFAULT_3G
+	help
+	  Select the wanted split between kernel and user memory. On a 1G
+	  machine, the 3G/1G default split will result in 128MiB of high
+	  memory. Selecting a 2G/2G split will make all of memory available
+	  as low memory. Note that this will make your kernel incompatible
+	  with binary only kernel modules.
+
+	config DEFAULT_3G
+		bool "3G/1G user/kernel split"
+	config DEFAULT_2G
+		bool "2G/2G user/kernel split"
+
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
index 73296d9..be5f6b6 100644
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -110,10 +110,22 @@ extern int page_is_ram(unsigned long pag
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
+#if defined(CONFIG_DEFAULT_3G)
 #define __PAGE_OFFSET		(0xC0000000)
+#elif defined(CONFIG_DEFAULT_2G)
+#define __PAGE_OFFSET		(0x80000000)
+#else
+#error" Bad memory split"
+#endif
 #define __PHYSICAL_START	CONFIG_PHYSICAL_START
 #else
+#if defined(CONFIG_DEFAULT_3G)
 #define __PAGE_OFFSET		(0xC0000000UL)
+#elif defined(CONFIG_DEFAULT_2G)
+#define __PAGE_OFFSET		(0x80000000UL)
+#else
+#error "Bad memory split"
+#endif
 #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 #endif
 #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)

-- 
Jens Axboe

