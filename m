Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSIKAec>; Tue, 10 Sep 2002 20:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSIKAeb>; Tue, 10 Sep 2002 20:34:31 -0400
Received: from packet.digeo.com ([12.110.80.53]:48004 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S318252AbSIKAd6>;
	Tue, 10 Sep 2002 20:33:58 -0400
Message-ID: <3D7E909A.512C23C1@digeo.com>
Date: Tue, 10 Sep 2002 17:38:50 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.34 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Chuck Lever <cel@citi.umich.edu>, Rik van Riel <riel@conectiva.com.br>,
       trond.myklebust@fys.uio.no,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu> <E17orzf-0007Gn-00@starship> <3D7E8936.9882E929@digeo.com> <E17ovLv-0007JB-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Sep 2002 00:38:38.0728 (UTC) FILETIME=[91F91080:01C2592B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> > ...
> We do get
> around to walking the ptes at file close I believe.  Is that not driven by
> zap_page_range, which moves any orphaned pte dirty bits down into the struct
> page?

Nope, close will just leave all the pages pte-dirty or PageDirty in
memory.  truncate will nuke all the ptes and then the pagecache.

But the normal way in which pte-dirty pages find their way to the
backing file is:

- page reclaim runs try_to_unmap or

- user runs msync().  (Which will only clean that mm's ptes!)

These will run set_page_dirty(), making the page visible to
one of the many things which run writeback.
