Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267668AbUIOWNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267668AbUIOWNb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 18:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267666AbUIOWMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:12:14 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:61360 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S267679AbUIOWBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:01:17 -0400
Date: Wed, 15 Sep 2004 23:58:10 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       an.li.wang@intel.com
Subject: Re: truncate shows non zero data beyond the end of the inode with MAP_SHARED
Message-ID: <20040915215810.GD15426@dualathlon.random>
References: <20040915122920.GA4454@dualathlon.random> <20040915210106.GX9106@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915210106.GX9106@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:01:06PM -0700, William Lee Irwin III wrote:
> Zeroing the final partial page during expanding truncate (flushing TLB)
> sounds like a reasonable half measure; we don't do anything at the moment.

I was only investingating solutions that would guarantee to never write
non-zero data on-disk in the last partial block of the inode, and in
turn solutions that would never trigger suprious I/O on disk.

Your suggestion is the other way around, that is we keep writing
non-zero in the half block, but exactly because of that, your "Zeroing
the final partial page", will have to mark the page dirty after that
(and probably trigger a COW if it was a MAP_PRIVATE).  Which means
_I/O_. So I think it'd be worse than my solution I suggested that
doesn't risk to write anything zero beyond the end of the file, and that
guarantees no suprious I/O will ever happen. IMHO I/O can be a lot more
costly than a double objrmap-driven pagetable walk + tlb flush.

However even doing the double pagetable walk + tlbflush around
writepages of partial pages, isn't nice at all. So I'm not sure if we've
to fix this at all.

I understood from Alan we probably shouldn't care to be posix compliant
(he nicely pointed out we're already SuSv3 compliant, which sounds good
enough) and we can keep going fast.
