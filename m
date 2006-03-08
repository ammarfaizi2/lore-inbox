Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750875AbWCHKXx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750875AbWCHKXx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 05:23:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751008AbWCHKXx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 05:23:53 -0500
Received: from ozlabs.org ([203.10.76.45]:38325 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750875AbWCHKXw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 05:23:52 -0500
Date: Wed, 8 Mar 2006 21:23:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Zhang, Yanmin" <yanmin.zhang@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, William Lee Irwin <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: Re: hugepage: Strict page reservation for hugepage inodes
Message-ID: <20060308102314.GB32571@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Zhang, Yanmin" <yanmin.zhang@intel.com>,
	Andrew Morton <akpm@osdl.org>,
	William Lee Irwin <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>
References: <117E3EB5059E4E48ADFF2822933287A44D3206@pdsmsx404>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <117E3EB5059E4E48ADFF2822933287A44D3206@pdsmsx404>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 05:25:16PM +0800, Zhang, Yanmin wrote:
> >>-----Original Message-----
> >>From: David Gibson [mailto:david@gibson.dropbear.id.au]
> >>Sent: 2006??3??1?? 7:36
> >>To: Zhang, Yanmin
> >>Cc: Andrew Morton; William Lee Irwin; linux-kernel@vger.kernel.org
> >>Subject: Re: hugepage: Strict page reservation for hugepage inodes
> >>
> >>hugepage: Strict page reservation for hugepage inodes
> >>
> >>These days, hugepages are demand-allocated at first fault time.
> >>There's a somewhat dubious (and racy) heuristic when making a new
> >>mmap() to check if there are enough available hugepages to fully
> >>satisfy that mapping.
> >>
> >>A particularly obvious case where the heuristic breaks down is where a
> >>process maps its hugepages not as a single chunk, but as a bunch of
> >>individually mmap()ed (or shmat()ed) blocks without touching and
> >>instantiating the pages in between allocations.  In this case the size
> >>of each block is compared against the total number of available
> >>hugepages.  It's thus easy for the process to become overcommitted,
> >>because each block mapping will succeed, although the total number of
> >>hugepages required by all blocks exceeds the number available.  In
> >>particular, this defeats such a program which will detect a mapping
> >>failure and adjust its hugepage usage downward accordingly.
> >>
> >>The patch below addresses this problem, by strictly reserving a number
> >>of physical hugepages for hugepage inodes which have been mapped, but
> >>not instatiated.
> The patch reserves a number of physical hugepages for hugepage inodes
> which have been mapped into address spaces, but it doesn't just reserve the
> pages what it needed. It reserves all huge pages from 0 to inode->i_size. For example,
> 
> 	fd = open("/mnt/hugepages/file1", O_CREAT|O_RDWR, 0755);
>  	*addr = mmap(NULL, HUGEPAGE_SIZE*3, PROT_NONE, MAP_SHARED, fd, HUGEPAGE_SIZE*5);
> 
> The patch would reserve 8 huge pages instead of 3 pages. I know that shmget/shmat
> have no such problem. But mmap has it and the patch looks not perfect.

Yes.  This is a simplifying assumption.  I know of no real application
that will waste pages because of this behaviour.  If you know one,
maybe we will need to reconsider.

> I have an idea. How about to record all the start/end address of huge page mmaping of the inode?
> Long long ago, there was a patch at http://marc.theaimsgroup.com/?l=lse-tech&m=108187931924134&w=2.
> Of course, we need port it to the latest kernel if this idea is better.

I know the patch - I was going to port it to the current kernel, but
came up with my patch instead, because it seemed like a simpler
approach.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
