Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264725AbSJRKMI>; Fri, 18 Oct 2002 06:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265061AbSJRKMI>; Fri, 18 Oct 2002 06:12:08 -0400
Received: from matrix.roma2.infn.it ([141.108.255.2]:6306 "EHLO
	matrix.roma2.infn.it") by vger.kernel.org with ESMTP
	id <S264725AbSJRKMG>; Fri, 18 Oct 2002 06:12:06 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>
To: "Gadad, Vijay" <vgadad@persistcorp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kernel BUG at page_alloc.c:220 - oops in 2.4.19
Date: Fri, 18 Oct 2002 12:18:33 +0200
User-Agent: KMail/1.4.3
References: <AAE2EF2556DA3045830D8DFFD01C4AD103C035@athena.persistcorp.local>
In-Reply-To: <AAE2EF2556DA3045830D8DFFD01C4AD103C035@athena.persistcorp.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200210181218.33516.gabrielli@roma2.infn.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02:39, venerdì 18 ottobre 2002, Gadad, Vijay wrote:
> I'm seeing an intermittent oops on a heavily loaded SMP system (Compaq
> DL360 G2).  I've read the messages suggesting this is related to the nvidia
> driver, but I don't have that loaded.
>
> This is the vanilla 2.4.19 kernel, plus Intel's e1000.o driver and the ipvs
> patch.
>
> Here's the ksymoops output:
>
>
>
>
> kernel BUG at page_alloc.c:220!
> invalid operand: 0000
> CPU:    1
> EIP:    0010:[rmqueue+509/592]    Not tainted

this may be a patch:

[albert@yoda albert]$ diff -ruN page_alloc.c new_page_alloc.c
--- page_alloc.c     
+++ new_page_alloc.c   
@@ -167,7 +167,7 @@
 #define MARK_USED(index, order, area) \
        __change_bit((index) >> (1+(order)), (area)->map)

-static inline struct page * expand (zone_t *zone, struct page *page,
+static inline struct page * expand(zone_t *zone, struct page *page,
         unsigned long index, int low, int high, free_area_t * area)
 {
        unsigned long size = 1 << high;
@@ -215,7 +215,6 @@
                        zone->free_pages -= 1UL << order;

                        page = expand(zone, page, index, order, curr_order, 
area);
-                       spin_unlock_irqrestore(&zone->lock, flags);

                        set_page_count(page, 1);
                        if (BAD_RANGE(zone,page))
@@ -224,6 +223,7 @@
                                BUG();
                        if (PageActive(page))
                                BUG();
+                       spin_unlock_irqrestore(&zone->lock, flags);
                        return page;
                }
                curr_order++;


__

Emiliano 'AlberT' Gabrielli


