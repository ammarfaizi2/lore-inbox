Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTFDKYl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 06:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTFDKYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 06:24:41 -0400
Received: from ns.suse.de ([213.95.15.193]:47364 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262569AbTFDKYj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 06:24:39 -0400
Date: Wed, 4 Jun 2003 12:38:08 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Always passing mm and vma down (was: [RFC][PATCH] Convert do_no_page() to a hook to avoid DFS race)
Message-ID: <20030604103808.GP3412@x30.school.suse.de>
References: <20030530164150.A26766@us.ibm.com> <20030531104617.J672@nightmaster.csn.tu-chemnitz.de> <20030531234816.GB1408@us.ibm.com> <20030601122200.GB1455@x30.local> <20030601200056.GA1471@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030601200056.GA1471@us.ibm.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 01, 2003 at 01:00:56PM -0700, Paul E. McKenney wrote:
> The immediate motivation is to avoid the race with zap_page_range()
> when another node writes to the corresponding portion of the file,
> similar to the situation with vmtruncate().  The thought was to
> leverage locking within the distributed filesystem, but if the
> race is solved locally, then, as you say, perhaps this is not 
> necessary.

exactly, this was my idea. Since we've the same race locally even on
ext2, maybe it worth to share the fix for all the fs somehow, the
problem sounds the same. You may still need callbacks to get right the
distributed fs though. still I was just wondering if the conceptual fix
could live in the highlevel rather than replicating it in the lowlevel.

> This sounds good to me, though am checking with some DFS people.

cool thanks!

> > And w/o proper high level locking, the non distributed filesystems will
> > corrupt the VM too with truncate against nopage. I already fixed this in
> > my tree. (see the attachment) So I wonder if the fixes could be shared.
> > I mean, you definitely need my fixes even when using the DFS on a
> > isolated box, and if you don't need them while using the fs locally, it
> > means we're duplicating effort somehow.
> 
> True -- my patches simply provided hooks to allow DFSs and local
> filesystems to fix the problem.  
> 
> So, the idea is for the DFS to hold a fr_write_lock on the
> truncate_lock across the invalidate_mmap_range() call, thus
> preventing the PTEs from any racing pagefaults from being
> installed?  This seems plausible at first glance, but need
> to stare at it some more.  This might permit the current
> do_no_page(), do_anonymous_page(), and ->nopage APIs to
> be used, but again, need to stare at it some more.

btw, we can discuss this some more next month at OLS too, if we didn't
clear all the issues first.

> (If I am not too confused, fr_write_lock() became
> write_seqlock() in the 2.5 tree...)

exactly, I didn't rename it yet in 2.4 since it would provide no runtime
benefit, but it is exactly the same thing ;).

> > Since I don't see the users of the new hook, it's a bit hard to judje if
> > the duplication is legitimate or not. So overall I'd agree with Andrew
> > that to judje the patch it'd make sense to see (or know more) about the
> > users of the hook too.
> 
> A simple change that takes care of all the cases certainly does
> seem better than a more complex change that only takes care of
> distributed filesystems!

agreed.

thanks,

Andrea
