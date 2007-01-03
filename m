Return-Path: <linux-kernel-owner+w=401wt.eu-S1754601AbXACGXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbXACGXr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 01:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754553AbXACGXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 01:23:46 -0500
Received: from twinlark.arctic.org ([207.29.250.54]:35970 "EHLO
	twinlark.arctic.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506AbXACGXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 01:23:45 -0500
Date: Tue, 2 Jan 2007 22:23:44 -0800 (PST)
From: dean gaudet <dean@arctic.org>
To: Denis Vlasenko <vda.linux@googlemail.com>
cc: "Robert P. J. Day" <rpjday@mindspring.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <200612302340.57337.vda.linux@googlemail.com>
Message-ID: <Pine.LNX.4.64.0701022214180.5913@twinlark.arctic.org>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
 <200612302149.35752.vda.linux@googlemail.com>
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
 <200612302340.57337.vda.linux@googlemail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Dec 2006, Denis Vlasenko wrote:

> I was experimenting with SSE[2] clear_page() which uses
> non-temporal stores. That one requires 16 byte alignment.
> 
> BTW, it worked ~300% faster than memset. But Andi Kleen
> insists that cache eviction caused by NT stores will make it
> slower in macrobenchmark.
> 
> Apart from fairly extensive set of microbechmarks
> I tested kernel compiles (i.e. "real world load")
> and they are FASTER too, not slower, but Andi
> is fairly entrenched in his opinion ;)
> I gave up.

you know, with the kernel zeroing pages through the 1:1 phys mapping, and 
userland accessing pages through a different mapping... it seems that 
frequently virtual address bits 12..14 will differ between user and 
kernel.

on K8 this results in a virtual alias conflict which costs *70 cycles* per 
cache line.  (K8 L1 DC uses virtual bits 12..14 as part of the index.)  
this is larger than the cost for L1 miss L2 hit...

this wouldn't happen with movnt... but then we get into the handwaving 
arguments about timing of accesses to the freshly zeroed page.  too bad 
there's no "evict from L1 to L2" operation -- that would avoid the virtual 
alias problem.

there's an event (75h unit mask 02h) to measure virtual alias conflicts... 
i've always wondered if there are workloads which trigger this behaviour. 
it can happy on copy to/from user as well.

-dean
