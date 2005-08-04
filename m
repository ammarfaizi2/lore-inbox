Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262764AbVHDWX4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262764AbVHDWX4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVHDWVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:21:40 -0400
Received: from graphe.net ([209.204.138.32]:40398 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262759AbVHDWT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:19:56 -0400
Date: Thu, 4 Aug 2005 15:19:52 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: NUMA policy interface
In-Reply-To: <20050804214132.GF8266@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0508041509330.10813@graphe.net>
References: <20050730191228.15b71533.pj@sgi.com> <Pine.LNX.4.62.0508011147030.5541@graphe.net>
 <20050803084849.GB10895@wotan.suse.de> <Pine.LNX.4.62.0508040704590.3319@graphe.net>
 <20050804142942.GY8266@wotan.suse.de> <Pine.LNX.4.62.0508040922110.6650@graphe.net>
 <20050804170803.GB8266@wotan.suse.de> <Pine.LNX.4.62.0508041011590.7314@graphe.net>
 <20050804211445.GE8266@wotan.suse.de> <Pine.LNX.4.62.0508041416490.10150@graphe.net>
 <20050804214132.GF8266@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005, Andi Kleen wrote:

> > There is this scan over the page table that verifies if all nodes are 
> > allocated according to the policy. That scan could easily be used to 
> > provide a map to the application (and to /proc/<pid>/smap) of where the
> 
> The application can already get it. But it's an ugly feature
> that I only used for debugging and I was actually considering
> to remove it.
> 
> Doing it for external users is a completely different thing though.
> I still think those have business in messing with other people's
> virtual addresses. In addition I expect it will cause problems
> longer term
> (did you ever look why mmap on /proc/*/mem is not allowed - it used
> to be long ago, but it was impossible to make it work race free and
> before that was always a gapping security hole) 

The proc stuff is fake anyways. I would not worry about that. The biggest 
worry is the locking mechanism to make this clean.

There are three possibilites:

1. do what cpusets is doing by versioning.

2. Have the task notifier access the task_struct information.
See http://lwn.net/Articles/145232/ "A new path to the refrigerator"

3. Maybe the easiest: Require mmap_sem to be taken for all policy 
accesses. Currently its only require for vma policies. Then we need
to make a copy of the policy at some point so that alloc_pages can
access policy information lock free. This may also allow us to fix
the bind issue if we would f.e. keep a bitmap in the taskstruct or (ab)use 
the cpusets map.

> If they cannot afford enough disk space it might be possible
> to do the page migration in swap cache like Hugh proposed.

This code already exist in the memory hotplug code base and Ray already 
had a working implementation for page migration. The migration code will 
also be necessary in order to relocate pages with ECC single bit failures 
that Russ is working on (of course that will only work for some pages) and
for Mel Gorman's defragmentation approach (if we ever get the split into 
differnet types of memory chunks in).
