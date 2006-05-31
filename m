Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbWEaOav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbWEaOav (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbWEaOav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 10:30:51 -0400
Received: from gold.veritas.com ([143.127.12.110]:59200 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S965042AbWEaOau (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 10:30:50 -0400
X-IronPort-AV: i="4.05,193,1146466800"; 
   d="scan'208"; a="60054029:sNHT31979192"
Date: Wed, 31 May 2006 15:30:42 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mason@suse.com,
       andrea@suse.de, axboe@suse.de
Subject: Re: [rfc][patch] remove racy sync_page?
In-Reply-To: <Pine.LNX.4.64.0605310335180.4441@blonde.wat.veritas.com>
Message-ID: <Pine.LNX.4.64.0605311517340.24204@blonde.wat.veritas.com>
References: <447AC011.8050708@yahoo.com.au> <20060529121556.349863b8.akpm@osdl.org>
 <447B8CE6.5000208@yahoo.com.au> <20060529183201.0e8173bc.akpm@osdl.org>
 <447BB3FD.1070707@yahoo.com.au> <Pine.LNX.4.64.0605292117310.5623@g5.osdl.org>
 <447BD31E.7000503@yahoo.com.au> <447BD9CE.2020505@yahoo.com.au>
 <Pine.LNX.4.64.0605301911480.10355@blonde.wat.veritas.com> <447CE1A3.60507@yahoo.com.au>
 <Pine.LNX.4.64.0605310335180.4441@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 31 May 2006 14:30:49.0967 (UTC) FILETIME=[D047FFF0:01C684BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2006, Hugh Dickins wrote:
> 
> Yes, I had noticed yours is a different issue.  I'm saying that if we
> can "fix" set_page_dirty_nolock not to sleep, then your issue is fixed
> (as least as it affects set_page_dirty_lock, which is all your patch
> is dealing with, and we hope all it needs to deal with).  Because your
> issue is with the sync_page in the lock_page of set_page_dirty_nolock,
> and it's that particular lock_page which I'm trying to be rid of.
> 
> I now think it can be done: in cases where TestSetPageLocked finds
> the page already locked, then I believe we can fall back to inode_lock
> to stabilize.  But I do need to consider the possibilities some more.

No, I'm wrong, and have been all along in thinking set_page_dirty_lock
could be done better avoiding the lock_page.  inode_lock gives the hint:
it's not irq safe, nor is mapping->private_lock, and both may be taken
by set_page_dirty.  The lock_page in set_page_dirty_lock was the obvious
reason it couldn't be used at interrupt time, but not the only reason.

So your lock_page_nosync does look the best way forward to me now.

Hugh
