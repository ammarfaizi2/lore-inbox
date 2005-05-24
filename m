Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261204AbVEXEha@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbVEXEha (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 00:37:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVEXEh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 00:37:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:9893 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261204AbVEXEhV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 00:37:21 -0400
Date: Tue, 24 May 2005 05:38:04 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
Subject: Re: [bugfix] try_to_unmap_cluster() passes out-of-bounds pte to
    pte_unmap()
In-Reply-To: <20050524024849.GH2057@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0505240535540.5541@goblin.wat.veritas.com>
References: <20050516021302.13bd285a.akpm@osdl.org> 
    <20050522212734.GF2057@holomorphy.com> 
    <20050523171406.483cdf69.akpm@osdl.org> 
    <20050524024849.GH2057@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-OriginalArrivalTime: 24 May 2005 04:37:20.0219 (UTC) 
    FILETIME=[458CAAB0:01C5601A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 May 2005, William Lee Irwin III wrote:
> On Mon, May 23, 2005 at 05:14:06PM -0700, Andrew Morton wrote:
> > I must say that I continue to find this approach a bit queazifying.
> > After some reading of the code I'd agree that yes, it's not possible for us
> > to get here with `pte' pointing at the first slot of the pte page, but it's
> > not 100% obvious and it's possible that someone will come along later and
> > will change things in try_to_unmap_cluster() which cause this unmap to
> > suddenly do the wrong thing in rare circumstances.
> > IOW: I'd sleep better at night if we took a temporary and actually unmapped
> > the thing which we we got back from pte_offset_map()..  Am I being silly?

There's a similar argument for queasiness in all the other (8 or more)
instances of the idiom.  I think we originally adopted (and I furthered)
this pte_unmap(pte - 1) idiom because in the majority of architecture's
configurations pte_unmap does nothing at all, so we resented assigning
a pointless variable in some critical loops.

> Not at all. I merely attempt to minimize diffsize by default. An
> alternative implementation follows (changelog etc. to be taken
> from the prior patch) in case it saves the time (however short) needed
> to write it yourself.

Either of wli's patches is fine with me.  There are several levels on
which try_to_unmap_cluster is harder to understand than the others,
and no good reason to resist the variable assignment.

We could rewrite pte_unmap to avoid the issue completely, since its
job is to unmap (or pretend to unmap) KM_PTE0's pte if the address
is in the fixmap area: but changing it to tolerate an off-by-one
address gives a queasy feeling too.

Thanks,
Hugh
