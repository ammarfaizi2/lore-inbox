Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261733AbVBOS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261733AbVBOS0r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 13:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbVBOS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 13:26:47 -0500
Received: from news.suse.de ([195.135.220.2]:29336 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261733AbVBOS0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 13:26:43 -0500
Date: Tue, 15 Feb 2005 19:24:44 +0100
From: Andi Kleen <ak@suse.de>
To: Ray Bryant <raybry@sgi.com>
Cc: Andi Kleen <ak@suse.de>, linux-mm <linux-mm@kvack.org>,
       Robin Holt <holt@sgi.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>, Marcello.Tossattu@cyclades.com,
       Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [RFC 2.6.11-rc2-mm2 0/7] mm: manual page migration -- overview
Message-ID: <20050215182444.GB7345@wotan.suse.de>
References: <20050212032535.18524.12046.26397@tomahawk.engr.sgi.com> <m1vf8yf2nu.fsf@muc.de> <42114279.5070202@sgi.com> <20050215115302.GB19586@wotan.suse.de> <42123C6C.3070102@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42123C6C.3070102@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I really don't see how that is relevant to the current discussion, which,
> as AFAIK, is that the kernel interface should be "migrate an entire process"
> versus what I have proposed.  What we are trying to avoid here for shared
> libraries is two things:  (1) don't migrate them needlessly, and (2) don't
> even make the migration request if we know that the pages shouldn't be
> migrated.
> 
> Using Steve Longerbeam's approach avoids (1).  But you will still scan the
> pte's of the proceeses to be migrated (if you go with a "migrate the
> entire process" approach) and try to migrate them, only to find out that
> they are pinned in place.  How is that a good thing?

You don't scan any PTEs, just the mempolicy tree. That is extremly
cheap. 

> >>    (The page migration code from the memory hotplug patch will handle
> >>    updating the pte's of the other processs (thank goodness for
> >>    rmap...))
> >
> >
> >I don't get this. Surely the migration code will check if a page
> >is already in the target node, and when that is the case do nothing.
> >
> >How could this "double migration" happen? 
> 
> Not so much a double migration, but a double request for migration.
> (This is not a correctness, but a performance issue, once again.)
> Consider the case of a 300 GB file mapped into 256 pid's.  One doesn't
> want each pid to try to migrate the file pages.  Granted, all after the

Again file policy nicely takes care of this.

> first one will find the data already migrated, but if you issue a
> migration request for each address space, the others won't know that
> the page has been migrated until they have found the page and looked
> up its current node.  That means doing a find_get_page() for each page
> in the mapped file in all 256 address spaces, and 255 of those address

You just look at the mempolicy extent tree linked from the
address space.

> >
> >>(3)  In the case where a particular file is mapped into different
> >>    processes at different file offsets (and we are migrating both
> >>    of the processes), one has to examine the file offsets to figure
> >>    out if the mappings overlap or not. If they overlap, then you've
> >>    got to issue two calls, each of which describes a non-overlapping
> >>    region; both calls taken together would cover the entire range
> >>    of pages mapped to the file.  Similarly if the ranges do not
> >>    overlap.
> >
> >
> >That sounds like a quite obscure corner case which I'm not sure
> >is worth all the complexity.
> >
> >-Andi
> >
> >
> 
> So what is your solution when this happens?  Make the job non-migratable?
> Yes, it may be an obscure case in your view but we've got to handle all of
> those cases to make a robust facility that can be used in a production 
> environment.

With per file policies you really don't care if there are overlaps or
not. You then care about offsets inside the object, not addresses
in some process virtual memory image. You just set the policy to migrate or
not migrate to the file and set a "lock bit" (that would
need to be added) and then no one else will touch the poliocy

-Andi
