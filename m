Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJUVnj>; Mon, 21 Oct 2002 17:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJUVnj>; Mon, 21 Oct 2002 17:43:39 -0400
Received: from packet.digeo.com ([12.110.80.53]:21914 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261740AbSJUVnf>;
	Mon, 21 Oct 2002 17:43:35 -0400
Message-ID: <3DB4766F.D3AB15B9@digeo.com>
Date: Mon, 21 Oct 2002 14:49:35 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
References: <3DB472B6.BC5B8924@digeo.com> <309670000.1035236015@flay>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 21:49:35.0801 (UTC) FILETIME=[BF40FA90:01C2794B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> >> Nope, kept OOMing and killing everything .
> >
> > Something broke.
> 
> Even I worked that out ;-)

Well I'm feeling especially helpful today.

> > Blockdevices only use ZONE_NORMAL for their pagecache.  That cat will
> > selectively put pressure on the normal zone (and DMA zone, of course).
> 
> Ah, I recall that now. That's fundamentally screwed.

When filesystems want to access metadata, they will typically read
a block into a buffer_head and access the memory directly.

 mnm:/usr/src/25> grep -rI b_data fs | wc -l
    844

That's a lot of kmaps need adding.

So we constrain blockdev->bd_inode->i_mapping->gfp_mask so that
the blockdev's pagecache memory is always in the direct-addressed
region.

It would be possible to fix on a per-fs basis - teach a filesystem
to kmap bh->b_page appropriately and then set __GFP_HIGHMEM in the
blockdev's gfp_mask.

But it doesn't seem to cause a lot of trouble in practice.
