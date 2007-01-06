Return-Path: <linux-kernel-owner+w=401wt.eu-S1751129AbXAFClG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbXAFClG (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbXAFCkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:40:51 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:36700 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXAFCbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:31:03 -0500
Message-Id: <20070106023511.043532000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:27 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>
Subject: [patch 34/50] SPARC64: Fix "mem=xxx" handling.
Content-Disposition: inline; filename=sparc64-fix-mem-xxx-handling.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: David Miller <davem@davemloft.net>

We were not being careful enough.  When we trim the physical
memory areas, we have to make sure we don't remove the kernel
image or initial ramdisk image ranges.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/sparc64/mm/init.c |  147 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 124 insertions(+), 23 deletions(-)

--- linux-2.6.19.1.orig/arch/sparc64/mm/init.c
+++ linux-2.6.19.1/arch/sparc64/mm/init.c
@@ -872,6 +872,115 @@ static unsigned long __init choose_bootm
 	prom_halt();
 }
 
+static void __init trim_pavail(unsigned long *cur_size_p,
+			       unsigned long *end_of_phys_p)
+{
+	unsigned long to_trim = *cur_size_p - cmdline_memory_size;
+	unsigned long avoid_start, avoid_end;
+	int i;
+
+	to_trim = PAGE_ALIGN(to_trim);
+
+	avoid_start = avoid_end = 0;
+#ifdef CONFIG_BLK_DEV_INITRD
+	avoid_start = initrd_start;
+	avoid_end = PAGE_ALIGN(initrd_end);
+#endif
+
+	/* Trim some pavail[] entries in order to satisfy the
+	 * requested "mem=xxx" kernel command line specification.
+	 *
+	 * We must not trim off the kernel image area nor the
+	 * initial ramdisk range (if any).  Also, we must not trim
+	 * any pavail[] entry down to zero in order to preserve
+	 * the invariant that all pavail[] entries have a non-zero
+	 * size which is assumed by all of the code in here.
+	 */
+	for (i = 0; i < pavail_ents; i++) {
+		unsigned long start, end, kern_end;
+		unsigned long trim_low, trim_high, n;
+
+		kern_end = PAGE_ALIGN(kern_base + kern_size);
+
+		trim_low = start = pavail[i].phys_addr;
+		trim_high = end = start + pavail[i].reg_size;
+
+		if (kern_base >= start &&
+		    kern_base < end) {
+			trim_low = kern_base;
+			if (kern_end >= end)
+				continue;
+		}
+		if (kern_end >= start &&
+		    kern_end < end) {
+			trim_high = kern_end;
+		}
+		if (avoid_start &&
+		    avoid_start >= start &&
+		    avoid_start < end) {
+			if (trim_low > avoid_start)
+				trim_low = avoid_start;
+			if (avoid_end >= end)
+				continue;
+		}
+		if (avoid_end &&
+		    avoid_end >= start &&
+		    avoid_end < end) {
+			if (trim_high < avoid_end)
+				trim_high = avoid_end;
+		}
+
+		if (trim_high <= trim_low)
+			continue;
+
+		if (trim_low == start && trim_high == end) {
+			/* Whole chunk is available for trimming.
+			 * Trim all except one page, in order to keep
+			 * entry non-empty.
+			 */
+			n = (end - start) - PAGE_SIZE;
+			if (n > to_trim)
+				n = to_trim;
+
+			if (n) {
+				pavail[i].phys_addr += n;
+				pavail[i].reg_size -= n;
+				to_trim -= n;
+			}
+		} else {
+			n = (trim_low - start);
+			if (n > to_trim)
+				n = to_trim;
+
+			if (n) {
+				pavail[i].phys_addr += n;
+				pavail[i].reg_size -= n;
+				to_trim -= n;
+			}
+			if (to_trim) {
+				n = end - trim_high;
+				if (n > to_trim)
+					n = to_trim;
+				if (n) {
+					pavail[i].reg_size -= n;
+					to_trim -= n;
+				}
+			}
+		}
+
+		if (!to_trim)
+			break;
+	}
+
+	/* Recalculate.  */
+	*cur_size_p = 0UL;
+	for (i = 0; i < pavail_ents; i++) {
+		*end_of_phys_p = pavail[i].phys_addr +
+			pavail[i].reg_size;
+		*cur_size_p += pavail[i].reg_size;
+	}
+}
+
 static unsigned long __init bootmem_init(unsigned long *pages_avail,
 					 unsigned long phys_base)
 {
@@ -889,31 +998,13 @@ static unsigned long __init bootmem_init
 		end_of_phys_memory = pavail[i].phys_addr +
 			pavail[i].reg_size;
 		bytes_avail += pavail[i].reg_size;
-		if (cmdline_memory_size) {
-			if (bytes_avail > cmdline_memory_size) {
-				unsigned long slack = bytes_avail - cmdline_memory_size;
-
-				bytes_avail -= slack;
-				end_of_phys_memory -= slack;
-
-				pavail[i].reg_size -= slack;
-				if ((long)pavail[i].reg_size <= 0L) {
-					pavail[i].phys_addr = 0xdeadbeefUL;
-					pavail[i].reg_size = 0UL;
-					pavail_ents = i;
-				} else {
-					pavail[i+1].reg_size = 0Ul;
-					pavail[i+1].phys_addr = 0xdeadbeefUL;
-					pavail_ents = i + 1;
-				}
-				break;
-			}
-		}
 	}
 
-	*pages_avail = bytes_avail >> PAGE_SHIFT;
-
-	end_pfn = end_of_phys_memory >> PAGE_SHIFT;
+	/* Determine the location of the initial ramdisk before trying
+	 * to honor the "mem=xxx" command line argument.  We must know
+	 * where the kernel image and the ramdisk image are so that we
+	 * do not trim those two areas from the physical memory map.
+	 */
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* Now have to check initial ramdisk, so that bootmap does not overwrite it */
@@ -932,6 +1023,16 @@ static unsigned long __init bootmem_init
 		}
 	}
 #endif	
+
+	if (cmdline_memory_size &&
+	    bytes_avail > cmdline_memory_size)
+		trim_pavail(&bytes_avail,
+			    &end_of_phys_memory);
+
+	*pages_avail = bytes_avail >> PAGE_SHIFT;
+
+	end_pfn = end_of_phys_memory >> PAGE_SHIFT;
+
 	/* Initialize the boot-time allocator. */
 	max_pfn = max_low_pfn = end_pfn;
 	min_low_pfn = (phys_base >> PAGE_SHIFT);

--
