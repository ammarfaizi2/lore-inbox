Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbVH3Cqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVH3Cqt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 22:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932094AbVH3Cqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 22:46:49 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:59802 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932093AbVH3Cqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 22:46:48 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sonny Rao <sonnyrao@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4313AEC9.3050406@yahoo.com.au>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>
	 <20050828175233.61cada23.akpm@osdl.org> <1125278389.5048.30.camel@mulgrave>
	 <20050828183531.0b4d6f2d.akpm@osdl.org> <1125285994.5048.40.camel@mulgrave>
	 <4312830C.8000308@yahoo.com.au>
	 <20050829164144.GC9508@localhost.localdomain>
	 <4313AEC9.3050406@yahoo.com.au>
Content-Type: text/plain
Date: Mon, 29 Aug 2005 21:46:19 -0500
Message-Id: <1125369981.5089.106.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-08-30 at 10:56 +1000, Nick Piggin wrote:
> Sonny Rao wrote:
> 
> >On Mon, Aug 29, 2005 at 01:37:48PM +1000, Nick Piggin wrote:
> >
> >>s/common/only ?
> >>
> >>But the page tree is indexed by file offset rather than virtual
> >>address, and we try to span the file's pagecache with the smallest
> >>possible tree. So it will tend to make the trees taller.
> >>
> >>
> >
> >I did some experiments with different map-shift values,
> >interestingly overall read throughput didn't change much but the
> >cpu-utilization of radix_tree_lookup (from oprofile) changed quite a
> >bit, especially in the case of MAP_SHIFT == 4 :  
> >
> >http://www.linuxsymposium.org/2005/linuxsymposium_procv2.pdf 
> >
> >Look on page 80, where I have the table.
> >
> Nice. So we can see that 6 is a pretty good choice of shift,
> 4 is too low. That doesn't tell us much about 5, but if you
> fit the curve, 5 should be between 14 and 15 ... so getting
> expensive.

Actually, several crucial pieces of data are missing.  It's not hard to
imagine that the results for 8, 10 and 12 are all equal to within the
error bars.  The missing piece of data, of course, is how big the file
was, which would tell us how deep the tree was.

> Of course, different systems and different workloads will
> be different. But I'd be wary of going below 6 unless there
> is a good reason.
> 
> >>I'm curious: what do the benchmarks say about your gang lookup?
> >>
> >
> >Gang-lookup isn't used in the page-cache lookups presently, so I'm
> >not sure why optimizing it is very important -- unless someone is
> >planning on implementing gang-lookups for page-cache reads. This would
> >also cut down on number times a lock is taken and released (expensive,
> >in the case of rwlock).  Perhaps there is another reason?
> >
> >
> 
> Gang lookup is mainly used on IO paths but also on truncate,
> which is a reasonably fast path on some workloads (James,
> this is my suggestion for what you should test - truncate).

Actually, I don't think I can test this.  In order to show a difference
between index 5 and index 6 on 32 bit, I'd have to deal with files > 4GB
in size.  My 32 bit machines are the voyagers and only have 4GB discs.

The machine with all the huge discs, is, naturally, ia64.

James


