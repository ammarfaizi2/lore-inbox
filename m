Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWAJPBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWAJPBj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 10:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWAJPBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 10:01:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:54071 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751095AbWAJPBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 10:01:38 -0500
Date: Tue, 10 Jan 2006 16:03:31 +0100
From: Jens Axboe <axboe@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Byron Stanoszek <gandalf@winds.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Address space split configuration
Message-ID: <20060110150331.GN3389@suse.de>
References: <20060110125852.GA3389@suse.de> <20060110132957.GA28666@elte.hu> <20060110133728.GB3389@suse.de> <Pine.LNX.4.63.0601100840400.9511@winds.org> <20060110143931.GM3389@suse.de> <20060110144412.GA9295@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110144412.GA9295@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10 2006, Ingo Molnar wrote:
> 
> * Jens Axboe <axboe@suse.de> wrote:
> 
> > +	  Select the wanted split between kernel and user memory.
> > +
> > +	  If the address range available to the kernel is less than the
> > +	  physical memory installed, the remaining memory will be available
> > +	  as "high memory". Accessing high memory is a little more costly
> > +	  than low memory, as it needs to be mapped into the kernel first.
> 
> make it _ALOT_ more clear that mere mortals should not touch this 
> option! Also, you do not mention the userspace-VM fragmentation issues.  
> Plus, if a user uses a 2G/2G split with more than 2G of RAM, the kernel 
> should print a warning that it's running with a non-default split. Do 
> the same if the user uses a non-default split with less than 960MB of 
> RAM.

I added the < 960MiB warning, but not for the 2G/2G as the option
depends on NOHIGHMEM right now.

I also changed the help text again, hope you are happy with it now.

> > +
> > +	  Note that selecting anything but the default 3G/1G split will make
> > +	  your kernel incompatible with binary only modules.
> 
> it's not 'will' but 'may', and even then, tons of .config things can 
> break bin-only modules, so just skip this paragraph.

Killed.

> looks good to me otherwise, with the text fixes it's:
> 
> Acked-by: Ingo Molnar <mingo@elte.hu>

Thanks! Updated patch below.

---

Add option for configuring the page offset, to better optimize the
kernel for higher memory machines. Enables users to get rid of high
memory for eg a 1GiB machine.

Signed-off-by: Jens Axboe <axboe@suse.de>
Acked-by: Ingo Molnar <mingo@elte.hu>

diff --git a/arch/i386/Kconfig b/arch/i386/Kconfig
index d849c68..20d1423 100644
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -444,6 +464,35 @@ config HIGHMEM64G
 
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
+	  Note that increasing the kernel address space limits the range
+	  available to user programs, making the address space there
+	  tighter.
+
+	  If you are not absolutely sure what you are doing, leave this
+	  option alone!
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
diff --git a/arch/i386/mm/init.c b/arch/i386/mm/init.c
index 7df494b..67f1da0 100644
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -597,6 +597,12 @@ void __init mem_init(void)
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 
+#if !defined(CONFIG_DEFAULT_3G)
+	/* if the user has less than 960MB of RAM, he should use the default */
+	if (max_low_pfn < (960 * 1024 * 1024 / PAGE_SIZE))
+		printk(KERN_INFO "Memory: less than 960MiB of RAM, you should use the default memory split setting\n");
+#endif
+
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
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

