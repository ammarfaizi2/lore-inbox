Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265144AbUEYWQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265144AbUEYWQz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUEYWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:13:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:55941 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265131AbUEYWJP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:09:15 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
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
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085522735.14969.130.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 08:05:36 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-05-26 at 07:54, Linus Torvalds wrote:
> On Wed, 26 May 2004, Benjamin Herrenschmidt wrote:
> > 
> > Well, just setting one of those 2 bits doesn't require a hash table
> > invalidate as long as nothing else changes.
> 
> Ok. And nothing ever writes to the SW page tables outside the page table 
> lock, right? So on ppc64, we could just do
> 
> 	#define ptep_update_dirty_accessed(ptep, entry, dirty) \
> 		*(ptep) = (entry)
> 
> and be done with it. No?
> 
> I'm not going to do it without a big ack from you.

No. The hash fault path will update the PTE dirty/accessed on a hash miss
exception without holding the page table lock (acts a bit like a HW TLB
as far as linux is concerned). That's why it needs to be atomic.

Ben.


