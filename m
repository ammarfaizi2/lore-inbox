Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263424AbTDXEZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 00:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264427AbTDXEZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 00:25:55 -0400
Received: from franka.aracnet.com ([216.99.193.44]:25062 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263424AbTDXEZs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 00:25:48 -0400
Date: Wed, 23 Apr 2003 21:37:41 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Fix SWSUSP & !SWAP
Message-ID: <28790000.1051159060@[10.10.2.4]>
In-Reply-To: <1051152437.2453.26.camel@laptop-linux>
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
 <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
 <1051142550.4306.10.camel@laptop-linux> <1605730000.1051145146@flay>
 <1051152437.2453.26.camel@laptop-linux>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > I don't believer I've ever seen things get OOM killed. Instead, page
>> > cache is discarded until things do fit.
>> 
>> What happens if user allocated pages are filling up all the space,
>> not page cache? Trust me, it happens ;-)
> 
> Yep, just because I haven't seen it, doesn't mean a thing. :>. In that
> case, there are two issues: memory to work in to start with and how to
> save the image without corrupting it.
> 
> Regarding #1, there must still be some memory available, mustn't there?
> swsusp only approx (nrpages in use/256) pages to do its work. Surely
> we'd always be able to get .4% of the number of pages? Even if we can't
> get that many, we should be able to adjust the algorithm to be able to
> suspend a machine with only 10 or so pages available to start with (no,
> I'm not volunteering to do it! I want to merge with 2.5 and get on to
> other projects!).

Well, if you have the pre-reserved area, you just start swapping pages out
into it. If we need a few pages (like 10) to manage data structures, etc,
we can just allocate those at boot, and keep them ready.
 
> Regarding #2, my algorithm (ie not the version in 2.5 at the mo)
> separates pages to be saved into 2 types. Pageset1 are pages we expect
> to be needed during suspend. Pageset2 is those that will definitely not
> be needed. My algorithm for saving the data goes: Save pageset2 pages to
> disk then (as per the original/current method) make a copy of pageset1
> pages (using the pageset2 locations + extra allocated memory if needsbe)
> and save the copy. Loading the image is the reverse process. Pageset 2
> currently only consists of all highmem pages + active and inactive list
> pages. 

Not sure that quite works ... don't you need PTE's to know what to swap
out? Those can be in highmem. However, all user pages would fit in pageset
2, I think.

> If we refined the algorithm, perhaps that would address your
> issue. The other point here is that since we have to be able to make a
> copy of pageset1 pages, and since I haven't inlined kmap/unmap in the
> routine to copy pageset1 pages back on resume (Pavel will say whew to
> that, I'm sure!), pageset1 has a miximum size of half normal memory. I
> reckon refining the algoritm so that pageset1 can be [nearly] guaranteed
> to always be smaller is the better area to focus on, and I'm perfectly
> happy to try suggestions, particularly when they come in the form of a
> code fragment that include a call to SetPagePageset2(struct page * page)
> for the relevant targets :>

The more I think about this, the more it seems so much simpler to just
require a reserved swap area the size of your RAM to suspend into. Would
make the code so much simpler ... forget the option bit I suggested earlier
;-)

M.

