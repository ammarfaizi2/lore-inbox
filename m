Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319521AbSIMFIB>; Fri, 13 Sep 2002 01:08:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319522AbSIMFH7>; Fri, 13 Sep 2002 01:07:59 -0400
Received: from franka.aracnet.com ([216.99.193.44]:36751 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S319521AbSIMFH5>; Fri, 13 Sep 2002 01:07:57 -0400
Date: Thu, 12 Sep 2002 22:10:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>
cc: Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, colpatch@us.ibm.com
Subject: Re: [PATCH] per-zone kswapd process
Message-ID: <617478427.1031868636@[10.10.2.3]>
In-Reply-To: <20020913045938.GG2179@holomorphy.com>
References: <20020913045938.GG2179@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Also, I'm wondering why the individual kernel threads don't have
>> their affinity masks set to make them run on the CPUs to which the
>> zone (or zones) are local?
>> Isn't it the case that with this code you could end up with a kswapd
>> on node 0 crunching on node 1's pages while a kswapd on node 1 crunches
>> on node 0's pages?
> 
> Without some architecture-neutral method of topology detection, there's
> no way to do this. A follow-up when it's there should fix it.

Every discontigmem arch should implement cpu_to_node, with a generic
fallback mechanism that returns 0 or something. Not that we do right
now, but that's easy to fix. There should also be a node_to_cpus call
that returns a bitmask of which cpus are in that node.

Matt ... want to sneak in the first bit of the topology patch, or
whatever lump this fell under? Seems like an appropriate juncture.
We have the code already somewhere, just need to fish it out.

>> If I'm not totally out to lunch on this, I'd have thought that a
>> better approach would be
>> 	int sys_kswapd(int nid)
>> 	{
>> 		return kernel_thread(kswapd, ...);
>> 	}
>> Userspace could then set up the CPU affinity based on some topology
>> or config information and would then parent a kswapd instance.  That
>> kswapd instance would then be bound to the CPUs which were on the
>> node identified by `nid'.
>> Or something like that?
> 
> I'm very very scared of handing things like that to userspace, largely
> because I don't trust userspace at all.
> 
> At this point, we need to enumerate nodes and provide a cpu to node
> correspondence to userspace, and the kernel can obey, aside from the
> question of "What do we do if we need to scan a node without a kswapd
> started yet?". I think mbligh recently got the long-needed arch code in
> for cpu to node... But I'm just not able to make the leap of faith that
> memory detection is something that can ever comfortably be given to
> userspace.

I don't think the userspace stuff is necessary - we can do this all 
in the kernel dead easily I think. Just need a couple of definitions,
which are trivially small functions.

M.

