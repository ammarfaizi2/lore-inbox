Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTKYFQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 00:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTKYFQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 00:16:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:15787 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262086AbTKYFQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 00:16:47 -0500
Date: Mon, 24 Nov 2003 21:23:15 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] Make balance_dirty_pages zone aware (1/2)
Message-Id: <20031124212315.02b0bd3d.akpm@osdl.org>
In-Reply-To: <1070800000.1069736303@[10.10.2.4]>
References: <3FBEB27D.5010007@us.ibm.com>
	<20031123143627.1754a3f0.akpm@osdl.org>
	<1034580000.1069688202@[10.10.2.4]>
	<20031124100043.5416ed4c.akpm@osdl.org>
	<39670000.1069719009@flay>
	<20031124170506.4024bb30.akpm@osdl.org>
	<1070800000.1069736303@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> "dd if=/dev/zero of=foo" would trigger it, I'd think. Watching the IO
>  rate, it should go wierd after ram is full (on a 3 or more node system, 
>  so there's < 40% of RAM for each node).

Also, note that page_writeback_init() will not allow 40% of memory to be
dirtied on such a system.  it is set much lower, partly to avoid an
explosion of unreclaimable buffer_heads.

bk revtool sez:


  - Allowing 40% of physical memory to be dirtied on massive ia32 boxes
    is unreasonable.  It pins too many buffer_heads and contribues to
    page reclaim latency.
  
    The patch changes the initial value of
    /proc/sys/vm/dirty_background_ratio, dirty_async_ratio and (the
    presently non-functional) dirty_sync_ratio so that they are reduced
    when the highmem:lowmem ratio exceeds 4:1.
  
    These ratios are scaled so that as the highmem:lowmem ratio goes
    beyond 4:1, the maximum amount of allowed dirty memory ceases to
    increase.  It is clamped at the amount of memory which a 4:1 machine
    is allowed to use.
  
  - Aggressive reduction in the dirty memory threshold at which
    background writeback cuts in.  2.4 uses 30% of ZONE_NORMAL.  2.5 uses
    40% of total memory.  This patch changes it to 10% of total memory
    (if total memory <= 4G.  Even less otherwise - see above).
  
  This means that:
  
  - Much more writeback is performed by pdflush.
  
  - When the application is generating dirty data at a moderate
    rate, background writeback cuts in much earlier, so memory is
    cleaned more promptly.
  
  - Reduces the risk of user applications getting stalled by writeback.
  
  - Will damage dbench numbers.  It turns out that the damage is
    fairly small, and dbench isn't a worthwhile workload for
    optimisation.
  
  - Moderate reduction in the dirty level at which the write(2) caller
    is forced to perform writeback (throttling).  Was 40% of total
    memory.  Is now 30% of total memory (if total memory <= 4G, less
    otherwise).
  
  This is to reduce page reclaim latency, and generally because
  allowing processes to flood the machine with dirty data is a bad
  thing in mixed workloads.

