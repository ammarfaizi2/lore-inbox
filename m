Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262768AbTCYW4s>; Tue, 25 Mar 2003 17:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264032AbTCYW4s>; Tue, 25 Mar 2003 17:56:48 -0500
Received: from packet.digeo.com ([12.110.80.53]:36048 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262768AbTCYW4r>;
	Tue, 25 Mar 2003 17:56:47 -0500
Date: Tue, 25 Mar 2003 17:12:23 -0800
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
Message-Id: <20030325171223.7a2c50ee.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0303252222530.12636-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0303252209070.12636-100000@localhost.localdomain>
	<Pine.LNX.4.44.0303252222530.12636-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Mar 2003 23:07:51.0009 (UTC) FILETIME=[5BD81D10:01C2F323]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> shrink_list's may_enter_fs (may_write_page would be a better name)
> currently reflects that swapcache page I/O won't suffer from FS
> complications, so can be done if __GFP_IO without __GFP_FS; but
> the same is true of a tmpfs page (which is just this stage away
> from being a swapcache page), so check bdi->memory_backed instead.
> 
> ...
>
> +			if (!(gfp_mask & (bdi->memory_backed?
> +					__GFP_IO: __GFP_FS)))
>  				goto keep_locked;

Barf.  I haven't used a question mark operator in ten years, and this is a
fine demonstration of why ;)

I think a feasibly comprehensible transformation would be:

	/*
	 * A comment goes here
	 */
	if (bdi->memory_backed)
		may_enter_fs = gfp_mask & __GFP_IO;
	else
		may_enter_fs = gfp_mask & __GFP_FS;


That being said, this is a bit presumptuous.  PF_MEMALLOC will protect us
from infinite recursion but there are other reasons for GFP_NOFS.

For example, a memory-backed filesystem may be trying to allocate GFP_NOFS
memory while holding filesystem locks which are taken by its writepage.

How about adding a new field to backing_dev_info for this case?  Damned if I
can think of a name for it though.



