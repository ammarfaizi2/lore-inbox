Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932430AbWFLWGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbWFLWGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWFLWGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:06:47 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:63381 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S932430AbWFLWGq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:06:46 -0400
Subject: Re: How long can an inode structure reside in the inode_cache?
From: Charlie Brett <cfb@hp.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
References: <4ae3c140606091710k7a320f2ex6390d0e01da4de9b@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:21:57 -0600
Message-Id: <1150150917.5631.77.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 20:10 -0400, Xin Zhao wrote:
> I was wondering how Linux decide to free an inode from the
> inode_cache? If a file is open, an inode structure will be created and
> put into the inode_cache, but when will this inode be free and removed
> from the inode_cache? after this file is closed? If so, this seems to
> be inefficient.
> 
> Can someone tell me how Linux handle this issue?
> 
> Thanks,
> Xin

As already pointed out, in the simplest case, an inode is removed from
the in_use list and marked free in the cache when the last user closes
it. There are certain situations where the inode cannot be marked free
right away, because of references to it. In those cases, the inode will
end up on the unused list, and will eventually get marked free in the
inode cache by kswapd when the system is low on free memory.

Now if your question is really, "When does the memory occupied by the
inode get released to the general memory pool?", then the answer is when
all the inodes of a cache page are marked free and kswapd returns the
entire page to the memory pool.

The whole process is not that inefficient, since memory is not
"recovered" until there is a need for it. Odds are, if memory was used
for a given type of cache, it will probably be needed again for the same
thing. The only problem that could occur is when there are a lot of
partially filled cache pages (e.g. pages that only contain a very few
number of objects). It does happen, but I think it's pretty rare.

If you do get into a situation where you think your system is spending a
lot of time trying to recover memory (perhaps because it has a large
amount of icache allocated), you could try running a process that
requires a large amount of memory, which would force recovery. Then,
when the process terminates, the memory would be released. This doesn't
change the behavior, but makes it a bit more predictable.

-- 
Charlie Brett <cfb@hp.com>

