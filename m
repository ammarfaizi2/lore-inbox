Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266846AbUH1Owz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266846AbUH1Owz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 10:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266786AbUH1Owz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 10:52:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:47904 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266850AbUH1Owx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 10:52:53 -0400
Date: Sat, 28 Aug 2004 15:52:41 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ram Pai <linuxram@us.ibm.com>, Gergely Tamas <dice@mfa.kfki.hu>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: data loss in 2.6.9-rc1-mm1
In-Reply-To: <41301E27.2020504@yahoo.com.au>
Message-ID: <Pine.LNX.4.44.0408281519300.4593-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Aug 2004, Nick Piggin wrote:
> 
> Ahh, yep - Hugh just forgot to also move the "nr" calculation
> into the ->readpage path, so it hits twice on the fast path.

Yes, your patch is better than mine.

> What's more, it looks like mine handles the corner case of reading off the
> end of a non-PAGE_SIZE file (but within the same page). I think yours will
> drop through and do the ->readpage, while mine doesn't...?

It's a common case, not a corner case: a short read to end of file,
then app does another read which returns 0 for the end of file: that
wouldn't normally fall through to readpage in Ram's case, but would
do unnecessary page_cache_readahead (won't do much) and find_get_page.

> I agree. We'll leave it to someone else to decide, then ;)

I vote for Nick's patch.

I do have one reservation on do_generic_mapping_read,
common to all these versions, unrelated to the current issue.

I'm surprised to notice that you're careful to re-i_size_read
after readpage, but otherwise rely on the initial i_size_read.
We could go around this loop many many times, faulting user pages
in actor, rescheduling away: the old (e.g. 2.4 or 2.6.0) code was
deficient after readpage, but at least it reassessed i_size each
time around the loop.  I guess if the file is truncated meanwhile,
the common case would be for a find_get_page to fail, and then the
situation be corrected after readpage; perhaps it's more likely to
show up as read returning too little on a large file being steadily
appended.  Maybe you already ruled these cases out as not worth the
overhead of handling, but it does surprise me that the old code was
safer in this respect.

Hugh

