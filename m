Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319516AbSIME7p>; Fri, 13 Sep 2002 00:59:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319518AbSIME7p>; Fri, 13 Sep 2002 00:59:45 -0400
Received: from holomorphy.com ([66.224.33.161]:25553 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S319516AbSIME7o>;
	Fri, 13 Sep 2002 00:59:44 -0400
Date: Thu, 12 Sep 2002 21:59:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] per-zone kswapd process
Message-ID: <20020913045938.GG2179@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Dave Hansen <haveblue@us.ibm.com>,
	"Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <3D815C8C.4050000@us.ibm.com> <3D81643C.4C4E862C@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D81643C.4C4E862C@digeo.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 09:06:20PM -0700, Andrew Morton wrote:
> I still don't see why it's per zone and not per node.  It seems strange
> that a wee little laptop would be running two kswapds?
> kswapd can get a ton of work done in the development VM and one per
> node would, I expect, suffice?

Machines without observable NUMA effects can benefit from it if it's
per-zone. It also follows that if there's more than one task doing this,
page replacement is less likely to block entirely. Last, but not least,
when I devised it, "per-zone" was the theme.


On Thu, Sep 12, 2002 at 09:06:20PM -0700, Andrew Morton wrote:
> Also, I'm wondering why the individual kernel threads don't have
> their affinity masks set to make them run on the CPUs to which the
> zone (or zones) are local?
> Isn't it the case that with this code you could end up with a kswapd
> on node 0 crunching on node 1's pages while a kswapd on node 1 crunches
> on node 0's pages?

Without some architecture-neutral method of topology detection, there's
no way to do this. A follow-up when it's there should fix it.


On Thu, Sep 12, 2002 at 09:06:20PM -0700, Andrew Morton wrote:
> If I'm not totally out to lunch on this, I'd have thought that a
> better approach would be
> 	int sys_kswapd(int nid)
> 	{
> 		return kernel_thread(kswapd, ...);
> 	}
> Userspace could then set up the CPU affinity based on some topology
> or config information and would then parent a kswapd instance.  That
> kswapd instance would then be bound to the CPUs which were on the
> node identified by `nid'.
> Or something like that?

I'm very very scared of handing things like that to userspace, largely
because I don't trust userspace at all.

At this point, we need to enumerate nodes and provide a cpu to node
correspondence to userspace, and the kernel can obey, aside from the
question of "What do we do if we need to scan a node without a kswapd
started yet?". I think mbligh recently got the long-needed arch code in
for cpu to node... But I'm just not able to make the leap of faith that
memory detection is something that can ever comfortably be given to
userspace.


Cheers,
Bill
