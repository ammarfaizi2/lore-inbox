Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266324AbUG1WVM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUG1WVM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 18:21:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUG1WUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 18:20:47 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:21946 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265521AbUG1WUQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 18:20:16 -0400
Subject: Re: [PATCH] don't pass mem_map into init functions
From: Dave Hansen <haveblue@us.ibm.com>
To: Jesse Barnes <jbarnes@engr.sgi.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-mm <linux-mm@kvack.org>,
       LSE <lse-tech@lists.sourceforge.net>, Anton Blanchard <anton@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200407281501.19181.jbarnes@engr.sgi.com>
References: <1091048123.2871.435.camel@nighthawk>
	 <200407281501.19181.jbarnes@engr.sgi.com>
Content-Type: multipart/mixed; boundary="=-Wd2qRscPwwWpTcDHuEa7"
Message-Id: <1091053187.2871.526.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 28 Jul 2004 15:19:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Wd2qRscPwwWpTcDHuEa7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2004-07-28 at 15:01, Jesse Barnes wrote:
> On Wednesday, July 28, 2004 1:55 pm, Dave Hansen wrote:
> > Compile tested on SMP x86 and NUMAQ.  I plan to give it a run on ppc64
> > in a bit.  I'd appreciate if one of the ia64 guys could make sure it's
> > OK for them as well.
> 
> Which tree is this against?  It doesn't apply to the bk tree or 
> linux-2.6.8-rc2-mm1.

Put this one before it, and it should apply cleanly.  I posted this one
earlier today, and didn't realize that the new one was dependent.  

-- Dave

--=-Wd2qRscPwwWpTcDHuEa7
Content-Disposition: attachment; filename=A-zoneinit_cleanup.patch
Content-Type: text/x-patch; name=A-zoneinit_cleanup.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

Only in A-zoneinit_cleanup/arch/i386/kernel: .semaphore.o.cmd
Only in A-zoneinit_cleanup/arch/i386/kernel: semaphore.o
Only in ../linux-2.6.8-rc2-mm1/arch/i386/mm: .init.o.d
Only in ../linux-2.6.8-rc2-mm1/arch/i386/mm: .init.o.tmp
diff -ur ../linux-2.6.8-rc2-mm1/include/linux/compile.h A-zoneinit_cleanup/include/linux/compile.h
--- ../linux-2.6.8-rc2-mm1/include/linux/compile.h	2004-07-28 13:15:16.000000000 -0700
+++ A-zoneinit_cleanup/include/linux/compile.h	2004-07-28 13:14:34.000000000 -0700
@@ -1,7 +1,7 @@
 /* This file is auto generated, version 0 */
 #define UTS_MACHINE "i386"
-#define UTS_VERSION "#0 SMP Wed Jul 28 13:15:16 PDT 2004"
-#define LINUX_COMPILE_TIME "13:15:16"
+#define UTS_VERSION "#0 SMP Wed Jul 28 13:14:33 PDT 2004"
+#define LINUX_COMPILE_TIME "13:14:33"
 #define LINUX_COMPILE_BY "root"
 #define LINUX_COMPILE_HOST "elm3b82"
 #define LINUX_COMPILE_DOMAIN "eng.beaverton.ibm.com"
Only in ../linux-2.6.8-rc2-mm1/init: .do_mounts.o.cmd
Only in ../linux-2.6.8-rc2-mm1/init: .initramfs.o.d
Only in ../linux-2.6.8-rc2-mm1/init: .version.o.cmd
Only in ../linux-2.6.8-rc2-mm1/init: do_mounts.o
Only in ../linux-2.6.8-rc2-mm1/init: version.o
diff -ur ../linux-2.6.8-rc2-mm1/mm/page_alloc.c A-zoneinit_cleanup/mm/page_alloc.c
--- ../linux-2.6.8-rc2-mm1/mm/page_alloc.c	2004-07-28 11:31:08.000000000 -0700
+++ A-zoneinit_cleanup/mm/page_alloc.c	2004-07-28 11:32:38.000000000 -0700
@@ -1415,6 +1415,52 @@
 	}
 }
 
+/*
+ * Page buddy system uses "index >> (i+1)", where "index" is 
+ * at most "size-1".
+ *
+ * The extra "+3" is to round down to byte size (8 bits per byte
+ * assumption). Thus we get "(size-1) >> (i+4)" as the last byte
+ * we can access.
+ *
+ * The "+1" is because we want to round the byte allocation up 
+ * rather than down. So we should have had a "+7" before we shifted
+ * down by three. Also, we have to add one as we actually _use_ the
+ * last bit (it's [0,n] inclusive, not [0,n[).
+ *
+ * So we actually had +7+1 before we shift down by 3. But 
+ * (n+8) >> 3 == (n >> 3) + 1 (modulo overflows, which we do not have).
+ *
+ * Finally, we LONG_ALIGN because all bitmap operations are on longs.
+ */
+unsigned long pages_to_bitmap_size(unsigned long order, unsigned long nr_pages)
+{
+	unsigned long bitmap_size;
+
+	bitmap_size = (nr_pages-1) >> (order+4);
+	bitmap_size = LONG_ALIGN(bitmap_size+1);
+
+	return bitmap_size;
+}
+
+void zone_init_free_lists(struct pglist_data *pgdat, struct zone *zone, unsigned long size)
+{
+	int order;
+	for (order = 0; ; order++) {
+		unsigned long bitmap_size;
+
+		INIT_LIST_HEAD(&zone->free_area[order].free_list);
+		if (order == MAX_ORDER-1) {
+			zone->free_area[order].map = NULL;
+			break;
+		}
+
+		bitmap_size = pages_to_bitmap_size(order, size);
+		zone->free_area[order].map = 
+		  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
+	}
+}
+
 #ifndef __HAVE_ARCH_MEMMAP_INIT
 #define memmap_init(start, size, nid, zone, start_pfn) \
 	memmap_init_zone((start), (size), (nid), (zone), (start_pfn))
@@ -1531,43 +1577,7 @@
 		zone_start_pfn += size;
 		lmem_map += size;
 
-		for (i = 0; ; i++) {
-			unsigned long bitmap_size;
-
-			INIT_LIST_HEAD(&zone->free_area[i].free_list);
-			if (i == MAX_ORDER-1) {
-				zone->free_area[i].map = NULL;
-				break;
-			}
-
-			/*
-			 * Page buddy system uses "index >> (i+1)",
-			 * where "index" is at most "size-1".
-			 *
-			 * The extra "+3" is to round down to byte
-			 * size (8 bits per byte assumption). Thus
-			 * we get "(size-1) >> (i+4)" as the last byte
-			 * we can access.
-			 *
-			 * The "+1" is because we want to round the
-			 * byte allocation up rather than down. So
-			 * we should have had a "+7" before we shifted
-			 * down by three. Also, we have to add one as
-			 * we actually _use_ the last bit (it's [0,n]
-			 * inclusive, not [0,n[).
-			 *
-			 * So we actually had +7+1 before we shift
-			 * down by 3. But (n+8) >> 3 == (n >> 3) + 1
-			 * (modulo overflows, which we do not have).
-			 *
-			 * Finally, we LONG_ALIGN because all bitmap
-			 * operations are on longs.
-			 */
-			bitmap_size = (size-1) >> (i+4);
-			bitmap_size = LONG_ALIGN(bitmap_size+1);
-			zone->free_area[i].map = 
-			  (unsigned long *) alloc_bootmem_node(pgdat, bitmap_size);
-		}
+		zone_init_free_lists(pgdat, zone, zone->spanned_pages);
 	}
 }
 
Binary files ../linux-2.6.8-rc2-mm1/usr/built-in.o and A-zoneinit_cleanup/usr/built-in.o differ
Binary files ../linux-2.6.8-rc2-mm1/usr/initramfs_data.cpio and A-zoneinit_cleanup/usr/initramfs_data.cpio differ
Binary files ../linux-2.6.8-rc2-mm1/usr/initramfs_data.cpio.gz and A-zoneinit_cleanup/usr/initramfs_data.cpio.gz differ
Binary files ../linux-2.6.8-rc2-mm1/usr/initramfs_data.o and A-zoneinit_cleanup/usr/initramfs_data.o differ

--=-Wd2qRscPwwWpTcDHuEa7--

