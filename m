Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbUKBTlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbUKBTlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261877AbUKBTkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:40:05 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:32916 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261964AbUKBTj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:39:27 -0500
Date: Tue, 2 Nov 2004 20:39:01 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Andy Whitcroft <apw@shadowen.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       nickpiggin@yahoo.com.au, linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041102193901.GO3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <40860000.1099235861@[10.10.2.4]> <41879145.7090309@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41879145.7090309@shadowen.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 01:53:09PM +0000, Andy Whitcroft wrote:
> I'll have a look out for the results, they should be around somewhere?

could you give an hint on which workload to use for the measurements?

> page for use.  The colder the page the slower the system went.

this is expected. This is why I waste no more than 4k of cache for each
local-apic irq, and this is also why I don't waste any cache at all if
the zerolist is already full or the hot-cold list is empty (plus if
there are PG_zero pages in the hot-cold list since I cache PG_zere deep
down in the buddy, I don't waste any cache at all by refiling them into
the zero quicklist). Not sure if you were using the same design. Note
that idle zeroing is a worthless feature in my patch, I never intented
to implement it, I just happened to be able to implement it with a
trivial change so I did (and it can be disabled via sysctl). all the
important stuff are bugfixes and obsoleting the inefficient slab for pte
allocation and to create a superset of the pte_quicklist in 2.4 that is
missing in 2.6 by mistake.

Note that I'm keeping track of hot and cold cache for the zerolist too.
Plus I can disable the idle zeroing and still I will be able to cache
zero information in O(1) (so then caching zero will be zerocost, plus
I'll keep track of the hottest zero page, and the coldest one).
