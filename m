Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUEYVpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUEYVpF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265111AbUEYVpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:45:04 -0400
Received: from gate.crashing.org ([63.228.1.57]:36741 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265103AbUEYVog (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:44:36 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085521251.24948.127.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 07:40:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Oh - btw - my suggested patch was totally broken for ppc64, because that 
> "ptep_update_dirty_accessed()" thing obviously also needs to that damn 
> hpte_update() crud etc. 
> 
> BenH - I'm leaving that ppc64 code to somebody knows what the hell he is
> doing. Ie you or Anton or something. Ok? I can act as a collector the
> different architecture things for that "ptep_update_dirty_accessed()"
> function.

Well, just setting one of those 2 bits doesn't require a hash table
invalidate as long as nothing else changes.

We do dirty by mapping r/o in the hash table, and accessed on hash
faults (our clear_young triggers a flush). So just setting those bits
in the linux PTE without touching the hash table is fine, we'll just
possibly take an extra fault on the next write or access, but that
might not be much slower than going to the hash update the permissions
directly

The original problem I have with set_pte is that our current
implementation of set_pte will overwrite the entire PTE, possibly losing
the bits that indicate that there is a copy in the hash and its index in
the hash bucket. So if set_pte is called on a PTE that is present, we
must flush it properly first as we will lose track of the hash one when
overriding. hpte_update() will simply add the old PTE to a batch which
is then flushed by either the mmu gather batch end, or by a call to
flush_tlb_*  

Ben.


