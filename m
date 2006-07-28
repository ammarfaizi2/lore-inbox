Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161307AbWG1VPt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161307AbWG1VPt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 17:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161308AbWG1VPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 17:15:49 -0400
Received: from www.osadl.org ([213.239.205.134]:57004 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1161307AbWG1VPt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 17:15:49 -0400
Subject: Re: [BUG] Lockdep recursive locking in kmem_cache_free
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Christoph Lameter <clameter@sgi.com>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Arjan van de Ven <arjan@infradead.org>, alokk@calsoftinc.com
In-Reply-To: <20060728211227.GB3739@localhost.localdomain>
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
Content-Type: text/plain
Date: Fri, 28 Jul 2006 23:20:08 +0200
Message-Id: <1154121608.10196.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 14:12 -0700, Ravikiran G Thirumalai wrote:
> On Fri, Jul 28, 2006 at 01:48:33PM -0700, Christoph Lameter wrote:
> > On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> > 
> > > On Fri, 2006-07-28 at 13:36 -0700, Christoph Lameter wrote:
> > > > On Fri, 28 Jul 2006, Thomas Gleixner wrote:
> > > > 
> > > > > Let me know, if you need more info
> > > > 
> > > > What type of NUMA system is this? How many nodes? Is memory exhausted on 
> > > > some so that allocations are redirected? Are cpusets or memory policies
> > > > used to redirect allocations?
> > > 
> > > Dual dual core opteron board, only one CPU brought up. This happens
> > > during bootup, so no special settings involved.
> > 
> > One cpu with two nodes?
> > 
> > > [    0.000000] Bootmem setup node 0 0000000000000000-0000000080000000
> > > [    0.000000] Bootmem setup node 1 0000000080000000-00000000fbff0000
> > 
> > Right two nodes. We may have a special case here of one cpu having to 
> > manage remote memory. Alien cache freeing is likely screwed up in that 
> > case because we cannot have the idea of one processor local to the node 
> > doing the alien cache draining . We have to take the remote lock (no cpu 
> > dedicate to that node).
> 
> Why should there be any problem taking the remote l3 lock?  If the remote
> node does not have cpu that does not mean we cannot take a lock from the
> local node!!! 
> 
> I think current git does not teach lockdep to ignore recursion for
> array_cache->lock when the array_cache->lock are from different cases.  As
> Arjan pointed out, I can see that l3->list_lock is special cased, but I
> cannot find where array_cache->lock is taken care of.
> 
> Again, if this is indeed a problem (recursion) machine should not boot even,
> when compiled without lockdep, tglx, can you please verify this?

It boots witjh lockdep disabled, so lockdep needs some education, which
is not that easy in this case.

	tglx


