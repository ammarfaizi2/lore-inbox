Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWAIEHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWAIEHS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 23:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWAIEHR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 23:07:17 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30342 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751227AbWAIEHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 23:07:16 -0500
Date: Sun, 8 Jan 2006 20:07:08 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Richter <ryan@tau.solarneutrino.net>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
Subject: Re: Fw: crash on x86_64 - mm related?
In-Reply-To: <20060109033149.GC283@tau.solarneutrino.net>
Message-ID: <Pine.LNX.4.64.0601082000450.3169@g5.osdl.org>
References: <Pine.LNX.4.64.0512121007220.15597@g5.osdl.org>
 <1134411882.9994.18.camel@mulgrave> <20051215190930.GA20156@tau.solarneutrino.net>
 <1134705703.3906.1.camel@mulgrave> <20051226234238.GA28037@tau.solarneutrino.net>
 <Pine.LNX.4.63.0512271807130.4955@kai.makisara.local>
 <20060104172727.GA320@tau.solarneutrino.net> <Pine.LNX.4.63.0601042334310.5087@kai.makisara.local>
 <20060105201249.GB1795@tau.solarneutrino.net> <Pine.LNX.4.64.0601051312380.3169@g5.osdl.org>
 <20060109033149.GC283@tau.solarneutrino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 8 Jan 2006, Ryan Richter wrote:
>
> Kernel BUG at mm/swap.c:49

Well, it sure triggered.

> Process taper (pid: 4501, threadinfo ffff8101453d8000, task ffff81017d0143c0)
> Call Trace:<ffffffff8028c614>{sgl_unmap_user_pages+124}
>		 <ffffffff8028834d>{release_buffering+27}

and it's that same sgl_unmap_user_pages() that keeps on triggering it.

Which was not what I was hoping for. I was hoping we'd see somebody _else_ 
decrementing the page count below the map count, and get a new clue.

However, the page flags you show later on (0x1c) ended up making me take 
notice of something. That's "dirty", and maybe it's from

	if (dirtied)
		SetPageDirty(page);

in that same sgl_unmap_user_pages() routine.. And it strikes me that that 
is bogus.

Code like that should use "set_page_dirty()", which does the appropriate 
callbacks to the filesystem for that page. I wonder if the bug is simply 
because the ST code just sets the dirty bit without telling anybody else 
about it...

Gaah. Hugh, Nick?

		Linus
