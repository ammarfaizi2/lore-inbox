Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264022AbUDFVyp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:54:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbUDFVyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:54:45 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55454
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264022AbUDFVyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:54:43 -0400
Date: Tue, 6 Apr 2004 23:54:41 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, hugh@veritas.com, vrajesh@umich.edu,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH 1/3] radix priority search tree - objrmap complexity fix
Message-ID: <20040406215441.GK2234@dualathlon.random>
References: <20040402205410.A7194@infradead.org> <20040402203514.GR21341@dualathlon.random> <20040403094058.A13091@infradead.org> <20040403152026.GE2307@dualathlon.random> <20040403155958.GF2307@dualathlon.random> <20040403170258.GH2307@dualathlon.random> <20040405105912.A3896@infradead.org> <20040405131113.A5094@infradead.org> <20040406042222.GP2234@dualathlon.random> <20040405214330.05e4ecd7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405214330.05e4ecd7.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 09:43:30PM -0700, Andrew Morton wrote:
> It does pagebuf I/O with kmalloced memory?  Wow.  Pretty much anything
> which goes from kmalloc virtual addresses back to pageframes is a big fat
> warning sign.

it's tricky indeed, though it worked fine as far as compound was left
disabled with hugetlbfs=n.

> Do you see any reason why we shouldn't flip things around and make the
> hugetlb code explicitly request the compound page metadata when allocating
> the pages?

I definitely agree we should reverse the logic to __GFP_COMP instead of
__GFP_NO_COMP in mainline. Problem is I coudln't do it in the short term
to avoid invalidating the testing done with hugetlbfs=y. Soon I can
reverse it and add the __GFP_COMP only for the hugetlbfs big-order
dyanmic allocations that should be quick to identify.

Christoph, I got no positive feedback yet for the alternate fix you
proposed and it's not obvious to my eyes (isn't good_pages going to be
screwed with your fix?), but I wanted to checkin a fix into CVS in the
meanwhile, so for now I've checked in my __GFP_NO_COMP fix that I'm sure
doesn't require any testing since it's obviously safe and it should
definitely fix the problem. This way you can also take your time for the
testing of your better fix.

What's not clear to me about your fix is if it's really working safe
with good_pages being overdecremented (good_pages doesn't look just an
hint, there seems to be a valid reason you're doing the set_bit/test_bit
on page->private, no?).

thanks.
