Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318223AbSIKAC1>; Tue, 10 Sep 2002 20:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318227AbSIKAC1>; Tue, 10 Sep 2002 20:02:27 -0400
Received: from packet.digeo.com ([12.110.80.53]:48515 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318223AbSIKAC1>;
	Tue, 10 Sep 2002 20:02:27 -0400
Message-ID: <3D7E8936.9882E929@digeo.com>
Date: Tue, 10 Sep 2002 17:07:18 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.34 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17orzf-0007Gn-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 00:07:06.0478 (UTC) FILETIME=[2A1AA0E0:01C25927]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> ...
> Andrew, did I miss something, or does the current code really ignore
> the pte dirty bits?

Sure.  pte_dirty -> PageDirty propagation happens in page reclaim,
and in msync.

We _could_ walk the pte chain in writeback.  But that would involve
visiting every page in the mapping, basically.  That could hurt.

But if a page is already dirty, and we're going to write it anyway,
it makes tons of sense to run around and clean all the ptes which
point at it.

It especially makes sense for fielmap_sync() to do that. (quickly
edits the todo file).

I'm not sure that MAP_SHARED is a good way of performing file writing,
really.  And not many things seem to use it for that. It's more there
as a way for unrelated processes to find a chunk of common memory via
the usual namespace.  Not sure about that, but I am sure that it's a
damn pest.
