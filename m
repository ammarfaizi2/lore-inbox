Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUFFBjg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUFFBjg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 21:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUFFBjg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 21:39:36 -0400
Received: from aun.it.uu.se ([130.238.12.36]:26097 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262744AbUFFBjf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 21:39:35 -0400
Date: Sun, 6 Jun 2004 03:39:23 +0200 (MEST)
Message-Id: <200406060139.i561dNDR018329@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: Re: [BUG] asm-ppc/pgtable.h breakage from 2.6.7-rc1-bk4
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jun 2004 17:29:23 -0500, Benjamin Herrenschmidt wrote:
>On Sat, 2004-06-05 at 14:56, Mikael Pettersson wrote:
>> The current 2.6.7-rc2 kernel hangs after starting INIT
>> on my PowerMac 4400. I traced the problem to the
>> ptep_set_access_flags() patch in 2.6.7-rc1-bk4, which
>> replaces ptep_establish()'s set_pte();flush_tlb_page()
>> sequence with a single pte_update() in two places in
>> mm/memory.c.
>> 
>> The patch below disables this change on ppc32, and
>> allows my 603ev-based PM4400 to finally boot 2.6.7-rc2.
>
>Can you try just adding the flush_tlb_page() to
>ptep_set_access_flags() and let me know if that helps ?

That (see below) also works and allows 2.6.7-rc2 to
boot on my PM4400.

/Mikael

--- linux-2.6.7-rc2/include/asm-ppc/pgtable.h.~1~	2004-06-06 03:17:36.000000000 +0200
+++ linux-2.6.7-rc2/include/asm-ppc/pgtable.h	2004-06-06 03:19:59.000000000 +0200
@@ -556,7 +556,10 @@
 	pte_update(ptep, 0, bits);
 }
 #define  ptep_set_access_flags(__vma, __address, __ptep, __entry, __dirty) \
-        __ptep_set_access_flags(__ptep, __entry, __dirty)
+do { \
+        __ptep_set_access_flags(__ptep, __entry, __dirty); \
+	flush_tlb_page(__vma, __address); \
+} while(0)
 
 /*
  * Macro to mark a page protection value as "uncacheable".
