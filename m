Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263142AbUC2Vc2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 16:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263143AbUC2Vc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 16:32:28 -0500
Received: from intolerance.mr.itd.umich.edu ([141.211.14.78]:59830 "EHLO
	intolerance.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S263142AbUC2Vbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 16:31:48 -0500
Date: Mon, 29 Mar 2004 16:30:51 -0500 (EST)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@eecs2340u28.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: Andrea Arcangeli <andrea@suse.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc2-aa5
In-Reply-To: <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.58.0403291615540.13685@eecs2340u28.engin.umich.edu>
References: <Pine.LNX.4.44.0403291843320.18876-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Moroton <akpm@osld.org> wrote:
>> Andrea Arcangeli <andrea@suse.de> wrote:
>>
>> Notably there is a BUG_ON(page->mapping) triggering in
>> page_remove_rmap in the pagecache case. that could be ex-pagecache
>> being
>> removed from pagecache before all ptes have been zapped, infact the
>> page_remove_rmap triggers in the vmtruncate path.
>
> Confused.  vmtruncate zaps the ptes before removing pages from
> pagecache,
> so I'd expect a non-null ->mapping in page_remove_rmap() is a very
> common
> thing.  truncate a file which someone has mmapped and it'll happen every
> time, will it not?

Andrea missed a not (!) in the BUG_ON. It is BUG_ON(!page->mapping).

The race Andrea hit _may_ be the mremap vs. vmtruncate race I hit:

http://marc.theaimsgroup.com/?l=linux-mm&m=107720111303624

A first truncate that raced with mremap and left an orphaned pte.
The following truncate tried to clear the orphaned pte, and reached
page_remove_rmap with page->mapping == NULL.

Yes. It can happen in all 2.4 and 2.6 kernels.

Hugh has a better fix than mine for the mremap vs. truncate race
in his anobjrmap 7/6 patch.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107998825716363

With prio_tree we have to modify Hugh's fix, though.

Thanks,
Rajesh

