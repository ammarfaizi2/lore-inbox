Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268834AbRHPU1U>; Thu, 16 Aug 2001 16:27:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271633AbRHPU1J>; Thu, 16 Aug 2001 16:27:09 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:33704 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S268834AbRHPU1B>; Thu, 16 Aug 2001 16:27:01 -0400
Date: Thu, 16 Aug 2001 16:27:11 -0400 (EDT)
From: Ben LaHaise <bcrl@redhat.com>
X-X-Sender: <bcrl@touchme.toronto.redhat.com>
To: Mark Hemment <markhe@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Align VM locks
In-Reply-To: <Pine.LNX.4.33.0108162006270.3340-300000@alloc.wat.veritas.com>
Message-ID: <Pine.LNX.4.33.0108161625160.5368-100000@touchme.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Mark Hemment wrote:

>   I do believe that improving the shootdown code won't remove the need for
> BOUNCE_WRITE.  Only a local, temporary, mapping is need and the lighter
> mapping is, the better.

Here's the patch I sent a few days ago that provides a couple of generic
kmap_atomic entries for exactly this purpose and uses them for page cache
access.  Not only does it avoid unneeded shootdowns, but it means that
spurious schedules won't happen under extreme loads.

		-ben

diff -ur /md0/kernels/2.4/v2.4.8-ac3/include/asm-i386/kmap_types.h vm-2.4.8-ac3/include/asm-i386/kmap_types.h
--- /md0/kernels/2.4/v2.4.8-ac3/include/asm-i386/kmap_types.h	Thu May  3 11:22:18 2001
+++ vm-2.4.8-ac3/include/asm-i386/kmap_types.h	Mon Aug 13 15:21:00 2001
@@ -6,6 +6,8 @@
 	KM_BOUNCE_WRITE,
 	KM_SKB_DATA,
 	KM_SKB_DATA_SOFTIRQ,
+	KM_USER0,
+	KM_USER1,
 	KM_TYPE_NR
 };

diff -ur /md0/kernels/2.4/v2.4.8-ac3/include/linux/highmem.h vm-2.4.8-ac3/include/linux/highmem.h
--- /md0/kernels/2.4/v2.4.8-ac3/include/linux/highmem.h	Wed Aug  8 20:31:43 2001
+++ vm-2.4.8-ac3/include/linux/highmem.h	Mon Aug 13 15:25:38 2001
@@ -45,8 +45,9 @@
 /* when CONFIG_HIGHMEM is not set these will be plain clear/copy_page */
 static inline void clear_user_highpage(struct page *page, unsigned long vaddr)
 {
-	clear_user_page(kmap(page), vaddr);
-	kunmap(page);
+	void *addr = kmap_atomic(page, KM_USER0);
+	clear_user_page(addr, vaddr);
+	kunmap_atomic(addr, KM_USER0);
 }

 static inline void clear_highpage(struct page *page)
@@ -85,11 +86,11 @@
 {
 	char *vfrom, *vto;

-	vfrom = kmap(from);
-	vto = kmap(to);
+	vfrom = kmap_atomic(from, KM_USER0);
+	vto = kmap_atomic(to, KM_USER1);
 	copy_user_page(vto, vfrom, vaddr);
-	kunmap(from);
-	kunmap(to);
+	kunmap_atomic(vfrom, KM_USER0);
+	kunmap_atomic(vto, KM_USER1);
 }

 static inline void copy_highpage(struct page *to, struct page *from)

