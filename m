Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261420AbUKFQyp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261420AbUKFQyp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 11:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKFQyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 11:54:45 -0500
Received: from [213.85.13.118] ([213.85.13.118]:61825 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261420AbUKFQyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 11:54:43 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16781.436.710721.667909@gargle.gargle.HOWL>
Date: Sat, 6 Nov 2004 19:54:12 +0300
To: Andrea Arcangeli <andrea@novell.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
In-Reply-To: <20041106153209.GC3851@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet>
	<200411051532.51150.jbarnes@sgi.com>
	<20041106012018.GT8229@dualathlon.random>
	<418C2861.6030501@cyberone.com.au>
	<20041106015051.GU8229@dualathlon.random>
	<16780.46945.925271.26168@thebsh.namesys.com>
	<20041106153209.GC3851@dualathlon.random>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli writes:
 > On Sat, Nov 06, 2004 at 02:37:05PM +0300, Nikita Danilov wrote:
 > > We need page-reservation API of some sort. There were several attempts
 > > to introduce this, but none get into mainline.
 > 
 > they're already in under the name of mempools

I am talking about slightly different thing. Think of some operation
that calls find_or_create_page(). find_or_create_page() doesn't know
about memory reserved in mempools, it uses alloc_page() directly. If one
wants to guarantee that compound operation has enough memory to
complete, memory should be reserved at the lowest level---in the page
allocator.

 > 
 > I'm perfectly aware the fs tends to be the less correct places in terms
 > of allocations, and luckily it's not an heavy memory user, so I still

Either you are kidding, or we are facing very different workloads. In
the world of file-system development, file-system is (not surprisingly)
single largest memory consumer.

 > have to see a deadlock in getblk or create_buffers or similar. It's
 > mostly a correctness issue (math proof it can't deadlock, right now it
 > can if more tasks all get stuck in getblk at the same time during a hard
 > oom condition etc..).

Add here mmap that can dirty all physical memory behind your back, and
delayed disk block allocation that forces ->writepage() to allocate
potentially huge extent when memory is already tight and hope of having
a proof becomes quite remote.

Nikita.
