Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWBBLO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWBBLO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 06:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750767AbWBBLO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 06:14:56 -0500
Received: from 60-240-149-171.tpgi.com.au ([60.240.149.171]:61621 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1750757AbWBBLOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 06:14:55 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: "linux-mm" <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] Dynamically allocated pageflags
Date: Thu, 2 Feb 2006 21:11:28 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1512323.pHxpG61xVQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602022111.32930.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1512323.pHxpG61xVQ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi everyone.

This is my latest revision of the dynamically allocated pageflags patch.

The patch is useful for kernel space applications that sometimes need to fl=
ag
pages for some purpose, but don't otherwise need the retain the state. A pr=
ime
example is suspend-to-disk, which needs to flag pages as unsaveable, alloca=
ted
by suspend-to-disk and the like while it is working, but doesn't need to
retain any of this state between cycles.

Since the last revision, I have switched to using per-zone bitmaps within e=
ach
bitmap.

I know that I could still add hotplug memory support. Is there anything else
missing?

Regards,

Nigel

 include/linux/dyn_pageflags.h |   66 ++++++++
 lib/Kconfig                   |    3=20
 lib/Makefile                  |    2=20
 lib/dyn_pageflags.c           |  330 +++++++++++++++++++++++++++++++++++++=
+++++
 4 files changed, 401 insertions(+)
diff -ruNp 3150-dynamic-pageflags.patch-old/include/linux/dyn_pageflags.h 3=
150-dynamic-pageflags.patch-new/include/linux/dyn_pageflags.h
=2D-- 3150-dynamic-pageflags.patch-old/include/linux/dyn_pageflags.h	1970-0=
1-01 10:00:00.000000000 +1000
+++ 3150-dynamic-pageflags.patch-new/include/linux/dyn_pageflags.h	2006-02-=
02 21:09:57.000000000 +1000
@@ -0,0 +1,66 @@
+/*
+ * include/linux/dyn_pageflags.h
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It implements support for dynamically allocated bitmaps that are
+ * used for temporary or infrequently used pageflags, in lieu of
+ * bits in the struct page flags entry.
+ */
+
+#ifndef DYN_PAGEFLAGS_H
+#define DYN_PAGEFLAGS_H
+
+#include <linux/mm.h>
+
+typedef unsigned long *** dyn_pageflags_t;
+
+#define BITNUMBER(page) (page_to_pfn(page))
+
+#if BITS_PER_LONG =3D=3D 32
+#define UL_SHIFT 5
+#else=20
+#if BITS_PER_LONG =3D=3D 64
+#define UL_SHIFT 6
+#else
+#error Bits per long not 32 or 64?
+#endif
+#endif
+
+#define BIT_NUM_MASK (sizeof(unsigned long) * 8 - 1)
+#define PAGE_NUM_MASK (~((1 << (PAGE_SHIFT + 3)) - 1))
+#define UL_NUM_MASK (~(BIT_NUM_MASK | PAGE_NUM_MASK))
+
+#define BITS_PER_PAGE (PAGE_SIZE << 3)
+#define PAGENUMBER(zone_offset) (zone_offset >> (PAGE_SHIFT + 3))
+#define PAGEINDEX(zone_offset) ((zone_offset & UL_NUM_MASK) >> UL_SHIFT)
+#define PAGEBIT(zone_offset) (zone_offset & BIT_NUM_MASK)
+
+#define PAGE_UL_PTR(bitmap, zone_num, zone_pfn) \
+       ((bitmap[zone_num][PAGENUMBER(zone_pfn)])+PAGEINDEX(zone_pfn))
+
+/* With the above macros defined, you can do...
+
+#define PagePageset1(page) (test_dynpageflag(&pageset1_map, page))
+#define SetPagePageset1(page) (set_dynpageflag(&pageset1_map, page))
+#define ClearPagePageset1(page) (clear_dynpageflag(&pageset1_map, page))
+*/
+
+#define BITMAP_FOR_EACH_SET(bitmap, counter) \
+	for (counter =3D get_next_bit_on(bitmap, -1); counter < max_pfn; \
+		counter =3D get_next_bit_on(bitmap, counter))
+
+extern void clear_dyn_pageflags(dyn_pageflags_t pagemap);
+extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+extern int free_dyn_pageflags(dyn_pageflags_t *pagemap);
+extern int dyn_pageflags_pages_per_bitmap(void);
+extern int get_next_bit_on(dyn_pageflags_t bitmap, int counter);
+extern unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap,
+		struct page *pg);
+
+extern int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
+extern void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
+extern void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page);
+#endif
diff -ruNp 3150-dynamic-pageflags.patch-old/lib/dyn_pageflags.c 3150-dynami=
c-pageflags.patch-new/lib/dyn_pageflags.c
=2D-- 3150-dynamic-pageflags.patch-old/lib/dyn_pageflags.c	1970-01-01 10:00=
:00.000000000 +1000
+++ 3150-dynamic-pageflags.patch-new/lib/dyn_pageflags.c	2006-02-02 21:09:4=
4.000000000 +1000
@@ -0,0 +1,330 @@
+/*
+ * lib/dyn_pageflags.c
+ *
+ * Copyright (C) 2004-2006 Nigel Cunningham <nigel@suspend2.net>
+ *=20
+ * This file is released under the GPLv2.
+ *
+ * Routines for dynamically allocating and releasing bitmaps
+ * used as pseudo-pageflags.
+ *
+ * Arrays are not contiguous. The first sizeof(void *) bytes are
+ * the pointer to the next page in the bitmap. This allows us to
+ * work under low memory conditions where order 0 might be all
+ * that's available. In their original use (suspend2), it also
+ * lets us save the pages at suspend time, reload and relocate them
+ * as necessary at resume time without much effort.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/dyn_pageflags.h>
+#include <linux/bootmem.h>
+
+#define page_to_zone_offset(pg) (page_to_pfn(pg) - page_zone(pg)->zone_sta=
rt_pfn)
+
+/*=20
+ * num_zones
+ *=20
+ * How many zones are there?
+ *
+ */
+
+static int num_zones(void)
+{
+	int result =3D 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		result++;
+
+	return result;
+}
+
+/*=20
+ * pages_for_zone(struct zone *zone)
+ *=20
+ * How many pages do we need for a bitmap for this zone?
+ *
+ */
+
+static int pages_for_zone(struct zone *zone)
+{
+	return (zone->spanned_pages + (PAGE_SIZE << 3) - 1) >>
+			(PAGE_SHIFT + 3);
+}
+
+/*
+ * page_zone_number(struct page *page)
+ *
+ * Which zone index does the page match?
+ *
+ */
+
+static int page_zone_number(struct page *page)
+{
+	struct zone *zone, *zone_sought =3D page_zone(page);
+	int zone_num =3D 0;
+
+	for_each_zone(zone)
+		if (zone =3D=3D zone_sought)
+			return zone_num;
+		else
+			zone_num++;
+
+	printk("Was looking for a zone for page %p.\n", page);
+	BUG_ON(1);
+
+	return 0;
+}
+
+/*
+ * dyn_pageflags_pages_per_bitmap
+ *
+ * Number of pages needed for a bitmap covering all zones.
+ *
+ */
+int dyn_pageflags_pages_per_bitmap(void)
+{
+	int total =3D 0;
+	struct zone *zone;
+
+	for_each_zone(zone)
+		total +=3D pages_for_zone(zone);
+
+	return total;
+}
+
+/*=20
+ * clear_dyn_pageflags(dyn_pageflags_t pagemap)
+ *
+ * Clear an array used to store local page flags.
+ *
+ */
+
+void clear_dyn_pageflags(dyn_pageflags_t pagemap)
+{
+	int i =3D 0, zone_num =3D 0;
+	struct zone *zone;
+=09
+	BUG_ON(!pagemap);
+
+	for_each_zone(zone) {
+		for (i =3D 0; i < pages_for_zone(zone); i++)
+			memset((pagemap[zone_num][i]), 0, PAGE_SIZE);
+		zone_num++;
+	}
+}
+
+/*=20
+ * allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+ *
+ * Allocate a bitmap for dynamic page flags.
+ *
+ */
+int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i, zone_num =3D 0;
+	struct zone *zone;
+
+	BUG_ON(*pagemap);
+
+	*pagemap =3D kmalloc(sizeof(void *) * num_zones(), GFP_ATOMIC);
+
+	if (!*pagemap)
+		return -ENOMEM;
+
+	for_each_zone(zone) {
+		int zone_pages =3D pages_for_zone(zone);
+		(*pagemap)[zone_num] =3D kmalloc(sizeof(void *) * zone_pages,
+					       GFP_ATOMIC);
+
+		if (!(*pagemap)[zone_num]) {
+			kfree (*pagemap);
+			return -ENOMEM;
+		}
+
+		for (i =3D 0; i < zone_pages; i++) {
+			unsigned long address =3D get_zeroed_page(GFP_ATOMIC);
+			(*pagemap)[zone_num][i] =3D (unsigned long *) address;
+			if (!(*pagemap)[zone_num][i]) {
+				printk("Error. Unable to allocate memory for "
+					"dynamic pageflags.");
+				free_dyn_pageflags(pagemap);
+				return -ENOMEM;
+			}
+		}
+		zone_num++;
+	}
+
+	return 0;
+}
+
+/*=20
+ * free_dyn_pageflags(dyn_pageflags_t *pagemap)
+ *
+ * Free a dynamically allocated pageflags bitmap. For Suspend2 usage, we
+ * support data being relocated from slab to pages that don't conflict
+ * with the image that will be copied back. This is the reason for the
+ * PageSlab tests below.
+ *
+ */
+void free_dyn_pageflags(dyn_pageflags_t *pagemap)
+{
+	int i =3D 0, zone_num =3D 0;
+	struct zone *zone;
+
+	if (!*pagemap)
+		return;
+=09
+	for_each_zone(zone) {
+		int zone_pages =3D pages_for_zone(zone);
+
+		if (!((*pagemap)[zone_num]))
+			continue;
+		for (i =3D 0; i < zone_pages; i++)
+			if ((*pagemap)[zone_num][i])
+				free_page((unsigned long) (*pagemap)[zone_num][i]);
+=09
+		if (PageSlab(virt_to_page((*pagemap)[zone_num])))
+			kfree((*pagemap)[zone_num]);
+		else
+			free_page((unsigned long) (*pagemap)[zone_num]);
+
+		zone_num++;
+	}
+
+	if (PageSlab(virt_to_page((*pagemap))))
+		kfree(*pagemap);
+	else
+		free_page((unsigned long) (*pagemap));
+
+	*pagemap =3D NULL;
+	return;
+}
+
+/*
+ * dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct page *pg)
+ *
+ * Get a pointer to the unsigned long containing the flag in the bitmap
+ * for the given page.
+ *
+ */
+
+unsigned long *dyn_pageflags_ul_ptr(dyn_pageflags_t *bitmap, struct page *=
pg)
+{
+	int zone_pfn =3D page_to_zone_offset(pg);
+	int zone_num =3D page_zone_number(pg);
+	int pagenum =3D PAGENUMBER(zone_pfn);
+	int page_offset =3D PAGEINDEX(zone_pfn);
+	return ((*bitmap)[zone_num][pagenum]) + page_offset;
+}
+
+/*
+ * test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
+ *
+ * Is the page flagged in the given bitmap?
+ *
+ */
+
+int test_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
+{
+	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
+	int zone_offset =3D page_to_zone_offset(page);
+	int bit =3D PAGEBIT(zone_offset);
+=09
+	return test_bit(bit, ul);
+}
+
+/*
+ * set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
+ *
+ * Set the flag for the page in the given bitmap.
+ *
+ */
+
+void set_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
+{
+	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
+	int zone_offset =3D page_to_zone_offset(page);
+	int bit =3D PAGEBIT(zone_offset);
+	set_bit(bit, ul);
+}
+
+/*
+ * clear_dynpageflags(dyn_pageflags_t *bitmap, struct page *page)
+ *
+ * Clear the flag for the page in the given bitmap.
+ *
+ */
+
+void clear_dynpageflag(dyn_pageflags_t *bitmap, struct page *page)
+{
+	unsigned long *ul =3D dyn_pageflags_ul_ptr(bitmap, page);
+	int zone_offset =3D page_to_zone_offset(page);
+	int bit =3D PAGEBIT(zone_offset);
+	clear_bit(bit, ul);
+}
+
+/*
+ * get_next_bit_on(dyn_pageflags_t bitmap, int counter)
+ *
+ * Given a pfn (possibly -1), find the next pfn in the bitmap that
+ * is set. If there are no more flags set, return max_pfn.
+ *
+ */
+
+int get_next_bit_on(dyn_pageflags_t bitmap, int counter)
+{
+	struct page *page;
+	struct zone *zone;
+	unsigned long *ul;
+	int zone_offset, pagebit, zone_num, first;
+
+	BUG_ON(counter =3D=3D max_pfn);
+
+	first =3D (counter =3D=3D -1);
+=09
+	if (first)
+		counter =3D pgdat_list->node_zones->zone_start_pfn;
+
+	page =3D pfn_to_page(counter);
+	zone =3D page_zone(page);
+	zone_num =3D page_zone_number(page);
+
+	if (!first)
+		counter++;
+=09
+	zone_offset =3D counter - zone->zone_start_pfn;
+
+	do {
+		if (zone_offset >=3D zone->spanned_pages) {
+			do {
+				zone =3D next_zone(zone);
+				if (!zone)
+					return max_pfn;
+				zone_num++;
+			} while(!zone->spanned_pages);
+
+			counter =3D zone->zone_start_pfn;
+			zone_offset =3D 0;
+			page =3D pfn_to_page(counter);
+		}
+	=09
+		/*
+		 * This could be optimised, but there are more
+		 * important things and the code is simple at
+		 * the moment=20
+		 */
+		ul =3D (bitmap[zone_num][PAGENUMBER(zone_offset)]) + PAGEINDEX(zone_offs=
et);
+	=09
+		pagebit =3D PAGEBIT(zone_offset);
+
+		counter++;
+		zone_offset++;
+		page =3D pfn_to_page(counter);
+=09
+	} while((counter <=3D max_pfn) && (!test_bit(pagebit, ul)));
+	return counter - 1;
+}
+
diff -ruNp 3150-dynamic-pageflags.patch-old/lib/Kconfig 3150-dynamic-pagefl=
ags.patch-new/lib/Kconfig
=2D-- 3150-dynamic-pageflags.patch-old/lib/Kconfig	2006-01-19 21:28:05.0000=
00000 +1000
+++ 3150-dynamic-pageflags.patch-new/lib/Kconfig	2006-01-24 06:54:07.000000=
000 +1000
@@ -38,6 +38,9 @@ config LIBCRC32C
 	  require M here.  See Castagnoli93.
 	  Module will be libcrc32c.
=20
+config DYN_PAGEFLAGS
+	bool
+
 #
 # compression support is select'ed if needed
 #
diff -ruNp 3150-dynamic-pageflags.patch-old/lib/Makefile 3150-dynamic-pagef=
lags.patch-new/lib/Makefile
=2D-- 3150-dynamic-pageflags.patch-old/lib/Makefile	2006-01-19 21:28:05.000=
000000 +1000
+++ 3150-dynamic-pageflags.patch-new/lib/Makefile	2006-01-24 06:54:07.00000=
0000 +1000
@@ -28,6 +28,8 @@ ifneq ($(CONFIG_HAVE_DEC_LOCK),y)
   lib-y +=3D dec_and_lock.o
 endif
=20
+obj-$(CONFIG_DYN_PAGEFLAGS) +=3D dyn_pageflags.o
+
 obj-$(CONFIG_CRC_CCITT)	+=3D crc-ccitt.o
 obj-$(CONFIG_CRC16)	+=3D crc16.o
 obj-$(CONFIG_CRC32)	+=3D crc32.o

--nextPart1512323.pHxpG61xVQ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD4ejkN0y+n1M3mo0RAjCoAKCtFmPTwjvcue1bqS7FXYhJNZzmWgCfS3Ue
9QFvZ2ZqLKnhTSHh1r/D06A=
=E/lo
-----END PGP SIGNATURE-----

--nextPart1512323.pHxpG61xVQ--
