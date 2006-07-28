Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161315AbWG1Vfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161315AbWG1Vfc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161313AbWG1Vfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:35:32 -0400
Received: from inbox2.nyi.net ([64.147.100.114]:38115 "HELO inbox2.nyi.net")
	by vger.kernel.org with SMTP id S1161315AbWG1Vfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:35:30 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Alok Kataria <alok.kataria@calsoftinc.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: Ravikiran G Thirumalai <kiran@scalex86.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <Pine.LNX.4.64.0607281422370.21238@schroedinger.engr.sgi.com>
References: <84144f020607272222o7b1d0270p997b8e3bf07e39e7@mail.gmail.com>
	 <1154067247.27297.104.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607280833510.18635@schroedinger.engr.sgi.com>
	 <1154117501.10196.2.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281313310.20754@schroedinger.engr.sgi.com>
	 <1154118476.10196.5.camel@localhost.localdomain>
	 <1154118947.10196.10.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281332190.20754@schroedinger.engr.sgi.com>
	 <1154119658.10196.17.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607281344410.20754@schroedinger.engr.sgi.com>
	 <20060728211227.GB3739@localhost.localdomain>
	 <Pine.LNX.4.64.0607281422370.21238@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 14:34:35 -0700
Message-Id: <1154122475.566.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 14:26 -0700, Christoph Lameter wrote:
> On Fri, 28 Jul 2006, Ravikiran G Thirumalai wrote:
> 
> > Why should there be any problem taking the remote l3 lock?  If the remote
> > node does not have cpu that does not mean we cannot take a lock from the
> > local node!!! 
> > 
> > I think current git does not teach lockdep to ignore recursion for
> > array_cache->lock when the array_cache->lock are from different cases.  As
> > Arjan pointed out, I can see that l3->list_lock is special cased, but I
> > cannot find where array_cache->lock is taken care of.
> 
> Ok.
>  
> > Again, if this is indeed a problem (recursion) machine should not boot even,
> > when compiled without lockdep, tglx, can you please verify this?
> 
> We seem to be fine on that level.
> 
> I would still like to see someone thinking through this a bit more.
> 
> Allocations via page_alloc_node() may be redirected by cpusets and 
> because nodes are low on memory. This means that we get memory on a 
> different node than we requested. How does that impact the alien lock 
> situation? 

Good point, i saw this thing occur with 2.6.17 tree (objects coming from
different node than requested), but in no ways does that affect the
correctness of the system. But i saw a marginal performance drop with
this case. 

As far as figuring out if the object is from a remote node we check the
node id from the slab, which was intialised while allocating the slab.
So the slab layer now just knows that objects in this slab are from the
slab->nodeid node, irrespective of the node from where the actual page
came. 

Thus nothing goes wrong, but we may see a little performance drop.


> In particular what happens if the off slab allocation for 
> the management object was on a different node from the slab data?

Same thing performance drop.

Thanks & Regards,
Alok

