Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVCIXuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVCIXuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVCIXtL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:49:11 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:23566 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262189AbVCIXqU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:46:20 -0500
Message-Id: <200503100216.j2A2GrDN015259@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/9] UML - Fix rounding bug in tlb flushing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

fix_range_common and flush_tlb_kernel_range_common don't work correctly,
if a PGD (or PUD or PMD) is not present and start_addr (resp. start) is not
aligned to a PGD boundary (or PUD or PMD boundary).

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tlb.c	2005-03-08 23:46:28.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tlb.c	2005-03-09 00:03:30.000000000 -0500
@@ -15,6 +15,8 @@
 #include "mem_user.h"
 #include "os.h"
 
+#define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
+
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                       unsigned long end_addr, int force, int data,
                       void (*do_ops)(int, struct host_vm_op *, int))
@@ -33,46 +35,46 @@
         for(addr = start_addr; addr < end_addr;){
                 npgd = pgd_offset(mm, addr);
                 if(!pgd_present(*npgd)){
+                        end = ADD_ROUND(addr, PGDIR_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pgd_newpage(*npgd)){
-                                end = addr + PGDIR_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
-                        addr += PGDIR_SIZE;
+                        addr = end;
                         continue;
                 }
 
                 npud = pud_offset(npgd, addr);
                 if(!pud_present(*npud)){
+                        end = ADD_ROUND(addr, PUD_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pud_newpage(*npud)){
-                                end = addr + PUD_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pud_mkuptodate(*npud);
                         }
-                        addr += PUD_SIZE;
+                        addr = end;
                         continue;
                 }
 
                 npmd = pmd_offset(npud, addr);
                 if(!pmd_present(*npmd)){
+                        end = ADD_ROUND(addr, PMD_SIZE);
+                        if(end > end_addr)
+                                end = end_addr;
                         if(force || pmd_newpage(*npmd)){
-                                end = addr + PMD_SIZE;
-                                if(end > end_addr)
-                                        end = end_addr;
                                 op_index = add_munmap(addr, end - addr, ops, 
                                                       op_index, last_op, data,
                                                       do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
-                        addr += PMD_SIZE;
+                        addr = end;
                         continue;
                 }
 
@@ -122,52 +124,52 @@
         for(addr = start; addr < end;){
                 pgd = pgd_offset(mm, addr);
                 if(!pgd_present(*pgd)){
+                        last = ADD_ROUND(addr, PGDIR_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pgd_newpage(*pgd)){
                                 updated = 1;
-                                last = addr + PGDIR_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr, 
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PGDIR_SIZE;
+                        addr = last;
                         continue;
                 }
 
                 pud = pud_offset(pgd, addr);
                 if(!pud_present(*pud)){
+                        last = ADD_ROUND(addr, PUD_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pud_newpage(*pud)){
                                 updated = 1;
-                                last = addr + PUD_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr,
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PUD_SIZE;
+                        addr = last;
                         continue;
                 }
 
                 pmd = pmd_offset(pud, addr);
                 if(!pmd_present(*pmd)){
+                        last = ADD_ROUND(addr, PMD_SIZE);
+                        if(last > end)
+                                last = end;
                         if(pmd_newpage(*pmd)){
                                 updated = 1;
-                                last = addr + PMD_SIZE;
-                                if(last > end)
-                                        last = end;
                                 err = os_unmap_memory((void *) addr,
                                                       last - addr);
                                 if(err < 0)
                                         panic("munmap failed, errno = %d\n",
                                               -err);
                         }
-                        addr += PMD_SIZE;
+                        addr = last;
                         continue;
                 }
 

