Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263444AbUEROix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263444AbUEROix (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263448AbUEROix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 10:38:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:17794 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263444AbUEROiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 10:38:52 -0400
Date: Tue, 18 May 2004 07:38:43 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
cc: Andrew Morton <akpm@osdl.org>, Larry McVoy <lm@bitmover.com>,
       mason@suse.com, wli@holomorphy.com, hugh@veritas.com, adi@bitmover.com,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
In-Reply-To: <200405172319.38853.elenstev@mesatop.com>
Message-ID: <Pine.LNX.4.58.0405180728510.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com> <200405172142.52780.elenstev@mesatop.com>
 <Pine.LNX.4.58.0405172056480.25502@ppc970.osdl.org> <200405172319.38853.elenstev@mesatop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 17 May 2004, Steven Cole wrote:
>
> No problems, and with PREEMPT of course.

Ok. Good. It's a small data-set, but the bug made sense, and so did the 
fix.

> > If you see a failure on ext3, please try to analyze the corruption pattern 
> > again. It might be something different.
> 
> So, I take it that I should revert that one-liner if I want to get any failure data?
> With it, ext3 was pretty solid for this testing.

Yes. That one-liner is bogus. It was a good way to test a hypothesis for
the common case of a filesystem that uses the block_write_full_page thing
(and reiser is one of the few that doesn't), but it wasn't the real fix.
The reiser patch was the real fix for the problem on reiser, but ext3
should have been ok already. It uses (through a lot of other functions)
generic_file_aio_write_nolock() as the real write engine, and that one
calls "commit_write()" with the page lock held.

		Linus
