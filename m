Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265972AbUBJPOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 10:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUBJPOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 10:14:32 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:3065 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S265972AbUBJPOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 10:14:23 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Date: Tue, 10 Feb 2004 23:24:01 +0800
User-Agent: KMail/1.5.4
Cc: Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random>
In-Reply-To: <20040208020624.GG31926@dualathlon.random>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200402100625.41288.mhf@linuxmail.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

Thank you very much you for your reply. 

On Sunday 08 February 2004 10:06, Andrea Arcangeli wrote:
> not sure what's the reason of the question though. with regard to

Reason for the question is to gain more understanding for centralizing
flaging of pages which should not be touched.

I also was confused by having seen a netdump patch which uses the 
PG_reserved bit wrongly, and asked if anything was changed recently
to explain whether this patch actually could work as is. 

> suspend to disk you should probably use the original e820 map to find if
> the reserved pages are ram or non ram, 

Generally yes but the process should be centralized using standard page 
flag mechanism. This is the only clean and application independent way.

Examples emphasizing the importance of centralisation as one would not 
want to consider these issues in the implementation of swsusp, netdump 
or debuggers:

- Drivers may be sensitive to reading/writing their DMA buffers without
  considering ongoing transfers. 
- (Embedded) devices iomemory could be mapped into DMA zone and 
  get trashed by parasitic accesses. 
- A bad ppro (see patch) can be locked up by accessing "the wrong" page. 

> the reserved ram pages should probably be saved/restored, 

Except when marked PG_nosave ;)

> however the saving/restore process should be probably directed by the 
> device driver owning those reserved ram pages to be very safe 

Yes, exactly, only the driver knows what is going on with it's data and 
_must_ be made responsible for taking care of it's data.

Also in case of DMA buffers, DMA must be properly managed (suspended)
by the driver.

- sidenote as to PM - Device buffers such as disk buffers and port FIFO's 
(serial, USB serial...) must be flushed too by their drivers -

> (can suspend to disk be made safe at all? :). 

Well, it seems to put a kernel and drivers into a fridge and revive 
them on taking them out is like freezing and reviving hell :)

Nigels Software suspend 2.0 is stable on 2.4 and 2.6 and well tested,
but there are issues affecting 1 in a 1000 such as MCE's occuring -
more on that will follow.
And with drivers, we continue to have problems and have high hopes 
for PM in 2.6.

> the non
> ram pages shouldn't need to be saved/restored (as you found there's the
> bios in there). Basically you've to differentiate between reserved ram
> pages and reserved non-ram (marked as reserved just because their
> physical address fits in the mem_map_t array).

It seems unclean and unsafe to touch non-RAM regions. On lots of 
"proper" non-PC hardware, there would even be even bus timeouts
if the location is not accessible (such as write to BIOS). 

> 
> I've seen in 2.6 there's a PG_nosave, but it seems to have a different
> purpose than a "PG_ram" that tells you if the page is ram or not. From a
> quick read of the code it seems all reserved pages are stored except the
> ones in the nosave segment (which is also marked protected as part of
> the static kernel .text). So in short it looks like we save/restore the
> non-ram too, maybe it's ok, dunno but I would find it a lot safer not to
> touch that non-ram.
> 

By what I read on LKML, 64bit is probably more fussy then 32bit. eg when 
accessing non-existing memory such as on a system with memory holes 
with /dev/mem often causes MCE's. 

And here is an example of touching non-RAM going wrong on a x86 PC:

One swsusp user received a MCE on swsusp accessing 0xa0000 (video). 
This seems to be quite recent hardware: a Athlon mobile XP 20000.
This Compaq evo is running alright with NOMCE on the commandline.

(I had posted a question about this on LKML - 
"Reserved pages not flagged on Compaq evo? on 4 Feb", but found out
meanwhile (to my big surprise) that swsusp accesses the area in 
question, thus likely rendering the question obsolete)

Here is a patch for 2.4.2[45], which marks non-ram, CPU-broken-pages, and 
nosave kernel-pages pages with PG_nosave. 

Applications such as swsusp, netdump or debuggers have just to check 
the PG_nosave bit to be safe.

I actually would like to rename the bit PG_nosave to PG_donttouch ;)

diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.24-Vanilla/arch/i386/mm/init.c linux-2.4.24-mhf179/arch/i386/mm/init.c
--- linux-2.4.24-Vanilla/arch/i386/mm/init.c	2004-01-21 15:53:01.000000000 +0800
+++ linux-2.4.24-mhf179/arch/i386/mm/init.c	2004-02-10 06:15:31.000000000 +0800
@@ -451,15 +451,18 @@
 {
 	if (!page_is_ram(pfn)) {
 		SetPageReserved(page);
+		SetPageNosave(page);
 		return;
 	}
 	
 	if (bad_ppro && page_kills_ppro(pfn)) {
 		SetPageReserved(page);
+		SetPageNosave(page);
 		return;
 	}
 	
 	ClearPageReserved(page);
+	ClearPageNosave(page);
 	set_bit(PG_highmem, &page->flags);
 	atomic_set(&page->count, 1);
 	__free_page(page);
@@ -478,10 +481,18 @@
 #endif
 }
 
+
+/* The definition of a nosave region is part of software suspend
+ * and repeated to enable compilation and execution if this patch
+ * with a nosave region using a vanilla kernel.
+ */
+//extern char __nosave_begin, __nosave_end;
+
 static int __init free_pages_init(void)
 {
 	extern int ppro_with_ram_bug(void);
 	int bad_ppro, reservedpages, pfn;
+	unsigned long addr;
 
 	bad_ppro = ppro_with_ram_bug();
 
@@ -489,12 +500,29 @@
 	totalram_pages += free_all_bootmem();
 
 	reservedpages = 0;
-	for (pfn = 0; pfn < max_low_pfn; pfn++) {
+	addr = (unsigned long)__va(0);
+	for (pfn = 0; pfn < max_low_pfn; pfn++, addr += PAGE_SIZE) {
+		if (page_is_ram(pfn)) {
+			/*
+			 * Only count reserved RAM pages
+			 */
+			if (PageReserved(mem_map+pfn))
+				reservedpages++;
+#if defined(__nosave_begin)
+			/*
+			 * Mark nosave pages
+			 */
+			if (addr < (unsigned long)&__nosave_begin ||
+					addr >= (unsigned long)&__nosave_end)
+                                continue;
+#else
+			continue;
+#endif
+		}
 		/*
-		 * Only count reserved RAM pages
+		 * All other pages such as non-RAM pages are always nosave
 		 */
-		if (page_is_ram(pfn) && PageReserved(mem_map+pfn))
-			reservedpages++;
+		SetPageNosave(mem_map+pfn);
 	}
 #ifdef CONFIG_HIGHMEM
 	for (pfn = highend_pfn-1; pfn >= highstart_pfn; pfn--)
diff -uN -r -X /home/mhf/sys/dont/dontdiff linux-2.4.24-Vanilla/include/linux/mm.h linux-2.4.24-mhf179/include/linux/mm.h
--- linux-2.4.24-Vanilla/include/linux/mm.h	2004-02-06 15:40:59.000000000 +0800
+++ linux-2.4.24-mhf179/include/linux/mm.h	2004-02-10 01:19:40.000000000 +0800
@@ -301,6 +301,21 @@
 #define PG_launder		15	/* written out by VM pressure.. */
 #define PG_fs_1			16	/* Filesystem specific */
 
+/* This page is either part of the nosave region of software suspend or
+ * hardware reserved.
+ *
+ * This page may be part of ROM, device mapped memory or broken on the CPU
+ * in use and should _not_ ever be accessed except when in the software
+ * suspend nosave region or when refering device mapped memory.
+ *
+ * This page is not saved by software suspend, ignored by netdump and by
+ * debuggers performing memory dumps.
+ *
+ * Debuggers may wish to implement an overide to allow access to this page
+ * for specialized debugging.
+ */
+#define PG_nosave		17
+
 #ifndef arch_set_page_uptodate
 #define arch_set_page_uptodate(page)
 #endif
@@ -327,6 +342,9 @@
 #define SetPageLaunder(page)	set_bit(PG_launder, &(page)->flags)
 #define ClearPageLaunder(page)	clear_bit(PG_launder, &(page)->flags)
 #define ClearPageArch1(page)	clear_bit(PG_arch_1, &(page)->flags)
+#define PageNosave(page)	test_bit(PG_nosave, &(page)->flags)
+#define SetPageNosave(page)	set_bit(PG_nosave, &(page)->flags)
+#define ClearPageNosave(page)	clear_bit(PG_nosave, &(page)->flags)
 
 /*
  * The zone field is never updated after free_area_init_core()

What is your opinion of this approach?

BTW, The patch below is needed to run it with a nosave region on 
Vanilla 2.4.2[45]:

diff -ruN linux-2.4.24/arch/i386/vmlinux.lds software-suspend-linux-2.4.24-rev7/arch/i386/vmlinux.lds
--- linux-2.4.24/arch/i386/vmlinux.lds	2004-01-22 19:46:03.000000000 +1300
+++ software-suspend-linux-2.4.24-rev7/arch/i386/vmlinux.lds	2004-01-30 15:23:38.000000000 +1300
@@ -53,6 +53,12 @@
   __init_end = .;
 
   . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
+  . = ALIGN(4096);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);

also uncomment in mm/init.c the line:
//extern char __nosave_begin, __nosave_end; 

Regards
Michael


