Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVEJPsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVEJPsK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbVEJPsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:48:09 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:52744 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261690AbVEJPrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:47:19 -0400
Message-ID: <4280D72C.4090203@shadowen.org>
Date: Tue, 10 May 2005 16:45:48 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jschopp@austin.ibm.com
CC: akpm@osdl.org, anton@samba.org, haveblue@us.ibm.com, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       linuxppc64-dev@ozlabs.org, olof@lixom.net, paulus@samba.org
Subject: Re: sparsemem ppc64 tidy flat memory comments and fix benign mempresent
 call
References: <E1DVAVE-00012m-Pq@pinky.shadowen.org> <427FEC57.8060505@austin.ibm.com>
In-Reply-To: <427FEC57.8060505@austin.ibm.com>
Content-Type: multipart/mixed;
 boundary="------------060509030101080602000401"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060509030101080602000401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

> Instead of moving all that around why don't we just drop the duplicate
> and the if altogether?  I tested and sent a patch back in March that
> cleaned up the non-numa case pretty well.
> 
> http://sourceforge.net/mailarchive/message.php?msg_id=11320001

Ok, Mike also expressed the feeling that it was no longer necessary to
handle the first block separatly.  I've tested the attached patch on the
machines I have to hand and it seems to boot just fine in the flat
memory modes with this applied.

Joel, Mike, Dave could you test this one on your platforms to confirm
its widly applicable, if so we can push it up to -mm.  The patch
attached applies to the patches proposed for the next -mm.  A full stack
on top of 2.6.12-rc3-mm2 can be found at the URL below (see the series
file):

http://www.shadowen.org/~apw/linux/sparsemem/sparsemem-2.6.12-rc3-mm2-V3/

Cheers.

-apw

--------------060509030101080602000401
Content-Type: text/plain;
 name="sparsemem-ppc64-flat-first-block-is-not-special"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sparsemem-ppc64-flat-first-block-is-not-special"

Testing seems to confirm that we do not need to handle the first memory
block specially in do_init_bootmem.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>

diffstat sparsemem-ppc64-flat-first-block-is-not-special
---

diff -upN reference/arch/ppc64/mm/init.c current/arch/ppc64/mm/init.c
--- reference/arch/ppc64/mm/init.c
+++ current/arch/ppc64/mm/init.c
@@ -612,14 +612,6 @@ void __init do_init_bootmem(void)
 	unsigned long start, bootmap_pages;
 	unsigned long total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	int boot_mapsize;
-	unsigned long start_pfn, end_pfn;
-	/*
-	 * Note presence of first (logical/coalasced) LMB which will
-	 * contain RMO region
-	 */
-	start_pfn = lmb.memory.region[0].physbase >> PAGE_SHIFT;
-	end_pfn = start_pfn + (lmb.memory.region[0].size >> PAGE_SHIFT);
-	memory_present(0, start_pfn, end_pfn);
 
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
@@ -636,18 +628,19 @@ void __init do_init_bootmem(void)
 	max_pfn = max_low_pfn;
 
 	/* Add all physical memory to the bootmem map, mark each area
-	 * present.  The first block has already been marked present above.
+	 * present.
 	 */
 	for (i=0; i < lmb.memory.cnt; i++) {
 		unsigned long physbase, size;
+		unsigned long start_pfn, end_pfn;
 
 		physbase = lmb.memory.region[i].physbase;
 		size = lmb.memory.region[i].size;
-		if (i) {
-			start_pfn = physbase >> PAGE_SHIFT;
-			end_pfn = start_pfn + (size >> PAGE_SHIFT);
-			memory_present(0, start_pfn, end_pfn);
-		}
+
+		start_pfn = physbase >> PAGE_SHIFT;
+		end_pfn = start_pfn + (size >> PAGE_SHIFT);
+		memory_present(0, start_pfn, end_pfn);
+
 		free_bootmem(physbase, size);
 	}
 

--------------060509030101080602000401--
