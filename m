Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319324AbSIMDqP>; Thu, 12 Sep 2002 23:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319508AbSIMDqO>; Thu, 12 Sep 2002 23:46:14 -0400
Received: from packet.digeo.com ([12.110.80.53]:25552 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319324AbSIMDqO>;
	Thu, 12 Sep 2002 23:46:14 -0400
Message-ID: <3D81643C.4C4E862C@digeo.com>
Date: Thu, 12 Sep 2002 21:06:20 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] per-zone kswapd process
References: <3D815C8C.4050000@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Sep 2002 03:50:52.0710 (UTC) FILETIME=[C1968C60:01C25AD8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> 
> This patch implements a kswapd process for each memory zone.

I still don't see why it's per zone and not per node.  It seems strange
that a wee little laptop would be running two kswapds?

kswapd can get a ton of work done in the development VM and one per
node would, I expect, suffice?

Also, I'm wondering why the individual kernel threads don't have
their affinity masks set to make them run on the CPUs to which the
zone (or zones) are local?

Isn't it the case that with this code you could end up with a kswapd
on node 0 crunching on node 1's pages while a kswapd on node 1 crunches
on node 0's pages?

If I'm not totally out to lunch on this, I'd have thought that a
better approach would be

	int sys_kswapd(int nid)
	{
		return kernel_thread(kswapd, ...);
	}

Userspace could then set up the CPU affinity based on some topology
or config information and would then parent a kswapd instance.  That
kswapd instance would then be bound to the CPUs which were on the
node identified by `nid'.

Or something like that?
