Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265798AbUFORpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265798AbUFORpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 13:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUFORpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 13:45:22 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:36061 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S265798AbUFORoe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 13:44:34 -0400
Date: Tue, 15 Jun 2004 19:44:36 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: lost dirty bits.
Message-ID: <20040615174436.GA10098@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
we just tracked down a severe bug in the memory management
code of s390. There is a race window where s390 can loose
a dirty bit. I never expected that SetPageUptodate is called
on an already up to date page...

blue skies,
  Martin.

---

[PATCH] s390: lost dirty bits.

The SetPageUptodate function is called for pages that are already
up to date. The arch_set_page_uptodate function of s390 may not
clear the dirty bit in that case otherwise a dirty bit which is set
between the start of an i/o for a writeback and a following call
to SetPageUptodate is lost.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:

--- linux-2.5/include/asm-s390/pgtable.h	24 Mar 2004 18:18:22 -0000	1.23
+++ linux-2.5/include/asm-s390/pgtable.h	15 Jun 2004 16:43:35 -0000	1.23.2.1
@@ -652,7 +652,8 @@
 
 #define arch_set_page_uptodate(__page)					  \
 	do {								  \
-		asm volatile ("sske %0,%1" : : "d" (0),			  \
+		if (!PageUptodate(__page))				  \
+			asm volatile ("sske %0,%1" : : "d" (0),		  \
 			      "a" (__pa((__page-mem_map) << PAGE_SHIFT)));\
 	} while (0)
 

