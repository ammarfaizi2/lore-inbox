Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbUCEVou (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbUCEVou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:44:50 -0500
Received: from mail.shareable.org ([81.29.64.88]:43911 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261223AbUCEVoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:44:46 -0500
Date: Fri, 5 Mar 2004 21:44:34 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, peter@mysql.com, riel@redhat.com,
       mbligh@aracnet.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040305214434.GD7254@mail.shareable.org>
References: <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com> <20040229014357.GW8834@dualathlon.random> <1078370073.3403.759.camel@abyss.local> <20040303193343.52226603.akpm@osdl.org> <1078371876.3403.810.camel@abyss.local> <20040303200704.17d81bda.akpm@osdl.org> <20040304045212.GG4922@dualathlon.random> <20040303211042.33cd15ce.akpm@osdl.org> <20040305201954.GB7254@mail.shareable.org> <20040305203340.GU4922@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040305203340.GU4922@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> > Can you use a read-write lock, so that userspace copies only need to
> > take the lock for reading?  That doesn't eliminate cacheline bouncing
> > but does eliminate the serialisation.
> 
> normally the bouncing would be the only overhead, but here I also think
> the serialization is a significant factor of the contention because the
> critical section is taking lots of time. So I would expect some
> improvement by using a read/write lock.

For something as significant as user<->kernel data transfers, it might
be worth eliminating the bouncing as well - by using per-CPU * per-mm
spinlocks.

User<->kernel data transfers would take the appropriate per-CPU lock
for the current mm, and not take page_table_lock.  Everything that
normally takes page_table_lock would, and also take all of the per-CPU locks.

That does require a set of per-CPU spinlocks to be allocated whenever
a new mm is allocated (although the sets could be cached so it needn't
be slow).

-- Jamie
