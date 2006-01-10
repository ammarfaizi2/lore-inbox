Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbWAJOhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWAJOhl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWAJOhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:37:41 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:44069 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751001AbWAJOhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:37:40 -0500
Date: Tue, 10 Jan 2006 15:39:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Byron Stanoszek <gandalf@winds.org>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2G memory split
Message-ID: <20060110143931.GM3389@suse.de>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0601100840400.9511@winds.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Byron Stanoszek wrote:
> On Tue, 10 Jan 2006, Jens Axboe wrote:
> 
> >>yes, i made it totally configurable in 2.4 days: 1:3, 2/2 and 3:1 splits
> >>were possible. It was a larger patch to enable all this across x86, but
> >>the Kconfig portion was removed a bit later because people _frequently_
> >>misconfigured their kernels and then complained about the results.
> >
> >How is this different than all other sorts of misconfigurations? As far
> >as I can tell, the biggest "problem" for some is if they depend on some
> >binary module that will of course break with a different page offset.
> >
> >For simplicity, I didn't add more than the 2/2 split, where we could add
> >even a 3/1 kernel/user or a 0.5/3.5 (I think sles8 had this).
> 
> I prefer setting __PAGE_OFFSET to (0x78000000) on machines with 2GB of RAM.
> This seems to let the kernel use the full 2GB of memory, rather than just
> 1920-1984 MB (at least back in 2.4 days).

A newer version, trying to cater to the various comments in here.
Changes:

- Add 1G_OPT split, meant for 1GiB machines. Uses 0xB0000000
- Add 1G/3G split
- Move the 2G/2G a little, so the full 2GiB of ram can be mapped.
- Improve help text (I hope :)
- Make option depend on EXPERIMENTAL.
- Make the page.h a lot more readable.

---

Add option for configuring the page offset, to better optimize the
kernel for higher memory machines. Enables users to get rid of high
memory for eg a 1GiB machine.

Signed-off-by: Jens Axboe <axboe@suse.de>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index d849c68..fcad8f7 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -444,6 +464,32 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	depends on NOHIGHMEM && EXPERIMENTAL
+	prompt "Memory split"
+	default DEFAULT_3G
+	help
+	  Select the wanted split between kernel and user memory.
+
+	  If the address range available to the kernel is less than the
+	  physical memory installed, the remaining memory will be available
+	  as "high memory". Accessing high memory is a little more costly
+	  than low memory, as it needs to be mapped into the kernel first.
+
+	  Note that selecting anything but the default 3G/1G split will make
+	  your kernel incompatible with binary only modules.
+
+	config DEFAULT_3G
+		bool "3G/1G user/kernel split"
+	config DEFAULT_3G_OPT
+		bool "3G/1G user/kernel split (for full 1G low memory)"
+	config DEFAULT_2G
+		bool "2G/2G user/kernel split"
+	config DEFAULT_1G
+		bool "1G/3G user/kernel split"
+
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff --git a/include/asm-i386/page.h b/include/asm-i386/page.h
index 73296d9..7da50a1 100644
--- a/include/asm-i386/page.h
+++ b/include/asm-i386/page.h
@@ -109,11 +109,23 @@ extern int page_is_ram(unsigned long pag
 
 #endif /* __ASSEMBLY__ */
 
+#if defined(CONFIG_DEFAULT_3G)
+#define __PAGE_OFFSET_RAW	(0xC0000000)
+#elif defined(CONFIG_DEFAULT_3G_OPT)
+#define	__PAGE_OFFSET_RAW	(0xB0000000)
+#elif defined(CONFIG_DEFAULT_2G)
+#define __PAGE_OFFSET_RAW	(0x78000000)
+#elif defined(CONFIG_DEFAULT_1G)
+#define __PAGE_OFFSET_RAW	(0x40000000)
+#else
+#error "Bad user/kernel offset"
+#endif
+
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#define __PAGE_OFFSET		__PAGE_OFFSET_RAW
 #define __PHYSICAL_START	CONFIG_PHYSICAL_START
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#define __PAGE_OFFSET		((unsigned long)__PAGE_OFFSET_RAW)
 #define __PHYSICAL_START	((unsigned long)CONFIG_PHYSICAL_START)
 #endif
 #define __KERNEL_START		(__PAGE_OFFSET + __PHYSICAL_START)

-- 
Jens Axboe

