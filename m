Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbVEPUli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbVEPUli (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 16:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbVEPUli
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 16:41:38 -0400
Received: from serv01.siteground.net ([70.85.91.68]:459 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S261168AbVEPUl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 16:41:29 -0400
Date: Mon, 16 May 2005 12:43:17 -0700 (PDT)
From: christoph <christoph@scalex86.org>
X-X-Sender: christoph@ScMPusgw
To: Dave Hansen <haveblue@us.ibm.com>
cc: linux-mm <linux-mm@kvack.org>, shai@scalex86.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Factor in buddy allocator alignment requirements in node
 memory alignment
In-Reply-To: <1116274451.1005.106.camel@localhost>
Message-ID: <Pine.LNX.4.62.0505161240240.13692@ScMPusgw>
References: <Pine.LNX.4.62.0505161204540.4977@ScMPusgw> <1116274451.1005.106.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 May 2005, Dave Hansen wrote:

> On Mon, 2005-05-16 at 12:05 -0700, christoph wrote:
> > Memory for nodes on i386 is currently aligned on 2 MB boundaries.
> > However, the buddy allocator needs pages to be aligned on
> > PAGE_SIZE << MAX_ORDER which is 8MB if MAX_ORDER = 11.
> 
> Why do you need this?  Are you planning on allowing NUMA KVA remap pages
> to be handed over to the buddy allocator?  That would be a major
> departure from what we do now, and I'd be very interested in seeing how
> that is implemented before a infrastructure for it goes in.

Because the buddy allocator is complaining about wrongly allocated zones!

in page_alloc.c:

static void __init free_area_init_core(struct pglist_data *pgdat,
                unsigned long *zones_size, unsigned long *zholes_size)
{
...

  const unsigned long zone_required_alignment = 1UL << (MAX_ORDER-1);

...

             if ((zone_start_pfn) & (zone_required_alignment-1))
                        printk(KERN_CRIT "BUG: wrong zone alignment, it will crash\n");


