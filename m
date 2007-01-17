Return-Path: <linux-kernel-owner+w=401wt.eu-S1750978AbXAQG1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbXAQG1u (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 01:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbXAQG1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 01:27:50 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:42462 "EHLO omx1.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751025AbXAQG1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 01:27:49 -0500
Date: Tue, 16 Jan 2007 22:27:36 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: menage@google.com, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       linux-mm@kvack.org, ak@suse.de, pj@sgi.com, dgc@sgi.com
Subject: Re: [RFC 0/8] Cpuset aware writeback
In-Reply-To: <20070116200506.d19eacf5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0701162219180.5215@schroedinger.engr.sgi.com>
References: <20070116054743.15358.77287.sendpatchset@schroedinger.engr.sgi.com>
 <20070116135325.3441f62b.akpm@osdl.org> <Pine.LNX.4.64.0701161407530.3545@schroedinger.engr.sgi.com>
 <20070116154054.e655f75c.akpm@osdl.org> <Pine.LNX.4.64.0701161602480.4263@schroedinger.engr.sgi.com>
 <20070116170734.947264f2.akpm@osdl.org> <Pine.LNX.4.64.0701161709490.4455@schroedinger.engr.sgi.com>
 <20070116183406.ed777440.akpm@osdl.org> <Pine.LNX.4.64.0701161920480.4677@schroedinger.engr.sgi.com>
 <20070116200506.d19eacf5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2007, Andrew Morton wrote:

> > Yes this is the result of the hierachical nature of cpusets which already 
> > causes issues with the scheduler. It is rather typical that cpusets are 
> > used to partition the memory and cpus. Overlappig cpusets seem to have 
> > mainly an administrative function. Paul?
> 
> The typical usage scenarios don't matter a lot: the examples I gave show
> that the core problem remains unsolved.  People can still hit the bug.

I agree the overlap issue is a problem and I hope it can be addressed 
somehow for the rare cases in which such nesting takes place.

One easy solution may be to check the dirty ratio before engaging in 
reclaim. If the dirty ratio is sufficiently high then trigger writeout via 
pdflush (we already wakeup pdflush while scanning and you already noted 
that pdflush writeout is not occurring within the context of the current 
cpuset) and pass over any dirty pages during LRU scans until some pages 
have been cleaned up.

This means we allow allocation of additional kernel memory outside of the 
cpuset while triggering writeout of inodes that have pages on the nodes 
of the cpuset. The memory directly used by the application is still 
limited. Just the temporary information needed for writeback is allocated 
outside.

Well sounds somehow still like a hack. Any other ideas out there?
