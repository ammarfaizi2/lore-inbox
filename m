Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVCFR2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVCFR2Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 12:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbVCFR2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 12:28:24 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:43747 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261441AbVCFR1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 12:27:43 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@suse.cz>
Subject: Re: BIOS overwritten during resume (was: Re: Asus L5D resume on battery power)
Date: Sun, 6 Mar 2005 18:29:59 +0100
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, Nigel Cunningham <ncunningham@cyclades.com>
References: <200502252237.04110.rjw@sisk.pl> <200503050026.06378.rjw@sisk.pl> <20050304234149.GD2647@elf.ucw.cz>
In-Reply-To: <20050304234149.GD2647@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503061830.00574.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, 5 of March 2005 00:41, Pavel Machek wrote:
> Hi!
> 
> > > Actually, take a look at Nigel's patch. He simply uses PageNosave
> > > instead of PageLocked -- that is cleaner.
> > 
> > Yes.  I thought about using PG_nosave in the begining, but there's a
> > 
> > BUG_ON(PageReserved(page) && PageNosave(page));
> > 
> > in swsusp.c:saveable() that I just didn't want to trigger.  It seems to me,
> > though, that we don't need it any more, do we?
> 
> No, we can just kill it. It was "if something unexpected happens, bail
> out soon".

OK

The following is what I'm comfortable with.  I didn't took the Nigel's patch
literally, because we do one thing differently (ie nosave pfns) and it contained
some changes that I thought were unnecessary.  The i386 part is untested.

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nrup linux-2.6.11/arch/i386/mm/init.c linux-2.6.11-a/arch/i386/mm/init.c
--- linux-2.6.11/arch/i386/mm/init.c	2005-03-02 08:38:17.000000000 +0100
+++ linux-2.6.11-a/arch/i386/mm/init.c	2005-03-06 18:16:34.000000000 +0100
@@ -272,12 +272,15 @@ void __init one_highpage_init(struct pag
 {
 	if (page_is_ram(pfn) && !(bad_ppro && page_kills_ppro(pfn))) {
 		ClearPageReserved(page);
+		ClearPageNosave(page);
 		set_bit(PG_highmem, &page->flags);
 		set_page_count(page, 1);
 		__free_page(page);
 		totalhigh_pages++;
-	} else
+	} else {
 		SetPageReserved(page);
+		SetPageNosave(page);
+	}
 }
 
 #ifndef CONFIG_DISCONTIGMEM
@@ -602,11 +605,17 @@ void __init mem_init(void)
 
 	reservedpages = 0;
 	for (tmp = 0; tmp < max_low_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
-			reservedpages++;
+		if (!page_is_ram(tmp))
+			/*
+			 * Non-RAM pages are always nosave
+			 */
+			SetPageNosave(pfn_to_page(tmp));
+		else
+			/*
+			 * Count reserved RAM pages
+			 */
+			if (PageReserved(pfn_to_page(tmp)))
+				reservedpages++;
 
 	set_highmem_pages_init(bad_ppro);
 
@@ -705,6 +714,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)addr, 0xcc, PAGE_SIZE);
 		free_page(addr);
@@ -720,6 +730,7 @@ void free_initrd_mem(unsigned long start
 		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -Nrup linux-2.6.11/arch/x86_64/mm/init.c linux-2.6.11-a/arch/x86_64/mm/init.c
--- linux-2.6.11/arch/x86_64/mm/init.c	2005-03-02 08:37:49.000000000 +0100
+++ linux-2.6.11-a/arch/x86_64/mm/init.c	2005-03-06 18:16:34.000000000 +0100
@@ -438,11 +438,17 @@ void __init mem_init(void)
 	totalram_pages += free_all_bootmem();
 
 	for (tmp = 0; tmp < end_pfn; tmp++)
-		/*
-		 * Only count reserved RAM pages
-		 */
-		if (page_is_ram(tmp) && PageReserved(pfn_to_page(tmp)))
-			reservedpages++;
+		if (!page_is_ram(tmp))
+			/*
+			 * Non-RAM pages are always nosave
+			 */
+			SetPageNosave(pfn_to_page(tmp));
+		else
+			/*
+			 * Count reserved RAM pages
+			 */
+			if (PageReserved(pfn_to_page(tmp)))
+				reservedpages++;
 #endif
 
 	after_bootmem = 1;
@@ -488,6 +494,7 @@ void free_initmem(void)
 	addr = (unsigned long)(&__init_begin);
 	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(addr));
+		ClearPageNosave(virt_to_page(addr));
 		set_page_count(virt_to_page(addr), 1);
 		memset((void *)(addr & ~(PAGE_SIZE-1)), 0xcc, PAGE_SIZE); 
 		free_page(addr);
@@ -505,6 +512,7 @@ void free_initrd_mem(unsigned long start
 	printk ("Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
+		ClearPageNosave(virt_to_page(start));
 		set_page_count(virt_to_page(start), 1);
 		free_page(start);
 		totalram_pages++;
diff -Nrup linux-2.6.11/kernel/power/swsusp.c linux-2.6.11-a/kernel/power/swsusp.c
--- linux-2.6.11/kernel/power/swsusp.c	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11-a/kernel/power/swsusp.c	2005-03-06 18:16:34.000000000 +0100
@@ -532,9 +532,9 @@ static int saveable(struct zone * zone, 
 		return 0;
 
 	page = pfn_to_page(pfn);
-	BUG_ON(PageReserved(page) && PageNosave(page));
 	if (PageNosave(page))
 		return 0;
+
 	if (PageReserved(page) && pfn_is_nosave(pfn)) {
 		pr_debug("[nosave pfn 0x%lx]", pfn);
 		return 0;

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
