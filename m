Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266838AbUJNSzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266838AbUJNSzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 14:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267254AbUJNSwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 14:52:11 -0400
Received: from danga.com ([66.150.15.140]:48297 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S266838AbUJNS34 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 14:29:56 -0400
Date: Thu, 14 Oct 2004 11:29:52 -0700 (PDT)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
In-Reply-To: <Pine.LNX.4.58.0410132255540.31327@danga.com>
Message-ID: <Pine.LNX.4.58.0410141121480.31327@danga.com>
References: <Pine.LNX.4.58.0410131204580.31327@danga.com> <416D8999.7080102@pobox.com>
 <Pine.LNX.4.58.0410131302190.31327@danga.com> <416D8C33.9080401@osdl.org>
 <Pine.LNX.4.58.0410131328400.31327@danga.com> <416D9139.1060200@osdl.org>
 <20041013232104.7e8dd97e.ak@suse.de> <Pine.LNX.4.58.0410132255540.31327@danga.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Brad Fitzpatrick wrote:

...
>
> It turns out that NUMA is the culprit and LVM has no effect on any
> configuration.  The machine has 6 memory slots.  If I have 4 sticks of
> 2GB in the machine, it makes zone 0 w/ 8GB and zone 1 disabled.  If I
> add two more 2GB sticks (total 12GB, filling all possible 6 slots),
> then I have 8GB in zone 0 and 4GB in zone 1, and then a mke2fs on a
> 280GB /dev/sdb1 works fine.
>
> In conclusion:
>
>     NUMA + 12 GB   -> works
>     NUMA + 8 GB    -> OOPS
>     no numa + 8 GB -> works
>
> And I suspect that without CONFIG_SMP, 8GB will also work, by virtue
> of there only being one NUMA zone.  I haven't tested that yet, but
> Randy referred me to these posts, where somebody with the same problem
> confirms that disabling NUMA and SMP fixes his problem:
>
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=109328505204081&w=2
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=109330259511819&w=2
>

Replying to myself, in hopes it'll benefit others.

It also works with NUMA and 8GB if I balance the memory between the two
processors, 2 sticks of 2GB on each.

Then the zones look like:

Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 00000000ffffffff
Node 1 MemBase 0000000100000000 Limit 00000001ffffffff
node 1 shift 24 addr 100000000 conflict 0
node 1 shift 25 addr 1fe000000 conflict 0
Using node hash shift of 26
Bootmem setup node 0 0000000000000000-00000000ffffffff
Bootmem setup node 1 0000000100000000-00000001ffffffff
No mptable found.
On node 0 totalpages: 1048575
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 1044479 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 1048575
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 1048575 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1


The eServer 325 manual in one place says you must add memory in
pairs, and in other places seems to suggest (but not say it's required?)
that you add memory in 1 & 2, then 5 & 6 (with SMP), and then 3 & 4.

It would've been nice if Linux either flat-out halted on boot saying,
"This is stupid, move your memory around" or ran in a degraded memory
configuration reliably without crashing.  The scary part is that the BIOS
was cool with the configuration and Linux was /mostly/ cool with it, most
of the time, until certain usage patterns (like mke2fs) made it crash.

Andi, I can still get you information, but for now I'll mark this one down
as "user error".  Perhals you'll have an idea on how to make Linux more
robust if another user winds up with this same issue, as Christopher
Swingley and I did.

- Brad


