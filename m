Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263356AbTLDRMm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 12:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbTLDRMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 12:12:42 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60854 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263356AbTLDRMk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 12:12:40 -0500
Date: Thu, 04 Dec 2003 09:12:27 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: memory hotremove prototype, take 3
Message-ID: <2840000.1070557947@flay>
In-Reply-To: <20031204154406.7FC587007A@sv1.valinux.co.jp>
References: <20031201034155.11B387007A@sv1.valinux.co.jp><187360000.1070480461@flay><20031204035842.72C9A7007A@sv1.valinux.co.jp><152440000.1070516333@10.10.2.4> <20031204154406.7FC587007A@sv1.valinux.co.jp>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > My target is somewhat NUMA-ish and fairly large.  So I'm not sure if
>> > CONFIG_NONLINEAR fits, but CONFIG_NUMA isn't perfect either.
>> 
>> If your target is NUMA, then you really, really need CONFIG_NONLINEAR.
>> We don't support multiple pgdats per node, nor do I wish to, as it'll
>> make an unholy mess ;-). With CONFIG_NONLINEAR, the discontiguities
>> within a node are buried down further, so we have much less complexity
>> to deal with from the main VM. The abstraction also keeps the poor
>> VM engineers trying to read / write the code saner via simplicity ;-)
> 
> IIRC, memory is contiguous within a NUMA node.  I think Goto-san will
> clarify this issue when his code gets ready. :-)

Right - but then you can't use discontigmem's multiple pgdat's inside
a node to implement hotplug mem for NUMA systems.
 
> Preallocating struct page array isn't feasible for the target system
> because max memory / min memory ratio is large.
> Our plan is to use the beginning (or the end) of the memory block being
> hotplugged.  If a 2GB memory block is added, first ~20MB is used for
> the struct page array for the rest of the memory block.

Right - that makes perfect sense, it just has 2 problems:

1) You end up with a discontiguous mem_map array (fixable by adding a layer
of indirection in the wrapped macros).
2) on 32 bit, it's going to make a mess, as you need to map mem_map
inside the permanently mapped kernel area (aka ZONE_NORMAL+vmalloc space 
except in a kind of wierd cornercase I created with remap_numa_kva, 
which creates a no-man's land of permanently mapped kernel memory 
between ZONE_NORMAL and VMALLOC_RESERVE area for the remapped 
lmem_maps from the other nodes).

>> You could just lock the pages, I'd think? I don't see at a glance
>> exactly what you were using this for, but would that work?
> 
> I haven't seriously considered to implement vmalloc'd memory, but I
> guess that would be too complicated if not impossible.
> Making kernel threads or interrupt handlers block on memory access
> sound very difficult to me.

Aahh, maybe I understand now. You're saying you don't support hotplugging
ZONE_NORMAL, so you want to restrict vmalloc accesses to the non-hotplugged
areas? In which case things like HIGHPTE will be a nightmare as well ... ;-)
You also need to be very wary of where memlocked pages are allocated from.

M.

