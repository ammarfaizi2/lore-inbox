Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288112AbSAQCfC>; Wed, 16 Jan 2002 21:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288117AbSAQCex>; Wed, 16 Jan 2002 21:34:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:60612 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S288112AbSAQCee>; Wed, 16 Jan 2002 21:34:34 -0500
Message-Id: <200201170234.g0H2YNq22752@butler1.beaverton.ibm.com>
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux (NUMA)
To: linux-kernel@vger.kernel.org
Subject: [PATCH] i386/kernel/acpitable.c mapping problems
Date: Wed, 16 Jan 2002 18:34:20 -0800
X-Mailer: KMail [version 1.3.1]
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes two bugs in the 2.4.17 acpitable.c.  Marcello and Linus please 
apply:

1) It didn't map in the entire table before doing a checksum on it, just the 
header.  With only one page mapped in, only the luck of BIOS table placement 
avoided a MMU fault before the fault handlers were installed.
2) The authors didn't realize that fixmap pages count down from the fixed 
base, so they ran off the end of virtual memory for any table over 2 pages 
long.

Tested on a variety of different types of Netfinity servers, from one CPU to 
eight, including a forthcoming one that has unusually large SSRT tables (the 
one that found the bug).

--- 2.4.17/arch/i386/kernel/acpitable.c.df	Sun Nov 11 22:15:06 2001
+++ 2.4.17/arch/i386/kernel/acpitable.c	Fri Jan 11 19:36:06 2002
@@ -172,40 +172,41 @@
 
 
 /*
- * Temporarily use the virtual area starting from FIX_IO_APIC_BASE_0,
+ * Temporarily use the virtual area starting from FIX_IO_APIC_BASE_END,
  * to map the target physical address. The problem is that set_fixmap()
  * provides a single page, and it is possible that the page is not
  * sufficient.
  * By using this area, we can map up to MAX_IO_APICS pages temporarily,
  * i.e. until the next __va_range() call.
+ *
+ * Important Safety Note:  The fixed I/O APIC page numbers are *subtracted*
+ * from the fixed base.  That's why we start at FIX_IO_APIC_BASE_END and
+ * count idx down while incrementing the phys address.
  */
-static __inline__ char *
+static __init char *
 __va_range(unsigned long phys, unsigned long size)
 {
-	unsigned long base, offset, mapped_size, mapped_phys = phys;
-	int idx = FIX_IO_APIC_BASE_0;
+	unsigned long base, offset, mapped_size;
+	int idx;
 
 	offset = phys & (PAGE_SIZE - 1);
 	mapped_size = PAGE_SIZE - offset;
-	set_fixmap(idx, mapped_phys);
-	base = fix_to_virt(FIX_IO_APIC_BASE_0);
+	set_fixmap(FIX_IO_APIC_BASE_END, phys);
+	base = fix_to_virt(FIX_IO_APIC_BASE_END);
+	dprintk("__va_range(0x%lx, 0x%lx): idx=%d mapped at %lx\n", phys, size,
+		FIX_IO_APIC_BASE_END, base);
 
 	/*
 	 * Most cases can be covered by the below.
 	 */
-	if (mapped_size >= size)
-		return ((unsigned char *) base + offset);
-
-	dprintk("__va_range: mapping more than a single page, size = 0x%lx\n",
-		size);
-
-	do {
-		if (idx++ == FIX_IO_APIC_BASE_END)
+	idx = FIX_IO_APIC_BASE_END;
+	while (mapped_size < size) {
+		if (--idx < FIX_IO_APIC_BASE_0)
 			return 0;	/* cannot handle this */
-		mapped_phys = mapped_phys + PAGE_SIZE;
-		set_fixmap(idx, mapped_phys);
-		mapped_size = mapped_size + PAGE_SIZE;
-	} while (mapped_size < size);
+		phys += PAGE_SIZE;
+		set_fixmap(idx, phys);
+		mapped_size += PAGE_SIZE;
+	}
 
 	return ((unsigned char *) base + offset);
 }
@@ -267,11 +268,14 @@
 	}
 
 	for (i = 0; i < tables; i++) {
-
+		/* Map in header, then map in full table length. */
 		header = (acpi_table_header *)
 			    __va_range(saved_rsdt.entry[i],
 				       sizeof(acpi_table_header));
-
+		if (!header)
+			break;
+		header = (acpi_table_header *)
+			    __va_range(saved_rsdt.entry[i], header->length);
 		if (!header)
 			break;
 


-- 
James Cleverdon, IBM xSeries Platform (NUMA), Beaverton
jamesclv@us.ibm.com   |   cleverdj@us.ibm.com

