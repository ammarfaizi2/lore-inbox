Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbWDXSZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWDXSZZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 14:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDXSZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 14:25:24 -0400
Received: from ns1.siteground.net ([207.218.208.2]:33158 "EHLO
	serv01.siteground.net") by vger.kernel.org with ESMTP
	id S1751096AbWDXSZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 14:25:23 -0400
Date: Mon, 24 Apr 2006 11:26:32 -0700
From: Ravikiran G Thirumalai <kiran@scalex86.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, LaurentVivier@wanadoo.fr, sct@redhat.com,
       linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] ext3 percpu counter fixes to suppport for more than 2**31 ext3 free blocks counter
Message-ID: <20060424182632.GA4063@localhost.localdomain>
References: <1144691929.3964.53.camel@dyn9047017067.beaverton.ibm.com> <1145631546.4478.10.camel@localhost.localdomain> <20060421150943.2fdc5c4a.akpm@osdl.org> <1145900913.4820.14.camel@dyn9047017069.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145900913.4820.14.camel@dyn9047017069.beaverton.ibm.com>
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

On Mon, Apr 24, 2006 at 10:48:32AM -0700, Mingming Cao wrote:
> On Fri, 2006-04-21 at 15:09 -0700, Andrew Morton wrote:
> > >
> > I think it would be saner to explicitly specify the size of the field. 
> > That means using s32 and s64 throughout this code.
> > 
> 
> Agree. Will use s64 in this code. As s32 has the same issue with what we
> have(unsigned long) on 32 bit machine today: it is not enough for ext3
> to support more than 2**31 free blocks, and also obviously not enough
> for 64 bit ext3 that Laurent is working on.

I think Andrew's suggestion was to change global counter to s64 and local
counter to s32.  That way we avoid allocating a 64 bit local counter on 64
bit systems when we could do with a 32 bit counter. (although there is no
real space savings with current alloc_percpu ;), but hopefully that will
change in the future)

> 
> I looked at the all users of percpu counter that are currently in
> mainline(2.6.17-rc1) and in mm tree(2.6.17-rc1-mm2), they are:
> 
> 1. ext2 free blocks/inodes/dirs 
> 	(int type, to be changed to unsinged long)
> 2. ext3 free blocks/inodes/dirs 
> 	(int type, changing to unsigned long or unsigned long long)
> 3. nr_files 
> 	(currently int type)
> 4. decnet_memory allocated 
> 	(was atomic_t type in mainline, changed to percpu counter type in mm)
> 5. tcp_memory allocated 
> 	(was atomic_t type, changed to percpu counter type in mm tree)
> 
> I could be wrong, but I think there will be no effect to change the size
> of the global counter from "long" to s64 for above percpu counter users,
> except gives the counter more room to grow. Kiran, what do you think?

Agree.  Since the counters were earlier int/atomic_t, s32 on local and s64 on
global should be OK.

> Did I miss any other users of the perpcu counters? 

No, AFAIK, these are the only users as of now.

Thanks,
Kiran
