Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUEKNCU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUEKNCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 09:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264717AbUEKNCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 09:02:20 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:34442 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264705AbUEKNCF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 09:02:05 -0400
Date: Wed, 6 Oct 2004 18:28:24 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       manfred@colorfullife.com, davej@redhat.com, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: dentry bloat.
Message-ID: <20041006125824.GE2004@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20040506200027.GC26679@redhat.com> <20040506150944.126bb409.akpm@osdl.org> <409B1511.6010500@colorfullife.com> <20040508012357.3559fb6e.akpm@osdl.org> <20040508022304.17779635.akpm@osdl.org> <20040508031159.782d6a46.akpm@osdl.org> <Pine.LNX.4.58.0405081019000.3271@ppc970.osdl.org> <20040508120148.1be96d66.akpm@osdl.org> <Pine.LNX.4.58.0405081208330.3271@ppc970.osdl.org> <20040508201259.GA6383@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040508201259.GA6383@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 08, 2004 at 08:30:55PM +0000, Dipankar Sarma wrote:
> On Sat, May 08, 2004 at 12:13:09PM -0700, Linus Torvalds wrote:
> > On Sat, 8 May 2004, Andrew Morton wrote:
> > > 
> > > I think we can simply take ->d_lock a bit earlier in __d_lookup.  That will
> > > serialise against d_move(), fixing the problem which you mention, and also
> > > makes d_movecount go away.
> > 
> > If you do that, RCU basically loses most of it's meaning.
> > 
> > You'll be taking a lock for - and dirtying in the cache - every single
> > dentry on the hash chain, which is pretty much guaranteed to be slower
> > than just taking the dcache_lock _once_, even if that one jumps across 
> > CPU's a lot.
> > 
> > In other words, no, I don't think that's a good idea. We really want to
> > take the dentry lock only after we're pretty sure we have the right
> > dentry. Otherwise the dentry chains will be bouncing from CPU to CPU all
> > the time.
> 
> Exactly. Taking ->d_lock for every dentry while traversing the hash
> chain should be avoided. As such, atomic operations on that path
> are getting costly.

We can see this happening in the following numbers taken using dcachebench*
gathered on 2-way P4 Xeon 2.4MHz SMP box with 4.5GB RAM. The benchmark was run
with the following parameters and averaged over 10 runs.
./dcachebench -p 32 -b testdir

		Average	microseconds/iterations 	Std. Deviation
		(lesser is better)
2.6.6		10204					161.5
2.6.6-mm1	10571					51.5


*dcachebench is a microbenchmark written by Bill Hartner and is available at
http://www-124.ibm.com/developerworks/opensource/linuxperf/dcachebench/dcachebench.html

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044999 Fax: 91-80-25268553
T/L : 9243696
