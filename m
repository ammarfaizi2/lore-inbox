Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266142AbUFPEKd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266142AbUFPEKd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 00:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266145AbUFPEKd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 00:10:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:35761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266142AbUFPEKQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 00:10:16 -0400
Date: Tue, 15 Jun 2004 21:09:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390: lost dirty bits.
Message-Id: <20040615210919.1c82a5c8.akpm@osdl.org>
In-Reply-To: <20040615174436.GA10098@mschwid3.boeblingen.de.ibm.com>
References: <20040615174436.GA10098@mschwid3.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:
>
> The SetPageUptodate function is called for pages that are already
>  up to date. The arch_set_page_uptodate function of s390 may not
>  clear the dirty bit in that case otherwise a dirty bit which is set
>  between the start of an i/o for a writeback and a following call
>  to SetPageUptodate is lost.
> 
>  Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
>  diffstat:
> 
>  --- linux-2.5/include/asm-s390/pgtable.h	24 Mar 2004 18:18:22 -0000	1.23
>  +++ linux-2.5/include/asm-s390/pgtable.h	15 Jun 2004 16:43:35 -0000	1.23.2.1
>  @@ -652,7 +652,8 @@
>   
>   #define arch_set_page_uptodate(__page)					  \
>   	do {								  \
>  -		asm volatile ("sske %0,%1" : : "d" (0),			  \
>  +		if (!PageUptodate(__page))				  \
>  +			asm volatile ("sske %0,%1" : : "d" (0),		  \
>   			      "a" (__pa((__page-mem_map) << PAGE_SHIFT)));\
>   	} while (0)

Do you know what the call path for the redundant SetpageUptodate() is?

This patch still has a little race - it'd be better to override _all_ of
SetPageUptodate() in page-flags.h and do:

	if (!test_and_set_bit(PG_uptodate, &page->flags))
		...


--- 25/include/asm-s390/pgtable.h~s390-lost-dirty-bits	2004-06-15 21:02:00.621441504 -0700
+++ 25-akpm/include/asm-s390/pgtable.h	2004-06-15 21:06:43.391453928 -0700
@@ -656,7 +656,8 @@ static inline pte_t mk_pte_phys(unsigned
 
 #define arch_set_page_uptodate(__page)					  \
 	do {								  \
-		asm volatile ("sske %0,%1" : : "d" (0),			  \
+		if (!test_and_set_bit(PG_uptodate, __page))		  \
+			asm volatile ("sske %0,%1" : : "d" (0),		  \
 			      "a" (__pa((__page-mem_map) << PAGE_SHIFT)));\
 	} while (0)
 
diff -puN include/linux/page-flags.h~s390-lost-dirty-bits include/linux/page-flags.h
--- 25/include/linux/page-flags.h~s390-lost-dirty-bits	2004-06-15 21:04:58.982326528 -0700
+++ 25-akpm/include/linux/page-flags.h	2004-06-15 21:08:30.493171992 -0700
@@ -194,16 +194,12 @@ extern unsigned long __read_page_state(u
 #define ClearPageReferenced(page)	clear_bit(PG_referenced, &(page)->flags)
 #define TestClearPageReferenced(page) test_and_clear_bit(PG_referenced, &(page)->flags)
 
-#ifndef arch_set_page_uptodate
-#define arch_set_page_uptodate(page) do { } while (0)
+#ifdef arch_set_page_uptodate
+#define SetPageUptodate(page) arch_set_page_uptodate(page)
+#else
+#define SetPageUptodate(page) set_bit(PG_uptodate, &(page)->flags)
 #endif
-
 #define PageUptodate(page)	test_bit(PG_uptodate, &(page)->flags)
-#define SetPageUptodate(page) \
-	do {								\
-		arch_set_page_uptodate(page);				\
-		set_bit(PG_uptodate, &(page)->flags);			\
-	} while (0)
 #define ClearPageUptodate(page)	clear_bit(PG_uptodate, &(page)->flags)
 
 #define PageDirty(page)		test_bit(PG_dirty, &(page)->flags)
_

