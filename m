Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269576AbUJFWYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269576AbUJFWYZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269508AbUJFWU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:20:59 -0400
Received: from gprs214-192.eurotel.cz ([160.218.214.192]:384 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S269538AbUJFWTZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:19:25 -0400
Date: Thu, 7 Oct 2004 00:18:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: __init poisoning for i386, too
Message-ID: <20041006221854.GA1622@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Overwrite __init section so calls to __init functions from normal code
are catched, reliably. I wonder if this should be configurable... but
it is configurable on x86-64 so I copied it. Please apply,

								Pavel

--- tmp/linux/arch/i386/Kconfig.debug	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/Kconfig.debug	2004-10-07 00:11:09.000000000 +0200
@@ -15,6 +15,13 @@
 	  with klogd/syslogd or the X server. You should normally N here,
 	  unless you want to debug such a crash.
 
+config INIT_DEBUG
+	bool "Debug __init statements"
+	depends on DEBUG_KERNEL
+	help
+	  Fill __init and __initdata at the end of boot. This helps debugging
+	  illegal uses of __init and __initdata after initialization.
+
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL
--- tmp/linux/arch/i386/mm/init.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/mm/init.c	2004-10-07 00:09:04.000000000 +0200
@@ -705,6 +705,9 @@
 		ClearPageReserved(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		free_page(addr);
+#ifdef CONFIG_INIT_DEBUG
+		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
+#endif
 		totalram_pages++;
 	}
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
