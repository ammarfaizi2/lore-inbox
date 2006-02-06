Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750920AbWBFKJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750920AbWBFKJy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 05:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWBFKJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 05:09:54 -0500
Received: from mail.suse.de ([195.135.220.2]:55516 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750914AbWBFKJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 05:09:53 -0500
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Date: Mon, 6 Feb 2006 11:09:44 +0100
User-Agent: KMail/1.8.2
Cc: Paul Jackson <pj@sgi.com>, akpm@osdl.org, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <20060206001959.394b33bc.pj@sgi.com> <20060206082258.GA1991@elte.hu>
In-Reply-To: <20060206082258.GA1991@elte.hu>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602061109.45788.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 February 2006 09:22, Ingo Molnar wrote:
> 
> * Paul Jackson <pj@sgi.com> wrote:
> 
> > Ingo wrote:
> > > Could you perhaps outline two actual use-cases 
> > > that would need two cpusets with different policies,
> > > on the same box?
> > 
> > We normally run with different policies, in the same box, on different 
> > cpusets at the same time.  But this might be because some cpusets 
> > -need- the memory spreading, and the others that don't are left to the 
> > default policy.
> 
> so in practice, the memory spreading is in fact a global setting, used
> by all cpusets that matter? That seems to support Andrew's observation
> that our assumptions / defaults are bad, pretty much independently of
> the workload.

Yes in general page cache and other global caches should be spread 
around all nodes by default. There was a patch to do this for the page 
cache in SLES9 for a long time, but d/icache and possibly other slab
caches have of course the same problem. For doing IO caching it doesn't matter much if 
the cache is local or not because memory access in read/write is not that
critical. But it's a big problem when one node fills up with 
IO (or dentry or inode) caches because an IO intensive process ran
on it on some time and later a process running there cannot get local
memory.

Of course there might be some corner cases where using local
memory for caching is still better (like mmap file IO), but my 
guess is that it isn't a good default. 

-Andi
