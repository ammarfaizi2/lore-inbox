Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbVLMVOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbVLMVOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbVLMVOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:14:45 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:18698
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030230AbVLMVOo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:14:44 -0500
Date: Tue, 13 Dec 2005 22:14:41 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-ID: <20051213211441.GH3092@opteron.random>
References: <20051213193735.GE3092@opteron.random> <20051213130227.2efac51e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051213130227.2efac51e.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2005 at 01:02:27PM -0800, Andrew Morton wrote:
> It's always bugged me that filemap_nopage() doesn't lock the page.  There
> might be additional uglies which could be tidied up if we were to do so.
> 
> The scalability loss would happen if there are multiple processes/threads
> faulting in the same page I guess.   I wonder how important that would be.

I don't know for sure, I know for sure with threads faulting on the same
page at the same time is common, but I don't know with processes, I
expected it is possible. 

> I suppose that even if we did lock the page in filemap_nopage(), the
> coverage isn't sufficient here - it needs to extend into do_no_page()?

I think so, for invalidate_mapping_pages (the simpler case since it's
less aggressive) we'd need to drop the page lock after increasing the
mapcount, so page_mapped() will notice it has to skip the page.

> Why this rather than down_read/down_write?  We might even be able to hoist
> ext3_inode's i_truncate_sem into the address_space, for zero space cost on
> most Linux inodes (dunno).

The only reason for not using semaphores, is to keep the fast path 100%
scalable, without risking cacheline bouncing and without requiring
exclusive access to a cacheline in a cpu (i.e. writes).

> Is there some way in which we can use mapping->truncate_count to tell
> do_no_page() that it raced with invalidate()?  By checking it after the pte
> has been established?

I tried that but failed, the reason is that the truncate_count alone is
worthless, we combine the truncate_count with the i_size information and
we write and read them in reverse order to do the locking for truncate.

But invalidates can't change the i_size, so truncate_count alone can't
be used.

I could save 4 bytes by using truncate_count instead of sl->sequence,
but the ugliness of the code that it would have been generated made me
waste 4 bytes.

> yield() is pretty sucky.

I wonder if we can use a waitqueue to wait a wakeup from the writer
while still leaving the fast path readonly. In theory yield() should
never trigger, when it triggers it means we had a race condition, but I
also don't like yield. anyway it was pointless to make it more
complicated before hearing some comment, I'd rather not invest too much
time in the seqschedlocks before knowing if they will be used ;).
