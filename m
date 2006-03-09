Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWCIAXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWCIAXa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932632AbWCIAXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:23:30 -0500
Received: from ozlabs.org ([203.10.76.45]:4764 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932630AbWCIAX3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:23:29 -0500
Date: Thu, 9 Mar 2006 11:22:51 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Message-ID: <20060309002251.GE17590@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	"'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
	linux-kernel@vger.kernel.org
References: <20060308235805.GC17590@localhost.localdomain> <200603090012.k290CDg13307@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603090012.k290CDg13307@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:12:13PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Wednesday, March 08, 2006 3:58 PM
> > > Hmm??  I don't think you need to extend the reservation when extending
> > > hugetlb file via ftruncate.  You don't have any vma that pass beyond
> > > current size.  So making a reservation is a wrong thing to do here.
> > 
> > Fwiw, I think truncate *should* extend the reservation.  We have a
> > separate thread arguing about whether we should be reserving by inode
> > length, as I've implemented, or by which ranges are actually mapped
> > (as apw's old path implemented).  As long as it *is* by inode length -
> > so it's conceptually all about the logical file in hugetlbfs, not
> > about any of its mappings - I think it makes sense for an extending
> > truncate() to extend the reservation.  It's not reserving them for any
> > particular mapping, it's reserving them for page cache pages.
> 
> But you already make reservation at mmap time.  If you reserve it again
> when extending the file, won't you double count?

Well, I'd generally expect extending truncate() to come before mmap(),
but in any case hugetlb_extend_reservation() is safe against double
counting (it's idempotent if called twice with the same number of
pages).  The semantics are "ensure the this many pages total are
guaranteed available, that is, either reserved or already
instantiated".

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
