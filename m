Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284619AbRLUPaR>; Fri, 21 Dec 2001 10:30:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284636AbRLUPaI>; Fri, 21 Dec 2001 10:30:08 -0500
Received: from mailbox.egenera.com ([208.51.147.22]:42251 "EHLO
	mailbox.egenera.com") by vger.kernel.org with ESMTP
	id <S284619AbRLUP3v>; Fri, 21 Dec 2001 10:29:51 -0500
Message-ID: <3C23551A.51D4BA90@egenera.com>
Date: Fri, 21 Dec 2001 10:28:26 -0500
From: "Philip R. Auld" <prauld@egenera.com>
Organization: Egenera Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: SMP race in munmap/ftruncate paths
In-Reply-To: <3C2233D2.853EC05C@egenera.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,


"Philip R. Auld" wrote:
> 
> Hi,
> 
>         It looks like there is an SMP locking problem and race
> the munmap and truncate paths.  I've hit this problem using a tree
> based on the redhat 2.4.7-10 kernel, which in turn is 2.4.7-ac3 plus
> some other patches. It looks like 2.4.16 still has these issues although
> this code has changed a bit.

[stuff snipped]

	As a follow-up to this I noticed that the lock hierarchy in this
area is broken as well. This problem _has_ been fixed in later kernels 
(at least as of 2.4.16). I'm just offering this up for completeness and in 
case someone else is not it a position to switch code bases at will.

truncate_list_pages is called with the mapping->page-lock held and 
since it violates the ordering it does a try_lock on the pagecache_lock.

mm/filemap.c
375                         pg_lock = PAGECACHE_LOCK(page);
376 
377                         if (!spin_trylock(pg_lock)) {
378                                 return 1;
379                         }
380 

But since the the caller (truncate_inode_pages) doesn't release the 
mapping->pagelock between calls the try_lock is useless. We can still
dead-lock. The patch I sent yesterday to bandaid (I won't say fix because
I don't think it solves the real problem...) the race I was seeing
exacerbates this. One solution is to move the mapping lock acquisition
into truncate_list_pages:

Index: mm/filemap.c
===================================================================
RCS file: /build/vault/linux2.4/mm/filemap.c,v
retrieving revision 1.5
diff -u -r1.5 filemap.c
--- mm/filemap.c	2001/10/19 03:48:00	1.5
+++ mm/filemap.c	2001/12/21 14:59:23
@@ -361,6 +366,7 @@
 	struct list_head *curr;
 	struct page * page;
 
+	spin_lock(&mapping->page_lock);
 	curr = head->next;
 	while (curr != head) {
 		unsigned long offset;
@@ -375,6 +381,7 @@
 			pg_lock = PAGECACHE_LOCK(page);
 
 			if (!spin_trylock(pg_lock)) {
+			        spin_unlock(&mapping->page_lock);
 				return 1;
 			}
 
@@ -402,10 +409,10 @@
 		}
 		curr = curr->next;
 	}
+	spin_unlock(&mapping->page_lock);
 	return 0;
 out_restart:
 	page_cache_release(page);
-	spin_lock(&mapping->page_lock);
 	return 1;
 }
 
@@ -425,7 +432,6 @@
 	unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
 	int complete;
 
-	spin_lock(&mapping->page_lock);
 	do {
 		complete = 1;
 		while (truncate_list_pages(mapping,&mapping->clean_pages, start, &partial))
@@ -436,7 +442,6 @@
 			complete = 0;
 	} while (!complete);
 	/* Traversed all three lists without dropping the lock */
-	spin_unlock(&mapping->page_lock);
 }
 
 /*



------------------------------------------------------
Philip R. Auld, Ph.D.                  Technical Staff 
Egenera Corp.                        pauld@egenera.com
165 Forest St, Marlboro, MA 01752        (508)786-9444
