Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265491AbTFMTKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 15:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265492AbTFMTKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 15:10:40 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:3826 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S265491AbTFMTKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 15:10:39 -0400
Message-ID: <3EEA24E0.7030801@google.com>
Date: Fri, 13 Jun 2003 12:24:16 -0700
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.21 released
References: <200306131453.h5DErX47015940@hera.kernel.org> <20030613211405.16faa9f6.us15@os.inf.tu-dresden.de>
In-Reply-To: <20030613211405.16faa9f6.us15@os.inf.tu-dresden.de>
Content-Type: multipart/mixed;
 boundary="------------070507070303000105080308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070507070303000105080308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Here's a minor patch against 2.4.21 that should help reduce out of 
memory problems on high ram systems with no swap space.  It's only been 
minimally tested in 2.4.21, but I've been running something similiar on 
2.4.18 for a bit now.

    Ross



--------------070507070303000105080308
Content-Type: text/plain;
 name="no-swap.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="no-swap.patch"

diff -urbBd linux-2.4.21/include/linux/swap.h linux-2.4.21-1/include/linux/swap.h
--- linux-2.4.21/include/linux/swap.h	Fri Jun 13 07:51:39 2003
+++ linux-2.4.21-1/include/linux/swap.h	Fri Jun 13 10:40:24 2003
@@ -82,6 +82,7 @@
 
 /* Swap 50% full? Release swapcache more aggressively.. */
 #define vm_swap_full() (nr_swap_pages*2 < total_swap_pages)
+#define swap_avail() (nr_swap_pages > 0)
 
 extern unsigned int nr_free_pages(void);
 extern unsigned int nr_free_buffer_pages(void);
diff -urbBd linux-2.4.21/mm/vmscan.c linux-2.4.21-1/mm/vmscan.c
--- linux-2.4.21/mm/vmscan.c	Thu Nov 28 15:53:15 2002
+++ linux-2.4.21-1/mm/vmscan.c	Fri Jun 13 11:26:26 2003
@@ -474,6 +474,18 @@
 			spin_unlock(&pagecache_lock);
 			UnlockPage(page);
 page_mapped:
+                        /* if we don't have swap, it doesn't
+                           do much good to swap things out. */
+			if (!page->mapping && !swap_avail()) {
+				/* Let's make the page active since we
+				   cannot swap it out.  It gets it off
+				   the inactive list. */
+				spin_unlock(&pagemap_lru_lock);
+				activate_page(page);
+				ClearPageReferenced(page);
+				spin_lock(&pagemap_lru_lock);
+				continue;
+			}
 			if (--max_mapped >= 0)
 				continue;
 

--------------070507070303000105080308--

