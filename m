Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUEYUbW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUEYUbW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 16:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265213AbUEYUbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 16:31:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:31164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265203AbUEYUbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 16:31:12 -0400
Date: Tue, 25 May 2004 13:30:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "David S. Miller" <davem@redhat.com>
cc: wesolows@foobazco.org, willy@debian.org, andrea@suse.de,
       benh@kernel.crashing.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       mingo@elte.hu, bcrl@kvack.org, linux-mm@kvack.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0405251319550.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
 <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
 <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525153501.GA19465@foobazco.org>
 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org> <20040525102547.35207879.davem@redhat.com>
 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org> <20040525105442.2ebdc355.davem@redhat.com>
 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 May 2004, Linus Torvalds wrote:
> 
> BenH - I'm leaving that ppc64 code to somebody knows what the hell he is
> doing. Ie you or Anton or something. Ok? I can act as a collector the
> different architecture things for that "ptep_update_dirty_accessed()"
> function.

Following up to myself.

I just committed a couple of trivial changesets that allows any 
architecture to re-define its own "ptep_update_dirty_accessed()" method.

The default one (if none is defined by the architecture) is just

	#ifndef ptep_update_dirty_accessed
	#define ptep_update_dirty_accessed(__ptep, __entry, __dirty) set_pte(__ptep, __entry)
	#endif

ie no change in behaviour. As an example of an alternate strategy, this is 
the one I committed for x86:

	#define ptep_update_dirty_accessed(__ptep, __entry, __dirty)	\
		do {							\
			if (__dirty) set_pte(__ptep, __entry);		\
		} while (0)

which is valid if the architecture updates its own accessed bits.

I just realized that for x86 the _clever_ way of doing this (for highmem
machines) is actually to only update the low word, which makes for much
better code for the PAE case (and still does exactle the same for the
non-PAE case):

	#define ptep_update_dirty_accessed(__ptep, __entry, __dirty)		\
		do {								\
			if (__dirty) (__ptep)->pte_low = (__entry).pte_low;	\
		} while (0)

but I haven't actually tested this.

Anybody willing to test the x86 PAE optimization?

In the meantime, other architectures can now fix their dirty/accessed bit
setting any way they damn well please.

			Linus
