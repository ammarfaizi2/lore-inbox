Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUKAXBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUKAXBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 18:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S380272AbUKAXBC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 18:01:02 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:34728 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S286412AbUKAV50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 16:57:26 -0500
Date: Mon, 1 Nov 2004 22:57:09 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: PG_zero
Message-ID: <20041101215709.GD3571@dualathlon.random>
References: <20041030141059.GA16861@dualathlon.random> <20041030140732.2ccc7d22.akpm@osdl.org> <20041030224528.GB3571@dualathlon.random> <43630000.1099236900@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43630000.1099236900@[10.10.2.4]>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 31, 2004 at 07:35:03AM -0800, Martin J. Bligh wrote:
> I'll non-micro-benchmark stuff for you on big machines if you want, but I've 
> wasted enough time coding this stuff already ;-)
> 
> BTW, the one really useful thing the whole page zeroing stuff did was to
> shift the profiled cost of page zeroing out to the routine acutally using
> the pages, as it's no longer just do_anonymous_page taking the cache hit.

I'm not a big fan of the idle zeroing myself despite I implemented it.
The only performance difference I can measure is the microbenchmark
running 3 times faster, everything else seems the same.

However the real point of the patch is to address all other issues with
the per-cpu list and to fixup the lack of pte_quicklist in 2.6, and to
avoid wasting zeropages (like the pte_quicklists did) by sharing them
with all other page-zero users.
 
I'm fine to drop the idle zeroing stuff, it just took another half an
hour to add it so I did it just in case (it can be already disabled via
sysctl of course).

btw, how did you implement idle zeroing? had you two per-cpu lists,
where the idle zeroing only refile across the two per-cpu lists like I
did? Did you address the COW with zeropage? the design I did for it is
the only one I could imagine beneficial at all, I would never attempt
taking any spinlock on the idle task. No idea if you also were just
refiling pages across two per-cpu lists. I need two lists anyways, one
is the hot-cold one (shared to avoid wasting memory like 2.6 mainline)
and one is the zero-list that is needed to avoid the lack of
pte_quicklists and to cache the PG_zero info (it actually renders
pte_quicklists obsolete since they're less optimal at utilizing zero
resources). Plus the patch fixes other issues like trying all per-cpu
lists in the classzone before falling back to the buddy allocator. It
removes the low watermark and other minor details. The idle zeroing is
just a minor thing in the whole patch, the point of PG_zero is to create
an infrastructure in the main page allocator that is capable of caching
already zero data like ptes.

So far this in practice has been an improvement or a noop, and it solves
various theoretical issues too, but I still need to test on some bigger
box and see if it makes any difference there or not... But since it's
rock solid here, it was good enough for posting ;)
