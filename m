Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264771AbSJVQ7e>; Tue, 22 Oct 2002 12:59:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264773AbSJVQ7e>; Tue, 22 Oct 2002 12:59:34 -0400
Received: from packet.digeo.com ([12.110.80.53]:3771 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264771AbSJVQ7d>;
	Tue, 22 Oct 2002 12:59:33 -0400
Message-ID: <3DB5855B.FD4CD26C@digeo.com>
Date: Tue, 22 Oct 2002 10:05:31 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: Re: ZONE_NORMAL exhaustion (dcache slab)
References: <3DB4855F.D5DA002E@digeo.com> <Pine.LNX.4.44L.0210221428060.1648-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 17:05:35.0604 (UTC) FILETIME=[3CEB0340:01C279ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Mon, 21 Oct 2002, Andrew Morton wrote:
> 
> > He had 3 million dentries and only 100k pages on the LRU,
> > so we should have been reclaiming 60 dentries per scanned
> > page.
> >
> > Conceivably the multiply in shrink_slab() overflowed, where
> > we calculate local variable `delta'.  But doubtful.
> 
> What if there were no pages left to scan for shrink_caches ?

Historically, this causes an ints-off lockup, but I think we've
fixed all them now ;)

> Could it be possible that for some strange reason the machine
> ended up scanning 0 slab objects ?
> 
> 60 * 0 is still 0, after all ;)
> 

More by good luck than by good judgement, if there are zero inactive
pages in a zone we come out of shrink_caches with max_scan equal
to SWAP_CLUSTER_MAX*2.  So if all of a zone's pages are out in
pagetables/skbuffs/whatever we'll put a lot of pressure on slab.

Which is good.  But it'll do that even if the offending zone cannot
contain any slab, which is not so good, but not very serious in
practice.  Search for "FIXME"...
