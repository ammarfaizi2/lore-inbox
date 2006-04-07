Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbWDGTS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbWDGTS3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 15:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964900AbWDGTS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 15:18:29 -0400
Received: from gold.veritas.com ([143.127.12.110]:10625 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S964899AbWDGTS2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 15:18:28 -0400
X-IronPort-AV: i="4.04,98,1144047600"; 
   d="scan'208"; a="58262594:sNHT31634304"
Date: Fri, 7 Apr 2006 20:18:18 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Andrea Arcangeli <andrea@suse.de>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: smp race fix between invalidate_inode_pages* and do_no_page
In-Reply-To: <20060401212138.3b48f634.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0604071945200.16361@blonde.wat.veritas.com>
References: <43C484BF.2030602@yahoo.com.au> <20060111082359.GV15897@opteron.random>
 <20060111005134.3306b69a.akpm@osdl.org> <20060111090225.GY15897@opteron.random>
 <20060111010638.0eb0f783.akpm@osdl.org> <20060111091327.GZ15897@opteron.random>
 <Pine.LNX.4.61.0601111949070.6448@goblin.wat.veritas.com> <43C75834.3040007@yahoo.com.au>
 <20060112234726.676c3873.akpm@osdl.org> <43C782F3.1090803@yahoo.com.au>
 <20060331123622.GB18093@opteron.random> <20060401212138.3b48f634.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Apr 2006 19:18:27.0591 (UTC) FILETIME=[0C51F170:01C65A78]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2006, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> > 
> > The new PG_truncate bitflag can be used as well to eliminate the
> > truncate_count from all vmas etc... that would save substantial memory
> > and remove some complexity, truncate_count grown a lot since the time we
> > introduced it.

truncate_count is playing a useful role with the vma tree, allowing
us to find our place again after allowing preemption in.  Though I'm
sometimes wondering whether just to make the vma _bigger_ and add a
list instead of that truncate_count: construct a list of vmas from
the prio_tree for unmap_mapping_range, so it can keep place in that,
instead of having to restart the tree whenever preempted.  But I
think NFS doesn't hold i_sem across unmapping, so it wouldn't work.

> > The PG_truncate is needed as well because we can't know in do_no_page if
> > page->mapping is legitimate null or not (think bttv and other device
> > drivers returning page->mapping null because they're private but not
> > reserved pages etc..)

That part is easily dealt with, as Nick and I have suggested,
just by marking vmas liable to having their pages truncated.
But that's certainly no more than one part of a larger solution.

> The patch will pretty clearly fix that.  But it really would be better to
> place all the cost over on the invalidate side, rather than adding overhead
> to the pagefault path.

I see ~2% slowdown in relevant faulting tests e.g. the lmbench ones.
I'd certainly prefer not to be locking pages here: or not without
word from the high-scalability people that Andrea's patch really in
practice doesn't hurt them (but the ~2% I see is on UP as much as MP).

> Could we perhaps check the page_count(page) and/or page_mapped(page) in
> invalidate_complete_page(), when we have tree_lock?

I'm thinking on it, but not finding it easy.  And I've just realized
that invalidate_inode_pages2 isn't the only problematic case here
(though agreed the more urgent one): MADV_REMOVE likewise needs to
invalidate pages without adjusting i_size, so also cannot rely on
the truncate_count/i_size method.

> Do you have handy any test code which others can use to recreate this bug?

I'd be glad of that too.

Hugh
