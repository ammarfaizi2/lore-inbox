Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUIOMxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUIOMxn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263818AbUIOMxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 08:53:43 -0400
Received: from mx2.elte.hu ([157.181.151.9]:11977 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264085AbUIOMwy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 08:52:54 -0400
Date: Wed, 15 Sep 2004 14:53:56 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: [patch] tune vmalloc size
Message-ID: <20040915125356.GA11250@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


there are a few devices that use lots of ioremap space. vmalloc space is
a showstopper problem for them.

this patch adds the vmalloc=<size> boot parameter to override
__VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
doubles the size.

	Ingo

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="tune-vmalloc.patch"


there are a few devices that use lots of ioremap space. vmalloc space
is a showstopper problem for them.

this patch adds the vmalloc=<size> boot parameter to override
__VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
doubles the size.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Arjan van de Ven <arjanv@redhat.com>

--- linux/arch/i386/kernel/setup.c.orig	
+++ linux/arch/i386/kernel/setup.c	
@@ -814,7 +814,15 @@ static void __init parse_cmdline_early (
 		 */
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
-	
+
+		/*
+		 * vmalloc=size forces the vmalloc area to be exactly 'size'
+		 * bytes. This can be used to increase (or decrease) the
+		 * vmalloc area - the default is 128m.
+		 */
+		if (c == ' ' && !memcmp(from, "vmalloc=", 8))
+			__VMALLOC_RESERVE = memparse(from+8, &from);
+		
 		c = *(from++);
 		if (!c)
 			break;
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -40,6 +40,8 @@
 #include <asm/tlbflush.h>
 #include <asm/sections.h>
 
+unsigned int __VMALLOC_RESERVE = 128 << 20;
+
 DEFINE_PER_CPU(struct mmu_gather, mmu_gathers);
 unsigned long highstart_pfn, highend_pfn;
 
--- linux/arch/i386/boot/setup.S.orig	
+++ linux/arch/i386/boot/setup.S	
@@ -156,7 +156,7 @@ cmd_line_ptr:	.long 0			# (Header versio
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long (MAXMEM-1) & 0x7fffffff
+ramdisk_max:	.long (-__PAGE_OFFSET-(512 << 20)-1) & 0x7fffffff
 					# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -94,13 +94,13 @@ typedef struct { unsigned long pgprot; }
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
+#ifndef __ASSEMBLY__
+
 /*
  * This much address space is reserved for vmalloc() and iomap()
  * as well as fixmap mappings.
  */
-#define __VMALLOC_RESERVE	(128 << 20)
-
-#ifndef __ASSEMBLY__
+extern unsigned int __VMALLOC_RESERVE;
 
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
--- linux/mm/vmalloc.c.orig	
+++ linux/mm/vmalloc.c	
@@ -247,6 +247,8 @@ found:
 out:
 	write_unlock(&vmlist_lock);
 	kfree(area);
+	if (printk_ratelimit())
+		printk(KERN_WARNING "allocation failed: out of vmalloc space - use vmalloc=<size> to increase size.\n");
 	return NULL;
 }
 

--RnlQjJ0d97Da+TV1--
