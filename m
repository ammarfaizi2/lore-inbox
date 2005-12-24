Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422638AbVLXJHX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422638AbVLXJHX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 04:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbVLXJHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 04:07:23 -0500
Received: from silver.veritas.com ([143.127.12.111]:34993 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030544AbVLXJHV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 04:07:21 -0500
Date: Sat, 24 Dec 2005 09:07:29 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: torvalds@osdl.org, michael.bishop@APPIQ.com, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au
Subject: Re: More info for DSM w/r/t sunffb on 2.6.15-rc6
In-Reply-To: <20051223.234622.14020212.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0512240828230.18398@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0512231223040.14098@g5.osdl.org>
 <20051223.154509.86780332.davem@davemloft.net>
 <Pine.LNX.4.61.0512240104440.17764@goblin.wat.veritas.com>
 <20051223.234622.14020212.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 24 Dec 2005 09:07:17.0262 (UTC) FILETIME=[7023CAE0:01C60869]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2005, David S. Miller wrote:
> From: Hugh Dickins <hugh@veritas.com>
> Date: Sat, 24 Dec 2005 01:21:07 +0000 (GMT)
> 
> > Those "prot = __pgprot(pg_iobits);" lines - any idea why they ever
> > got inserted?  I guess to add _PAGE_E in the sparc64 case, and
> > whatever the equivalent was in the earlier sparc cases?
> > Can they safely be corrected early in 2.6.16?
> 
> Corrected?  By that you mean removed?

Removed would make the source look prettier, but I assume it's
there for a reason, and should be corrected rather than removed.

I assume the reason is to add some necessary flagbits into prot;
and not to violate the permissions model by giving shared write
access to areas mapped privately.

I was wondering your estimation of the likelihood of problems if we
change sparc and sparc64 io_remap_pfn_range to respect the distinction
between shared and private, readonly and writable, early in 2.6.16,
or early in 2.6.17.

But this incident of X trying for MAP_PRIVATE (wanting that to mean
shared) before MAP_SHARED shows we cannot assume sanity around here.
Looks like we'd need to scatter VM_SHARED tests (like yours) around
various driver mmaps at the same time, to get X back to working on them.

I knew there were several drivers ignoring vm_page_prot in their calls
to (io_)remap_pfn_range; I hadn't realized that whole architectures
were doing so in low-level functions used by many.

Or is there a good argument that the shared-write/private-readonly
distinction makes no sense on anything you might apply
io_remap_pfn_range to?  That read access to the device amounts
to write access, because of side-effects?  (I know nothing of this,
I'm just trying to guess how I might be fussing unnecessarily over it.)

> We have so many hacks
> in the tree dealing with this kind of stuff.  For example,
> pgprot_noncached() as used by things like snd_pccm_lib_mmap_iomem().

pgprot_noncached looks okay to me: not pretty, but doing just what
I'd expect, adding in some necessary flagbits while respecting the
permissions.  A hack yes (a subsequent mprotect would lose the
added flagbits I think), but good enough for most.

Hugh
