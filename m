Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTDXDKI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 23:10:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264240AbTDXDKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 23:10:07 -0400
Received: from smtp2.clear.net.nz ([203.97.37.27]:55469 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263628AbTDXDKG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 23:10:06 -0400
Date: Thu, 24 Apr 2003 15:17:26 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Fix SWSUSP & !SWAP
In-reply-to: <1605730000.1051145146@flay>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Grover, Andrew" <andrew.grover@intel.com>,
       Marc Giger <gigerstyle@gmx.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-id: <1051152437.2453.26.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <F760B14C9561B941B89469F59BA3A847E96E0E@orsmsx401.jf.intel.com>
 <20030424000344.GC32577@atrey.karlin.mff.cuni.cz>
 <1051142550.4306.10.camel@laptop-linux> <1605730000.1051145146@flay>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-24 at 12:45, Martin J. Bligh wrote:
> > I don't believer I've ever seen things get OOM killed. Instead, page
> > cache is discarded until things do fit.
> 
> What happens if user allocated pages are filling up all the space,
> not page cache? Trust me, it happens ;-)

Yep, just because I haven't seen it, doesn't mean a thing. :>. In that
case, there are two issues: memory to work in to start with and how to
save the image without corrupting it.

Regarding #1, there must still be some memory available, mustn't there?
swsusp only approx (nrpages in use/256) pages to do its work. Surely
we'd always be able to get .4% of the number of pages? Even if we can't
get that many, we should be able to adjust the algorithm to be able to
suspend a machine with only 10 or so pages available to start with (no,
I'm not volunteering to do it! I want to merge with 2.5 and get on to
other projects!).

Regarding #2, my algorithm (ie not the version in 2.5 at the mo)
separates pages to be saved into 2 types. Pageset1 are pages we expect
to be needed during suspend. Pageset2 is those that will definitely not
be needed. My algorithm for saving the data goes: Save pageset2 pages to
disk then (as per the original/current method) make a copy of pageset1
pages (using the pageset2 locations + extra allocated memory if needsbe)
and save the copy. Loading the image is the reverse process. Pageset 2
currently only consists of all highmem pages + active and inactive list
pages. If we refined the algorithm, perhaps that would address your
issue. The other point here is that since we have to be able to make a
copy of pageset1 pages, and since I haven't inlined kmap/unmap in the
routine to copy pageset1 pages back on resume (Pavel will say whew to
that, I'm sure!), pageset1 has a miximum size of half normal memory. I
reckon refining the algoritm so that pageset1 can be [nearly] guaranteed
to always be smaller is the better area to focus on, and I'm perfectly
happy to try suggestions, particularly when they come in the form of a
code fragment that include a call to SetPagePageset2(struct page * page)
for the relevant targets :>

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Be diligent to present yourself approved to God as a workman who does
not need to be ashamed, handling accurately the word of truth.
	-- 2 Timothy 2:14, NASB.

