Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267197AbSLEC4k>; Wed, 4 Dec 2002 21:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267200AbSLEC4k>; Wed, 4 Dec 2002 21:56:40 -0500
Received: from h-64-105-35-8.SNVACAID.covad.net ([64.105.35.8]:61845 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S267197AbSLEC4j>; Wed, 4 Dec 2002 21:56:39 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Wed, 4 Dec 2002 19:02:18 -0800
Message-Id: <200212050302.TAA03366@adam.yggdrasil.com>
To: david@gibson.dropbear.id.au
Subject: Re: [RFC] generic device DMA implementation
Cc: davem@redhat.com, James.Bottomley@steeleye.com, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, miles@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Dec 04, 2002 at 07:44:17PM -0600, James Bottomley wrote:
>> david@gibson.dropbear.id.au said:
>> > Do you have an example of where the second option is useful?  Off hand
>> > the only places I can think of where you'd use a consistent_alloc()
>> > rather than map_single() and friends is in cases where the hardware's
>> > behaviour means you absolutely positively have to have consistent
>> > memory. 
>> 
>> Well, it comes from parisc drivers.  Here you'd really rather have
>> consistent memory because it's more efficient, but on certain
>> platforms it's just not possible.

>Hmm... that doesn't seem sufficient to explain it.

	The question is not what is possible, but what is optimal.

	Yes, it is possible to write drivers for machines without
consistent memory that work with any DMA device, by using
dma_{map,sync}_single as you suggest, even if caching could be
disabled.  That is how drivers/scsi/53c700.c and
drivers/net/lasi_82596.c work today.

	The advantages of James's approach is that it will result in
these drivers having simpler source code and even smaller object code
on machines that do not have this problem.

	If were to try the approach of using pci_{map,sync}_single
always (i.e., just writing the code not to use alloc_consistent), that
would have a performance cost on machines where using consistent
memory for writing small amounts of data is cheaper than the cost of
the cache flushes that would otherwise be required.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


