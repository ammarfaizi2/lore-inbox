Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTKZCOh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 21:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263953AbTKZCOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 21:14:36 -0500
Received: from rth.ninka.net ([216.101.162.244]:19844 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263946AbTKZCOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 21:14:34 -0500
Date: Tue, 25 Nov 2003 18:14:13 -0800
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: jbarnes@sgi.com, steiner@sgi.com, jes@trained-monkey.org,
       viro@math.psu.edu, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: hash table sizes
Message-Id: <20031125181413.7cdc6ccf.davem@redhat.com>
In-Reply-To: <20031125132439.3c3254ff.akpm@osdl.org>
References: <16323.23221.835676.999857@gargle.gargle.HOWL>
	<20031125204814.GA19397@sgi.com>
	<20031125130741.108bf57c.akpm@osdl.org>
	<20031125211424.GA32636@sgi.com>
	<20031125132439.3c3254ff.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Nov 2003 13:24:39 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Well yes, we'd want
> 
> 	vfs_caches_init(min(num_physpages, some_platform_limit()));
> 
> which on ia32 would evaluate to nr_free_buffer_pages() and on ia64 would
> evaluate to the size of one of those zones.
> 
> If the machine has zillions of small zones then perhaps this will result in
> an undersized hashtable.

While a platform may have a hard limit, there is also a generic
"usefullness" limit.

If you make the hash tables too huge, you start trading cache misses
on the hash list traversal for misses on the hash array head accesses
themselves.  Big hashes can hurt you also if you don't actually use
them to capacity.

Luckily, now that we've moved the page cache over to the rbtree thing,
there are not many hash tables that strongly depend upon the amount
of RAM in the system.  Unfortunately, the dentry and inode cache ones
being discussed here are two of the remaining ones.

I also believe that vmalloc()'ing this thing is the wrong idea.

Dynamic growth of hash tables, while intellectually interesting to
consider as a solution to the "use to capacity" issue mentioned above,
is wholly impractical in my experience for two reasons: 1) the locking
is messy if not next to impossible 2) getting the higher order allocs
after the system has fully booted is a game of Russian Roulette.

Therefore, I think the safest "fix" for this problem right now is to
just put a hard fixed cap on the hash tables sizes for now instead of
coming up with all sorts of clever new formulas.  In particular, for
the purposes of 2.6.0, we can explore better ideas later.

Andrew's suggested ideas seem to come closest to this.
