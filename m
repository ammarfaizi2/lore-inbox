Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293297AbSBXH6x>; Sun, 24 Feb 2002 02:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293299AbSBXH6o>; Sun, 24 Feb 2002 02:58:44 -0500
Received: from postfix2-1.free.fr ([213.228.0.9]:45271 "EHLO
	postfix2-1.free.fr") by vger.kernel.org with ESMTP
	id <S293297AbSBXH6f>; Sun, 24 Feb 2002 02:58:35 -0500
From: Willy Tarreau <wtarreau@free.fr>
Message-Id: <200202240758.g1O7wWP00403@ns.home.local>
Subject: Re: 2.4.18-rc4 compile problem
To: hjb@pro-linux.de
Date: Sun, 24 Feb 2002 08:58:32 +0100 (CET)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I had no problems compiling 2.4.17. Then I applied patch 2.4.18-rc1 without
> error, and the above problem appeared. Then I applied the incremental
> patches through -rc4 but the problem remains.

2.4.18-rc1 unexports page_cache_release and replaces it with a macro, so you
may have one driver under the fs directory that now needs to include 
linux/pagemap.h.

You'll catch the culprit with simething like :

# find fs -name '*.o' | xargs nm -oa|grep page_cache_release

But I sincerely think that you have a damaged 2.4.17 source tree. You may want
to de-tar it again to check. I tried to compile everything under 2.4.18-rc1,
and all compiled well. You may have tried rmap or other patches on it before.

Well, finally I compiled 2.4.18-rc4 with your .config (gcc-2.95.3) while typing
this mail and it compiled and linked :

# tools/build -b bbootsect bsetup compressed/bvmlinux.out CURRENT > bzImage
# Root device is (8, 3)
# Boot sector 512 bytes.
# Setup is 2516 bytes.
# System is 649 kB
# make[1]: Leaving directory `/usr/src/linux-2.4.18-rc4/arch/i386/boot'
# 106.120u 9.440s 0:59.65 193.7%  0+0k 0+0io 400347pf+0w
# pcw{willy}120:

Regards,
Willy

#### for info, extract from patch-2.4.18-rc1 ####
--- linux.orig/include/linux/pagemap.h  Tue Jan 22 17:51:24 2002
+++ linux/include/linux/pagemap.h       Wed Jan  9 17:10:17 2002
@@ -29,7 +29,7 @@
 #define PAGE_CACHE_ALIGN(addr) (((addr)+PAGE_CACHE_SIZE-1)&PAGE_CACHE_MASK)
 
 #define page_cache_get(x)      get_page(x)
-extern void FASTCALL(page_cache_release(struct page *));
+#define page_cache_release(x)  __free_page(x)
--- linux.orig/kernel/ksyms.c   Tue Jan 22 17:51:24 2002
+++ linux/kernel/ksyms.c        Wed Feb  6 21:06:42 2002
@@ -95,7 +95,6 @@
-EXPORT_SYMBOL(page_cache_release);


