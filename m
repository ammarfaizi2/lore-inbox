Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269477AbRHGWFm>; Tue, 7 Aug 2001 18:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269478AbRHGWFd>; Tue, 7 Aug 2001 18:05:33 -0400
Received: from [63.209.4.196] ([63.209.4.196]:57104 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S269477AbRHGWFV>; Tue, 7 Aug 2001 18:05:21 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
Date: Tue, 7 Aug 2001 22:03:40 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9kpojs$14d$1@penguin.transmeta.com>
In-Reply-To: <3B7030B3.9F2E8E67@zip.com.au> <Pine.LNX.4.33.0108071426380.30280-100000@touchme.toronto.redhat.com>
X-Trace: palladium.transmeta.com 997221881 29112 127.0.0.1 (7 Aug 2001 22:04:41 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 7 Aug 2001 22:04:41 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0108071426380.30280-100000@touchme.toronto.redhat.com>,
Ben LaHaise  <bcrl@redhat.com> wrote:
>
>Yes, but I'm using raid 0.  The ratio of highmem to normal memory is
>~3.25:1, and it would seem that this is breaking write throttling somehow.

Ahh - I see it. 

Check "nr_free_buffer_pages()" - and notice how the function is meant to
return the number of pages that can be used for buffers.

But the function doesn't understand about the limitations of buffer
allocations inherent in GFP_NOFS, namely that it won't ever allocate a
high-mem buffer. So it just stupidly adds up the number of free pages,
coming to the conclusion that we have a _lot_ of memory that buffers
could use..

This obviously makes the whole balance_dirty() algorithm not work at
all.

This should be fairly easy to do. Instead of counting all zones,
nr_free_buffer_pages() should count only the zones that are listed in
the GFP_NOFS zonelist. So instead of using

	unsigned int sum;

	sum = nr_free_pages();
	sum += nr_inactive_clean_pages();
	sum += nr_inactive_dirty_pages;

it should do something like this instead (but please hide the "zonelist"
lookup behind some nice macro, I almost lost my lunch when I wrote that
;)

	unsigned int sum = 0;
	zonelist_t *zonelist = contig_page_data.node_zonelists+(gfp_mask & GFP_ZONEMASK);
	zone_t **zonep = zonelist->zones, *zone;

	for (;;) {
		zone_t *zone = *zonep;
		if (!zone)
			return sum;
		sum += zone->free_pages + zone->inactive_clean_pages + zone->inactive_dirty_pages;
	}

which is more accurate, and actually faster to boot (look at what
"nr_free_pages()" and friends do - they already walk all the zones)

I can't easily test this - mind giving it a whirl?

		Linus
