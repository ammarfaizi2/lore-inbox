Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316673AbSFFB7L>; Wed, 5 Jun 2002 21:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFFB7K>; Wed, 5 Jun 2002 21:59:10 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:55052 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S316673AbSFFB7J>; Wed, 5 Jun 2002 21:59:09 -0400
Message-ID: <3CFEC2E6.F1AF17B5@zip.com.au>
Date: Wed, 05 Jun 2002 19:03:18 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: glynis@butterfly.hjsoft.com
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.20: smbfs oops in smb_readpage
In-Reply-To: <20020606013654.GA32609@butterfly.hjsoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

glynis@butterfly.hjsoft.com wrote:
> 
> reading a file from an smbfs causes this oops, then the smbfs won't
> unmount.
> ...
> >>EIP; ccae8013 <[smbfs]smb_readpage+13/40>   <=====
> 
> >>ebx; c11a2850 <_end+ea2c6c/c5e241c>
> >>ecx; c11a2850 <_end+ea2c6c/c5e241c>
> >>edx; c1049b8c <_end+d49fa8/c5e241c>
> >>edi; c66f3138 <_end+63f3554/c5e241c>
> >>esp; c78a5e44 <_end+75a6260/c5e241c>
> 
> Trace; c013bed4 <read_pages+84/a0>
> Trace; c013bfb0 <do_page_cache_readahead+c0/140>

You can blame me for that.

Does this work OK?

--- 2.5.20/mm/readahead.c~readpages	Wed Jun  5 18:59:49 2002
+++ 2.5.20-akpm/mm/readahead.c	Wed Jun  5 19:00:14 2002
@@ -32,7 +32,7 @@ static inline unsigned long get_min_read
 }
 
 static int
-read_pages(struct address_space *mapping,
+read_pages(struct file *file, struct address_space *mapping,
 		struct list_head *pages, unsigned nr_pages)
 {
 	unsigned page_idx;
@@ -44,7 +44,7 @@ read_pages(struct address_space *mapping
 		struct page *page = list_entry(pages->prev, struct page, list);
 		list_del(&page->list);
 		if (!add_to_page_cache_unique(page, mapping, page->index))
-			mapping->a_ops->readpage(NULL, page);
+			mapping->a_ops->readpage(file, page);
 		page_cache_release(page);
 	}
 	return 0;
@@ -167,7 +167,7 @@ void do_page_cache_readahead(struct file
 	 * uptodate then the caller will launch readpage again, and
 	 * will then handle the error.
 	 */
-	read_pages(mapping, &page_pool, nr_to_really_read);
+	read_pages(file, mapping, &page_pool, nr_to_really_read);
 	blk_run_queues();
 	BUG_ON(!list_empty(&page_pool));
 	return;

-
