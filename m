Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUEQOMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUEQOMo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbUEQOMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:12:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:62632 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261422AbUEQOMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:12:38 -0400
Date: Mon, 17 May 2004 07:12:31 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <20040516231120.405a0d14.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0405170706200.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com>
 <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040516231120.405a0d14.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 16 May 2004, Andrew Morton wrote:
> 
> i_size is updated in generic_commit_write(), on a per-page basis, or I'm
> missing something?  I sure hope so.

It's updated AFTER we drop the page lock. It's not enough to do it 
page-per-page, you have to do it protected by the only thing that 
block_write_full_page() sees, namely the page lock.

So what can happen is

	copy data from user space to page
	commit_write()
	unlock_page()
	**preemption happens**
			fsync
			block_write_full_page()
			doen't see the new i_size, clears the data
	**preempt back**
	update i_size.

end result: zeroes where the process wrote stuff.

> As for O_DIRECT: I need to think about that a bit more.  We hold i_sem and
> have done an fdatasync prior to entering generic_file_aio_write_nolock() so
> there should be no dirty pagecache at this stage anyway.

That just hides the race. 

> But I doubt if bk is using direct-IO in combination with MAP_SHARED...

Absolutely. I think the bug happens for the regular case, simply because 
nobody is even _using_ direct-IO. But in direct-IO, the race is about a 
million times bigger, because we won't actually update i_size until much 
much later.

		Linus
