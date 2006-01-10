Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWAJTQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWAJTQW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751305AbWAJTQW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:16:22 -0500
Received: from rtr.ca ([64.26.128.89]:37506 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1751302AbWAJTQV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:16:21 -0500
Message-ID: <43C40803.2000106@rtr.ca>
Date: Tue, 10 Jan 2006 14:16:19 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051013 Debian/1.7.12-1ubuntu1
X-Accept-Language: en, en-us
MIME-Version: 1.0
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Byron Stanoszek <gandalf@winds.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: [PATCH ]  VMSPLIT config options (with default config fixed)
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <Pine.LNX.4.64.0601100804380.4939@g5.osdl.org> <43C3E9C2.1000309@rtr.ca> <20060110173217.GU3389@suse.de> <43C3F0CA.10205@rtr.ca> <43C403BA.1050106@pobox.com>
In-Reply-To: <43C403BA.1050106@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, fixed the ordering of the "default" lines
so that the Kconfig actually works correctly.

Best for Andrew to soak this one in -mm.

Signed-off-by:  Mark Lord <mlord@pobox.com>

diff -u --recursive --new-file --exclude='.*' linux-2.6.15/arch/i386/Kconfig linux/arch/i386/Kconfig
--- linux-2.6.15/arch/i386/Kconfig	2006-01-02 22:21:10.000000000 -0500
+++ linux/arch/i386/Kconfig	2006-01-10 12:02:40.000000000 -0500
@@ -448,6 +448,43 @@

  endchoice

+choice
+	depends on EXPERIMENTAL && !X86_PAE
+	prompt "Memory split"
+	default VMSPLIT_3G
+	help
+	  Select the desired split between kernel and user memory.
+
+	  If the address range available to the kernel is less than the
+	  physical memory installed, the remaining memory will be available
+	  as "high memory". Accessing high memory is a little more costly
+	  than low memory, as it needs to be mapped into the kernel first.
+	  Note that increasing the kernel address space limits the range
+	  available to user programs, making the address space there
+	  tighter.  Selecting anything other than the default 3G/1G split
+	  will also likely make your kernel incompatible with binary-only
+	  kernel modules.
+
+	  If you are not absolutely sure what you are doing, leave this
+	  option alone!
+
+	config VMSPLIT_3G
+		bool "3G/1G user/kernel split"
+	config VMSPLIT_3G_OPT
+		bool "3G/1G user/kernel split (for full 1G low memory)"
+	config VMSPLIT_2G
+		bool "2G/2G user/kernel split"
+	config VMSPLIT_1G
+		bool "1G/3G user/kernel split"
+endchoice
+
+config PAGE_OFFSET
+	hex
+	default 0xB0000000 if VMSPLIT_3G_OPT
+	default 0x78000000 if VMSPLIT_2G
+	default 0x40000000 if VMSPLIT_1G
+	default 0xC0000000
+
  config HIGHMEM
  	bool
  	depends on HIGHMEM64G || HIGHMEM4G
diff -u --recursive --new-file --exclude='.*' linux-2.6.15/include/asm-i386/page.h linux/include/asm-i386/page.h
--- linux-2.6.15/include/asm-i386/page.h	2006-01-02 22:21:10.000000000 -0500
+++ linux/include/asm-i386/page.h	2006-01-10 12:04:56.000000000 -0500
@@ -110,10 +110,10 @@
  #endif /* __ASSEMBLY__ */

  #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#define __PAGE_OFFSET		CONFIG_PAGE_OFFSET
  #define __PHYSICAL_START	CONFIG_PHYSICAL_START
  #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#define __PAGE_OFFSET		((unsigned long)CONFIG_PAGE_OFFSET)
  #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
  #endif
  #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)
