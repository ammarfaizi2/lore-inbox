Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135323AbRDZQu0>; Thu, 26 Apr 2001 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135341AbRDZQuQ>; Thu, 26 Apr 2001 12:50:16 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:20243 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S135323AbRDZQuA>; Thu, 26 Apr 2001 12:50:00 -0400
Date: Thu, 26 Apr 2001 20:00:12 +0200 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: Feng Xian <fxian@fxian.jukie.net>, <linux-kernel@vger.kernel.org>,
        Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
In-Reply-To: <20010426001539.A14115@vger.timpanogas.org>
Message-ID: <Pine.LNX.4.30.0104261942160.16238-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Apr 2001, Jeff V. Merkey wrote:

> I am seeing this as well on 2.4.3 with both _get_free_pages() and
> kmalloc().  In the kmalloc case, the modules hang waiting
> for memory.

One possible source of this hang is due to the change below in
2.4.3, non GPF_ATOMIC and non-recursive allocations (PF_MEMALLOC is set)
will loop until the requested continuous memory is available.

	Szaka

diff -u --recursive --new-file v2.4.2/linux/mm/page_alloc.c
linux/mm/page_alloc.c--- v2.4.2/linux/mm/page_alloc.c        Sat Feb  3
19:51:32 2001
+++ linux/mm/page_alloc.c       Tue Mar 20 15:05:46 2001
@@ -455,8 +455,7 @@
                        memory_pressure++;
                        try_to_free_pages(gfp_mask);
                        wakeup_bdflush(0);
-                       if (!order)
-                               goto try_again;
+                       goto try_again;
                }
        }

