Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131337AbQLJUrv>; Sun, 10 Dec 2000 15:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131540AbQLJUrl>; Sun, 10 Dec 2000 15:47:41 -0500
Received: from smtp2.volny.cz ([212.20.96.11]:62983 "EHLO smtp2.volny.cz")
	by vger.kernel.org with ESMTP id <S131337AbQLJUr0>;
	Sun, 10 Dec 2000 15:47:26 -0500
Date: Sun, 10 Dec 2000 21:03:52 +0100
From: Miloslav Trmac <mitr@volny.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] truncate () doesn't clear partial pages
Message-ID: <20001210210352.A764@linux.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
vmtruncate () in test11 doesn't clear ends of partial pages. Patch is attached
below.
HOWEVER, it doesn't fix everything: partial_clear () contains
        if (!pte_present(pte))
                return;
so swapped-out pages don't get truncated (so the patch seems to break things:
truncate () behaves differently under memory pressure).
To reproduce:
------tst.c:
int
main (int argc, char *argv[])
{
  int fd;
  volatile char *base, *p;
  unsigned i, len;

  fd = open (argv[1], O_RDWR);
  len = atoi (argv[2]) * 1048576;
  base = mmap (NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
  p = base;
  base[49] = 1;
  base[50] = 2;
  for (i = len / 4096; i != 0; i--)
    { /* Touch all pages to eat memory and force swapping the 1st page out */
      *p = 1;
      p += 4096;
    }
  ftruncate (fd, 50);
  printf ("%u,%u\n", base[49], base[50]);
  return 0;
}
------
$ dd bs=1M count=$MEGS </dev/zero >tmp
$ ./tst tmp $MEGS
Plain test11 prints always 1,2 (i.e. partial page unaffected), patched
prints 1,0 if $MEGS is low enough, 1,2 if the first page was swapped out
($MEGS >= your RAM size).
The swap case should probably be handled as in ptrace.c: access_one_page()
(fault_in_page), but I don't understand the kernel well enough.
	Mirek Trmac

--- mm/memory.c.orig	Sun Dec 10 19:51:01 2000
+++ mm/memory.c	Sun Dec 10 20:17:45 2000
@@ -935,7 +935,7 @@
 		unsigned long diff;
 
 		/* mapping wholly truncated? */
-		if (mpnt->vm_pgoff >= pgoff) {
+		if (mpnt->vm_pgoff > pgoff) {
 			flush_cache_range(mm, start, end);
 			zap_page_range(mm, start, len);
 			flush_tlb_range(mm, start, end);
@@ -951,13 +951,16 @@
 		/* Ok, partially affected.. */
 		start += diff << PAGE_SHIFT;
 		len = (len - diff) << PAGE_SHIFT;
-		if (start & ~PAGE_MASK) {
-			partial_clear(mpnt, start);
-			start = (start + ~PAGE_MASK) & PAGE_MASK;
+		if (partial) {
+			partial_clear(mpnt, start + partial);
+			start += PAGE_SIZE;
+			len -= PAGE_SIZE;
+		}
+		if (len) {
+			flush_cache_range(mm, start, end);
+			zap_page_range(mm, start, len);
+			flush_tlb_range(mm, start, end);
 		}
-		flush_cache_range(mm, start, end);
-		zap_page_range(mm, start, len);
-		flush_tlb_range(mm, start, end);
 	} while ((mpnt = mpnt->vm_next_share) != NULL);
 }
 			      
@@ -984,7 +987,7 @@
 	if (!mapping->i_mmap && !mapping->i_mmap_shared)
 		goto out_unlock;
 
-	pgoff = (offset + PAGE_CACHE_SIZE - 1) >> PAGE_CACHE_SHIFT;
+	pgoff = offset >> PAGE_CACHE_SHIFT;
 	partial = (unsigned long)offset & (PAGE_CACHE_SIZE - 1);
 
 	if (mapping->i_mmap != NULL)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
