Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261479AbUEQOLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUEQOLP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUEQOLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:11:15 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:6824 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261479AbUEQOLM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:11:12 -0400
Date: Mon, 17 May 2004 07:11:04 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       Andrew Morton <akpm@osdl.org>, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517141104.GC29054@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
	adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
	linux-kernel@vger.kernel.org
References: <200405132232.01484.elenstev@mesatop.com> <5.1.0.14.2.20040515130250.00b84ff8@171.71.163.14> <20040514204153.0d747933.akpm@osdl.org> <200405151923.41353.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 07:42:16PM -0700, Linus Torvalds wrote:
> On Sun, 16 May 2004, Larry McVoy wrote:
> > Be aware that how BK does I/O is with write() on the way out but with 
> > mmap on the way in.  The process which forked renumber has just written
> > the file and the renumber process is reading it with mmap.
> > 
> > If there are still any problems with mixing read/write and mmap then that
> > may be a prolem but I would have expected to see things start going 
> > wrong on a page boundary and the one core dump I saw was page aligned 
> > at the tail but not at the head, it started in the middle of the page.
> 
> The kernel should have no problems with mixed read/write and mmap usage, 
> although user space obviously needs to synchronize the accesses on its own 
> some way. There is no implicit synchronization otherwise, and the mmap 
> user can see a partial write at any stage of the write.

You can strace BK and see what it does but I'll save you the trouble.
We never hold a mapping open to a file being written because we never
rewrite a file in place (that's a really bad thing for an SCM to do).
What we do is to write the file to SCCS/x.<filename> and then when it is
written we rename it to SCCS/s.<filename>.  Any process which wants to
map it is either going to get the old s.<filename> or the new s.<filename>
but there is no chance that we are extending the file while someone has it
mapped.  Famous last words and all that notwithstanding, that's my belief.

So unless I'm more dimwitted than normal we don't have any synchronization
problems by design.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
