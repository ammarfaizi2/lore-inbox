Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263806AbRGBLY2>; Mon, 2 Jul 2001 07:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263862AbRGBLYT>; Mon, 2 Jul 2001 07:24:19 -0400
Received: from tsukuba.m17n.org ([192.47.44.130]:60082 "EHLO tsukuba.m17n.org")
	by vger.kernel.org with ESMTP id <S263806AbRGBLYF>;
	Mon, 2 Jul 2001 07:24:05 -0400
Date: Mon, 2 Jul 2001 20:23:58 +0900 (JST)
Message-Id: <200107021123.f62BNwj02290@mule.m17n.org>
From: NIIBE Yutaka <gniibe@m17n.org>
To: "David S. Miller" <davem@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Cache issues
In-Reply-To: <200106291418.f5TEI0i09541@mule.m17n.org>
In-Reply-To: <200106270051.f5R0pkl19282@mule.m17n.org>
	<Pine.LNX.4.21.0106270710050.1291-100000@freak.distro.conectiva>
	<200106280007.f5S07qQ04446@mule.m17n.org>
	<20010628012349.L1554@redhat.com>
	<200106280041.f5S0fDr05278@mule.m17n.org>
	<15162.32433.598824.599520@pizda.ninka.net>
	<200106280104.f5S14XA05644@mule.m17n.org>
	<200106291418.f5TEI0i09541@mule.m17n.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

NIIBE Yutaka wrote:
 > I don't see any reason why we need to flush the cache here.
 > 
 > --- v2.4.6-pre5/mm/memory.c	Mon Jun 25 18:48:10 2001
 > +++ kernel/mm/memory.c	Tue Jun 26 14:48:15 2001
 > @@ -1109,8 +1109,6 @@ static int do_swap_page(struct mm_struct
 >  			return -1;
 >  		}
 >  		wait_on_page(page);
 > -		flush_page_to_ram(page);
 > -		flush_icache_page(vma, page);
 >  	}
 >  
 >  	/*

I've looked thorough all flush_page_to_ram and flush_icache_page calls.
If the architecture support follows the rule of Documentation/cachetlb.txt, 
I think that all the occurrences of flush_page_to_ram and
flush_icache_page are (almost) bogus now.

We have two issues yet:

(1) include/linux/highmem.h:memclear_highpage_flush
    We need to call flush_dcache_page here to remove flush_page_to_ram

(2) kernel/ptrace.c
    We need to call flush_dcache_page here too.
    Special care would be needed here.  I think that we cannot defer
    the flushing here.  There's the case where page->mapping ==
    &swapper_space, thus mapping->i_mmap == NULL 
    && mapping->i_mmap_shared == NULL.

Besides, flush_cache_page in mm/memory.c:{break_cow,do_wp_page}	are
redundant for SH-4.  SH-4's cache is direct mapped, virtually indexed
phisically tagged, so we don't need to flush anything.
-- 
