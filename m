Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262232AbVBKHjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262232AbVBKHjx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 02:39:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262237AbVBKHj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 02:39:29 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:45303 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262202AbVBKHXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 02:23:53 -0500
Date: Fri, 11 Feb 2005 07:23:09 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrea Arcangeli <andrea@suse.de>
cc: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [RFC] Changing COW detection to be memory hotplug friendly
In-Reply-To: <20050210204025.GS18573@opteron.random>
Message-ID: <Pine.LNX.4.61.0502110710150.5866@goblin.wat.veritas.com>
References: <20050203035605.C981A7046E@sv1.valinux.co.jp> 
    <Pine.LNX.4.61.0502072041130.30212@goblin.wat.veritas.com> 
    <Pine.LNX.4.61.0502081549320.2203@goblin.wat.veritas.com> 
    <20050210190521.GN18573@opteron.random> 
    <Pine.LNX.4.61.0502101953190.6194@goblin.wat.veritas.com> 
    <20050210204025.GS18573@opteron.random>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2005, Andrea Arcangeli wrote:
> On Thu, Feb 10, 2005 at 08:19:47PM +0000, Hugh Dickins wrote:
> > 
> > get_user_pages broke COW in advance of the I/O.  The reason for
> > subsequent COW if the page gets unmapped is precisely because
> > can_share_swap_page used page_count to judge exclusivity, and
> > get_user_pages has bumped that up, so the page appears (in danger
> > of being) non-exclusive when actually it is exclusive.  By changing
> > can_share_swap_page to use page_mapcount, that frustration vanishes.
> 
> What if a second thread does a fork() while the rawio is in progress?
> The page will be again no shareable, and if you unmap it the rawio will
> be currupt if the thread that executed the fork while the I/O is in
> progress writes to a part of the page again after it has been unmapped
> (obviously the part of the page that isn't under read-rawio, rawio works
> with the hardblocksize, not on the whole page). 

I think there's no difference here between the two techniques.

With the new can_share_swap_page, yes, "page_swapcount" goes up with
the fork, the page will be judged non-exclusive, a user write to
another part of the page will replace it by a copy page, and it's
undefined how much of the I/O will be captured in the copy.

But even with the old can_share_swap_page, and try_to_unmap_one
refusing to unmap the page, copy_page_range's COW checking would
still remove write permission from the pte of an anonymous
page, so a user write to another part of the page would find
raised page_count and replace it by a copy page: same behaviour.

And it's fine for the behaviour to be somewhat undefined in this
peculiar case: the important thing is just that the page must not
be freed and reused while I/O occurs, hence get_user_page raising
the page_count - which I'm _not_ proposing to change!

Hugh
