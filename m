Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261370AbUCHWdh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 17:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUCHWdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 17:33:37 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:34313
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261370AbUCHWdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 17:33:35 -0500
Date: Mon, 8 Mar 2004 23:34:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: objrmap-core-1 (rmap removal for file mappings to avoid 4:4 in <=16G machines)
Message-ID: <20040308223415.GB12612@dualathlon.random>
References: <20040308202433.GA12612@dualathlon.random> <20040308130231.59deef80.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040308130231.59deef80.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 01:02:31PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > without this patch not even the 4:4 tlb overhead would allow intensive
> > shm (shmfs+IPC) workloads to surivive on 32bit archs. Basically without
> > this fix it's like 2.6 is running w/o pte-highmem.
> 
> yes.
> 
> > But the real reason of this work is for huge 64bit archs, so we speedup
> > and avoid to waste tons of ram.
> 
> pte_chain space consumption is approximately equal to pagetable page space
> consumption.  Sometimes a bit more, sometimes a lot less, approximately
> equal.

exactly.

> 
> So why do you say it saves "tons of ram"?

because in most high end workloads several gigabytes of ram are
allocated in the pagetables, and without this patch we would waste
another several gigabytes for rmap too (basically doubling the memory
cost of the pagetables). And several gigabytes of ram saved is "tons of
ram" in my vocabulary. I'm talking 64bit here (ignoring the fact the
several gigabytes doesn't fit anyways in the max 4G of zone-normal with
4:4)

> > on 32-ways the scalability is hurted
> > very badly by rmap, so it has to be removed (Martin can provide the
> > numbers I think).
> 
> I don't recall that the objrmap patches ever significantly affected CPU
> utilisation.

it does, the number precisely is a 30% figure slowdown in kernel compiles.

also check any readprofile in any of your boxes, rmap is at the very
top.

> I'm not saying that I'm averse to the patches, but I do suspect that this is
> a case of large highmem boxes dragging the rest of the kernel along behind
> them, and nothing else.

highmem has nothing to do with this. Saving several gigs of ram and
speedups of 30% on 32-ways are the only real reason.
