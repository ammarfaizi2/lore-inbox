Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271974AbRIESsH>; Wed, 5 Sep 2001 14:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272103AbRIESrs>; Wed, 5 Sep 2001 14:47:48 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:7086 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271974AbRIESrn>;
	Wed, 5 Sep 2001 14:47:43 -0400
Date: Wed, 05 Sep 2001 19:48:00 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Buddy allocator - help! I thought I understood this
Message-ID: <525190103.999719280@[10.132.112.53]>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I could swear I understood this bit of __free_pages_ok()
Monday night, but my mind appears to have gone blank.

As I recall, the memory bitmaps indicate by the
status a bit op returns whether or not a page
is on the free list for that particular order
area.

So how does this work (lines from vanilla 2.4.9
attached). I'm interested particularly in line
114:

  if (!__test_and_change_bit(index, area->map))

This examines the bitmap entry, in the
current order being examined bitmap.

As the page is being free'd, on the first pass,
won't the page ALWAYS register as unallocated?
This claims to test whether the buddy page
is still allocated. Wouldn't this test be:

  if (!__test_and_change_bit(index^1, area->map))

The annoying thing is I'm SURE I read through
this and understood it fully Monday night.

Or is the bitmap trying to tell us whether the
BUDDY is used? This doesn't seem to be what
expand et al are doing.

Please help - my head hurts.

(NB, if this is a code bug rather than local brain
 bug, this explains a lot)
--
Alex Bligh



    99          if (page_idx & ~mask)
   100                  BUG();
   101          index = page_idx >> (1 + order);
   102
   103          area = zone->free_area + order;
   104
   105          spin_lock_irqsave(&zone->lock, flags);
   106
   107          zone->free_pages -= mask;
   108
   109          while (mask + (1 << (MAX_ORDER-1))) {
   110                  struct page *buddy1, *buddy2;
   111
   112                  if (area >= zone->free_area + MAX_ORDER)
   113                          BUG();
   114                  if (!__test_and_change_bit(index, area->map))
   115                          /*
   116                           * the buddy page is still allocated.
   117                           */
   118                          break;
   119                  /*
   120                   * Move the buddy up one level.
   121                   */


