Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266915AbUG1Nqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266915AbUG1Nqx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 09:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266916AbUG1Nqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 09:46:52 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:3040 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S266915AbUG1Nqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 09:46:51 -0400
Date: Wed, 28 Jul 2004 15:46:40 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Chris Mason <mason@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: writepages drops bh on not uptodate page
Message-ID: <20040728134640.GI15895@dualathlon.random>
References: <20040728045156.GH15895@dualathlon.random> <1091019818.6333.84.camel@watt.suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1091019818.6333.84.camel@watt.suse.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2004 at 09:03:39AM -0400, Chris Mason wrote:
> Ahhhh, this really explains it, thanks andrea.  I agree your fix should
> solve things, but I'm wondering if we shouldn't make readpage[s] do a
> wait_on_page_writeback().  That might do a better job of protecting us
> from future variations of this problem.

the invariant is that not-fully-uptodate pages needs the bh on them
while they're under writeback. As far as this holds true, there seems
not to be other issues since readpage checks the bh, and readpages don't
need to check for anything since it only does I/O on newly allocated
pages (which cannot be under writeback). try_to_free_buffers doesn't
allow the bh to go away under writeback.

So the other approach would be to wait_on_page_writeback before a
->readpage (not ->readpages), if we're not in a add_to_page_cache case
(where we know the page cannot be under writeback).  But that looks less
efficient and we don't need that as long as we don't break the above
invariant. Though I certainly agree that adding the
wait_on_page_writeback in the highlevel code that goes to call readpage
would have fixed the bug too.
