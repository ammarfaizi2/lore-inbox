Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTJXU4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 16:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbTJXU4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 16:56:51 -0400
Received: from fmr05.intel.com ([134.134.136.6]:34201 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S262609AbTJXU4s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 16:56:48 -0400
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH 2.4.23-pre8]  Remove broken prefetching in free_one_pgd()
Date: Fri, 24 Oct 2003 13:56:31 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F36E6@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH 2.4.23-pre6 add kmap_types.h for CONFIG_CRYPTO
Thread-Index: AcOaXCWxutBo7GOaSjO/oCTozTGzbAAE34aA
From: "Luck, Tony" <tony.luck@intel.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Cc: <marcelo@conectiva.com.br>
X-OriginalArrivalTime: 24 Oct 2003 20:56:32.0279 (UTC) FILETIME=[4DBE1270:01C39A71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch was accepted into 2.5.55, attributed to "davej@uk".

This code will prefetch from beyond the end of the page table
being cleared ... which is clearly a bad thing if the page table
in question is allocated from the last page of memory (or precedes
a hole on a discontig mem system).

-Tony Luck

diff -ru linux-2.4.23-pre8/mm/memory.c fix/mm/memory.c
--- linux-2.4.23-pre8/mm/memory.c	Fri Oct 24 13:37:23 2003
+++ fix/mm/memory.c	Fri Oct 24 13:40:47 2003
@@ -120,10 +120,8 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
+	for (j = 0; j < PTRS_PER_PMD ; j++)
 		free_one_pmd(pmd+j);
-	}
 	pmd_free(pmd);
 }
 
