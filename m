Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267808AbTAMENr>; Sun, 12 Jan 2003 23:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267811AbTAMENr>; Sun, 12 Jan 2003 23:13:47 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:27407 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267808AbTAMENq>; Sun, 12 Jan 2003 23:13:46 -0500
Date: Sun, 12 Jan 2003 23:20:04 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Brian Gerst <bgerst@didntduck.org>
cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: 2.5.55/.56 instant reboot problem on 486
In-Reply-To: <3E21157D.30607@didntduck.org>
Message-ID: <Pine.LNX.3.96.1030112231930.18057A-200000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY=------------000509000002030104030808
Content-ID: <Pine.LNX.3.96.1030112231930.18057B@gatekeeper.tmr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--------------000509000002030104030808
Content-Type: TEXT/PLAIN; CHARSET=us-ascii; FORMAT=flowed
Content-ID: <Pine.LNX.3.96.1030112231930.18057C@gatekeeper.tmr.com>

On Sun, 12 Jan 2003, Brian Gerst wrote:

> The problem is that one_page_table_init() pulls the rug out from under 
> the kernel by installing a new page table before setting it up.  A 486 
> has a small TLB so any miss will cause a triple fault and reset.  Try 
> this patch and see if it fixes it.

As someone who uses 486's for routers on occasion, thank you!

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

--------------000509000002030104030808
Content-Type: TEXT/PLAIN; NAME=ptefix-1
Content-ID: <Pine.LNX.3.96.1030112231930.18057D@gatekeeper.tmr.com>
Content-Description: 

diff -urN linux-2.5.56/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.5.56/arch/i386/mm/init.c	Sun Jan 12 00:16:22 2003
+++ linux/arch/i386/mm/init.c	Sun Jan 12 01:48:28 2003
@@ -71,12 +71,16 @@
  */
 static pte_t * __init one_page_table_init(pmd_t *pmd)
 {
-	pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-	set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
-	if (page_table != pte_offset_kernel(pmd, 0))
-		BUG();	
+	if (pmd_none(*pmd)) {
+		pte_t *page_table = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		set_pmd(pmd, __pmd(__pa(page_table) | _PAGE_TABLE));
+		if (page_table != pte_offset_kernel(pmd, 0))
+			BUG();	
 
-	return page_table;
+		return page_table;
+	}
+	
+	return pte_offset_kernel(pmd, 0);
 }
 
 /*

--------------000509000002030104030808--
