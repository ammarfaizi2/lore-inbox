Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbUDSQZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbUDSQZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 12:25:34 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34279
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261221AbUDSQZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 12:25:29 -0400
Date: Mon, 19 Apr 2004 18:25:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: slab-alignment-rework.patch in -mc
Message-ID: <20040419162533.GR29954@dualathlon.random>
References: <1082383751.6746.33.camel@f235.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082383751.6746.33.camel@f235.suse.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/mirror/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mc4/broken-out/slab-alignment-rework.patch

I don't think this is right:

> -	if (flags & SLAB_HWCACHE_ALIGN) {
> -		/* Need to adjust size so that objs are cache aligned. */
> -		/* Small obj size, can get at least two per cache line. */
> +	if (!align) {
> +		/* Default alignment: compile time specified l1 cache size.
> +		 * Except if an object is really small, then squeeze multiple
> +		 * into one cacheline.
> +		 */
> +		align = cache_line_size();
>  		while (size <= align/2)
>  			align /= 2;
> -		size = (size+align-1)&(~(align-1));
>  	}
> +	size = ALIGN(size, align);
>  

I want anon-vma to really use only 12 bytes, period. No best-guess must
be made automatically by the slab code, rounding it to 16 bytes.

this is not just for anon-vma though. For this specific case it's
absolteuly useless to throw 4 more bytes of ram at every anon-vma, it's
not hw aligned anyways so there will be false sharing anyways, so at the
very least we must try to save ram since we cannot scale the cache anyways.
Other cases for small objects are similar.

Overall I think it's definitely wrong to remove the hw alignment request
from the caller, the hw alignment must be used only where worthwhile.
for vmas and anon-vmas the hw alignment definitely isn't worthwhile and
we must not waste ram like the above patch does.

The other changes like using cache_line_size() is an _obvious_
improvement of course, I'm not commenting that part, but I'd ask to
please rewrite that patch removing the removal of the hw-alignment
parameter dictated by the kmem_cache_create caller.
