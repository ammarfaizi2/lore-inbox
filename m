Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267636AbSLFWVK>; Fri, 6 Dec 2002 17:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbSLFWVK>; Fri, 6 Dec 2002 17:21:10 -0500
Received: from [195.223.140.107] ([195.223.140.107]:4738 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267636AbSLFWVJ>;
	Fri, 6 Dec 2002 17:21:09 -0500
Date: Fri, 6 Dec 2002 23:28:52 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206222852.GF4335@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <20021206022853.GJ1567@dualathlon.random> <20021206024140.GL9882@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206024140.GL9882@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 06:41:40PM -0800, William Lee Irwin III wrote:
> No idea why there's not more support behind or interest in page
> clustering. It's an optimization (not required) for 64-bit/saner arches.

softpagesize sounds a good idea to try for archs with a page size < 8k
indeed, modulo a few places where the 4k pagesize is part of the
userspace abi, for that reason on x86-64 Andi recently suggested to
changed the abi to assume a bigger page size and I suggested to assume
it to be 2M and not a smaller thing as originally suggested, that way we
waste some more virtual space (not an issue on 64bit) and some cache
color (not a big deal either, those caches are multiway associative even
if not fully associative), so eventually in theory we could even switch
the page size to 2M ;)

however don't mistake softpagesize with the PAGE_CACHE_SIZE (the latter
I think was completed some time ago by Hugh). I think PAGE_CACHE_SIZE
is a broken idea (i'm talking about the PAGE_CACHE_SIZE at large, not
about the implementation that may even be fine with Hugh's patch
applied).

PAGE_CACHE_SIZE will never work well due the fragmentation problems it
introduces. So I definitely vote for dropping PAGE_CACHE_SIZE and to
experiment with a soft PAGE_SIZE, multiple of the hardware PAGE_SIZE.
That means the allocator minimal granularity will return 8k. on x86 that
breaks a bit the ABI. on x86-64 the softpagesize would breaks only the 32bit
compatibilty mode abi a little so it would be even less severe. And I
think the softpagesize should be a config option so it can be
experimented without breaking the default config even on x86.

the soft PAGE_SIZE will also decrease of an order of magnitude the page
fault rate, the number of pte will be the same but we'll cluster the pte
refills all served from the same I/O anyways (readhaead usually loads
the next pages too anyways). So it's a kind of quite obvious design
optimization to experiment with (maybe for 2.7?).

Andrea
