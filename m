Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932620AbWCIAIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbWCIAIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 19:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932624AbWCIAIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 19:08:45 -0500
Received: from ozlabs.org ([203.10.76.45]:55706 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932620AbWCIAIo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 19:08:44 -0500
Date: Thu, 9 Mar 2006 10:58:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Message-ID: <20060308235805.GC17590@localhost.localdomain>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Chen, Kenneth W" <kenneth.w.chen@intel.com>,
	"'Zhang, Yanmin'" <yanmin_zhang@linux.intel.com>,
	linux-kernel@vger.kernel.org
References: <1141788278.29825.89.camel@ymzhang-perf.sh.intel.com> <200603081828.k28ISgg10244@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603081828.k28ISgg10244@unix-os.sc.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2006 at 10:28:41AM -0800, Chen, Kenneth W wrote:
> Zhang, Yanmin wrote on Tuesday, March 07, 2006 7:25 PM
> > Currently, ftruncate on hugetlb files couldn't extend them. My patch enables it.
> > 
> > This patch is against 2.6.16-rc5-mm3 and on the top of the patch which
> > implements mmap on zero-length hugetlb files with PROT_NONE.
> 
> > -
> > -	inode->i_size = offset;
> > -	spin_lock(&mapping->i_mmap_lock);
> > -	if (!prio_tree_empty(&mapping->i_mmap))
> > -		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> > -	spin_unlock(&mapping->i_mmap_lock);
> > -	truncate_hugepages(inode, offset);
> > +        if (offset > inode->i_size) {
> > +        	if (hugetlb_extend_reservation(HUGETLBFS_I(inode), pgoff) != 0)
> > +			return -ENOMEM;
> > +		inode->i_size = offset;
> > +	}
> > +	else {
> > +
> > +		inode->i_size = offset;
> > +		spin_lock(&mapping->i_mmap_lock);
> > +		if (!prio_tree_empty(&mapping->i_mmap))
> > +			hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> > +		spin_unlock(&mapping->i_mmap_lock);
> > +		truncate_hugepages(inode, offset);
> > +	}
> >  	return 0;
> >  }
>  
> Hmm??  I don't think you need to extend the reservation when extending
> hugetlb file via ftruncate.  You don't have any vma that pass beyond
> current size.  So making a reservation is a wrong thing to do here.

Fwiw, I think truncate *should* extend the reservation.  We have a
separate thread arguing about whether we should be reserving by inode
length, as I've implemented, or by which ranges are actually mapped
(as apw's old path implemented).  As long as it *is* by inode length -
so it's conceptually all about the logical file in hugetlbfs, not
about any of its mappings - I think it makes sense for an extending
truncate() to extend the reservation.  It's not reserving them for any
particular mapping, it's reserving them for page cache pages.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
