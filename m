Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbWDTDJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbWDTDJp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 23:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDTDJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 23:09:45 -0400
Received: from fmr20.intel.com ([134.134.136.19]:42726 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751085AbWDTDJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 23:09:45 -0400
Subject: Re: [PATCH 2/3] swsusp i386 mark special saveable/unsaveable pages
From: Shaohua Li <shaohua.li@intel.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: lkml <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>,
       Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200604191633.24433.ncunningham@cyclades.com>
References: <1144809501.2865.40.camel@sli10-desk.sh.intel.com>
	 <200604191259.57951.ncunningham@cyclades.com>
	 <1145417334.19994.24.camel@sli10-desk.sh.intel.com>
	 <200604191633.24433.ncunningham@cyclades.com>
Content-Type: text/plain
Date: Thu, 20 Apr 2006 11:08:05 +0800
Message-Id: <1145502485.19994.36.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 16:33 +1000, Nigel Cunningham wrote:
> Hi.
> 
> On Wednesday 19 April 2006 13:28, Shaohua Li wrote:
> > On Wed, 2006-04-19 at 12:59 +1000, Nigel Cunningham wrote:
> > > Hi.
> > >
> > > On Wednesday 19 April 2006 12:53, Shaohua Li wrote:
> > > > On Wed, 2006-04-19 at 12:08 +1000, Nigel Cunningham wrote:
> > > > > Hi.
> > > > >
> > > > > On Wednesday 19 April 2006 11:51, Shaohua Li wrote:
> > > > > > On Wed, 2006-04-19 at 11:41 +1000, Nigel Cunningham wrote:
> > > > > > > Oh, and while we're on the topic, if only part of a page is NVS,
> > > > > > > what's the right behaviour? My e820 table has:
> > > > > > >
> > > > > > > BIOS-e820: 000000003dff0000 - 000000003dffffc0 (ACPI data)
> > > > > > > BIOS-e820: 000000003dffffc0 - 000000003e000000 (ACPI NVS)
> > > > > >
> > > > > > If only part of a page is NVS, my patch will save the whole page.
> > > > > > Any other idea?
> > > > >
> > > > > A device model driver that handles saving just the part of the page,
> > > > > using preallocated buffers to avoid the potential allocation
> > > > > problems? (The whole page could then safely be Nosave).
> > > >
> > > > The allocation might not be a problem, this just needs one or two extra
> > > > pages. A problem is if just part of the page is NVS, could we touch
> > > > other part (save/restore) the page.
> > >
> > > Yes, so I was thinking of treating it with a pseudo driver that could
> > > save and restore just that portion of the page.
> >
> > Sounds like a good idea. If NVS is already aligned to page size, do you
> > still use the pseudo driver to save/restore the pages? In my system, the
> > NVS memory is 512k.
> > In the other way, we could let the 'swsusp_add_arch_pages' accept
> > address instead of a pfn and let snapshot.c handle the partial page
> > issue.
> 
> I guess the cleanest solution would be to use the same routine in either case. 
> If that was a pseudo driver, it would mean double the memory usage (the pages 
> allocated would also be atomically copied), so perhaps using 
> swsusp_add_arch_pages is the way to go.
Ok, fixed by below patch.
> 
> I wonder too whether Mel Gorman e820 table patches could be leveraged to make 
> finding the NVS data really nice and simple?
Sounds it can't benefit us to me.

patch is on top of the swsusp-add-architecture-special-saveable-pages
patches of 2.6.17-rc1-mm3. Andrew, could you please also queue this
patch in -mm for test? Thanks!

architecture special saveable memory might not be aligned to PAGE_SIZE.
We should just save part of a page in the unaligned case. We changed
swsusp_add_arch_pages to accept an 'address' instead of a 'pfn'.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc1-mm3-root/arch/i386/kernel/setup.c   |   10 ++---
 linux-2.6.17-rc1-mm3-root/arch/x86_64/kernel/setup.c |   10 ++---
 linux-2.6.17-rc1-mm3-root/kernel/power/snapshot.c    |   34 ++++++++++++-------
 3 files changed, 32 insertions(+), 22 deletions(-)

diff -puN kernel/power/snapshot.c~swsusp-add-architecture-special-saveable-pages-fix kernel/power/snapshot.c
--- linux-2.6.17-rc1-mm3/kernel/power/snapshot.c~swsusp-add-architecture-special-saveable-pages-fix	2006-04-18 15:21:45.000000000 +0800
+++ linux-2.6.17-rc1-mm3-root/kernel/power/snapshot.c	2006-04-18 15:27:30.000000000 +0800
@@ -40,8 +40,9 @@ static unsigned int nr_meta_pages;
 static unsigned long *buffer;
 
 struct arch_saveable_page {
-	unsigned long pfn;
-	void *data;
+	unsigned long start;
+	unsigned long end;
+	char *data;
 	struct arch_saveable_page *next;
 };
 static struct arch_saveable_page *arch_pages;
@@ -50,13 +51,16 @@ int swsusp_add_arch_pages(unsigned long 
 {
 	struct arch_saveable_page *tmp;
 
-	while (start <= end) {
+	while (start < end) {
 		tmp = kzalloc(sizeof(struct arch_saveable_page), GFP_KERNEL);
 		if (!tmp)
 			return -ENOMEM;
-		tmp->pfn = start;
+		tmp->start = start;
+		tmp->end = ((start >> PAGE_SHIFT) + 1) << PAGE_SHIFT;
+		if (tmp->end > end)
+			tmp->end = end;
 		tmp->next = arch_pages;
-		start++;
+		start = tmp->end;
 		arch_pages = tmp;
 	}
 	return 0;
@@ -75,17 +79,20 @@ static unsigned int count_arch_pages(voi
 
 static int save_arch_mem(void)
 {
-	void *kaddr;
+	char *kaddr;
 	struct arch_saveable_page *tmp = arch_pages;
+	int offset;
 
 	pr_debug("swsusp: Saving arch specific memory");
 	while (tmp) {
-		tmp->data = (void *)__get_free_page(GFP_ATOMIC);
+		tmp->data = (char *)__get_free_page(GFP_ATOMIC);
 		if (!tmp->data)
 			return -ENOMEM;
+		offset = tmp->start - (tmp->start & PAGE_MASK);
 		/* arch pages might haven't a 'struct page' */
-		kaddr = kmap_atomic_pfn(tmp->pfn, KM_USER0);
-		memcpy(tmp->data, kaddr, PAGE_SIZE);
+		kaddr = kmap_atomic_pfn(tmp->start >> PAGE_SHIFT, KM_USER0);
+		memcpy(tmp->data + offset, kaddr + offset,
+			tmp->end - tmp->start);
 		kunmap_atomic(kaddr, KM_USER0);
 
 		tmp = tmp->next;
@@ -95,14 +102,17 @@ static int save_arch_mem(void)
 
 static int restore_arch_mem(void)
 {
-	void *kaddr;
+	char *kaddr;
 	struct arch_saveable_page *tmp = arch_pages;
+	int offset;
 
 	while (tmp) {
 		if (!tmp->data)
 			continue;
-		kaddr = kmap_atomic_pfn(tmp->pfn, KM_USER0);
-		memcpy(kaddr, tmp->data, PAGE_SIZE);
+		offset = tmp->start - (tmp->start & PAGE_MASK);
+		kaddr = kmap_atomic_pfn(tmp->start >> PAGE_SHIFT, KM_USER0);
+		memcpy(kaddr + offset, tmp->data + offset,
+			tmp->end - tmp->start);
 		kunmap_atomic(kaddr, KM_USER0);
 		free_page((long)tmp->data);
 		tmp->data = NULL;
diff -puN arch/i386/kernel/setup.c~swsusp-add-architecture-special-saveable-pages-fix arch/i386/kernel/setup.c
--- linux-2.6.17-rc1-mm3/arch/i386/kernel/setup.c~swsusp-add-architecture-special-saveable-pages-fix	2006-04-18 15:28:00.000000000 +0800
+++ linux-2.6.17-rc1-mm3-root/arch/i386/kernel/setup.c	2006-04-18 15:29:26.000000000 +0800
@@ -1500,8 +1500,8 @@ static void __init e820_save_acpi_pages(
 		struct e820entry *ei = &e820.map[i];
 		unsigned long start, end;
 
-		start = PFN_DOWN(ei->addr);
-		end = PFN_UP(ei->addr + ei->size);
+		start = ei->addr;
+		end = ei->addr + ei->size;
 		if (start >= end)
 			continue;
 		if (ei->type != E820_ACPI && ei->type != E820_NVS)
@@ -1510,15 +1510,15 @@ static void __init e820_save_acpi_pages(
 		 * If the region is below max_low_pfn, it will be
 		 * saved/restored by swsusp follow 'RAM' type.
 		 */
-		if (start < max_low_pfn)
-			start = max_low_pfn;
+		if (start < (max_low_pfn << PAGE_SHIFT))
+			start = max_low_pfn << PAGE_SHIFT;
 		/*
 		 * Highmem pages (ACPI NVS/Data) are reserved, but swsusp
 		 * highmem save/restore will not save/restore them. We marked
 		 * them as arch saveable pages here
 		 */
 		if (end > start)
-			swsusp_add_arch_pages(start, end - 1);
+			swsusp_add_arch_pages(start, end);
 	}
 }
 
diff -puN arch/x86_64/kernel/setup.c~swsusp-add-architecture-special-saveable-pages-fix arch/x86_64/kernel/setup.c
--- linux-2.6.17-rc1-mm3/arch/x86_64/kernel/setup.c~swsusp-add-architecture-special-saveable-pages-fix	2006-04-18 15:28:07.000000000 +0800
+++ linux-2.6.17-rc1-mm3-root/arch/x86_64/kernel/setup.c	2006-04-18 15:31:31.000000000 +0800
@@ -564,8 +564,8 @@ static void __init e820_save_acpi_pages(
 		struct e820entry *ei = &e820.map[i];
 		unsigned long start, end;
 
-		start = round_down(ei->addr, PAGE_SIZE) >> PAGE_SHIFT;
-		end = round_up(ei->addr + ei->size, PAGE_SIZE) >> PAGE_SHIFT;
+		start = ei->addr, PAGE_SIZE;
+		end = ei->addr + ei->size;
 		if (start >= end)
 			continue;
 		if (ei->type != E820_ACPI && ei->type != E820_NVS)
@@ -574,10 +574,10 @@ static void __init e820_save_acpi_pages(
 		 * If the region is below end_pfn, it will be
 		 * saved/restored by swsusp follow 'RAM' type.
 		 */
-		if (start < end_pfn)
-			start = end_pfn;
+		if (start < (end_pfn << PAGE_SHIFT))
+			start = end_pfn << PAGE_SHIFT;
 		if (end > start)
-			swsusp_add_arch_pages(start, end - 1);
+			swsusp_add_arch_pages(start, end);
 	}
 }
 
_


