Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263295AbTCUGhn>; Fri, 21 Mar 2003 01:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263300AbTCUGhm>; Fri, 21 Mar 2003 01:37:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:36029 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263295AbTCUGha>;
	Fri, 21 Mar 2003 01:37:30 -0500
Date: Thu, 20 Mar 2003 22:48:32 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] anobjrmap 2/6 mapping
Message-Id: <20030320224832.0334712d.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303202312560.2743-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303202310440.2743-100000@localhost.localdomain>
	<Pine.LNX.4.44.0303202312560.2743-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 06:48:12.0870 (UTC) FILETIME=[D7B0DE60:01C2EF75]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> It is likely that I've screwed up on the "Morton pages", those
> ext3 journal pages locked at truncate time which then turn into
> fish with wings: please check them out, I never manage to wrap
> my head around them.  Certainly don't want a page using private
> for both bufferheads and swp_entry_t.

It goes BUG in try_to_free_buffers().

We really should fix this up for other reasons, probably by making ext3's
per-page truncate operations wait on commit, and be more aggressive about
pulling the page's buffers off the transaction at truncate time.

The same thing _could_ happen with other filesystems; not too sure about
that.

Still.  I suggest you look at freeing up page->list from anon/swapcache
pages.  It really doesn't do much.

Meanwhile, I backed out that bit - I don't actually see where the failure is
anyway.  The page is page_mapped(), !PageAnon and ->mapping == NULL.

