Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVD2HIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVD2HIA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 03:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbVD2HH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 03:07:59 -0400
Received: from lixom.net ([66.141.50.11]:41108 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S262447AbVD2HHk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 03:07:40 -0400
Date: Fri, 29 Apr 2005 02:07:52 -0500
To: akpm@osdl.org
Cc: linuxppc64-dev@ozlabs.org, anton@samba.org, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64: Remove hot busy-wait loop in __hash_page
Message-ID: <20050429070752.GA30785@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
From: Olof Johansson <olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It turns out that our current __hash_page code will do a very hot
busy-wait loop waiting on _PAGE_BUSY to be cleared. It even does
ldarx/stdcx in the loop, which will bounce reservations around like crazy
if there's more than one CPU spinning on the same PTE (or even another
PTE in the same reservation granule). The end result is that each fault
takes longer when there's contention, which in turn increases the chance
of another thread hitting the same fault and also piling up. Not pretty.

There's two options here:
1. Do an out-of-line busy loop a'la spinlocks with just loads (no
   reserves)
2. Just bail and refault if needed.

(2) makes sense here: If the PTE is busy, chances are it's in flux anyway
and the other code path making a change might just be ready to hash it.

This fixes a stampede seen on a large-ish system where a multithreaded
HPC app faults in the same text pages on several cpus at the same time.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6/arch/ppc64/mm/hash_low.S
===================================================================
--- 2.6.orig/arch/ppc64/mm/hash_low.S	2005-04-24 17:49:43.000000000 -0500
+++ 2.6/arch/ppc64/mm/hash_low.S	2005-04-28 17:19:04.000000000 -0500
@@ -85,7 +85,10 @@ _GLOBAL(__hash_page)
 	bne-	htab_wrong_access
 	/* Check if PTE is busy */
 	andi.	r0,r31,_PAGE_BUSY
-	bne-	1b
+	/* If so, just bail out and refault if needed. Someone else
+	 * is changing this PTE anyway and might hash it.
+	 */
+	bne-	bail_ok
 	/* Prepare new PTE value (turn access RW into DIRTY, then
 	 * add BUSY,HASHPTE and ACCESSED)
 	 */
@@ -215,6 +218,10 @@ _GLOBAL(htab_call_hpte_remove)
 	/* Try all again */
 	b	htab_insert_pte	
 
+bail_ok:
+	li	r3,0
+	b	bail
+
 htab_pte_insert_ok:
 	/* Insert slot number & secondary bit in PTE */
 	rldimi	r30,r3,12,63-15
