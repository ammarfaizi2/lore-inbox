Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030228AbVLFUhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030228AbVLFUhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030227AbVLFUhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:37:40 -0500
Received: from alfie.demon.co.uk ([80.177.172.67]:58124 "EHLO
	alfie.demon.co.uk") by vger.kernel.org with ESMTP id S1030228AbVLFUhj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:37:39 -0500
Date: Tue, 6 Dec 2005 20:35:02 +0000
From: Nick Holloway <Nick.Holloway@pyrites.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.15-rc4 1/1] cpia: use vm_insert_page() instead of remap_pfn_range()
Message-ID: <20051206203502.GA7591@pyrites.org.uk>
References: <20051205152758.GA29108@pyrites.org.uk> <Pine.LNX.4.61.0512061801220.26899@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0512061801220.26899@goblin.wat.veritas.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 06:31:26PM +0000, Hugh Dickins wrote:
> On Mon, 5 Dec 2005, Nick Holloway wrote:
> > Although the cpia driver functioned correctly after printing out the
> > "incomplete pfn remapping" message, I thought I would have a go at the
> > trivial conversion'' as I have access to the hardware.
> 
> A couple of minor points which you may reasonably feel go beyond
> what you were attempting:
> 
> rvfree becomes totally pointless (since vfree checks for NULL itself),
> so it would be better to delete rvfree and replace the rvfree calls
> by vfree calls (removing the size argument).

I could see that would be the next step in the cleanup, but I wanted to
perform the minumum changes, so it was clear what I had done.

> pos would be better off as a u8* matching frame_buf, than an unsigned
> long that has to be cast this way and that.

I agree.  I couldn't see any logical reason for dealing with it as
"unsigned long", and wondered about switching to "void*".  On the other
hand, the machine this was being tested on was remote, and the scope
for a bad change that locked up would have halted development.

> And a third point which makes me hesitate.  It used to set PAGE_SHARED
> (read-write access) on all the page table entries, whether the mmap
> was MAP_PRIVATE or MAP_SHARED, PROT_WRITE or not.  That was wrong, and
> Linus intentionally does not permit that mistake with vm_insert_page.
> 
> And the change _probably_ causes no trouble for anyone; but it _might_
> cause trouble somewhere: it could be that userspace needs correcting
> (to ask for shared write access where it wasn't asking before).
> I've no idea whether write access makes sense with this driver.

I did wonder about that too.  The application I tested with does:

    mmap(..., PROT_READ|PROT_WRITE, MAP_SHARED, ... );

This seems to be a common incantation for video4linux clients.  It would
also seem to be the wrong thing for the mmap to not be MAP_SHARED.

> So personally I'm rather reluctant to recommend a change of this kind
> late in a release cycle (and I'd prefer that you didn't have to endure
> the noisy warnings at this stage too, but Linus put them in,
> so I think he wants them to stay).

I'm not concerned with the warnings -- I just fancied a quick kernel hack,
and had the hardware to test.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
