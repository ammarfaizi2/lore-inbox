Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbUDTA0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbUDTA0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261979AbUDTA0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:26:03 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13450
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261887AbUDTAZ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:25:58 -0400
Date: Tue, 20 Apr 2004 02:26:02 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Gruenbacher <agruen@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
Message-ID: <20040420002602.GY29954@dualathlon.random>
References: <1082383751.6746.33.camel@f235.suse.de> <20040419162533.GR29954@dualathlon.random> <4084017C.5080706@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4084017C.5080706@colorfullife.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 06:42:36PM +0200, Manfred Spraul wrote:
> Then pass "4" as the align parameter to kmem_cache_create. That's the 
> main point of the patch: it's now possible to explicitely specify the 
> requested alignment. 32 for the 3rd level page tables, the optimal 
> number for the pte_chains, etc.
> 
> >No best-guess must
> >be made automatically by the slab code, rounding it to 16 bytes.
> >
> If you pass 0 as align to kmem_cache_create, then it's rounded to L2 
> size. It's questionable if that's really the best thing - on 
> uniprocessor, 16-byte might result is better performance - there is no 
> risk of false sharing.

my point is that 0 as align must not round to l2 size or you break
stuff. you likely have broken the vma alignment to make the most obvious
example because I don't think it's a l1 cache multiple.

Removing the HW_ALIGN bitflag isn't nearly enough to avoid breaking
stuff after your changes to the kmem_cache_create API, to avoid breaking
stuff you need to change _all_ other kmem_cache_create and replace 0
with 4 if they didn't have the HW_ALIGN parameter, you didn't do that
and things breaks, not just for small objects, but for the ones bigger
than the cachesize too.

If you fixup all other kmem_cache_create callers to pass 4 instead of 0
that could be fine with me, but I still think this removal of the
HW_ALIGN bitflag is completely worthless, you still have a branch
checking !align, so you don't seem to gain anything and you break stuff.

Note: I really appreciate the runtime evaluation of the cachesize, those
parts are fine, changing offset to "align" is also more than welcome,
only the removal of HW_ALIGN bitflag w/o s/0/4/ where HW_ALIGN was
missing is bogus and breaks stuff.
