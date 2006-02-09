Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422647AbWBIKCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422647AbWBIKCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 05:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422652AbWBIKCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 05:02:07 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2231 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1422647AbWBIKCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 05:02:05 -0500
From: Andi Kleen <ak@suse.de>
To: bharata@in.ibm.com
Subject: Re: [discuss] mmap, mbind and write to mmap'ed memory crashes 2.6.16-rc1[2] on 2 node X86_64
Date: Thu, 9 Feb 2006 10:58:26 +0100
User-Agent: KMail/1.8.2
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       Ray Bryant <raybry@mpdtxmail.amd.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org
References: <20060205163618.GB21972@in.ibm.com> <200602081706.26853.ak@suse.de> <20060209043933.GA2986@in.ibm.com>
In-Reply-To: <20060209043933.GA2986@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602091058.26811.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 February 2006 05:39, Bharata B Rao wrote:
> On Wed, Feb 08, 2006 at 05:06:26PM +0100, Andi Kleen wrote:
> > On Wednesday 08 February 2006 16:59, Christoph Lameter wrote:
> > > On Wed, 8 Feb 2006, Andi Kleen wrote:
> > > 
> > > > On Wednesday 08 February 2006 16:42, Christoph Lameter wrote:
> > > > 
> > > > > However, this has implications for policy_zone. This variable should store
> > > > > the zone that policies apply to. However, in your case this zone will vary 
> > > > > which may lead to all sorts of weird behavior even if we fix 
> > > > > bind_zonelist. To which zone does policy apply? ZONE_NORMAL or ZONE_DMA32?
> > > > 
> > > > It really needs to apply to both (currently you can't police 4GB of your 
> > > > memory on x86-64) But I haven't worked out a good design how to implement it yet.
> > > 
> > > So a provisional solution would be to simply ignore empty zones in 
> > > bind_zonelist?
> > 
> > That would likely prevent the crash yes (Bharata can you test?)
> 
> With this solution, the kernel doesn't crash, but the application does.
> 
> Shouldn't we fail mbind if we can't bind any zones ?

Really need to fix this properly to support both zones in mbind




> Does it make sense to have a separate policy_zone for each node so that we
> have atleast one(highest) zone in a node which comes under memory policy ?

That wouldn't solve the problem. The problem is that the mempolicy needs 
at least two zonelists to handle all type of allocations (that is why 
i added the concept of policy zone in the first place - to avoid the need
of multilevel zonelists in the policies)

Or maybe it's better to just don't do any policy for GFP_DMA32 
allocations and always use the highest zonelist. I guess they're somewhat
rare anyways and the policy will rarely succeed.

-Andi
