Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422718AbWA1ABE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422718AbWA1ABE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 19:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWA1ABE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 19:01:04 -0500
Received: from ns1.siteground.net ([207.218.208.2]:51109 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1422713AbWA1ABC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 19:01:02 -0500
Date: Fri, 27 Jan 2006 16:01:00 -0800
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Andrew Morton <akpm@osdl.org>
Cc: dada1@cosmosbay.com, davem@davemloft.net, linux-kernel@vger.kernel.org,
       shai@scalex86.org, netdev@vger.kernel.org, pravins@calsoftinc.com
Subject: Re: [patch 3/4] net: Percpufy frequently used variables -- proto.sockets_allocated
Message-ID: <20060128000100.GD3565@localhost.localdomain>
References: <20060126185649.GB3651@localhost.localdomain> <20060126190357.GE3651@localhost.localdomain> <43D9DFA1.9070802@cosmosbay.com> <20060127195227.GA3565@localhost.localdomain> <20060127121602.18bc3f25.akpm@osdl.org> <20060127224433.GB3565@localhost.localdomain> <20060127150106.38b9e041.akpm@osdl.org> <20060127150847.48c312c0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127150847.48c312c0.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - serv01.siteground.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - scalex86.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 03:08:47PM -0800, Andrew Morton wrote:
> Andrew Morton <akpm@osdl.org> wrote:
> >
> > Oh, and because vm_acct_memory() is counting a singleton object, it can use
> > DEFINE_PER_CPU rather than alloc_percpu(), so it saves on a bit of kmalloc
> > overhead.
> 
> Actually, I don't think that's true.  we're allocating a sizeof(long) with
> kmalloc_node() so there shouldn't be memory wastage.

Oh yeah there is. Each dynamic per-cpu object would have been  atleast
(NR_CPUS * sizeof (void *) + num_cpus_possible * cacheline_size ).  
Now kmalloc_node will fall back on size-32 for allocation of long, so
replace the cacheline_size above with 32 -- which then means dynamic per-cpu
data are not on a cacheline boundary anymore (most modern cpus have 64byte/128 
byte cache lines) which means per-cpu data could end up false shared....

Kiran
