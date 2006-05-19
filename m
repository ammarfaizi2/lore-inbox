Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWESBKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWESBKs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWESBKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:10:48 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58845 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932163AbWESBKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:10:47 -0400
Date: Thu, 18 May 2006 18:10:31 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, dgc@sgi.com, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: [PATCH 01/03] Cpuset: might sleep checking zones allowed fix
In-Reply-To: <20060518175838.1c287d60.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0605181803090.22861@schroedinger.engr.sgi.com>
References: <20060518043556.15898.73616.sendpatchset@jackhammer.engr.sgi.com>
 <20060517222543.600cb20a.akpm@osdl.org> <20060518175838.1c287d60.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this is another case demonstrating that alloc_pages() behavior is 
way too complex right now. Dave, Nick and I talked about how to fix 
this a couple of days ago and what we came up with for a solution was to 
implement some sort of layering for alloc_pages(). Vaguely we thought the 
following may work:

First have a lower layer that is simply allocating a page from a zone 
without regards to the policies and cpuset constraints etc.

Second a middle layer where one must explicitly specify cpuset and policy 
constraint.

And thirdly a higher layer that obtains policies and cpuset constraints 
from the context.

Allocations can then use the proper layer for their allocations.
F.e. cpusets could use the middle and lower layer without getting into 
problems with recursion.

Preferably there would be some 3rd level policy/cpusets engine that can 
work on any lower allocator so that we could use this engine to allocate 
from unusual allocators huge pages, uncached pages and slab objects 
following the proper cpuset/policy constraints.

