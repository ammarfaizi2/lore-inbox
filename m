Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267399AbUHDTc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267399AbUHDTc7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 15:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267388AbUHDTcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 15:32:55 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52352 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267393AbUHDTb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 15:31:56 -0400
Date: Wed, 04 Aug 2004 12:30:29 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
cc: eric@cisu.net, kernel@kolivas.org, barryn@pobox.com,
       swsnyder@insightbb.com, linux-kernel@vger.kernel.org
Subject: Re: HIGHMEM4G config for 1GB RAM on desktop?
Message-ID: <210450000.1091647829@flay>
In-Reply-To: <20040804120633.4dca57b3.akpm@osdl.org>
References: <200408021602.34320.swsnyder@insightbb.com><410FA145.70701@kolivas.org><20040804060625.GE10340@suse.de><200408040614.30820.eric@cisu.net><20040804130707.GN10340@suse.de> <20040804120633.4dca57b3.akpm@osdl.org>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The 896M/128M split has a bit of a problem now each zone has its own LRU:
> the size of the highmem zone is less than the amount of memory which is
> described by the default /proc/sys/vm/dirty_ratio.  So it is easy to
> completely fill highmem with dirty pages.  This causes a fairly large
> amount of writeback via vmscan.c's writepage().  This causes poor I/O
> submission patterns.  This causes a simple large, linear `dd' write to run
> at only 50-70% of disk bandwidth.  (This was 6-12 months ago - it might be
> a bit better now)
> 
> But I seem to be the only person who has noticed this yet ;) A workaround
> is to decrease dirty_ratio and dirty_background_ratio.
> 
> Decreasing PAGE_OFFSET as above is attractive, but I believe 0xc0000000 is
> part of the ABI, and although we know (from the 4g/4g and other such
> patches) that everything will work OK, I wonder if it's really worth doing,
> especially as it's a compile-time thing.
> 
> But hey, if someone can identify specific benefits from it then perhaps
> sneaking in a config option, or maintaining an external patch would be
> worthwhile.

I had a patch for a config option, ported forward by someone at IBM (I forget
who, possibly Dave) from Andrea's original. I think we finally decided 
(in consultation with Andrea) we could drop the complicated stuff he had
in the asm code, so it's pretty simple ... something like this:

diff -purN -X /home/mbligh/.diff.exclude 200-config_hz/arch/i386/Kconfig 210-config_page_offset/arch/i386/Kconfig
--- 200-config_hz/arch/i386/Kconfig	2004-03-14 09:48:36.000000000 -0800
+++ 210-config_page_offset/arch/i386/Kconfig	2004-03-14 09:49:04.000000000 -0800
@@ -763,6 +763,44 @@ config HIGHMEM64G
 
 endchoice
 
+choice
+	help
+	  On i386, a process can only virtually address 4GB of memory.  This
+	  lets you select how much of that virtual space you would like to 
+	  devoted to userspace, and how much to the kernel.
+
+	  Some userspace programs would like to address as much as possible and 
+	  have few demands of the kernel other than it get out of the way.  These
+	  users may opt to use the 3.5GB option to give their userspace program 
+	  as much room as possible.  Due to alignment issues imposed by PAE, 
+	  the "3.5GB" option is unavailable if "64GB" high memory support is 
+	  enabled.
+
+	  Other users (especially those who use PAE) may be running out of
+	  ZONE_NORMAL memory.  Those users may benefit from increasing the
+	  kernel's virtual address space size by taking it away from userspace, 
+	  which may not need all of its space.  An indicator that this is 
+	  happening is when /proc/Meminfo's "LowFree:" is a small percentage of
+	  "LowTotal:" while "HighFree:" is very large.
+
+	  If unsure, say "3GB"
+	prompt "User address space size"
+        default 1GB
+	
+config	05GB
+	bool "3.5 GB"
+	depends on !HIGHMEM64G
+	
+config	1GB
+	bool "3 GB"
+	
+config	2GB
+	bool "2 GB"
+	
+config	3GB
+	bool "1 GB"
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff -purN -X /home/mbligh/.diff.exclude 200-config_hz/arch/i386/Makefile 210-config_page_offset/arch/i386/Makefile
--- 200-config_hz/arch/i386/Makefile	2004-03-12 11:06:23.000000000 -0800
+++ 210-config_page_offset/arch/i386/Makefile	2004-03-14 09:49:04.000000000 -0800
@@ -114,6 +114,7 @@ drivers-$(CONFIG_PM)			+= arch/i386/powe
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
+AFLAGS_vmlinux.lds.o += -include $(TOPDIR)/include/asm-i386/page.h
 
 boot := arch/i386/boot
 
diff -purN -X /home/mbligh/.diff.exclude 200-config_hz/include/asm-i386/page.h 210-config_page_offset/include/asm-i386/page.h
--- 200-config_hz/include/asm-i386/page.h	2004-03-12 11:07:27.000000000 -0800
+++ 210-config_page_offset/include/asm-i386/page.h	2004-03-14 09:49:04.000000000 -0800
@@ -97,9 +97,20 @@ typedef struct { unsigned long pgprot; }
 #ifdef CONFIG_X86_4G_VM_LAYOUT
 #define __PAGE_OFFSET		(0x02000000)
 #define TASK_SIZE		(0xff000000)
-#else
+#elif defined(CONFIG_05GB)
+#define __PAGE_OFFSET		(0xe0000000)
+#define TASK_SIZE		(0xe0000000)
+#elif defined(CONFIG_1GB)
 #define __PAGE_OFFSET		(0xc0000000)
 #define TASK_SIZE		(0xc0000000)
+#elif defined(CONFIG_2GB)
+#define __PAGE_OFFSET		(0x80000000)
+#define TASK_SIZE		(0x80000000)
+#elif defined(CONFIG_3GB)
+#define __PAGE_OFFSET		(0x40000000)
+#define TASK_SIZE		(0x40000000)
+#else
+#error I have no idea what VM layout to use
 #endif
 
 /*
diff -purN -X /home/mbligh/.diff.exclude 200-config_hz/include/asm-i386/processor.h 210-config_page_offset/include/asm-i386/processor.h
--- 200-config_hz/include/asm-i386/processor.h	2004-03-12 11:07:47.000000000 -0800
+++ 210-config_page_offset/include/asm-i386/processor.h	2004-03-14 09:49:04.000000000 -0800
@@ -294,7 +294,11 @@ extern unsigned int mca_pentium_flag;
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifdef CONFIG_05GB
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 16))
+#else
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#endif
 
 /*
  * Size of io_bitmap, covering ports 0 to 0x3ff.



