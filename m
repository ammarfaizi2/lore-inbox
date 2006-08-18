Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWHRSUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWHRSUr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 14:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWHRSUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 14:20:47 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:25296 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751464AbWHRSUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 14:20:46 -0400
Date: Sat, 19 Aug 2006 03:19:16 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: manfred@colorfullife.com, ak@muc.de, mpm@selenic.com, marcelo@kvack.org,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au, ak@suse.de,
       dgc@sgi.com
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
Message-Id: <20060819031916.85d5979e.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
	<20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
	<20060816094358.e7006276.ak@muc.de>
	<Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
	<44E3FC4F.2090506@colorfullife.com>
	<Pine.LNX.4.64.0608172222210.29168@schroedinger.engr.sgi.com>
	<20060818161739.f7581645.kamezawa.hiroyu@jp.fujitsu.com>
	<Pine.LNX.4.64.0608180956080.31844@schroedinger.engr.sgi.com>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Aug 2006 09:58:13 -0700 (PDT)
Christoph Lameter <clameter@sgi.com> wrote:

> On Fri, 18 Aug 2006, KAMEZAWA Hiroyuki wrote:
> 
> > Just a note: with SPARSEMEM, we need more calculation and access to
> > mem_section[] table and page structs(mem_map).
> 
> Uhh, a regression against DISCONTIG. Could you address that issue?
> 
At first, ia64's DISCONTIG is special because of VIRTUAL_MEMMAP.
and ia64's SPARSEMEM is special,too. it's SPARSEMEM_EXTREME.


Considering generic arch, see include/asm-generic/memory_model.h,
which doesn't use virtual mem_map.

with FLATMEM, pfn_to_page() is  pfn + mem_map. just an address calclation.

with *usual* DISCONTIG
--  
  pgdat = NODE_DATA(pfn_to_nid(pfn));
  page = pgdat->node_mem_map + pfn - pgdat->node_start_pfn
--
if accessing to pgdat is fast, cost will not be big problem.
pfn_to_nid() is usually implemeted by calclation or table look up.

and usual SPARSEMEM, (not EXTREME)
--
page = mem_section[(pfn >> SECTION_SHIFT)].mem_map + pfn
--
need one table look up. maybe not very big.

with SPARSEMEM_EXTREME
--
page = mem_section[(pfn >> SECTION_SHIFT)][(pfn & MASK)].mem_map + pfn
--
need one (big)table look up.


-Kame

