Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265169AbUEYW1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUEYW1B (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEYWXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:23:39 -0400
Received: from gate.crashing.org ([63.228.1.57]:9094 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265166AbUEYWXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:23:03 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405251504170.9951@ppc970.osdl.org>
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
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251504170.9951@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085523563.15281.136.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 08:19:24 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 08:09, Linus Torvalds wrote:

> But if we don't update the hash tables, how will the TLB entry _ever_ say 
> that the page is writable? So we won't take just _one_ extra fault on the 
> next write, we'll _keep_ taking them, since the hash tables will continue 
> to claim that the page is read-only, even if the linux sw page tables say 
> it is writable.
> 
> So I think the code needs to invalidate the hash after having updated the 
> pte. No?

No, we'll take a hash fault, not a page fault. The hash fault is an asm
fast path, which in this case, will update the HPTE RW permission when
the PTE has PAGE_RW (and will set PAGE_DIRTY again, but that's fine).

Ben.


