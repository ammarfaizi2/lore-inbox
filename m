Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287427AbRLaK2k>; Mon, 31 Dec 2001 05:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287483AbRLaK2a>; Mon, 31 Dec 2001 05:28:30 -0500
Received: from [202.54.26.202] ([202.54.26.202]:20715 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S287427AbRLaK2Q>;
	Mon, 31 Dec 2001 05:28:16 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: linux-kernel@vger.kernel.org
Message-ID: <65256B33.0039476C.00@sandesh.hss.hns.com>
Date: Mon, 31 Dec 2001 15:50:54 +0530
Subject: locked page handling
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In 2.4.16, vmscan.c::shrink_cache(), we have following piece of code -

          /*
           * The page is locked. IO in progress?
           * Move it to the back of the list.
           */
          if (unlikely(TryLockPage(page))) {
               if (PageLaunder(page) && (gfp_mask & __GFP_FS)) {
                    page_cache_get(page);
                    spin_unlock(&pagemap_lru_lock);
                    wait_on_page(page);
                    page_cache_release(page);
                    spin_lock(&pagemap_lru_lock);
               }
               continue;
          }

1) Who is moving the page the back of list ?
2) Is the locked page worth waiting for? I can understand that the page is being
 laundered so after wait we may get a clean page but from performance
     point of view this is involving unnecessary context switches. Also during
high memory pressure kswapd shall sleep here when it can get more
     clean pages on the inactive list ? What are we loosing if we don't wait on
the page and believe that in next pass we shall free this page

-- Amol





