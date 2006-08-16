Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWHPVuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWHPVuV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 17:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWHPVuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 17:50:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:978 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932264AbWHPVuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 17:50:20 -0400
Date: Wed, 16 Aug 2006 14:49:57 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: mpm@selenic.com, Marcelo Tosatti <marcelo@kvack.org>,
       linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Andi Kleen <ak@suse.de>, Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 0/7] A modular slab allocator V1
In-Reply-To: <44E344A8.1040804@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608161427500.18621@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <44E344A8.1040804@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006, Manfred Spraul wrote:

> Which .config settings are necessary? I tried to use it (uniprocessor, no
> debug options enabled), but the compilation failed. 2.6.18-rc4 kernel. All 7
> patches applied.

I only build it on IA64. Never tested it on another arch. What error 
messages are you getting?

> And: Are you sure that the slabifier works on vmalloc ranges? The code uses
> virt_to_page(). Does that function work for vmalloc on all archs?

Hmm.... Not tried it just got minimal things going to have some numnbers. 
You are right. A real virtual address to page translation for 
vmalloc would involve going through the page tables. Seems that 
virt_to_page that is used in get_object_page() does not do that.

In order to get vmalloc working we would need first to check the
address. If its in the vmalloc range then walk the page table and get
the struct page address that way. There is a function

vmalloc_to_page()

in mm/memory.c that would do that for us. 

So we need to modify get_object_page() to check for a VMALLOC range
and then use vmalloc_to_page instead of virt_to_page.

