Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268873AbUHLXjG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268873AbUHLXjG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 19:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268880AbUHLXjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 19:39:06 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:14563 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268873AbUHLXjB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 19:39:01 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] allocate page caches pages in round robin fasion
Date: Thu, 12 Aug 2004 16:38:37 -0700
User-Agent: KMail/1.6.2
Cc: steiner@sgi.com
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408121638.37416.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a NUMA machine, page cache pages should be spread out across the system 
since they're generally global in nature and can eat up whole nodes worth of 
memory otherwise.  This can end up hurting performance since jobs will have 
to make off node references for much or all of their non-file data.

The patch works by adding an alloc_page_round_robin routine that simply 
allocates on successive nodes each time its called, based on the value of a 
per-cpu variable modulo the number of nodes.  The variable is per-cpu to 
avoid cacheline contention when many cpus try to do page cache allocations at 
once.

After dd if=/dev/zero of=/tmp/bigfile bs=1G count=2 on a stock kernel:
Node 7 MemUsed:         49248 kB
Node 6 MemUsed:         42176 kB
Node 5 MemUsed:        316880 kB
Node 4 MemUsed:         36160 kB
Node 3 MemUsed:         45152 kB
Node 2 MemUsed:         50000 kB
Node 1 MemUsed:         68704 kB
Node 0 MemUsed:       2426256 kB

and after the patch:
Node 7 MemUsed:        328608 kB
Node 6 MemUsed:        319424 kB
Node 5 MemUsed:        318608 kB
Node 4 MemUsed:        321600 kB
Node 3 MemUsed:        319648 kB
Node 2 MemUsed:        327504 kB
Node 1 MemUsed:        389504 kB
Node 0 MemUsed:        744752 kB

Signed-off-by: Jesse Barnes <jbarnes@sgi.com>

Thanks,
Jesse
