Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWBFWK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWBFWK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 17:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWBFWK2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 17:10:28 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:13721 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932197AbWBFWK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 17:10:27 -0500
Date: Mon, 6 Feb 2006 14:10:07 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Paul Jackson <pj@sgi.com>, ak@suse.de, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
In-Reply-To: <20060206210701.GA24446@elte.hu>
Message-ID: <Pine.LNX.4.62.0602061406310.18919@schroedinger.engr.sgi.com>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
 <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com>
 <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu>
 <20060206120109.0738d6a2.pj@sgi.com> <20060206200506.GA13466@elte.hu>
 <Pine.LNX.4.62.0602061221200.18348@schroedinger.engr.sgi.com>
 <20060206204111.GA20495@elte.hu> <Pine.LNX.4.62.0602061243200.18394@schroedinger.engr.sgi.com>
 <20060206210701.GA24446@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Feb 2006, Ingo Molnar wrote:

> the grep faults in the pagecache, and depending on which job is active 
> first, the placement of the pages will either be spread out or local, 
> depending on the timing of those jobs. How do you expect this to behave 
> deterministically?

It behaves using node local allocation as expected. The determinism is 
only broken when the user sets up a cpuset. This is an unusual activity 
by the sysadmin and he will be fully aware of what is going on.

> cases i suspect what matters are project-specific data files - which 
> will be allocated deterministically because they are mostly private to 
> the cpuset. But e.g. /usr files want to be local in most cases, even for 
> a 'spread out' cpuset. Why would you want to allocate them globally?

We allocate nothing globally.

> but a single object cannot be allocated both locally and globally!  
> (well, it could be, for read-mostly workloads, but lets ignore that 
> possibility) So instead of letting chance determine it, it is the most 
> natural thing to let the object (or its container) determine which 
> strategy to use - not the workload. This avoids the ambiguity at its 
> core.

We want cpusets to make a round robin allocation within the memory 
assigned to the cpuset. There is no global allocation that I 
am aware of.

> so if two projects want to use the same file in two different ways at 
> the same time then there is no solution either under the VFS-based or 
> under the cpuset-based approach - but at least the VFS-based method is 
> fully predictable, and wont depend on which science department starts 
> its simulation job first ...

It will just reduce performance by ~20% for selected files. Surely nobody 
will notice ;-)
