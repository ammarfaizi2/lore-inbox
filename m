Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946294AbWJSSHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946294AbWJSSHV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946295AbWJSSHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:07:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:15794 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1946294AbWJSSHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:07:19 -0400
Date: Thu, 19 Oct 2006 11:07:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Anton Blanchard <anton@samba.org>
cc: Paul Mackerras <paulus@samba.org>, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
In-Reply-To: <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
Message-ID: <Pine.LNX.4.64.0610191057040.8873@schroedinger.engr.sgi.com>
References: <1161026409.31903.15.camel@farscape>
 <Pine.LNX.4.64.0610161221300.6908@schroedinger.engr.sgi.com>
 <1161031821.31903.28.camel@farscape> <Pine.LNX.4.64.0610161630430.8341@schroedinger.engr.sgi.com>
 <17717.50596.248553.816155@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610180811040.27096@schroedinger.engr.sgi.com>
 <17718.39522.456361.987639@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610181448250.30710@schroedinger.engr.sgi.com>
 <17719.1849.245776.4501@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.64.0610190906490.7852@schroedinger.engr.sgi.com>
 <20061019163044.GB5819@krispykreme> <Pine.LNX.4.64.0610190959560.8433@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006, Christoph Lameter wrote:

> I would expect this patch to fix your issues. This will allow fallback 
> allocations to occur in the page allocator during slab bootstrap. This 
> means your per node queues will be contaminated as they were before. After 
> the slab allocator is fully booted then the per node queues will become 
> gradually become node clean.

Forgot to mention the results of this contamination: The bootstrap process 
exercises fine control over data structures to place them in such a way 
that the slab allocator can perform optimally. F.e. data structures are 
placed in such a way on nodes that a kmalloc does not need a single off 
node reference.

The contamination will disrupt this placement. The slab believes that 
memory is from a different node than were it actually came from. As a 
result key data structures (such as cpucache descriptors) are placed 
on the wrong node. kmalloc and other slab operations may require
off node allocations for every call. Depending on the NUMA factor this may 
have a significant influence on overall system performance (We have 
measured this effect to cause a drop of 20% in AIM7 performance!).

In addition to this stuff, I am right now dealing with huge page 
fault serialization (introduced to safely support DB2) and sparsemem 
continually causing nested table lookups in fundamental vm operations. All 
work of IBM people. Not interested in performance at all?
