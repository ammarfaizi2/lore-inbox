Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265268AbRFUWcH>; Thu, 21 Jun 2001 18:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265269AbRFUWb7>; Thu, 21 Jun 2001 18:31:59 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:37522 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S265268AbRFUWbr>; Thu, 21 Jun 2001 18:31:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Alan Cox <laughing@shared-source.org>
Subject: Re: Linux-2.4.5-ac17 --- Where is the  truncate_inode_pages speedup patch?
Date: Fri, 22 Jun 2001 00:52:10 +0200
X-Mailer: KMail [version 1.2.2]
Cc: Andrew Morton <andrewm@uow.edu.au>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010621223153Z265268-17720+6468@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alan,

I use it all the time and it is not pre6 stuff related...:-)

Thanks,
	Dieter

--- linux/mm/filemap.c    Mon May 28 13:31:49 2001
+++ linux/mm/filemap.c     Mon Jun 11 23:31:08 2001
@@ -230,17 +230,17 @@
                unsigned long offset;
 
                page = list_entry(curr, struct page, list);
-               curr = curr->next;
                offset = page->index;
 
                /* Is one of the pages to truncate? */
                if ((offset >= start) || (*partial && (offset + 1) == start)) 
{
+                       list_del(head);
+                       list_add(head, curr);
                        if (TryLockPage(page)) {
                                page_cache_get(page);
                                spin_unlock(&pagecache_lock);
                                wait_on_page(page);
-                               page_cache_release(page);
-                               return 1;
+                               goto out_restart;
                        }
                        page_cache_get(page);
                        spin_unlock(&pagecache_lock);
@@ -252,11 +252,15 @@
                                truncate_complete_page(page);
 
                        UnlockPage(page);
-                       page_cache_release(page);
-                       return 1;
+                       goto out_restart;
                }
+               curr = curr->next;
        }
        return 0;
+out_restart:
+       page_cache_release(page);
+       spin_lock(&pagecache_lock);
+       return 1;
 }
 
 
@@ -273,15 +277,19 @@
 {
        unsigned long start = (lstart + PAGE_CACHE_SIZE - 1) >> 
PAGE_CACHE_SHIFT;
        unsigned partial = lstart & (PAGE_CACHE_SIZE - 1);
+       int complete;
 
-repeat:
        spin_lock(&pagecache_lock);
-       if (truncate_list_pages(&mapping->clean_pages, start, &partial))
-               goto repeat;
-       if (truncate_list_pages(&mapping->dirty_pages, start, &partial))
-               goto repeat;
-       if (truncate_list_pages(&mapping->locked_pages, start, &partial))
-               goto repeat;
+       do {
+               complete = 1;
+               while (truncate_list_pages(&mapping->clean_pages, start, 
&partial))
+                       complete = 0;
+               while (truncate_list_pages(&mapping->dirty_pages, start, 
&partial))
+                       complete = 0;
+               while (truncate_list_pages(&mapping->locked_pages, start, 
&partial))
+                       complete = 0;
+       } while (!complete);
+       /* Traversed all three lists without dropping the lock */
        spin_unlock(&pagecache_lock);
 }
