Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbTCKUcg>; Tue, 11 Mar 2003 15:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261616AbTCKUcg>; Tue, 11 Mar 2003 15:32:36 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:16300 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S261613AbTCKUce>; Tue, 11 Mar 2003 15:32:34 -0500
Message-ID: <3E6E4A60.90001@google.com>
Date: Tue, 11 Mar 2003 12:43:12 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jason Li <zhjl000@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: out_of_memory called to often
References: <20030311191342.18575.qmail@web41003.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jason Li wrote:

>Hi,
>
>We are running an embedded linux (2.4.19) with no swap
>sapce. And we haven't applied any rmap yet.
>
I believe you may be seeing the same issue I brought up in a previous 
email.  Have you tried what I suggested? I've appended the email to this 
message with out the test code.

    Ross


I've verified this in 2.4.21-pre5 by code inspection and can trigger the 
problem on 2.4.18.  It appears to have been fixed in 2.5.

The folowing code vmscan.c assumes that there is available swap space.

       /*
        * this is the non-racy check for busy page.
        */
       if (!page->mapping || !is_page_cache_freeable(page)) {
           spin_unlock(&pagecache_lock);
           UnlockPage(page);
page_mapped:
           if (--max_mapped >= 0)
               continue;

           /*
            * Alert! We've found too many mapped pages on the
            * inactive list, so we start swapping out now!
            */
           spin_unlock(&pagemap_lru_lock);
           swap_out(priority, gfp_mask, classzone);
           return nr_pages;
       }


If there is no swap space, then unfreeable pages are left on the 
inactive queue and the vmtree is walked rather than going through the 
rest of the inactive queue.  I believe something like
       /*
        * this is the non-racy check for busy page.
        */
       if (!page->mapping || !is_page_cache_freeable(page)) {
           spin_unlock(&pagecache_lock);
           UnlockPage(page);
page_mapped:
                       /* If we don't have any swap space left, there
                          is no reason to worry about pages that do
                          not have swap associated with them, there
                          is nothing we can do about it. */
                       if (!page->mapping && !swap_avail()) {
                               /* Let's make the page active since we
                                  cannot swap it out.  It get's it off
                                  the inactive list. */
                               spin_unlock(&pagemap_lru_lock);
                               activate_page(page);
                               ClearPageReferenced(page);
                               spin_lock(&pagemap_lru_lock);
                               continue;
                       }
           if (--max_mapped >= 0)
               continue;

           /*
            * Alert! We've found too many mapped pages on the
            * inactive list, so we start swapping out now!
            */
           spin_unlock(&pagemap_lru_lock);
           swap_out(priority, gfp_mask, classzone);
           return nr_pages;
       }

will work better when there is no swap space available.  If this change 
is made, it may also be necessary to limit refill_inactive to prevent it 
from using too much cpu.  This bug can be triggered with the attached 
code and the correct parameters.  In particular on a 3 gigabyte machine 
with no swap,

for i in $(seq 0 9); do dd if=/dev/zero of=file$i bs=1024k count=512; done
killmm 1032735283 2 9

Usually causes an out of memory error when there is hundreds of 
megabytes of cache.


   Ross

