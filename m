Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWARCKQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWARCKQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 21:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWARCKQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 21:10:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750841AbWARCKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 21:10:14 -0500
Date: Tue, 17 Jan 2006 18:09:56 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] mm: Convert global dirty_exceeded flag to per-node
 node_dirty_exceeded
Message-Id: <20060117180956.7f2627a6.akpm@osdl.org>
In-Reply-To: <20060118012953.GC5289@localhost.localdomain>
References: <20060117020352.GB5313@localhost.localdomain>
	<20060116181323.7a5f0ac7.akpm@osdl.org>
	<20060118012953.GC5289@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
>
> On Mon, Jan 16, 2006 at 06:13:23PM -0800, Andrew Morton wrote:
> > Ravikiran G Thirumalai <kiran@scalex86.org> wrote:
> > >
> > > Convert global dirty_exceeded flag to per-node node_dirty_exceeded.
> > > 
> > > dirty_exceeded ping pongs between nodes in order to force all cpus in
> > > the system to increase the frequency of calls to balance_dirty_pages.
> > > 
> > > Currently dirty_exceeded is used by balance_dirty_pages_ratelimited to
> > > force all CPUs in the system call balance_dirty_pages often, in order to
> > > reduce the amount of dirty pages in the entire system (based on
> > > dirty_thresh and one CPU exceeding thee ratelimits).  As dirty_exceeded
> > > is a global variable, it will ping-pong between nodes of a NUMA system
> > > which is not good.
> > 
> > Did you not test this obvious little optimisation?
> 
> We ran the test we encountered this problem on with your patch.
> At first it looked like it did not help.  But later we found that there was
> false sharing on this variable.

OK.  That's a bit nasty, isn't it?  It can work well or poorly for
different people depending upon vagaries of .config and the linker.

We should find out what it was sharing _with_.  Could you please run

	nm -n vmlinux| grep -C5 dirty_exceeded


