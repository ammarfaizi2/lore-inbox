Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSEUNJz>; Tue, 21 May 2002 09:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314499AbSEUNJy>; Tue, 21 May 2002 09:09:54 -0400
Received: from imladris.infradead.org ([194.205.184.45]:22797 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S313505AbSEUNJw>; Tue, 21 May 2002 09:09:52 -0400
Date: Tue, 21 May 2002 14:09:45 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] buffermem_pages removal (1/5)
Message-ID: <20020521140945.A15796@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With all work done by akpm in 2.5 Linus no more has a buffer cache
in the traditional sense.  Still we try to keep estimates about
what would be the buffer cache size by keeping the number of pages
indexed by block device inodes.  This is broken not only because the
old buffercache was also used for file data which is nowdays not
hashed to block device inodes and thus makes every user of this data
assume wrong numbers.  Second is is possible to use block device
pages not through the buffer_head interface (i.e. userspace
block device nodes, possibly JFS also soon).  In addition the atomic_t
used for this bookkepping (buffermem_pages) causes cacheline bouncing
on larger machines.

This is the first patch of a series to get rid of it.  It removes the
useless output of supposedly buffer pages in show_mem(), which is used
by the magic sysrq key code.


--- 1.11/arch/alpha/mm/init.c	Sun May  5 18:56:26 2002
+++ edited/arch/alpha/mm/init.c	Tue May 21 14:26:44 2002
@@ -137,7 +137,6 @@
 	printk("%ld reserved pages\n",reserved);
 	printk("%ld pages shared\n",shared);
 	printk("%ld pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 #endif
 
--- 1.4/arch/alpha/mm/numa.c	Sun May  5 18:58:06 2002
+++ edited/arch/alpha/mm/numa.c	Tue May 21 14:26:53 2002
@@ -425,5 +425,4 @@
 	printk("%ld pages shared\n",shared);
 	printk("%ld pages swap cached\n",cached);
 	printk("%ld pages in page table cache\n",pgtable_cache_size);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
--- 1.11/arch/arm/mm/init.c	Sun May  5 18:56:29 2002
+++ edited/arch/arm/mm/init.c	Tue May 21 14:25:57 2002
@@ -100,7 +100,6 @@
 	printk("%d slab pages\n", slab);
 	printk("%d pages shared\n", shared);
 	printk("%d pages swap cached\n", cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 struct node_info {
--- 1.8/arch/cris/mm/init.c	Sun May  5 18:57:40 2002
+++ edited/arch/cris/mm/init.c	Tue May 21 14:25:59 2002
@@ -181,7 +181,6 @@
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
 	printk("%ld pages in page table cache\n",pgtable_cache_size);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /*
--- 1.16/arch/i386/mm/init.c	Tue May 21 04:57:06 2002
+++ edited/arch/i386/mm/init.c	Tue May 21 14:26:01 2002
@@ -93,7 +93,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
--- 1.14/arch/ia64/mm/init.c	Sun May  5 18:56:48 2002
+++ edited/arch/ia64/mm/init.c	Tue May 21 14:26:04 2002
@@ -187,7 +187,6 @@
 			pgdat = pgdat->node_next;
 		} while (pgdat);
 		printk("Total of %ld pages in page table cache\n", pgtable_cache_size);
-		printk("%ld buffermem pages\n", nr_buffermem_pages());
 		printk("%d free buffer pages\n", nr_free_buffer_pages());
 	}
 #else /* !CONFIG_DISCONTIGMEM */
--- 1.5/arch/m68k/mm/init.c	Sun May  5 18:56:52 2002
+++ edited/arch/m68k/mm/init.c	Tue May 21 14:26:08 2002
@@ -107,7 +107,6 @@
     printk("%d pages shared\n",shared);
     printk("%d pages swap cached\n",cached);
     printk("%ld pages in page table cache\n",pgtable_cache_size);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 extern void init_pointer_table(unsigned long ptable);
--- 1.4/arch/mips/mm/init.c	Sun May  5 18:57:00 2002
+++ edited/arch/mips/mm/init.c	Tue May 21 14:26:12 2002
@@ -135,7 +135,6 @@
 	printk("%d pages swap cached\n",cached);
 	printk("%ld pages in page table cache\n",pgtable_cache_size);
 	printk("%d free pages\n", free);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
--- 1.4/arch/mips64/mm/init.c	Sun May  5 18:56:54 2002
+++ edited/arch/mips64/mm/init.c	Tue May 21 14:26:10 2002
@@ -339,7 +339,6 @@
 	printk("%d pages swap cached\n",cached);
 	printk("%ld pages in page table cache\n", pgtable_cache_size);
 	printk("%d free pages\n", free);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 #ifndef CONFIG_DISCONTIGMEM
--- 1.3/arch/parisc/mm/init.c	Sun May  5 18:57:02 2002
+++ edited/arch/parisc/mm/init.c	Tue May 21 14:26:14 2002
@@ -154,7 +154,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 void set_pte_phys (unsigned long vaddr, unsigned long phys)
--- 1.17/arch/ppc/mm/init.c	Thu May  9 09:19:25 2002
+++ edited/arch/ppc/mm/init.c	Tue May 21 14:26:22 2002
@@ -140,7 +140,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* Free up now-unused memory */
--- 1.13/arch/ppc64/mm/init.c	Sun May  5 18:57:05 2002
+++ edited/arch/ppc64/mm/init.c	Tue May 21 14:26:16 2002
@@ -134,7 +134,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 void *
--- 1.9/arch/s390/mm/init.c	Sun May  5 18:57:11 2002
+++ edited/arch/s390/mm/init.c	Tue May 21 14:26:24 2002
@@ -87,7 +87,6 @@
         printk("%d pages shared\n",shared);
         printk("%d pages swap cached\n",cached);
         printk("%ld pages in page table cache\n",pgtable_cache_size);
-        printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
--- 1.9/arch/s390x/mm/init.c	Sun May  5 18:57:16 2002
+++ edited/arch/s390x/mm/init.c	Tue May 21 14:26:26 2002
@@ -87,7 +87,6 @@
         printk("%d pages shared\n",shared);
         printk("%d pages swap cached\n",cached);
         printk("%ld pages in page table cache\n",pgtable_cache_size);
-        printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
--- 1.8/arch/sh/mm/init.c	Sun May  5 18:57:20 2002
+++ edited/arch/sh/mm/init.c	Tue May 21 14:26:28 2002
@@ -70,7 +70,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
--- 1.11/arch/sparc/mm/init.c	Sun May  5 18:57:30 2002
+++ edited/arch/sparc/mm/init.c	Tue May 21 14:26:36 2002
@@ -82,7 +82,6 @@
 	if (sparc_cpu_model == sun4m || sparc_cpu_model == sun4d)
 		printk("%ld entries in page dir cache\n",pgd_cache_size);
 #endif	
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 extern pgprot_t protection_map[16];
--- 1.28/arch/sparc64/mm/init.c	Thu May  9 11:30:48 2002
+++ edited/arch/sparc64/mm/init.c	Tue May 21 14:26:32 2002
@@ -341,7 +341,6 @@
 #ifndef CONFIG_SMP
 	printk("%d entries in page dir cache\n",pgd_cache_size);
 #endif	
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 void mmu_info(struct seq_file *m)
--- 1.6/arch/x86_64/mm/init.c	Sun May  5 18:57:33 2002
+++ edited/arch/x86_64/mm/init.c	Tue May 21 14:26:41 2002
@@ -67,7 +67,6 @@
 	printk("%d reserved pages\n",reserved);
 	printk("%d pages shared\n",shared);
 	printk("%d pages swap cached\n",cached);
-	printk("%ld buffermem pages\n", nr_buffermem_pages());
 }
 
 /* References to section boundaries */
