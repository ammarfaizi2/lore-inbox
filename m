Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUITXY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUITXY4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 19:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUITXY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 19:24:56 -0400
Received: from holomorphy.com ([207.189.100.168]:28610 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S267380AbUITXYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 19:24:52 -0400
Date: Mon, 20 Sep 2004 16:16:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@suse.de>
Cc: Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Ray Bryant <raybry@austin.rr.com>, linux-mm <linux-mm@kvack.org>,
       Jesse Barnes <jbarnes@sgi.com>, Dan Higgins <djh@sgi.com>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Brent Casavant <bcasavan@sgi.com>, Nick Piggin <piggin@cyberone.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>, Paul Jackson <pj@sgi.com>,
       Dave Hansen <haveblue@us.ibm.com>, stevel@mwwireless.net
Subject: Re: [PATCH 2.6.9-rc2-mm1 0/2] mm: memory policy for page cache allocation
Message-ID: <20040920231626.GA9106@holomorphy.com>
References: <20040920190033.26965.64678.54625@tomahawk.engr.sgi.com> <20040920205509.GF4242@wotan.suse.de> <414F560E.7060207@sgi.com> <20040920223742.GA7899@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040920223742.GA7899@wotan.suse.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2004 at 12:37:42AM +0200, Andi Kleen wrote:
> Your counter can have the same worst case behaviour, just 
> different.  You only have to add freeing into the picture.
> Or when you consider getting more memory bandwidth from the interleaving
> (I know this is not your primary goal with this) then a sufficient
> access pattern could lead to rather uninterleaved allocation 
> in the file.
> Any allocation algorithm will have such a worst case, so I'm not
> too worried. Given ia hash function is not too bad it should
> be bearable.
> The nice advantage of the static offset is that it makes benchmarks
> actually repeatable and is completely lockless

The hash function looks like choosing the nth node whose corresponding
bit is set in node_online_map such that linear_page_index(vma, address)
(why isn't it using linear_page_index()?) mod num_online_nodes() is n,
which actually appears weak compared to various hash functions I've
seen in use for e.g. page coloring. The hash functions I've seen in use
are not tremendously more expensive than mod, and generally meant to be
computationally cheap as opposed to strong.

The kind of scheme you've employed for MPOL_INTERLEAVE is what would be
called "direct mapped" in the context of page coloring, and Ray Bryant's
would be called "bin hopping" there. A nontrivial (though not
necessarily complex or expensive) hash function mod num_online_nodes()
would be considered hashed, and the last category I see in use
elsewhere is a "best bin" algorithm, which tracks utilization of bins
(for page coloring, colors; here nodes) and chooses one of the least
utilized bins thus far.

I'd expect all 4 alternatives (and maybe even a variety of hash
functions for address hashing) to be useful in various contexts,
though I'm unaware of which kinds of apps want which algorithms most.

I don't have any idea what kind of difference the variations on the
locality domain for Bryant's bin hopping algorithm make; I'd tend to
try to make it similar to the others' precedents, but there may be
other interactions.


-- wli
