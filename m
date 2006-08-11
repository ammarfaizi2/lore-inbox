Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWHKRV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWHKRV6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932266AbWHKRV6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 13:21:58 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:63171 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932264AbWHKRV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 13:21:57 -0400
Date: Fri, 11 Aug 2006 10:21:24 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, mpm@selenic.com,
       npiggin@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Simple Slab: A slab allocator with minimal meta information
In-Reply-To: <44DB7F29.3060901@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608111014470.17885@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0608091744290.4966@schroedinger.engr.sgi.com>
 <20060810140153.e5932e76.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608092211320.5806@schroedinger.engr.sgi.com>
 <20060810144451.13591e4b.kamezawa.hiroyu@jp.fujitsu.com>
 <20060810151305.bc4602e0.kamezawa.hiroyu@jp.fujitsu.com>
 <Pine.LNX.4.64.0608100823580.8368@schroedinger.engr.sgi.com>
 <44DB7F29.3060901@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2006, Manfred Spraul wrote:

> Christoph, could you run a test? GigE routing with tiny packets should be
> sufficient. Two cpu bound nics, one does rx, the other one tx. Move the
> skb_head_cache to sslab.

You are right. The problem is that the simple slab does not do the LIFO 
thing that regular slab does. Instead it services objects from the same 
page until its empty and then it gets a new page (which is very unlikely 
to be cache hot). The cpu caches are necessary in order to effectively
handle objects that still have cachelines in the various processor 
memory caches. So at a minimum we would need a cpucache layer on top of 
simple slab.
 
I still do not get the role of the shared cache though. This from the 
early days of SMP and at that time I thought that all processors had
separate caches? Thus crossfeeding objects could not have too much of a 
benefit. On the other hand NUMA nodes cache series of cachelines when 
going on to the interconnect. The shared cache is useful to track 
the state of objects that are potentially in that cache. Reuse of those
objects would avoid additional cacheline acquisition. The same is true
for multi core. The shared caches provide a kind of state of the shared
caches. Maybe the shared caches need to be configured depending on the
underlying cache architecture?

