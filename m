Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265157AbUEYWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbUEYWQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbUEYWNq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:13:46 -0400
Received: from fw.osdl.org ([65.172.181.6]:48269 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265183AbUEYWJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:09:46 -0400
Date: Tue, 25 May 2004 15:09:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <1085521251.24948.127.camel@gaston>
Message-ID: <Pine.LNX.4.58.0405251504170.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>  <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
  <1085371988.15281.38.camel@gaston>  <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
  <1085373839.14969.42.camel@gaston>  <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
  <20040525034326.GT29378@dualathlon.random>  <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
  <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> 
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>  <20040525153501.GA19465@foobazco.org>
  <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>  <20040525102547.35207879.davem@redhat.com>
  <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>  <20040525105442.2ebdc355.davem@redhat.com>
  <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org> <1085521251.24948.127.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
> 
> Well, just setting one of those 2 bits doesn't require a hash table
> invalidate as long as nothing else changes.

I'm starting to doubt this, because:

> We do dirty by mapping r/o in the hash table, and accessed on hash
> faults (our clear_young triggers a flush). So just setting those bits
> in the linux PTE without touching the hash table is fine, we'll just
> possibly take an extra fault on the next write or access, but that
> might not be much slower than going to the hash update the permissions
> directly.

But if we don't update the hash tables, how will the TLB entry _ever_ say 
that the page is writable? So we won't take just _one_ extra fault on the 
next write, we'll _keep_ taking them, since the hash tables will continue 
to claim that the page is read-only, even if the linux sw page tables say 
it is writable.

So I think the code needs to invalidate the hash after having updated the 
pte. No?

		Linus
