Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWGGXSh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWGGXSh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 19:18:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932381AbWGGXSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 19:18:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:61647 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932379AbWGGXSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 19:18:36 -0400
Date: Fri, 7 Jul 2006 16:18:10 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Hugh Dickins <hugh@veritas.com>,
       Christoph Hellwig <hch@infradead.org>, Con Kolivas <kernel@kolivas.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Message-Id: <20060707231810.3790.19313.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 00/11] Reduce MAX_NR_ZONES V1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep seeing zones on various platforms that are never used and wonder
why we compile support for them into the kernel. Counters show up for HIGHMEM
and DMA32 that are alway zero.

This patch allows the removal of ZONE_DMA32 for non x86_64 architectures
and it will get rid of ZONE_HIGHMEM for arches not using highmem
(like 64 bit architectures). If an arch does not define CONFIG_HIGHMEM
then ZONE_HIGHMEM will not be defined. Similarly if an arch does not
define CONFIG_ZONE_DMA32 then ZONE_DMA32 will not be defined.

No current architecture uses all the 4 zones (DMA,DMA32,NORMAL,HIGH) that we
have now. The patchset will reduce the number of zones for all platforms.

On many platforms that do not have DMA32 or HIGHMEM this will reduce the number
of zones by 50%. F.e. ia64 only uses DMA and NORMAL.

Large amounts of memory can be saved for larger systemss that may have a
few hundred NUMA nodes.

With ZONE_DMA32 and ZONE_HIGHMEM support optional MAX_NR_ZONES will be 2 for
many non i386 platforms and even for i386 without CONFIG_HIGHMEM set.

Tested on ia64, x86_64 and on i386 with and without highmem.

The patchset consists of 11 patches that are following this message.

One could go even further than this patchset and also make ZONE_DMA optional
because some platforms do not need a separate DMA zone and can do DMA to all
of memory. This could reduce MAX_NR_ZONES to 1. Such a patchset will hopefully follow
soon.

RFC->V1
- Macro cleanup
- Code cleanup
- Modify GFP_ZONETYPES according to the number of zones.
- Fix up i386 NUMA SRAT compile
- Get rid of CONFIG_DMA_IS_DMA32 etc.
- Resequence the patch so that the cleanup patches are first.
- Remove invalid refernce to HIGHMEM in swap prefetch
- Test and debug on i386

