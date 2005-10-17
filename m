Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbVJQPkg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbVJQPkg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 11:40:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbVJQPkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 11:40:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:9943 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751322AbVJQPkf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 11:40:35 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: x86_64: 2.6.14-rc4 swiotlb broken
Date: Mon, 17 Oct 2005 17:40:56 +0200
User-Agent: KMail/1.8
Cc: Andrew Morton <akpm@osdl.org>, Ravikiran G Thirumalai <kiran@scalex86.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, tglx@linutronix.de,
       shai@scalex86.org
References: <20051017093654.GA7652@localhost.localdomain> <200510171153.56063.ak@suse.de> <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510170819290.23590@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510171740.57614.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 October 2005 17:27, Linus Torvalds wrote:
> On Mon, 17 Oct 2005, Andi Kleen wrote:
> > The patch is actually not quite correct - in theory node 0 could be too
> > small to contain the full swiotlb bounce buffers.
>
> Is node 0 guaranteed to be all low-memory? What if it allocates stuff at
> the end of memory on NODE(0)?

This is 64bit ... only low memory.

>
> Anyway, it sounds like "alloc_bootmem_low_pages()" is seriously buggered
> if it allocates non-low pages, if only because of its name...

The pages are all low, just at the wrong end of the memory.

> > The real fix would be to get rid of the pgdata lists and just walk the
> > node_online_map on bootmem.c. The memory hotplug guys have
> > a patch pending for this.
>
> Argh. Which one should I pick? The NODE(0) one looks simpler, but is it
> sufficient for now in practice (with the real one going into 2.6.14+)?
>
> 		Linus

First this problem is definitely not critical. AFAIK it only happens on 
scalex's unreleased machines. Intel NUMA x86 machines are really rare
and on AMD it doesn't happen because the swiotlb is not used there.
So just ignoring it is a quite reasonable option.

Both NODE(0) and node_online_map are risky. NODE(0) may break IA64
(they share this code) and node_online_map may break one of the weirder
ARM platforms again (for which the original revert was done)

For 2.6.14 I think it's best to ignore it and use node_online_map for 2.6.15.

-Andi 
