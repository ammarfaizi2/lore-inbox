Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbUEQOw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUEQOw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 10:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261498AbUEQOw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 10:52:29 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:43944 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261451AbUEQOw1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 10:52:27 -0400
Date: Mon, 17 May 2004 07:52:17 -0700
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Steven Cole <elenstev@mesatop.com>,
       Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
       adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s && s->tree' failed: The saga continues.)
Message-ID: <20040517145217.GA30695@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Steven Cole <elenstev@mesatop.com>, Andrew Morton <akpm@osdl.org>,
	William Lee Irwin III <wli@holomorphy.com>, hugh@veritas.com,
	adi@bitmover.com, scole@lanl.gov, support@bitmover.com,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200405132232.01484.elenstev@mesatop.com> <20040517022816.GA14939@work.bitmover.com> <Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org> <200405162136.24441.elenstev@mesatop.com> <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org> <20040517141427.GD29054@work.bitmover.com> <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405170717080.25502@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 17, 2004 at 07:32:44AM -0700, Linus Torvalds wrote:
> My claim (which may be bogus, but isn't), is that you wrote the file with 
> a buffered interface like stdio (or your own buffers), and that the buffer 
> size is likely a nice round number like 8kB or something. I think that's 
> what stdio uses by default.

Yup, that's what we do.

> And at some point earlier in the process you did an fflush(), or somebody
> else had written a header of n*PAGE_SIZE + 0x4ff bytes, or something like
> that. Since this was the ChangeSet file, I suspect that the "header" is 
> the checkin-comment section at the beginning, and the "second phase" is 
> the actual key list thing. You know how you write the ChangeSet file 
> better than I do.

I don't think we flush along the way but let me look.  Whoops, you're right,
we do.  Right where you thought too.  But that doesn't explain there being
3 blocks of nulls (there should NEVER be a null in the s.ChangeSet file, we
don't compress that, it's always ascii).

But the bigger problem is that you are missing the point that I mentioned
elsewhere, we are writing to a tmp file, the tmp file is NOT mmapped.
We mmap only after that file is closed and renamed.  We don't map the
tmp file.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
