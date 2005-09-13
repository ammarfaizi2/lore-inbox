Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbVIMSxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbVIMSxz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 14:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964983AbVIMSxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 14:53:54 -0400
Received: from serv01.siteground.net ([70.85.91.68]:47580 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S964979AbVIMSxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 14:53:53 -0400
Date: Tue, 13 Sep 2005 11:53:48 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       dipankar@in.ibm.com, bharata@in.ibm.com, shai@scalex86.org,
       Rusty Russell <rusty@rustcorp.com.au>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: [patch 7/11] net: Use bigrefs for net_device.refcount
Message-ID: <20050913185348.GA3724@localhost.localdomain>
References: <20050913155112.GB3570@localhost.localdomain> <20050913161012.GI3570@localhost.localdomain> <43271A28.9090301@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43271A28.9090301@cosmosbay.com>
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

On Tue, Sep 13, 2005 at 08:27:52PM +0200, Eric Dumazet wrote:
> Ravikiran G Thirumalai a écrit :
> 
> Hum...
> 
> Did you tried to place refcnt/netdev_refcnt in a separate cache line than 
> queue_lock ? I got good results too...
> 
> >  	/* device queue lock */
> >  	spinlock_t		queue_lock;
> >  	/* Number of references to this device */
> > -	atomic_t		refcnt;
> > +	struct bigref	        netdev_refcnt ____cacheline_aligned_in_smp ; 
> >  	/* delayed register/unregister */
> >  	struct list_head	todo_list;
> >  	/* device name hash chain */
> 
> Every time a cpu take the queue_lock spinlock, it exclusively gets one 
> cache line. If another cpu try to access netdev_refcnt, it has to grab this 
> cache line (even if properely per_cpu designed, there is still one shared 
> field). In fact the whole struct net_device should be re-ordered for 
> SMP/NUMA performance.

I agree. Maybe placing the queue_lock in a different cacheline is the 
right approach?

Thanks,
Kiran
