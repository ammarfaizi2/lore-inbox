Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263176AbUC2Wpz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 17:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263158AbUC2Wpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 17:45:54 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:36250
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263176AbUC2Wp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 17:45:27 -0500
Date: Tue, 30 Mar 2004 00:45:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: 2.6.5-rc2-aa5
Message-ID: <20040329224526.GL3808@dualathlon.random>
References: <20040329150646.GA3808@dualathlon.random> <20040329124803.072bb7c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040329124803.072bb7c6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 12:48:03PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > Notably there is a BUG_ON(page->mapping) triggering in
> > page_remove_rmap in the pagecache case. that could be ex-pagecache being
> > removed from pagecache before all ptes have been zapped, infact the
> > page_remove_rmap triggers in the vmtruncate path.
> 
> Confused.  vmtruncate zaps the ptes before removing pages from pagecache,
> so I'd expect a non-null ->mapping in page_remove_rmap() is a very common

the bugcheck was for NULL ->mapping in page_remove_rmap:

	BUG_ON(!page->mapping);

I tend to forget the ! in the pseudocode in emails sorry (today I did it
twice, luckily I didn't get it wrong in the actual patches ;).

> thing.  truncate a file which someone has mmapped and it'll happen every
> time, will it not?

as you say vmtruncate zaps the pte _first_, so the page->mapcount should
be down to 0 by the time we set page->mapping = NULL. 

the thing I was wondering about is the controlled race where some page
can go out of pagecache despite still being mapped somewhere, that could
happen in the past IIRC.
