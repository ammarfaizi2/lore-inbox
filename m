Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263015AbUDTOth@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263015AbUDTOth (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 10:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUDTOtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 10:49:36 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:52905
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263015AbUDTOte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 10:49:34 -0400
Date: Tue, 20 Apr 2004 16:49:37 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Manfred Spraul <manfred@colorfullife.com>, agruen@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: slab-alignment-rework.patch in -mc
Message-ID: <20040420144937.GG29954@dualathlon.random>
References: <1082383751.6746.33.camel@f235.suse.de> <20040419162533.GR29954@dualathlon.random> <4084017C.5080706@colorfullife.com> <20040420002423.469cca01.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040420002423.469cca01.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 20, 2004 at 12:24:23AM -0700, Andrew Morton wrote:
> So I do think that we should either make "align=0" translate to "pack them
> densely" or do the big sweep across all kmem_cache_create() callsites.

agreed.

> If the latter, while we're there, let's remove SLAB_HWCACHE_ALIGN where it
> isn't obviously appropriate.  I'd imagine that being able to fit more inodes
> into memory is a net win over the occasional sharing effect, for example.

One warning here, false sharing here isn' the only reason for hw
alignment, for structures like inodes or other things often are coded
packing the fields used at the same time together in the same cacheline,
this pratically can reduce the cache utilization to 1 cacheline instead
of 2 cachelines at runtime (even if there's no false sharing at all
because the structure is much bigger than the l1 size anyways).

So the hardware alignment should be removed with care looking the layout
of the structures and evaluating if we're losing cacheline packing. For
example the task_struct definitely must be fully l1 aligned, not because
of false sharing issues that are probably non existent in the task
struct anyways, but because most important fileds in the task struct
are packed to maximize the cache utilization at runtime.

For 12 bytes small things including locks like anon-vma the false
sharing is the biggest issue (but still it doesn't worth to l1 align it
in the anon-vma case), for buffer headers and task_structs the cacheline
packing provided by the l1 alignment of the structure is the primary
reason for wanting an l1 alignment. Each case should be evaluated
separately.
