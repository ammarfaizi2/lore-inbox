Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSEDNsv>; Sat, 4 May 2002 09:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312983AbSEDNsu>; Sat, 4 May 2002 09:48:50 -0400
Received: from [195.223.140.120] ([195.223.140.120]:19212 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312973AbSEDNsu>; Sat, 4 May 2002 09:48:50 -0400
Date: Sat, 4 May 2002 15:49:43 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa1 & vm-34: unresolved kmap_pagetable
Message-ID: <20020504154943.W1396@dualathlon.random>
In-Reply-To: <20020503203738.E1396@dualathlon.random> <3CD339B7.5BEB2DB4@eyal.emu.id.au> <20020504092531.L1396@dualathlon.random> <3CD3E505.A688C20A@eyal.emu.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 04, 2002 at 11:41:25PM +1000, Eyal Lebedinsky wrote:
> Well, this may be a problem for NVdriver (a mostly binary only driver)
> which I use.

This should fix it:

diff -urN NVIDIA_kernel-1.0-2313/nv.c NVIDIA_kernel-1.0-2313.pte-highmem/nv.c
--- NVIDIA_kernel-1.0-2313/nv.c	Tue Nov 27 21:39:17 2001
+++ NVIDIA_kernel-1.0-2313.pte-highmem/nv.c	Sun Feb  3 16:35:18 2002
@@ -42,6 +42,7 @@
 #include <linux/interrupt.h>           
 #include <linux/tqueue.h>               // struct tq_struct 
 #include <linux/poll.h>
+#include <linux/highmem.h>
 #ifdef CONFIG_PM
 #include <linux/pm.h>                   // power management
 #endif
@@ -2267,7 +2268,7 @@
 {
     pgd_t *pg_dir;
     pmd_t *pg_mid_dir;
-    pte_t *pg_table;
+    pte_t *pg_table, pte;
 
     /* XXX do we really need this? */
     if (address > VMALLOC_START)
@@ -2297,11 +2298,13 @@
     if (pmd_none(*pg_mid_dir))
         goto failed;
 
-    pg_table = pte_offset(pg_mid_dir, address);
-    if (!pte_present(*pg_table))
+    pg_table = pte_offset_atomic(pg_mid_dir, address);
+    pte = *pg_table;
+    pte_kunmap(pg_table);
+    if (!pte_present(pte))
         goto failed;
 
-    return ((pte_val(*pg_table) & KERN_PAGE_MASK) | NV_MASK_OFFSET(address));
+    return ((pte_val(pte) & KERN_PAGE_MASK) | NV_MASK_OFFSET(address));
 
   failed:
     return (unsigned long) NULL;

Andrea
