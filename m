Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269975AbUJNGHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269975AbUJNGHT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 02:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269976AbUJNGHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 02:07:19 -0400
Received: from danga.com ([66.150.15.140]:55961 "EHLO danga.com")
	by vger.kernel.org with ESMTP id S269975AbUJNGHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 02:07:15 -0400
Date: Wed, 13 Oct 2004 23:07:14 -0700 (PDT)
From: Brad Fitzpatrick <brad@danga.com>
X-X-Sender: bradfitz@danga.com
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OOPS] 2.6.9-rc4, dual Opteron, NUMA, 8GB
In-Reply-To: <20041013232104.7e8dd97e.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0410132255540.31327@danga.com>
References: <Pine.LNX.4.58.0410131204580.31327@danga.com> <416D8999.7080102@pobox.com>
 <Pine.LNX.4.58.0410131302190.31327@danga.com> <416D8C33.9080401@osdl.org>
 <Pine.LNX.4.58.0410131328400.31327@danga.com> <416D9139.1060200@osdl.org>
 <20041013232104.7e8dd97e.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Oct 2004, Andi Kleen wrote:

> On Wed, 13 Oct 2004 13:34:01 -0700 "Randy.Dunlap" <rddunlap@osdl.org> wrote:
> >
> > > Who's responsible for the K8_NUMA stuff?  I'd love to work with them to
> > > narrow this down.
> >
> > Andi Kleen (SUSE).  Copied.
>
> It looks like memory corruption somewhere. I suspect not directly related to NUMA,
> but the different memory layout with NUMA may trigger it.
>
> I would enable CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC and see if that
> triggers it elsewhere.
>
> First suspection would be the device driver. Perhaps you can test it with
> a different block device?
>
> -Andi

Andi,

CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC show no corruption.

It turns out that NUMA is the culprit and LVM has no effect on any
configuration.  The machine has 6 memory slots.  If I have 4 sticks of
2GB in the machine, it makes zone 0 w/ 8GB and zone 1 disabled.  If I
add two more 2GB sticks (total 12GB, filling all possible 6 slots),
then I have 8GB in zone 0 and 4GB in zone 1, and then a mke2fs on a
280GB /dev/sdb1 works fine.

In conclusion:

    NUMA + 12 GB   -> works
    NUMA + 8 GB    -> OOPS
    no numa + 8 GB -> works

And I suspect that without CONFIG_SMP, 8GB will also work, by virtue
of there only being one NUMA zone.  I haven't tested that yet, but
Randy referred me to these posts, where somebody with the same problem
confirms that disabling NUMA and SMP fixes his problem:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=109328505204081&w=2
   http://marc.theaimsgroup.com/?l=linux-kernel&m=109330259511819&w=2

When I boot NUMA w/ 12GB, I get:

Scanning NUMA topology in Northbridge 24
Number of nodes 2 (10010)
Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Node 1 MemBase 0000000200000000 Limit 00000002ffffffff
node 1 shift 24 addr 200000000 conflict 0
node 1 shift 25 addr 200000000 conflict 0
Using node hash shift of 26
Bootmem setup node 0 0000000000000000-00000001ffffffff
Bootmem setup node 1 0000000200000000-00000002ffffffff
No mptable found.
On node 0 totalpages: 2097151
  DMA zone: 4096 pages, LIFO batch:1
  Normal zone: 2093055 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1
On node 1 totalpages: 1048575
  DMA zone: 0 pages, LIFO batch:1
  Normal zone: 1048575 pages, LIFO batch:16
  HighMem zone: 0 pages, LIFO batch:1


When I boot NUMA w/ 8GB, k8topology.c prints out:

...
Node 0 MemBase 0000000000000000 Limit 00000001ffffffff
Skipping disabled node 1
...

I can get you the full dmesg of both configs tomorrow.

Anything else you'd like to see?

- Brad
