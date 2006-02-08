Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161094AbWBHQUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161094AbWBHQUf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 11:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161095AbWBHQUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 11:20:35 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:8336 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161094AbWBHQUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 11:20:34 -0500
Date: Wed, 8 Feb 2006 08:20:20 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Bharata B Rao <bharata@in.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes
 2.6.16-rc1[2] on 2 node X86_64
In-Reply-To: <200602081706.26853.ak@suse.de>
Message-ID: <Pine.LNX.4.62.0602080816560.2289@schroedinger.engr.sgi.com>
References: <20060205163618.GB21972@in.ibm.com> <200602081645.24733.ak@suse.de>
 <Pine.LNX.4.62.0602080755500.908@schroedinger.engr.sgi.com>
 <200602081706.26853.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006, Andi Kleen wrote:

> > So a provisional solution would be to simply ignore empty zones in 
> > bind_zonelist?
> 
> That would likely prevent the crash yes (Bharata can you test?)
> 
> But of course it still has the problem of a lot of memory being unpolicied
> on machines with >4GB if there's both DMA32 and NORMAL.

The fix could result in a zonelist with no zones. So we can answer one 
question in __alloc_pages().

Index: linux-2.6.16-rc2/mm/page_alloc.c
===================================================================
--- linux-2.6.16-rc2.orig/mm/page_alloc.c	2006-02-08 00:05:09.000000000 -0800
+++ linux-2.6.16-rc2/mm/page_alloc.c	2006-02-08 08:18:59.000000000 -0800
@@ -913,7 +913,7 @@ restart:
 	z = zonelist->zones;  /* the list of zones suitable for gfp_mask */
 
 	if (unlikely(*z == NULL)) {
-		/* Should this ever happen?? */
+		/* May occur if MPOL_BIND results in an empty zonelist */
 		return NULL;
 	}
 
