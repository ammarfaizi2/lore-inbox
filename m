Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWIMXtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWIMXtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 19:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWIMXtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 19:49:10 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:50389 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751250AbWIMXtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 19:49:09 -0400
Date: Wed, 13 Sep 2006 16:48:58 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Alok Kataria <alok.kataria@calsoftinc.com>,
       "Shai Fultheim (Shai@scalex86.org)" <shai@scalex86.org>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "Benzi Galili (Benzi@ScaleMP.com)" <benzi@scalemp.com>
Subject: Re: [patch] slab: Do not use mempolicy for kmalloc_node
In-Reply-To: <20060913233741.GB4359@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609131641340.20799@schroedinger.engr.sgi.com>
References: <20060912144518.GA4653@localhost.localdomain>
 <Pine.LNX.4.64.0609121034290.11278@schroedinger.engr.sgi.com>
 <20060912195246.GA4039@localhost.localdomain>
 <Pine.LNX.4.64.0609121251160.12388@schroedinger.engr.sgi.com>
 <20060913221435.GA4359@localhost.localdomain>
 <Pine.LNX.4.64.0609131517370.20316@schroedinger.engr.sgi.com>
 <20060913233741.GB4359@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Ravikiran G Thirumalai wrote:

> > We only do this under certain conditions. The main purpose of this 
> > function is to allocate an object without having specified a node.
> 
> Yes, the conditions being cpuset constraints or a mempolicy being in place.
> Again, since objects can be allocated off other nodes under certain
> conditions, I thought it was good to document it...

This is only true for the CONFIG_NUMA case.

> This is the case when we are requesting an object from a non existent
> node/invalid node.  So we have 2 choices, either to spread the allocations 
> as per the cpuset constraints (the same treatment as kmalloc), or to 
> allocate from the requesting node, either ways we are not strictly 
> confirming to the user's choice of node (which we cannot).  I cannot see 
> major advantage or disadvantage either ways, so I chose to keep the policy
> in current mainline code -- spread according to the policy set.

The two cases were your patch still applied memory policies were:

1. nodeid = -1. This is one particular case that we wanted to fix because
   it means use numa_node_id().

2. The case where the nodelist does not yet exist.

AFAIK this situation only occurs on boot strap when we are actually 
attempting to allocate from a different node than what we are running on. 
Falling back to the local node is the right thing to do because we have 
that already working. A process that is running on a node must always have 
the nodelists for all caches allocated. The cpuup callbacks take care of that.

kmalloc_node needs work like page_alloc_node. page_alloc_node() never 
consults memory policies and thus one would not expect kmalloc_node to do 
so either.
