Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264427AbRFIRlH>; Sat, 9 Jun 2001 13:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264430AbRFIRk5>; Sat, 9 Jun 2001 13:40:57 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:49371 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264427AbRFIRkz>;
	Sat, 9 Jun 2001 13:40:55 -0400
Date: Sat, 9 Jun 2001 13:40:52 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <andrewm@uow.edu.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] truncate_inode_pages
In-Reply-To: <3B224613.440AE25C@uow.edu.au>
Message-ID: <Pine.GSO.4.21.0106091331120.19361-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> takes 45 seconds CPU time due to the O(clean * dirty) algorithm in
> truncate_inode_pages().  The machine is locked up for the duration.
> The patch reduces this to 20 milliseconds via an O(clean + dirty)
> algorithm.

Unfortunately, it's _not_ O(clean + dirty).

> +		while (truncate_list_pages(&mapping->clean_pages, start, &partial)) {
> +			spin_lock(&pagecache_lock);
> +			complete = 0;
> +		}

Cool. Now think what happens if pages with large indices are in the
very end of list. Half of them. You skip clean/2 pages on each of
clean/2 passes. Hardly a linear behaviour - all you need is a different
program to trigger it.

Now, having a separate pass that would reorder the pages on list,
moving the to-kill ones in the beginning might help.

