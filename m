Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262060AbVBUSPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262060AbVBUSPn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbVBUSPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 13:15:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:20170 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262060AbVBUSPN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 13:15:13 -0500
Subject: Re: [RFC][PATCH] Dynamically allocated pageflags.
From: Dave Hansen <haveblue@us.ibm.com>
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
In-Reply-To: <1108793012.4098.0.camel@desktop.cunningham.myip.net.au>
References: <1108780994.4077.63.camel@desktop.cunningham.myip.net.au>
	 <1108782127.19253.4.camel@localhost>
	 <1108784122.4077.123.camel@desktop.cunningham.myip.net.au>
	 <1108792304.19253.12.camel@localhost>
	 <1108793012.4098.0.camel@desktop.cunningham.myip.net.au>
Content-Type: multipart/mixed; boundary="=-E4VJlrIkt1IPFxGRtprC"
Date: Mon, 21 Feb 2005 10:15:02 -0800
Message-Id: <1109009702.11984.23.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-E4VJlrIkt1IPFxGRtprC
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, 2005-02-19 at 17:03 +1100, Nigel Cunningham wrote:
> > The mem_maps are per-pgdat or per-node with discontig, but I have a
> > patch in the pipeline to take them out of there and make one for every
> > 128MB or 256MB, etc... area of memory (for memory hotplug).  So, hanging
> > them off the pgdat or zone won't even work in that case, because even
> > the struct zone can have pretty sparse memory inside of it.  I *think*
> > the table is the only way to go.  But, that can wait until Monday. :)
> 
> Okay. I'll just wait :>

I didn't realize at first that your patch already did 95% of what I
wanted.  Pretty much all that has to be done is make checks in the
allocation loop to make sure that pages are present before allocating
the map space for them.

However, one use that I was thinking of would require map space for even
non-present pages: implementing something like pfn_valid() for memory
hotplug.  We'd need a bit for every page that is possible in the system,
no matter what.  So, I added a flag to the alloc routine to allow both
of these combinations.

We could also optimize the lookup side to assume that a NULL in the
top-level table implies all 0's for the second level. Then, have the
users of PAGE_UL_PTR() check for NULL results.  That would save some
memory, and another cacheline during a lookup.  

static inline unsigned long *PAGE_UL_PTR(dyn_pageflags_t *bitmap, int
pagenum)
{
	unsigned long *map = bitmap[PAGENUMBER(pagenum)];

	if (unlikely(!map))
		return NULL;

	return map + PAGEINDEX(pagenum);
}

The other thing is to replace max_mapnr with something that is friendly
for memory hotplug.  We have a way to represent the largest _possible_
physical memory with MAX_PHYSADDR_BITS.  That can be used instead of
max_mapnr to figure out how big the table has to be.  This patch isn't
merged yet, but it's where I got MAX_PHYSADDR_BITS.

http://www.sr71.net/patches/2.6.11/2.6.11-rc3-mhp1/broken-out/B-sparse-160-sparsemem-i386.patch

The only other question is how much memory this design can handle.  With
512 indexes in the top-level page (64-bit architectures), a 128k maximum
kmalloc() for the second level, and 4k pages, I think that's 2TB of
memory.  We can always use __alloc_pages() directly if we need more than
that. :)

Attached patch is untested, uncompiled, and would have to be applied
after the sparsemem patches I pointed to above, anyway.  Does it look
OK, in concept?

-- Dave

--=-E4VJlrIkt1IPFxGRtprC
Content-Disposition: attachment; filename=unflat_dyn_pageflags.patch
Content-Type: text/x-patch; name=unflat_dyn_pageflags.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit



---

 dynpageflags-dave/include/linux/dyn_pageflags.h |   20 ++++++++++++++++++--
 dynpageflags-dave/include/linux/mmzone.h        |   13 +++++++++++++
 dynpageflags-dave/lib/dyn_pageflags.c           |   15 +++++++++++----
 3 files changed, 42 insertions(+), 6 deletions(-)

diff -puN include/linux/dyn_pageflags.h~unflat_dyn_pageflags include/linux/dyn_pageflags.h
--- dynpageflags/include/linux/dyn_pageflags.h~unflat_dyn_pageflags	2005-02-21 08:31:38.000000000 -0800
+++ dynpageflags-dave/include/linux/dyn_pageflags.h	2005-02-21 09:42:36.000000000 -0800
@@ -14,12 +14,28 @@
 
 typedef unsigned long ** dyn_pageflags_t;
 
+enum pageflags_type {
+	PRESENT_PAGES_ONLY,
+	ALL_PAGES
+};
+
 #define BITNUMBER(page) (page_to_pfn(page))
 
 #define PAGEBIT(page) ((int) ((page_to_pfn(page))%(8 * sizeof(unsigned long))))
 
 #define BITS_PER_PAGE (PAGE_SIZE * 8)
-#define PAGES_PER_BITMAP ((max_mapnr + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
+
+/*
+ * This MAX_MAPNR definition should probably go in place of max_mapnr
+ * in a real mm header
+ */
+#ifdef CONFIG_FLATMEM
+#define MAX_MAPNR	 (max_mapnr)
+#else
+#define MAX_MAPNR	 (MAX_PHYSADDR_BITS-PAGE_SHIFT)
+#endif
+#define PAGES_PER_BITMAP ((MAX_MAPNR + BITS_PER_PAGE - 1) / BITS_PER_PAGE)
+
 #define PAGENUMBER(page) (BITNUMBER(page) / BITS_PER_PAGE)
 
 #define PAGEINDEX(page) ((BITNUMBER(page) - (BITS_PER_PAGE * PAGENUMBER(page)))/(8*sizeof(unsigned long)))
@@ -37,7 +53,7 @@ typedef unsigned long ** dyn_pageflags_t
 */
 
 extern void clear_dyn_pageflags(dyn_pageflags_t pagemap);
-extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap);
+extern int allocate_dyn_pageflags(dyn_pageflags_t *pagemap, enum pageflags_type);
 extern int free_dyn_pageflags(dyn_pageflags_t *pagemap);
 
 /* Used by Suspend2 */
diff -puN lib/dyn_pageflags.c~unflat_dyn_pageflags lib/dyn_pageflags.c
--- dynpageflags/lib/dyn_pageflags.c~unflat_dyn_pageflags	2005-02-21 08:31:39.000000000 -0800
+++ dynpageflags-dave/lib/dyn_pageflags.c	2005-02-21 09:42:23.000000000 -0800
@@ -38,7 +38,7 @@ void clear_dyn_pageflags(dyn_pageflags_t
  * Description:	Allocate a bitmap for local page flags.
  * Arguments:	dyn_pageflags_t *:	Pointer to the bitmap.
  */
-int allocate_dyn_pageflags(dyn_pageflags_t *pagemap)
+int allocate_dyn_pageflags(dyn_pageflags_t *pagemap, enum pageflags_type type)
 {
 	int i;
 
@@ -47,12 +47,17 @@ int allocate_dyn_pageflags(dyn_pageflags
 	*pagemap = kmalloc(sizeof(void *) * PAGES_PER_BITMAP, GFP_ATOMIC);
 
 	for (i = 0; i < PAGES_PER_BITMAP; i++) {
+		int pfn = i * BITS_PER_PAGE;
+		if ((type == PRESENT_PAGES_ONLY) &&
+		    !pfn_valid_range(i, i + BITS_PER_PAGE))
+			continue;
+
 		(*pagemap)[i] = (unsigned long *) get_zeroed_page(GFP_ATOMIC);
 		if (!(*pagemap)[i]) {
 			printk("Error. Unable to allocate memory for "
 					"dynamic pageflags.");
 			free_dyn_pageflags(pagemap);
-			return 1;
+			return -ENOMEM;
 		}
 	}
 	return 0;
@@ -69,8 +74,10 @@ int free_dyn_pageflags(dyn_pageflags_t *
 	if (!*pagemap)
 		return 1;
 
-	for (i = 0; i < PAGES_PER_BITMAP; i++)
-		free_pages((unsigned long) (*pagemap)[i], 0);
+	for (i = 0; i < PAGES_PER_BITMAP; i++) {
+		if (pagemap[i])
+			free_pages((unsigned long) (*pagemap)[i], 0);
+	}
 
 	kfree(*pagemap);
 	*pagemap = NULL;
diff -puN include/linux/mmzone.h~unflat_dyn_pageflags include/linux/mmzone.h
--- dynpageflags/include/linux/mmzone.h~unflat_dyn_pageflags	2005-02-21 09:16:28.000000000 -0800
+++ dynpageflags-dave/include/linux/mmzone.h	2005-02-21 09:21:18.000000000 -0800
@@ -410,6 +410,19 @@ extern struct pglist_data contig_page_da
 #error ZONES_SHIFT > MAX_ZONES_SHIFT
 #endif
 
+#ifndef CONFIG_SPARSEMEM
+static inline int pfn_valid_range(int start_pfn, int end_pfn)
+{
+	return pfn_valid(start) || pfn_valid(end);
+}
+#else
+static inline int pfn_valid_range(int start_pfn, int end_pfn)
+{
+	return valid_section_nr(start_pfn >> PAGES_PER_SECTION) ||
+	       valid_section_nr(end_pfn >> PAGES_PER_SECTION);
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _LINUX_MMZONE_H */
_

--=-E4VJlrIkt1IPFxGRtprC--

