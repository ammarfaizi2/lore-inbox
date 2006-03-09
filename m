Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbWCIBDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbWCIBDz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 20:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbWCIBDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 20:03:55 -0500
Received: from ozlabs.org ([203.10.76.45]:34468 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932690AbWCIBDy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 20:03:54 -0500
Date: Thu, 9 Mar 2006 12:03:14 +1100
From: "'David Gibson'" <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Message-ID: <20060309010314.GG17590@localhost.localdomain>
Mail-Followup-To: 'David Gibson' <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	"'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
	linux-kernel@vger.kernel.org
References: <20060309002251.GE17590@localhost.localdomain> <200603090033.k290XBg13472@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603090033.k290XBg13472@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 04:33:10PM -0800, Chen, Kenneth W wrote:
> David Gibson wrote on Wednesday, March 08, 2006 4:23 PM
> > > But you already make reservation at mmap time.  If you reserve it again
> > > when extending the file, won't you double count?
> > 
> > Well, I'd generally expect extending truncate() to come before mmap(),
> > but in any case hugetlb_extend_reservation() is safe against double
> > counting (it's idempotent if called twice with the same number of
> > pages).  The semantics are "ensure the this many pages total are
> > guaranteed available, that is, either reserved or already
> > instantiated".
> 
> It's kind of peculiar that kernel reserve hugetlb page at the time of
> extending truncate.  Maybe there is a close correlation between mmap
> size to the file size.  But these two aren't the same and and shouldn't
> be mixed.

Indeed.  The fundamental basis of my approach as opposed to that in
apw's old accounting patches is that reservation is related to
filesize, not mmap() size.  The only connection to mmap() is that
(shared writable) mmap() on hugetlbfs also extends filesize and
reservation size as a side effect.

There's a slight wrinkle in the different between i_size and reserved
pages.  i_size can be extended beyond the "reserved portion" of the
file.  We need that behaviour because i_size also acts as a hard
offset limit for MAP_PRIVATE mappings, but privately instantiated
pages don't come from the file's reservation.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
