Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262975AbUB1HFn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 02:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbUB1HFm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 02:05:42 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:42412
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262975AbUB1HF2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 02:05:28 -0500
Date: Sat, 28 Feb 2004 08:05:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high end)
Message-ID: <20040228070521.GQ8834@dualathlon.random>
References: <20040227173250.GC8834@dualathlon.random> <Pine.LNX.4.44.0402271350240.1747-100000@chimarrao.boston.redhat.com> <20040227122936.4c1be1fd.akpm@osdl.org> <20040227211548.GI8834@dualathlon.random> <162060000.1077919387@flay> <20040228023236.GL8834@dualathlon.random> <20040228045713.GA388@ca-server1.us.oracle.com> <20040228061838.GO8834@dualathlon.random> <472800000.1077950719@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <472800000.1077950719@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 27, 2004 at 10:45:21PM -0800, Martin J. Bligh wrote:
> 
> > thanks for giving it a spin (btw I assume it's 2.4, that's fine for
> > a quick test, and I seem not to find the 2:2 and 1:3 options in the 2.6
> > kernel anymore ;).
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/mbligh/patches/2.6.3/2.6.3-mjb1/212-config_page_offset
> (which sits on top of the 4/4 patches, so might need some massaging to apply)

thanks for maintaining this bit too, very helpful!

> > What I probably didn't specify yet is that 2.5:1.5 is feasible too, I've
> > a fairly small and strightforward patch here from ibm that implements
> > 3.5:0.5 for PAE mode (for a completely different matter, but I mean,
> > it's not really a problem to do 2.5:1.5 either if needed, it's the same
> > as the current PAE mode 3.5:0.5).
> 
> I'm not sure it's that straightforward really - doing the non-pgd aligned
> split is messy. 2.5 might actually be much cleaner than 3.5 though, as we
> never updated the mappings of the PMD that's shared between user and kernel.
> Hmmm ... that's quite tempting.

I read the 3.5:0.5 PAE sometime last year and it was pretty
strightforward too, the only single reason I didn't merge it is that
it had the problem that it changed common code that every archs depends
on, so it broke all other archs, but it's not really a matter of
difficult code, as worse it just needs a few liner change in every arch
to make them compile again. So I'm quite optimistic 2.5:1.5 will be
doable with a reasonably clean patch and with ~zero performance downside
compared to 3:1 and 2:2.

In the meantime testing 2:2 against 4:4 (with a very/too reduced ipcshm
in the 2:2 test) still sounds very interesting.

> > starting with the assumtion that 32G machines works with 3:1 (like they
> > do in 2.4), and assuming the size of a page is 48 bytes (like in 2.4, in
> > 2.6 it's a bit bigger but we can most certainly shrink it, for example
> > removing rmap for anon pages will immediatly release 128M of kernel
> > memory), moving from 32G to 64G means losing 384M of those additional
> > 512M in pages, you can use the remaining additional 512M-384M=128M for
> > vmas, task structs, files etc...  So 2.5:1.5 should be enough as far as
> > the kernel is concerned to run on 64G machines (provided the page_t is
> > not bigger than 2.4 which sounds feasible too).
> 
> Shrinking struct page sounds nice. Did Hugh's patch actually end up doing
> that? I don't recall that, but I don't see why it wouldn't.

full objrmap can certainly release 8 bytes per page, 128M total, so
quite an huge amount of ram (that is also why I'd like to do the full
objrmap and not only to stop at the file mappings ;).
