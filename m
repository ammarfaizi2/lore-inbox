Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUIJMPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUIJMPH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 08:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267380AbUIJMPF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 08:15:05 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:38574 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267378AbUIJMOb (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 08:14:31 -0400
Date: Fri, 10 Sep 2004 13:14:15 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Nikita Danilov <nikita@clusterfs.com>
cc: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: 2.6.9-rc1: page_referenced_one() CPU consumption
In-Reply-To: <16705.34633.433179.600565@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.44.0409101304570.16614-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Nikita Danilov wrote:
> 
> in 2.6.9-rc1 page_referenced_one() is among top CPU consumers (which
> wasn't a case for 2.6.8-rc2) in the host kernel when running heavily
> loaded UML. readprofile -b shows that time is spent in
> spin_lock(&mm->page_table_lock), so, I reckon, recent "rmaplock: kill
> page_map_lock" changes are probably not completely unrelated.
> 
> Without any deep investigation, one possible scenario is that multiple
> threads are doing (as part of direct reclaim),
> 
>    refill_inactive_zone()
>        page_referenced()
>            page_referenced_file() /* (1) mapping->i_mmap_lock doesn't
>                                      serialize them */
>                page_referenced_one()
>                    spin_lock(&mm->page_table_lock) /* (2) everybody is
>                                                      serialized here */
> 
> (1) and (2) will be true if we have one huge address space with a lot of
> VMAs, which seems to be exactly what UML does:
> 
> $ wc /proc/<UML-host-pid>/maps
> 4134 28931 561916
> 
> This didn't happen before, because page_referenced_one() used to
> try-lock.

I'd be very surprised if you're wrong.

I remarked on that in the ChangeLog comment: "Though I suppose
it's possible that we'll find that vmscan makes better progress with
trylocks than spinning - we're free to choose trylocks again if so."

I'm quite content to go back to a trylock in page_referenced_one - and
in try_to_unmap_one?  But yours is the first report of an issue there,
so I'm inclined to wait for more reports (which should come flooding in
now you mention it!), and input from those with a better grasp than I
of how vmscan pans out in practice (Andrew, Nick, Con spring to mind).

Hugh

