Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964814AbWBFUuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964814AbWBFUuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964815AbWBFUuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:50:20 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55941 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S964814AbWBFUuT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:50:19 -0500
Date: Mon, 6 Feb 2006 12:49:59 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060206204111.GA20495@elte.hu>
Message-ID: <Pine.LNX.4.62.0602061243200.18394@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
 <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu>
 <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu>
 <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com>
 <20060206204111.GA20495@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Ingo Molnar wrote:

> it's a feature, not a weird effect! Under the VFS-driven scheme, if two 
> projects (one 'local' and one 'global') can access the same (presumably 
> big) file, then the sysadmin has to make up his mind and determine which 
> policy to use for that file. The file will either be local, or global - 
> consistently.

But that local or global allocation policy depends on what task is 
accessing the data at what time. A simple grep should not result in 
interleaving. A big application accessing the same data from multiple 
processes should have interleaving for shared data. Both may not be active 
at the same time.
 
> with the per-cpuset policy approach on the other hand it would be 
> non-deterministic which policy the file gets allocated under: whichever 
> cpuset first manages to touch that file. That is what i'd call a weird 
> and undesirable effect. This weirdness comes from the conceptual hickup 
> of attaching the object-allocation policy to the workload, not to the 
> file objects of the workload - hence conflicts can arise if two 
> workloads share file objects.

Well these weird effects are then at least expected since there was a 
cpuset set up for applications to activate this effect and the 
processes running in that cpuset will behave in the weird way we want.

The mountpoint option means that reading the contents of a file in some 
filesystems is slower than in others because some files spread their pages 
all over the system while others are node local. Again if the process is 
single threaded the node local is always the right approach. These single 
threaded processes will no longer be able to run with full pagecache 
speed. Memory will be used in other nodes that may have been reserved for 
other purposes by the user.

