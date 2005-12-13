Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbVLMVCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbVLMVCw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 16:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbVLMVCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 16:02:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:45447 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030213AbVLMVCv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 16:02:51 -0500
Date: Tue, 13 Dec 2005 13:02:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
Message-Id: <20051213130227.2efac51e.akpm@osdl.org>
In-Reply-To: <20051213193735.GE3092@opteron.random>
References: <20051213193735.GE3092@opteron.random>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> wrote:
>
> ...
>
> Clearly taking the page lock in do_no_page would fix it too, but it
> would destroy the scalability of page faults.

It's always bugged me that filemap_nopage() doesn't lock the page.  There
might be additional uglies which could be tidied up if we were to do so.

The scalability loss would happen if there are multiple processes/threads
faulting in the same page I guess.   I wonder how important that would be.

I suppose that even if we did lock the page in filemap_nopage(), the
coverage isn't sufficient here - it needs to extend into do_no_page()?


> The seqschedlock instead
> is 100% smp scalable in the fast path (exactly like RCU and seqlocks),
> and it's lightweight in the write path too and it doesn't introducing
> latencies in freeing memory.

Why this rather than down_read/down_write?  We might even be able to hoist
ext3_inode's i_truncate_sem into the address_space, for zero space cost on
most Linux inodes (dunno).

Is there some way in which we can use mapping->truncate_count to tell
do_no_page() that it raced with invalidate()?  By checking it after the pte
has been established?

> My main concern is the yield() instead of a waitqueue but perhaps that
> can be improved somehow (I didn't think much about it yet). Not sure if
> a waitqueue would be better off inside or outside the seqschedlock, but
> I believe these are secondary matters, in practice it should never
> trigger.

yield() is pretty sucky.

