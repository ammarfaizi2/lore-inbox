Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932768AbVITObM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768AbVITObM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932766AbVITObL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 10:31:11 -0400
Received: from noname.neutralserver.com ([70.84.186.210]:28278 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932764AbVITObK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 10:31:10 -0400
Date: Tue, 20 Sep 2005 17:34:26 +0300
From: Dan Aloni <da-x@monatomic.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org
Subject: Re: workaround large MTU and N-order allocation failures
Message-ID: <20050920143426.GB26617@localdomain>
References: <20050918143526.GA24181@localdomain> <1127111462.5272.7.camel@npiggin-nld.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127111462.5272.7.camel@npiggin-nld.site>
User-Agent: Mutt/1.5.10i
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2005 at 04:31:02PM +1000, Nick Piggin wrote:
> On Sun, 2005-09-18 at 17:35 +0300, Dan Aloni wrote:
> > Hello,
> > 
> > Is there currently a workaround available for handling large MTU 
> > (larger than 1 page, even 2-order) in the Linux network stack?
> > 
> > The problem with large MTU is external memory fragmentation in
> > the buddy system following high workload, causing alloc_skb() to 
> > fail.
> > 
> > I'm interested in patches for both 2.4 and 2.6 kernels.
> > 
> 
> Yes there is currently a workaround. That is to keep increasing
> /proc/sys/vm/min_free_kbytes until your allocation failures stop.

We have developed a much more reliable workaround which works on both
the 2.4 and 2.6 trees. 

Our development is called 'Pre-allocated Big Buffers', basically prebb 
provides fixed-sized pools of fixed-size blocks that are allocated during
boot time using the bootmem allocator (thus are disconnected from the 
slab cache completely). block size need not to be page aligned. It is 
possible to allocate these blocks at O(1) efficiency at any context.

Each pool has a minimum and maximum object size (where allocations 
should strive to be the maximum for memory usage efficiency). Currently 
we use prebb to ensure no fragmentation and fine-tuned memory usage.

(Of course a few changes inside net/core/skbuff.c were needed for 
skb buffers to allocate from prebb instead of slab).

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net
